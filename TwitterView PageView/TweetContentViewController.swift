//
//  TweetContentViewController.swift
//  TwitterView PageView
//
//  Created by r-neil 10/10/2015.
//  Copyright © 2015 r-neil. All rights reserved.
//

import UIKit

class TweetContentViewController: UIViewController {
    
    @IBOutlet weak private var tweetDisplayName: UILabel!
    @IBOutlet weak private var tweetUserName: UILabel!
    @IBOutlet weak private var tweetMessage: UILabel!
    @IBOutlet weak private var tweetUserImg: UIImageView!
    @IBOutlet weak private var tweetCreateTime: UILabel!
    @IBOutlet weak private var tweetCreateDate: UILabel!
    
    private var createDate : String?
    private var createTime : String?
    private var displayName : String?
    private var userName : String?
    private var message : String?
    private var userImg :  UIImage?
    
    var pageViewIndex: Int?
    var testText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if createDate != nil{
        tweetCreateDate.text = createDate
        tweetCreateTime.text = createTime
        tweetUserName.text = userName
        tweetDisplayName.text = displayName
        tweetMessage.text = message
        tweetUserImg.image = userImg
        tweetUserImg.layer.cornerRadius = 10
        tweetUserImg.clipsToBounds = true
            
        }
    }
    func createTweetView(singleTweet:Tweet){
        createDate = singleTweet.getTweetDate
        createTime = singleTweet.getTweetTime
        displayName = singleTweet.tweetUserDisplayName
        userName = singleTweet.tweetUserName
        message = singleTweet.tweetMessage
        userImg = singleTweet.tweetUserProfileImg
    }
    
}
