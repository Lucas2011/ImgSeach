//
//  NetworkTools.swift
//  ImgSeach_XI_Li
//
//  Created by Lucas on 7/25/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation

class NetworkTools :NSObject{
    static let shared: NetworkTools  =
    {
        let tools = NetworkTools()
        
        return tools
        
    }()
    
    
    // https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=0fe1aaa149e2cd9cfae6d59c927e453f&text=cat&format=json&nojsoncallback=1

    func request(keyWord: String, finished: @escaping ([Model]?,Error?) -> ()) {
        var flickrAPI = "";
        flickrAPI += "https://api.flickr.com/services/rest/?";
        flickrAPI += "method=flickr.photos.search&";
        flickrAPI += "api_key=0fe1aaa149e2cd9cfae6d59c927e453f";
        flickrAPI += "&text==\(keyWord)";
        flickrAPI += "&format=json&nojsoncallback=1";
        flickrAPI += "&page=1";
        flickrAPI += "&format=json";



        
        let session = URLSession(configuration: .default)

        let urlAdd = URLRequest(url: URL(string: flickrAPI)!)
        
        session.dataTask(with: urlAdd) { (data:Data?, res:URLResponse?,error:Error?) in
        
            if error == nil{
                let dict:NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                let dataDict = dict["photos"] as! NSDictionary
                let dataAarray = dataDict["photo"] as! NSMutableArray
                var data: [Model] = [Model]()
                for item in dataAarray
                {
                    let model = Model()
                    model.setValuesForKeys(item as! [String : Any])
                    data.append(model)
                    
                }
                finished(data,nil)
            }
            
            
        }.resume()

            
        }
    







}
    
    
    
    
    
    
    
    
    

