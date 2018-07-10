//
//  WikiDetailController.swift
//  MediaWiki
//
//  Created by Zert Interactive on 7/10/18.
//  Copyright © 2018 Zert Interactive. All rights reserved.
//

import UIKit

class WikiDetailController: UIViewController {

    var searchItemDetailModel:SearchItemModel?
    
    @IBOutlet weak var searchItemDetail: UILabel!
    @IBOutlet weak var searchItemTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchItemDetail.isHidden = true
        self.searchItemTitle.text = searchItemDetailModel?.ProductName
        self.searchItemDetail.text = (searchItemDetailModel?.SDetails)!
        
        let doubletapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(WikiDetailController.myviewTapped(_:)))
        doubletapGestureRecognizer.numberOfTapsRequired = 2
       // doubletapGestureRecognizer.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(doubletapGestureRecognizer)

        // Do any additional setup after loading the view.
    }
    
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        
      fadeinAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true, completion: nil)
        }
        
       
    
    }
    
    
    func fadeinAnimation(){
        self.searchItemDetail.alpha = 0.0
        self.searchItemDetail.isHidden = true
        
        
        UIView.animate(withDuration: 1.5) {
            self.searchItemDetail.alpha = 1.0
            self.searchItemDetail.isHidden = false
            
        }
    }
    
    func fadeOutAnimation(){
                
        UIView.animate(withDuration: 1.5) {
            self.searchItemDetail.alpha = 0.0
           // self.searchItemDetail.isHidden = true
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fadeinAnimation()
        
    }
    
   
    @IBAction func dismissController(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
