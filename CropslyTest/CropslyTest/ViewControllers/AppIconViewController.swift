//
//  ViewController.swift
//  CropslyTest
//
//  Created by Admin on 18/01/22.
//

import UIKit

class AppIconViewController: UIViewController {
    
    @IBOutlet weak var collectionViewAppIcons: UICollectionView!

    var isEditMode:Bool = false {
        didSet {
            self.navigationItem.rightBarButtonItem?.isEnabled = isEditMode
        }
    }
    
    var icons = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupData()
        isEditMode = false
        title = "Cropsly"
    }
    
    fileprivate func setupData(){
        icons.removeAll()
        for i in 0..<10{
            icons.append(i % 2 == 0 ? "icon1" : "icon2")
        }
        collectionViewAppIcons.reloadData()
    }
    
    @IBAction func actionDone(_ sender: UIBarButtonItem) {
        self.isEditMode = false
        self.collectionViewAppIcons.reloadData()
    }
    
}

//MARK: Collection view datasource and delegates
extension AppIconViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppIconCollectionCell.reuseId, for: indexPath) as! AppIconCollectionCell
        cell.delegate = self
        cell.btnRemove.isHidden = !isEditMode
        cell.imgIcon.image = UIImage(named:icons[indexPath.row])
        if isEditMode {
            cell.layer.add(AnimationUtility.shared.getShakeAnimation(), forKey: "shake")
        }else {
            cell.layer.removeAnimation(forKey: "shake")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
}


//MARK: App Icon Cell Delegate
extension AppIconViewController:AppIconCollectionCellDelegate {
    func longPressIcon() {
        isEditMode = true
        self.collectionViewAppIcons.reloadData()
    }
    
    func removeApp(cell: AppIconCollectionCell) {
        guard let indexPath = collectionViewAppIcons.indexPath(for: cell) else {
            return
        }
        UIView.animate(withDuration: 0.25) {
            cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        } completion: { isSuccess in
            cell.isHidden = true
            self.icons.remove(at: indexPath.row)
            self.collectionViewAppIcons.performBatchUpdates {
                self.collectionViewAppIcons.deleteItems(at: [indexPath])
            } completion: { isSuccess in
                DispatchQueue.main.async {
                    self.collectionViewAppIcons.reloadData()
                }
            }
        }
    }
    
    
}
