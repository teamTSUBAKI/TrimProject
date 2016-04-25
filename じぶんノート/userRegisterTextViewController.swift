//
//  userRegisterTextViewController.swift
//  じぶんノート
//
//  Created by kuroda takumi on 2016/04/25.
//  Copyright © 2016年 BiyousiNote.inc. All rights reserved.
//

import UIKit

class userRegisterTextViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConst: NSLayoutConstraint!
    
    var appDelegate:AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.grayColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //キーボード立ち上げ
        self.textView.becomeFirstResponder()
        
        let okButton = UIBarButtonItem(title: "ok",style: .Plain,target: self,action: #selector(userRegisterTextViewController.okButtonTaped))
        self.navigationItem.rightBarButtonItem = okButton
        
        textView.text = appDelegate.myGoal

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //アナリティクス
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: "userGoalTextView")
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject:AnyObject])

        self.textView.textContainerInset = UIEdgeInsetsMake(8, 8, 0, 8)
        self.textView.sizeToFit()
        
        //キーボードの動きを察知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
    }
    
    func keyBoardWillChangeFrame(notification:NSNotification){
        
        if let userInfo = notification.userInfo{
            
            let keyBoardValue:NSValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
            let keyBoardFrame:CGRect = keyBoardValue.CGRectValue()
            
            //テキストビューのボトムからの高さをキーボードの高さにする。
            self.textViewBottomConst.constant = keyBoardFrame.height
            
        }
        
        
    }
    
    func okButtonTaped(){
        
        appDelegate.myGoal = textView.text
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
