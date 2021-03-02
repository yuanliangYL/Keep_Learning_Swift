//
//  ViewController.swift
//  Limit Input Text Field
//
//  Created by nimo on 2017/5/8.
//  Copyright © 2017年 nimoAndHisFriends. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {

    var limitedTextView:UITextView!
    
    var allowInputNumberLabel:UILabel!

    var keyboardCurrntState: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white


        initNavigationBar()

        initInputField()

        //监听键盘
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }


    func initInputField() {

        let naviFrame = self.navigationController?.navigationBar.frame //导航栏frame
        let statusBarFrame = UIApplication.shared.statusBarFrame  //状态栏frame

        let avatarImgView = UIImageView(frame: CGRect(x: 0, y: (naviFrame?.height)! + statusBarFrame.height + 50, width: 70, height: 70))
        avatarImgView.image = #imageLiteral(resourceName: "avatar.jpg")
        self.view.addSubview(avatarImgView)
        
        limitedTextView = UITextView(frame: CGRect(x: 80, y: avatarImgView.frame.origin.y, width: self.view.frame.width - 70 - 20, height: 300))
        self.view.addSubview(limitedTextView)
        limitedTextView.delegate = self
        limitedTextView.font = UIFont.systemFont(ofSize: 20)
        limitedTextView.backgroundColor = UIColor.lightGray


        allowInputNumberLabel = UILabel(frame: CGRect(x: self.view.frame.width - 80, y: self.view.frame.height - 40, width: 50, height: 40))
        self.view.addSubview(allowInputNumberLabel)
        allowInputNumberLabel.text = "140"
        allowInputNumberLabel.textAlignment = .right
    }
    
    func initNavigationBar() {

        let leftItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem

        let rightItem = UIBarButtonItem(title: "Tweet", style: .plain, target: self, action: nil)
        rightItem.tintColor = UIColor.orange
        navigationItem.rightBarButtonItem = rightItem

    }
    
//    todo need to limit the paste action so that the length might be exceed!
    func textViewDidChange(_ textView: UITextView) {

        let currentCharactorCount = (textView.text?.count)!
        if  currentCharactorCount >= 140 {
            limitedTextView.resignFirstResponder()
        }
        allowInputNumberLabel.text = "\(140 - currentCharactorCount)"
    }


    //监听键盘移动
    @objc func keyboardWillChangeFrame(note: Notification) {


        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval

        let endFrame = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        let y = endFrame.origin.y
        
        //计算工具栏距离底部的间距
        let margin = UIScreen.main.bounds.height - y
        if keyboardCurrntState == margin {
            return
        }
        keyboardCurrntState = margin


        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: [], animations:{
//            键盘弹出
            if margin > 0 {
                self.allowInputNumberLabel.frame.origin.y = self.allowInputNumberLabel.frame.origin.y - margin
            }
//            键盘收起
            else {
                self.allowInputNumberLabel.frame.origin.y = self.view.frame.height - 40
            }

        } ,completion: nil)


    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        limitedTextView.endEditing(true)
    }
}

