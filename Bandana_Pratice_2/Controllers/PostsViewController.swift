//
//  ViewController.swift
//  Bandana_Pratice_2
//
//  Created by Rakesh Nangunoori on 31/01/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class PostsViewController: UIViewController {
    var refreshPageController = UIRefreshControl()
    
    @IBOutlet weak var postsTableView: PostsTableview!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = " "
        self.postsTableView.loadeDataInTable( inController: self)
        LoaderView.shared.showActivityIndicator(view: self.view, targetVC: self)
        self.refreshPageController.addTarget(self, action: #selector(self.pullToRefreshMethod(_:)), for: .valueChanged)
        self.postsTableView.addSubview(self.refreshPageController)
        if !Reachability.isConnectedToNetwork(){
                  LoaderView.shared.hideActivityIndicator(view: self.view)
                 let alert = UIAlertController(title: "Alert", message: "please check your internet", preferredStyle: .alert)
                      let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                      })
                      alert.addAction(cancel)
                      DispatchQueue.main.async(execute: {
                         self.present(alert, animated: true)
                 })
                 return
        }else {
                getPosts()
        }
       
    }
    
    func getPosts() {
        postsTableView.getPosts() { (error) in
                   DispatchQueue.main.async {
                       //LoadingOverlay.shared.hideOverlayView()
                       LoaderView.shared.hideActivityIndicator(view: self.view)
                        self.postsTableView.reloadData()
                   }
                }
        
    }

    //Pull to refresh controller target method
        @objc func pullToRefreshMethod(_ sender:UIRefreshControl) {
        self.postsTableView.clearAllData()
         postsTableView.getPosts() { (error) in
             DispatchQueue.main.async {
            self.refreshPageController.endRefreshing()
            self.postsTableView.reloadData()
            }
        }
       }

}

