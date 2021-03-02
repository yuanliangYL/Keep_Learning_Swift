//
//  ViewController.swift
//  CustomFont
//
//  Created by nimo on 18/03/2017.
//  Copyright © 2017 nimo. All rights reserved.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "I am the king of the world"
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)

        label.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalTo(self.view)
        }

        label.font = UIFont.systemFont(ofSize: 30)
        
        let changeBtn = UIButton(type: .custom)
        changeBtn.setTitle("Change Font Family", for: UIControlState.normal)
        changeBtn.addTarget(self, action: #selector(changeFontFamily), for: .touchUpInside)
        changeBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        self.view.addSubview(changeBtn)
        changeBtn.layer.borderColor = UIColor.blue.cgColor
        changeBtn.layer.borderWidth = 1
        changeBtn.layer.cornerRadius = 22

        changeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(500)
            make.centerX.equalTo(self.view)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }


        printAllSupportedFontNames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @objc func changeFontFamily() {

        label.font = UIFont(name: "Avenir Next", size: 30)
    }
    
    func printAllSupportedFontNames() {

        //字体
        let familyNames = UIFont.familyNames

        for familyName in familyNames {
            print("++++++ \(familyName)")

            //字体对应的类型
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print("----- \(fontName)")
            }
        }
    }

}

