//
//  ViewController.swift
//  MediaWiki
//
//  Created by Zert Interactive on 7/10/18.
//  Copyright © 2018 Zert Interactive. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var mediaWikiTableView: UITableView!
    fileprivate var searchItem = [SearchItemModel]()
    fileprivate var filteredItemArray = [SearchItemModel]()
    
    var firstTimeUpScrollFlag = false
    var firstTimeBottomScrollFlag = false
    
    @IBOutlet weak var topMenuConstraint: NSLayoutConstraint!
    var topConstraint : CGFloat = 0.0
    
    @IBOutlet weak var bottomMenuBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topMenu: UIView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let dummyBookmark = [SearchItemModel(ProductName: "##Bookmarks1", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 2", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 3", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 4", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 5 ", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 3", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 4", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 5 ", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 3", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 4", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 5 ", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 3", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 4", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 5 ", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 3", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 4", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 5 ", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 3", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 4", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 ),SearchItemModel(ProductName: "##Bookmarks 5 ", SDetails: "https://www.mediawiki.org/wiki/API:Main_page", Price:0.0 )
        ]
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let _ = customActivityIndicatory(self.view, startAnimate: true)
        self.getDummyWikiResult()
        self.registerCutomCell()
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "MediaWiki"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerCutomCell(){
        
        self.mediaWikiTableView.register(UINib(nibName: "SearchItemCell", bundle: nil), forCellReuseIdentifier: "SearchItemCell")
    }
    
    func configureTableViewDelegate(){
        
        self.mediaWikiTableView.delegate = self
        self.mediaWikiTableView.dataSource = self;
    }
    
    
    
    @IBAction func searchItem(_ sender: UIButton) {
        
        self.getDummyWikiResult()
        
    }
    
    @IBAction func clearSearch(_ sender: UIButton) {
        
        self.searchTextField.text = nil
        self.showBookMarks()
        
    }
    
    func showBookMarks(){
        self.filteredItemArray = self.dummyBookmark
        DispatchQueue.main.async {
            self.mediaWikiTableView.reloadData()
        }
    }
    
    
    func addSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search "
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func filterProductForSearchText(_ searchText: String) {
        filteredItemArray = searchItem.filter({( product : SearchItemModel) -> Bool in
            
            if searchBarIsEmpty() {
                return true
            } else {
                return  product.ProductName.lowercased().contains(searchText.lowercased())
            }
        })
        
        DispatchQueue.main.async {
            self.mediaWikiTableView.reloadData()
            
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    
    func showEmptyProduct(){
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.mediaWikiTableView.bounds.size.width, height: self.mediaWikiTableView.bounds.size.height))
        messageLabel.text = "No Product Found"
        if self.view.frame.size.height > 568.0 {
            messageLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        }else{
            messageLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
            
        }
        
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        
        self.mediaWikiTableView.backgroundView = messageLabel
        
    }
    
    
    
}
extension ViewController:UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    
    // .....Pragma mark - UITableViewDataSource & UITableViewDelegate implementation starts.....
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if filteredItemArray.isEmpty{
            showEmptyProduct()
        }else{
            self.mediaWikiTableView.backgroundView = nil
        }
        return filteredItemArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fuddelCell = tableView.dequeueReusableCell(withIdentifier: "SearchItemCell", for: indexPath) as! SearchItemCell
       // fuddelCell.delegate = self
        let tempFuudelData = filteredItemArray[indexPath.row] as SearchItemModel
        fuddelCell.fuudel = tempFuudelData
        
        return fuddelCell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let wikiDetailController = self.storyboard?.instantiateViewController(withIdentifier: "wikidetail") as? WikiDetailController
        let selectedItem = filteredItemArray[indexPath.row] as SearchItemModel
        wikiDetailController?.searchItemDetailModel = selectedItem
        
        DispatchQueue.main.async {
            self.present(wikiDetailController!, animated: true, completion: nil)

        }
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if firstTimeBottomScrollFlag{
            firstTimeUpScrollFlag = false
            
            UIView.animate(withDuration: 0.5) {
                DispatchQueue.main.async {
                    self.topMenuConstraint.constant = 0;
                    self.view.layoutIfNeeded()
                }

            }
        }
        
//        if firstTimeUpScrollFlag{
//            firstTimeBottomScrollFlag = false
//            UIView.animate(withDuration: 0.5) {
//                DispatchQueue.main.async {
//                    self.bottomMenuBottomConstraint.constant = 0.0;
//                    self.view.layoutIfNeeded()
//                }
//
//            }
//        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < 0 {
            
            if !firstTimeBottomScrollFlag{
                
                UIView.animate(withDuration: 0.5) {
                    DispatchQueue.main.async {
                        self.bottomMenuBottomConstraint.constant = -44.0;
                        self.view.layoutIfNeeded()
                    }
                    self.firstTimeBottomScrollFlag = true
                    
                }
                
            }
          
        }else{
            if !firstTimeUpScrollFlag{
                UIView.animate(withDuration: 0.5) {
                    DispatchQueue.main.async {
                        self.topMenuConstraint.constant = -50.0;
                        self.view.layoutIfNeeded()
                    }
                    self.firstTimeUpScrollFlag = true
                    
                }
            }

//            UIView.animate(withDuration: 0.5) {
//                self.topMenuConstraint.constant = self.topConstraint;
//                self.view.layoutIfNeeded()
//            }

        }

    }
    
    
    
    // .....Pragma mark - UITableViewDataSource & UITableViewDelegate implementation ends.....
    
    
    
}


// .....Pragma mark - UISearchResultsUpdating implementation Starts.....

extension ViewController : UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        filterProductForSearchText((searchController.searchBar.text?.trimmingCharacters(in: .whitespaces))!)
        
    }
    
    
}

// .....Pragma mark - UISearchResultsUpdating implementation ends.....


// .....Pragma mark - Other Customs functionality  implementation Starts.....

extension ViewController{
    
    fileprivate func getDummyWikiResult(){
        let urlEndPoint: String = "http://77.68.80.27:4010/marketplaceapi/getsubmenulistbycategoryid?&categoryid=351&pageindex=1&pagesize=1000&resturentid=1"
        guard let url = URL(string: urlEndPoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        
        let session = URLSession(configuration:URLSessionConfiguration.default)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET ")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            
            
            do {
                guard let rootDict = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                
                if  let porductArray = rootDict["data"] as? [[String : Any]]{
                    
                    for product in porductArray{
                        self.searchItem.append(SearchItemModel(ProductName: product["ProductName"] as! String, SDetails: product["Details"] as! String, Price:product["Price"] as! Double))
                    }
                }
                
                if !self.searchItem.isEmpty{
                    DispatchQueue.main.async {
                        let _ = self.customActivityIndicatory(self.view, startAnimate: false)
                        self.addSearchController()
                        self.configureTableViewDelegate()
                        self.filteredItemArray = self.searchItem
                        self.mediaWikiTableView.reloadData()
                    }
                }
                
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            
        }
        
        task.resume()
    }
    
    fileprivate func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
        
        let mainContainer: UIView = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        //mainContainer.backgroundColor = UIColor.white
        //mainContainer.alpha = 0.5
        mainContainer.tag = 789456123
        mainContainer.isUserInteractionEnabled = false
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        viewBackgroundLoading.center = viewContainer.center
        viewBackgroundLoading.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha:1.0)
        //  viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicatorView.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        if startAnimate!{
            viewBackgroundLoading.addSubview(activityIndicatorView)
            mainContainer.addSubview(viewBackgroundLoading)
            viewContainer.addSubview(mainContainer)
            activityIndicatorView.startAnimating()
        }else{
            for subview in viewContainer.subviews{
                if subview.tag == 789456123{
                    subview.removeFromSuperview()
                }
            }
        }
        return activityIndicatorView
    }
    
}

