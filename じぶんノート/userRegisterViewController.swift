//
//  userRegisterViewController.swift
//  じぶんノート
//
//  Created by kuroda takumi on 2016/04/22.
//  Copyright © 2016年 BiyousiNote.inc. All rights reserved.
//

import UIKit

class userRegisterViewController: UIViewController,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    
    @IBOutlet weak var myGoalTextViewPlaceHolder: UILabel!
    
    var appDelegate:AppDelegate!
    
    var keyBoardToolBar:UIToolbar?
    var pickerView:UIPickerView?
    
    let userWork:NSArray = ["美容師","理容師","美容専門学生","理容専門学生"]
    let userWorksYear:NSArray = ["１年目","２年目","３年目","４年目","５年目","６年目","７年目","８年目","９年目","１１年目","１２年目","１３年目","１４年目","１５年目","１６年目","１７年目","１８年目","１９年目","２０年目","２１年目","２２年目","２３年目","１０年目","２４年目","２５年目","２６年目","２７年目","２８年目","２９年目","３０年目","３１年目","３２年目","３３年目","３４年目","３５年目","３６年目","３７年目","３８年目","３９年目","４０年目","４１年目","４２年目","４３年目","４４年目","４５年目","４６年目","４７年目","４８年目","４９年目","５０年目","５１年目","５２年目","５３年目","５４年目","５５年目","５６年目","５７年目","５８年目","５９年目","６０年目"]
    
    @IBOutlet weak var PhotoButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var myGorlTextView: UITextView!
    @IBOutlet weak var myGorlButton: UIButton!
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userYearField: UITextField!
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    //ユーザー名と年数の選択中の方を入れる
    var textActiveField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        PhotoButton.backgroundColor = colorFromRGB.colorWithHexString("B0C4DE")
        PhotoButton.layer.cornerRadius = 50
        PhotoButton.layer.masksToBounds = true
        
        userImageView.layer.cornerRadius = 50
        userImageView.layer.masksToBounds = true
        userImageView.contentMode = .ScaleAspectFill
        userImageView.clipsToBounds = true
        
        usernameTextField.placeholder = "トリムさん"
        userYearField.placeholder = "美容師１年目"
        userYearField.tag = 1
        
        usernameTextField.delegate = self
        userYearField.delegate = self
        myGorlTextView.delegate = self
        
        
        self.pickerView = UIPickerView()
        self.pickerView?.delegate = self
        self.pickerView?.showsSelectionIndicator = true
        self.pickerView?.backgroundColor = UIColor.whiteColor()
        
        
        self.keyBoardToolBar = UIToolbar(frame:CGRectMake(0,0,self.view.bounds.width,38))
        
        
        let spacebarItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace,target: nil,action: nil)
        let doneButton = UIBarButtonItem(title: "完了",style: .Plain,target: self,action: Selector("pickerDoneButtontaped"))
        
        self.keyBoardToolBar?.setItems([spacebarItem,doneButton], animated: true)
        
        self.userYearField.inputAccessoryView = self.keyBoardToolBar
        self.userYearField.inputView = self.pickerView
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        myGorlTextView.text = appDelegate.myGoal
        
        if appDelegate.myGoal != nil{
            
            myGoalTextViewPlaceHolder.hidden = true
        }else{
            myGoalTextViewPlaceHolder.hidden = false
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(userRegisterViewController.keyboardWillShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(userRegisterViewController.keyBoardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    
    func pickerDoneButtontaped(){
    
        userYearField.resignFirstResponder()
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (component == 0){
            
            return userWork.count
        }else{
            
            return userWorksYear.count
        }
        
    }
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (component == 0){
            
            return userWork[row] as? String
        }else{
            
            return userWorksYear[row] as? String
            
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //選択されてる列を取得
        let row01:NSInteger = pickerView.selectedRowInComponent(0)
        let row02:NSInteger = pickerView.selectedRowInComponent(1)
        
        self.userYearField.text = "\(userWork[row01]) \(userWorksYear[row02])"
        
        
    }
    
    //ピッカーの列数
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func keyboardWillShown(notification:NSNotification){
        
        //選択されたフィールドが年数で、かつtextFieldが空だったら
        if textActiveField.tag == 1 && textActiveField.text == ""{
            
            textActiveField.text = "美容師１年目"
        }
        
        if let userInfo = notification.userInfo{
            if let keyBoradFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue(),animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue{
                //スクロールビューの位置をデフォルトに戻す。
                restoreScrollViewSize()
                
                //キーボードのフレームサイズをスクロールビュー上の座標に転換
                let convertedKeyBoardFrame = scrollview.convertRect(keyBoradFrame, fromView: nil)
                //選択されているテキストフィールドy座標からキーボードのY座標を引く
                let offSetY:CGFloat = CGRectGetMaxY(textActiveField.frame) - CGRectGetMinY(convertedKeyBoardFrame)
                
                //
                if offSetY < 0{return}
                
                updateScrollViewSize(offSetY,duration:animationDurarion)
            }
            
        }
        
    }
    
    
    
    func updateScrollViewSize(moveSize:CGFloat,duration:NSTimeInterval){
    
        UIView.beginAnimations("ResizeForKeyBoard", context: nil)
        UIView.setAnimationDuration(duration)
        
        let contentsInSet = UIEdgeInsetsMake(0, 0, moveSize, 0)
        scrollview.contentInset = contentsInSet
        scrollview.scrollIndicatorInsets = contentsInSet
        scrollview.contentOffset = CGPointMake(0, moveSize)
        
        UIView.commitAnimations()
        
    }
    
    
    //スクロールビューの位置をデフォルトに戻す。
    func restoreScrollViewSize(){
    
        scrollview.contentInset = UIEdgeInsetsZero
        scrollview.scrollIndicatorInsets = UIEdgeInsetsZero
        
    }
    
    
    func keyBoardWillHide(notification:NSNotification){
        
        restoreScrollViewSize()
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        //選択中のフィールドを入れる
        textActiveField = textField
        
        return true
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //リターンを押されたらキーボード閉じる。
        //textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    
    @IBAction func photoButtonTaped(sender: AnyObject) {
        
    
        let alert:UIAlertController = UIAlertController(title: "プロフィール写真を設定",message: "",preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction:UIAlertAction = UIAlertAction(title: "キャンセル",style:UIAlertActionStyle.Cancel,handler: {(action:UIAlertAction)-> Void in
            
            print("キャンセル")
            
        })
        
        let cameraAction = UIAlertAction(title: "写真を撮る",style: UIAlertActionStyle.Default,handler: {(action:UIAlertAction)-> Void in
            
            self.cameraStart()
            
        })
        
        let PhotosAction = UIAlertAction(title: "アルバムから選ぶ",style: UIAlertActionStyle.Default,handler: {(action:UIAlertAction)-> Void in
            
            self.selectFromAlbum()
            
        })
        
        let deletePhoto = UIAlertAction(title: "写真を削除",style: UIAlertActionStyle.Default,handler:{(action:UIAlertAction)-> Void in
            
            self.imageDelete()
            
            
        })
        
        alert.addAction(cancelAction)
        alert.addAction(cameraAction)
        alert.addAction(PhotosAction)
        
        if userImageView.image != nil{
            
            alert.addAction(deletePhoto)
            
        }
        
        presentViewController(alert, animated: true, completion: nil)

        
        
    }
    
    
    
    
    //アルアムから写真を選択
    func selectFromAlbum(){
    
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        albumPicker.allowsEditing = true
        albumPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(albumPicker, animated: true, completion: nil)
        
    }
    
    
    
    
    
    func cameraStart(){
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.Camera
        //カメラが利用可能かチェック
         if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            //インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            self.presentViewController(cameraPicker, animated: true, completion: nil)
         }else{
            
            print("エラー")
            
        }
        
    }
    
    
    //撮影が完了した時に呼ばれる
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            userImageView.image = pickedImage
            
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    //撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    func imageDelete(){
    
        userImageView.image = nil
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        
        //performSegueWithIdentifier("toReminder", sender: nil)
    }
    @IBAction func myGoalButtonTaped(sender: AnyObject) {
        
        let textViewController:userRegisterTextViewController = storyboard?.instantiateViewControllerWithIdentifier("userRegisterTextView") as! userRegisterTextViewController
        
        let navigation = UINavigationController()
        navigation.viewControllers = [textViewController]
        
        presentViewController(navigation, animated: true, completion: nil)
        
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
