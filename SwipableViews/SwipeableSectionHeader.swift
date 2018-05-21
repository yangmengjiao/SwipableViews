//
//  SwipeableSectionHeader.swift
//  SwipableViews
//
//  Created by mengjiao on 5/21/18.
//  Copyright © 2018 mengjiao. All rights reserved.
//

import UIKit

public protocol SwipeableSectionHeaderDelegate{
    func deleteSection(section: Int)
}

open class SwipeableSectionHeader: UIView {
   public var section:Int = 0
    
    var container:UIView!
   public var titleLabel:UILabel!
   public var deleteButton:UIButton!
    
   public var delegate:SwipeableSectionHeaderDelegate?//delegate
    
   public var swipeLeft:UISwipeGestureRecognizer!
    
   public var swipeRight:UISwipeGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.container = UIView()
        self.addSubview(container)
        self.titleLabel = UILabel()
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.textAlignment = .center
        self.container.addSubview(self.titleLabel)
        
        self.deleteButton = UIButton(type: .custom)
        self.deleteButton.backgroundColor = UIColor(red: 0xfc/255, green: 0x21/255,
                                                    blue: 0x25/255, alpha: 1)
        self.deleteButton.setTitle("delete order", for:.normal)
        self.deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.deleteButton.addTarget(self, action:#selector(buttonTapped(_:)), for:.touchUpInside)
        self.container.addSubview(self.deleteButton)
        
        self.swipeLeft = UISwipeGestureRecognizer(target:self,
                                                  action:#selector(headerViewSwiped(_:)))
        self.swipeLeft.direction = .left
        self.addGestureRecognizer(self.swipeLeft)
        
        self.swipeRight = UISwipeGestureRecognizer(target:self,
                                                   action:#selector(headerViewSwiped(_:)))
        self.swipeRight.direction = .right
        self.addGestureRecognizer(self.swipeRight)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func headerViewSwiped(_ recognizer:UISwipeGestureRecognizer){
        if recognizer.state == .ended {
            var newFrame = self.container.frame
            if recognizer.direction == .left {
                newFrame.origin.x = -self.deleteButton.frame.width
            }else{
                newFrame.origin.x = 0
            }
            UIView.animate(withDuration: 0.25, animations: {
                ()-> Void in
                self.container.frame = newFrame
            })
        }
    }
    
    @objc func buttonTapped(_ button:UIButton){
        delegate?.deleteSection(section: section)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.container.frame = CGRect(x: 0, y:0, width:self.frame.width + 100,
                                      height:self.frame.height)
        self.titleLabel.frame = CGRect(x: 16, y:0, width:self.frame.width,
                                       height:self.frame.height)
        self.titleLabel.textAlignment = .left
        self.deleteButton.frame = CGRect(x: self.frame.size.width, y:0, width:100,
                                         height:self.frame.height)
    }
}
