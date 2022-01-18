//
//  AppIconCollectionCell.swift
//  CropslyTest
//
//  Created by Admin on 18/01/22.
//

import UIKit
protocol AppIconCollectionCellDelegate:AnyObject {
    func longPressIcon()
    func removeApp(cell:AppIconCollectionCell)
}

class AppIconCollectionCell: UICollectionViewCell {
    
    static let reuseId = "AppIconCollectionCell"
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    weak var delegate:AppIconCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAppIcon(sender:)))
        longPress.minimumPressDuration = 0.5
        self.addGestureRecognizer(longPress)
    }
    
    @objc func longPressAppIcon(sender:AppIconCollectionCell){
        delegate?.longPressIcon()
    }
    
    @IBAction func actionRemove(_ sender: UIButton) {
        delegate?.removeApp(cell: self)
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
