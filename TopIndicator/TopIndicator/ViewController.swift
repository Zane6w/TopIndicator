//
//  ViewController.swift
//  TopIndicator
//
//  Created by zhi zhou on 2016/10/21.
//  Copyright © 2016年 zhi zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:- 属性
    /// 指示器View
    @IBOutlet weak var IndicatorView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupIndicator()
        
//        let statusBar = UIApplication.shared.statusBarOrientation
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.orientationChanged), name: Notification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- 指示器位移动画
    func setupIndicator() {
        let indicatorAnimate = CABasicAnimation(keyPath: "position")
        
        let portraitwidth = view.bounds.size.width
        let landscapeWidth = view.bounds.size.width
        
        // 获取状态栏横竖屏状态
        let statusBar = UIApplication.shared.statusBarOrientation
        
        // 竖屏时
        if UIInterfaceOrientationIsPortrait(statusBar) {
            indicatorAnimate.fromValue = NSValue(cgPoint: CGPoint(x: -portraitwidth, y: 0))
            indicatorAnimate.toValue = NSValue(cgPoint: CGPoint(x: portraitwidth * 2, y: 0))
            indicatorAnimate.duration = 1.5
            print("竖屏")
        }
        
        if UIInterfaceOrientationIsLandscape(statusBar) {
            // 横屏时
            indicatorAnimate.fromValue = NSValue(cgPoint: CGPoint(x: -landscapeWidth, y: 0))
            indicatorAnimate.toValue = NSValue(cgPoint: CGPoint(x: landscapeWidth * 2, y: 0))
            indicatorAnimate.duration = 1.5
            print("横屏")
        }

        indicatorAnimate.repeatCount = MAXFLOAT
        indicatorAnimate.isRemovedOnCompletion = false
        
        IndicatorView.layer.add(indicatorAnimate, forKey: nil)
    }
    
    // MARK:- 监听屏幕旋转
    func orientationChanged(note: Notification) {
        setupIndicator()
    }
    
    override func removeObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        NotificationCenter.removeObserver(self, forKeyPath: "UIApplicationDidChangeStatusBarOrientation")
    }
}

