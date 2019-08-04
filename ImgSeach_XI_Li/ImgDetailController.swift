//
//  ImgDetailController.swift
//  ImgSeach_XI_Li
//
//  Created by Lucas on 7/25/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import UIKit

class ImgDetailController: UIViewController {

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(imgView)
    }
    lazy var imgView: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width * 1.6) )
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    var imgURL:String?{
        didSet{
            let url = URL(string: imgURL!)
            DispatchQueue.global(qos: .default).async{
                let data:NSData =  try! NSData.init(contentsOf: url!, options: .alwaysMapped)
                DispatchQueue.main.async {
                    self.imgView.image = UIImage(data: data as Data)
                }
                
            }
        }
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
