//
//  LunchViewController.swift
//  BottleRocketAssignement
//
//  Created by Hassan Baraka on 4/13/21.
//

import UIKit

class LunchViewController: UICollectionViewController {
    var viewModel:LunchViewModel?
    var lunchInformation = [Restaurant]()
    var lunchInfo:[Restaurant] = []
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegates()
        configureUI()
        loadLunchData()
//        configureSpacing()
        print(lunchInfo.count)
        // Do any additional setup after loading the view.
    }
    func configureDelegates(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func configureSpacing(){
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        collectionView.collectionViewLayout = layout
    }
    func configureUI(){
    }
    func loadLunchData(){
        NetworkManager.shared.fetchLunch() {[weak self] (res) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch res {
                case .failure(let error):
                    print(error)
                case .success(let lunch):
                    for restaurant in lunch.restaurants{
                        self.lunchInfo.append(restaurant)
                    }
                    self.collectionView.reloadData()
                    print(self.lunchInfo.count)
                }
            }
        }
        
    }
    
}
extension LunchViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.destination)
        if let destination = segue.destination as? DetailViewController {
       
            destination.resturantInfo = self.lunchInfo[self.selectedIndex]
            print(destination.resturantInfo as Any)
        }
        if let destination = segue.destination as? MapViewController {
            destination.resturantsArray = self.lunchInfo
            print(destination.resturantsArray as Any)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        print(self.selectedIndex)
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lunchInfo.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LunchCollectionViewCell.reuseId, for: indexPath) as? LunchCollectionViewCell else { fatalError() }
        let cellData = lunchInfo[indexPath.row]
        cell.configure(with: LunchViewModel(with: cellData))
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 180.0)
    }
}

