//
//  ViewController.swift
//  DisplayLinkSample
//
//  Created by Keisuke Shoji on 2015/01/27.
//  Copyright (c) 2015年 VASILY Inc.,. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let secondLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 円のレイヤー
        let frame = view.frame
        let path = UIBezierPath()
        path.addArcWithCenter(
            CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)),
            radius: frame.width / 2.0 - 20.0,
            startAngle: CGFloat(-M_PI_2),
            endAngle: CGFloat(M_PI + M_PI_2),
            clockwise: true)
        secondLayer.path = path.CGPath
        secondLayer.strokeColor = UIColor.blackColor().CGColor
        secondLayer.fillColor = UIColor.clearColor().CGColor
        secondLayer.speed = 0.0
        view.layer.addSublayer(secondLayer)

        // 円を描くアニメーション
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 60.0
        secondLayer.addAnimation(animation, forKey: "strokeCircle")

        // CADisplayLink設定
        let displayLink = CADisplayLink(target: self, selector: Selector("update:"))
        displayLink.frameInterval = 1   // 1フレームごとに実行
        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }

    func update(displayLink: CADisplayLink) {
        // timeOffsetに現在時刻の秒数を設定
        let time = NSDate().timeIntervalSince1970
        let seconds = floor(time) % 60
        let milliseconds = time - floor(time)
        secondLayer.timeOffset = seconds + milliseconds
    }
}
