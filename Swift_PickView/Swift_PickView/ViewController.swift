//
//  ViewController.swift
//  Swift_PickView
//
//  Created by 袁亮 on 2018/2/8.
//  Copyright © 2018年 Albert Yuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    lazy var dataArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //读取本地数据
        let path : String = Bundle.main.path(forResource: "foods", ofType: "plist")!
        dataArr = NSMutableArray(contentsOfFile: path)!

        
        pickerView(picker, didSelectRow: 0, inComponent: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


//datasource
extension ViewController {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataArr.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let arr:[String] = dataArr[component] as! [String]
        return arr.count
    }
}

//delegate
extension ViewController {
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat{
//    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        let arr:[String] = dataArr[component] as! [String]
        return arr[row] as String
        
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
//    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        let arr:[String] = dataArr[component] as! [String]
        labelView.text = arr[row]
        
        print("点击了：\(component)"+"_____"+"\(row)"+arr[row])
    }
   
}
