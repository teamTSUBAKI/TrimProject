//
//  userRegisterViewController.swift
//  じぶんノート
//
//  Created by kuroda takumi on 2016/04/22.
//  Copyright © 2016年 BiyousiNote.inc. All rights reserved.
//

import UIKit

class userRegisterViewController: UIViewController,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    
    
    @IBOutlet weak var PhotoButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var myGorlTextView: UITextView!
    @IBOutlet weak var myGorlButton: UIButton!
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userYearField: UITextField!
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoButton.backgroundColor = colorFromRGB.colorWithHexString("B0C4DE")
        PhotoButton.layer.cornerRadius = 50
        PhotoButton.layer.masksToBounds = true
        
        userImageView.layer.cornerRadius = 50
        userImageView.layer.masksToBounds = true
        userImageView.contentMode = .ScaleAspectFill
        userImageView.clipsToBounds = true
        
        usernameTextField.placeholder = "トリムさん"
        userYearField.placeholder = "美容師2年目"
        
        
        
        // Do any additional setup after loading the view.
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
