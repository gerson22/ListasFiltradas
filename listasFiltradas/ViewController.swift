//
//  ViewController.swift
//  listasFiltradas
//
//  Created by Gerson Isaias on 06/02/21.
//

import UIKit

class ViewController: UIViewController, IPost {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollViewObjects: UIScrollView!
    @IBOutlet weak var tfSearch: UITextField!
    
    var allPosts: [Post]!
    var postFiltered = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Post.all(self)
    }
    
    func onGettingAllPosts(posts: [Post]) {
        DispatchQueue.main.async {
            self.allPosts = posts
            self.fillStackView(posts: self.allPosts)
        }
        
    }
    
    func fillStackView(posts:[Post]){
        var positionY = 0
        let heightItem = 120
        let spacing = 10
        posts.forEach { (post) in
            let item = Item(frame: CGRect(x: 0, y: positionY, width: Int(self.view.frame.width), height: heightItem))
            item.build(post)
            self.stackView.addSubview(item)
            
            positionY += heightItem + spacing
        }
        self.scrollViewObjects.contentSize.height = CGFloat(posts.count * heightItem) + CGFloat(posts.count * spacing)
    }
    
    func clearStackView(){
        self.stackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    @IBAction func onTextChange(_ sender: UITextField) {
        clearStackView()
        if sender.text!.isEmpty {
            fillStackView(posts: allPosts)
        }else{
            postFiltered = allPosts.filter({ $0.title.contains(sender.text!) })
            fillStackView(posts: postFiltered)
        }
    }
}

