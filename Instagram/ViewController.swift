//
//  ViewController.swift
//  Instagram
//
//  Created by tyoko on 2016/09/15.
//  Copyright © 2016年 takayoshi.yokoyama. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTab()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //currentUserがnilならログインしていない
        if FIRAuth.auth()?.currentUser == nil {
            //ログインしていないときの処理
            dispatch_async(dispatch_get_main_queue()){
                let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(loginViewController!, animated: true, completion: nil)
            }
        }
    }
    
    
    func setupTab(){
        
        //画像のファイル名を指定してESTabBarControllerを作成する
        let tabBarController = ESTabBarController(tabIconNames: ["home", "camera", "setting"])
        //背景色、選択時の色を設定する
        tabBarController.selectedColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        tabBarController.buttonsBackgroundColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        //作成したESTabBarControllerを親のViewController(=self)に追加する。
        addChildViewController(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.view.frame = view.bounds
        tabBarController.didMoveToParentViewController(self)
        
        //タブをタップした時に表示するViewControllerを設定する。
        let homeViewController = storyboard?.instantiateViewControllerWithIdentifier("Home")
        let settingViewContrller = storyboard?.instantiateViewControllerWithIdentifier("Setting")
        
        tabBarController.setViewController(homeViewController, atIndex: 0)
        tabBarController.setViewController(settingViewContrller, atIndex: 2)
        
        //真ん中のタブはボタンとして扱う
        tabBarController.highlightButtonAtIndex(1)
        tabBarController.setAction({
            //ボタンが押されたらImageViewControllerをモーダルで表示する。
            let imageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ImageSelect")
            self.presentViewController(imageViewController!, animated: true, completion: nil)
        }, atIndex: 1)
        
        
    }


}

