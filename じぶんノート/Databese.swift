//
//  File.swift
//  じぶんノート
//
//  Created by kuroda takumi on 2015/12/25.
//  Copyright © 2015年 BiyousiNote.inc. All rights reserved.
//

import Foundation
import RealmSwift

class User:Object{
    
    dynamic var id = 0
    dynamic var createDate:NSDate?
    dynamic var editdate:NSDate?
    dynamic var userName:String?
    dynamic var worksArea:String?
    //美容師か、理容師か、学生か
    dynamic var works:String?
    //職業歴
    dynamic var worksYear = 0
    //目標
    dynamic var myGoal:String?
    //一言自己紹介
    dynamic var onePhrase:String?
    
    //性別
    dynamic var sex:String?
    
    dynamic var passWord:String?
    dynamic var Email:String?
    
    //写真の名前
    dynamic var userPhotoName:String?
    
    override class func primaryKey() -> String{
        
        return "id"
    }
    
    
}


class Note:Object{
    
    dynamic var id = 0
    dynamic var createDate:NSDate?
    dynamic var editDate:NSDate?
    dynamic var noteText = ""
    dynamic var modelName = ""
    dynamic var timerTime = 0
    
    override class func primaryKey() -> String{
        return "id"
        
    }
    
    let photos = List<Photos>()
    
}


class Photos:Object{
    dynamic var id = 0
    dynamic var createDate:NSDate?
    dynamic var filename = ""
    
     var note:[Note]{
        return linkingObjects(Note.self, forProperty:"photos")
    }
    
    override class func primaryKey() -> String{
        
        return "id"
    }
    
}


class Reminder:Object{
    dynamic var id = 0
    dynamic var createDate:NSDate?
    dynamic var editDate:NSDate?
    //タイムは仮にintにしておく
    dynamic var Time:NSDate?
    //0はオフ、1はオン。
    dynamic var repitition = 0

    override class func primaryKey() -> String{
        return "id"
    }
    
    
}