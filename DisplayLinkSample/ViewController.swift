//
//  ViewController.swift
//  DisplayLinkSample
//
//  Created by Keisuke Shoji on 2015/01/27.
//  Copyright (c) 2015年 VASILY Inc.,. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    private let secondLayer: CAShapeLayer = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 円のレイヤー
        let frame: CGRect = view.frame
        let path: UIBezierPath = .init()
        let margin: CGFloat = 20
        path.addArc(withCenter: CGPoint(x: frame.width / 2, y: frame.height / 2),
                    radius: frame.width / 2 - margin,
                    startAngle: CGFloat(-Double.pi / 2),
                    endAngle: CGFloat(Double.pi * 1.5),
                    clockwise: true)
        secondLayer.path = path.cgPath
        secondLayer.strokeColor = UIColor.black.cgColor
        secondLayer.fillColor = UIColor.clear.cgColor
        secondLayer.speed = 0
        view.layer.addSublayer(secondLayer)

        // 円を描くアニメーション
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 60
        secondLayer.add(animation, forKey: "strokeCircle")

        // CADisplayLink設定
        let displayLink: CADisplayLink = .init(target: self, selector: #selector(update(_:)))
        displayLink.preferredFramesPerSecond = 60   // FPS設定
        displayLink.add(to: .current, forMode: .common)
    }

    @objc private func update(_ displayLink: CADisplayLink) {
        // timeOffsetに現在時刻の秒数を設定
        let time: TimeInterval = Date().timeIntervalSince1970
        let seconds: TimeInterval = floor(time).truncatingRemainder(dividingBy: 60)
        let milliseconds: TimeInterval = time - floor(time)
        secondLayer.timeOffset = seconds + milliseconds
    }
}
