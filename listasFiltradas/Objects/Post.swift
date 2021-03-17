//
//  Post.swift
//  listasFiltradas
//
//  Created by Gerson Isaias on 06/02/21.
//

import UIKit

class Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    init(userId:Int, id:Int, title:String, body:String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    
    static func all(_ observable:IPost){
        let session = URLSession.shared
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error ?? "Error en el request")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data!)
                observable.onGettingAllPosts(posts: posts)
            }catch{
                print("No fue posible la decodificacion")
            }
            
            print(response!)
        }
        task.resume()
    
    }
}
