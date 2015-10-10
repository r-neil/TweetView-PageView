//
//  MainViewController.swift
//  TwitterView PageView
//
//  Created by r-neil 10/10/2015.
//  Copyright © 2015 r-neil. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPageViewControllerDataSource, TwitterRequestDelegate, UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var pageViewController : UIPageViewController?
    var pageController = UIPageControl.appearance()
    
    
    private var TwitterRequester = TwitterRequest()
    private var arrayOfTweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageViewController()
        setupPageIndicators()
        TwitterRequester.delegate = self
        userNameTextField.delegate = self
        pageViewController!.dataSource = self
        userNameTextField.text = randomTwitterUsername()
    }

    struct Storyboard {
        static let segueToPageVC = "Segue Page View Controller"
        static let tweetVC = "Tweet Content View Controller"
    }
    
    //MARK: PageViewController Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.segueToPageVC{
            pageViewController = segue.destinationViewController as? UIPageViewController
        }
    }
    
    func setupPageViewController(){
        let startVC = tweetViewControllerAtIndex(0)
        let VCArray = [startVC]
        pageViewController?.setViewControllers(VCArray, direction: .Forward, animated: true, completion: nil)
    }
    
    //MARK: PageViewController Data Source Delegates
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentVC = viewController as! TweetContentViewController
        var currentIndex = currentVC.pageViewIndex!
        
        if currentIndex == arrayOfTweets.count-1{
            return nil
        }else{
            currentIndex++
            return tweetViewControllerAtIndex(currentIndex)
        }
    }
        
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentVC = viewController as! TweetContentViewController
        var currentIndex = currentVC.pageViewIndex!
        
        if currentIndex == 0{
            return nil
        }else{
            currentIndex--
            return tweetViewControllerAtIndex(currentIndex)
        }
    }
        
    //MARK: Twitter Content Views
    
    func tweetViewControllerAtIndex(index: Int) -> TweetContentViewController{
        if arrayOfTweets.count == 0{
            return TweetContentViewController()
            //no tweets available
        }else{
            let tweetViewToDisplay = storyboard?.instantiateViewControllerWithIdentifier(Storyboard.tweetVC) as? TweetContentViewController
            tweetViewToDisplay?.pageViewIndex = index
            tweetViewToDisplay?.createTweetView(arrayOfTweets[index])
            return tweetViewToDisplay!
        }
    }
    
    //MARK: Setup Page Indicators
    
    func setupPageIndicators(){
        pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageController.currentPageIndicatorTintColor = UIColor.blackColor()
        pageController.backgroundColor = UIColor.whiteColor()
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return arrayOfTweets.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    //MARK: Tweet Content Delegate
    
    func returnArrayOfTweets(tweets:Array<Tweet>){
        spinner.stopAnimating() 
        arrayOfTweets += tweets
        setupPageViewController()
        setupPageIndicators()
    }
    
    //MARK: Textfield Delegage 
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != ""{
            let firstChar = textField.text![textField.text!.startIndex]
            if firstChar == "@"{
                spinner.startAnimating()
                arrayOfTweets.removeAll()
                TwitterRequester.searchTwitter(textField.text!)
            }
        }
        return true
    }
    
    //MARK: Auto Twitter Name Generator
    let sampleTwitterArray = ["@Snowden","@007","@SethMacFarlane","@SpaceX","@tim_cook","@JerrySeinfeld","@elonmusk"]
    
    func randomTwitterUsername() ->String{
        let randomIndex = Int(arc4random_uniform(UInt32(sampleTwitterArray.count)))
        return sampleTwitterArray[randomIndex]
    }
    
}


