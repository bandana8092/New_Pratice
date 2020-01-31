//
//  PostsTableView.swift
//  Bandana_Pratice_2
//
//  Created by Rakesh Nangunoori on 31/01/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import Foundation
import UIKit


class PostsTableview: UITableView,UITableViewDelegate,UITableViewDataSource {
    //Mark:- Variable Declaration
    var postModel = [PostModel]()
    var totalPages = 0
    var currentPage = 0
    var pageCount = 1
    var presentedInViewController : UIViewController!
    
    
    // load when intiallay call service
    func loadeDataInTable(inController:UIViewController){
        self.register(UINib.init(nibName: "PostsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.presentedInViewController = inController
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView()
        
    }
    
    //Mark:- Switch Status
    func updateSwitchStatus(postModel:[PostModel],indexPath:NSIndexPath,complitionHandler:@escaping(_ error:NSError?)-> Void){
        postModel[indexPath.row].switchStatus = postModel[indexPath.row].switchStatus ? false : true
        complitionHandler(nil)
    }
    
    // load data when auto load  to append data to tableview
    func autoLoadData(withPost:[PostModel]){
        if(withPost.count == 0){
            return
        }
        self.postModel = self.postModel+withPost
        var loadIndexPaths = [IndexPath]()
        for index in self.numberOfRows(inSection: 0) ... self.postModel.count-1{
            let indexPath = IndexPath.init(row: index, section: 0)
            loadIndexPaths.append(indexPath)
        }
        self.beginUpdates()
        self.insertRows(at: loadIndexPaths, with: .automatic)
        self.endUpdates()
    }
    // clear tableviewDate
    func clearAllData(){
        
        self.pageCount = 1
        self.currentPage = 1
        self.totalPages = 1
        self.presentedInViewController.navigationItem.title = ""
    }
    
    //Mark:- Api Call
    func getPosts(complitionHandler:@escaping(_ error:NSError?)-> Void){
        ServiceHandler.shared.getDetailsFromServer(url: "\(BASE_URL)\(pageCount)") { (responseData, error) in
            if error == nil{
                //print(responseData!)
                
                if responseData?.object(forKey: "nbPages") != nil{
                    let total = String(describing: responseData!.object(forKey: "nbPages")!)
                    self.totalPages = Int(total) ?? 0
                }
                if responseData?.object(forKey: "page") != nil{
                    let current = String(describing: responseData!.object(forKey: "page")!)
                    self.currentPage = Int(current) ?? 0
                }
                if let arrObj = responseData?.object(forKey: "hits") as? NSArray {
                    if self.pageCount == 1{
                        self.postModel.removeAll()
                    }
                    for eachObj in arrObj{
                        let modelObj = PostModel(postModel: eachObj as! NSDictionary)
                        self.postModel.append(modelObj)
                        
                    }
                    complitionHandler(nil)
                }else{
                    // print("No Data")
                }
                
            }else{
                //print("error")
                complitionHandler(error)
            }
        }
        
    }
    
    //Mark:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostsTableViewCell
        cell.updateCell(postModel: postModel ,indexPath: indexPath)
        cell.selectionStyle = .none
        
        return  cell
    }
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateSwitchStatus(postModel:postModel, indexPath:indexPath as NSIndexPath) { (error) in
            if error == nil{
                
                let filteredArr = self.postModel.filter{$0.switchStatus == true}
                if filteredArr.count > 0{
                    self.presentedInViewController.navigationItem.title = "Number of selected posts: \(filteredArr.count)"
                }else{
                    self.presentedInViewController.navigationItem.title = " "
                }
                self.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if   indexPath.row == postModel.count - 1 {
            var spinner : UIActivityIndicatorView!
            if #available(iOS 13.0, *) {
                spinner = UIActivityIndicatorView(style:UIActivityIndicatorView.Style.medium)
            } else {
                // Fallback on earlier versions
            }
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.tableFooterView = spinner
            self.tableFooterView!.isHidden = false
            if totalPages > currentPage {
                pageCount += 1
                getPosts() { (error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            print(self.pageCount)
                            self.reloadData()
            } }
                }
            } else {
                spinner.isHidden = true
                spinner.stopAnimating()
            }
        }
    }
    
    
}
