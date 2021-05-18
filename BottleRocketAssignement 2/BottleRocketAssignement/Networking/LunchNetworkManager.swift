//
//  LunchNetworkManager.swift
//  BottleRocketAssignement
//
//  Created by Hassan Baraka on 4/13/21.
//

import UIKit

final class NetworkManager{
    typealias LunchParamaters =  Result<LunchData,Error>
    static var shared = NetworkManager()
    let session:DataTaskMaker
     init(session: DataTaskMaker = URLSession.shared){
        self.session = session
    }
}
protocol DataTaskMaker {
  func dataTask(with url: URL,
                completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
extension URLSession: DataTaskMaker{ }

extension NetworkManager{
    func fetchLunch(completion: @escaping (LunchParamaters) -> ()) {
        let urlString = "https://s3.amazonaws.com/br-codingexams/restaurants.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error{
                completion(.failure(err))
            }
            guard let response = response as? HTTPURLResponse else { return }
            print(response.statusCode)
            guard let data = data else { return }
            
            do {
                let lunchDataReturned = try JSONDecoder().decode(LunchData.self, from: data)
                completion(.success(lunchDataReturned))
                print("\(lunchDataReturned)")
            } catch let error as NSError {
                completion(.failure(error))
                print("Fetching error: \(error), \(error.userInfo)")
            }
        }.resume()
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
