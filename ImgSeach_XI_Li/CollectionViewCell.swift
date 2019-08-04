//
//  CollectionViewCell.swift
//  ImgSeach_XI_Li

//
//  Created by Lucas on 7/25/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imgView)
        self.contentView.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imgView: UIImageView = {
        let img = UIImageView(frame: self.bounds)
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    var cellModel:Model?{
        didSet{
            imgView.image = UIImage.init(named: "")
            
            cellModel!.imgURL = "https://farm\(cellModel!.farm).staticflickr.com/\(cellModel!.server!)/\(cellModel!.id!)_\(cellModel!.secret!).jpg"
            
            let url = URL(string: cellModel!.imgURL!)!
            
            DispatchQueue.global(qos: .default).async{
                
                let data:NSData =  try! NSData.init(contentsOf: url, options: .alwaysMapped)
                
                DispatchQueue.main.async {
                    self.imgView.image = UIImage(data: data as Data)
                }
                
            }
        }
    }

    
}
