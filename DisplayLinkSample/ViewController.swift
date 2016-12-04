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
        path.addArc(withCenter: CGPoint(x: frame.midX, y: frame.midY),
                    radius: frame.width / 2.0 - 20.0,
                    startAngle: CGFloat(-M_PI_2),
                    endAngle: CGFloat(M_PI + M_PI_2),
                    clockwise: true)
        secondLayer.path = path.cgPath
        secondLayer.strokeColor = UIColor.black.cgColor
        secondLayer.fillColor = UIColor.clear.cgColor
        secondLayer.speed = 0.0
        view.layer.addSublayer(secondLayer)

        // 円を描くアニメーション
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 60.0
        secondLayer.add(animation, forKey: "strokeCircle")

        // CADisplayLink設定
        let displayLink = CADisplayLink(target: self, selector: #selector(update(_:)))
        displayLink.preferredFramesPerSecond = 60   // FPS設定
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }

    func update(_ displayLink: CADisplayLink) {
        // timeOffsetに現在時刻の秒数を設定
        let time = Date().timeIntervalSince1970
        let seconds = floor(time).truncatingRemainder(dividingBy: 60)
        let milliseconds = time - floor(time)
        secondLayer.timeOffset = seconds + milliseconds
    }
}
