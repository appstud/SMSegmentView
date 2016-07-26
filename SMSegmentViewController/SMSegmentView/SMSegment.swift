//
//  SMSegment.swift
//
//  Created by Si MA on 03/01/2015.
//  Copyright (c) 2015 Si Ma. All rights reserved.
//

import UIKit

public class SMSegment: SMBasicSegment {
    
    // UI Elements
    override public var frame: CGRect {
        didSet {
            self.resetContentFrame()
        }
    }
    
    public var verticalMargin: CGFloat = 5.0 {
        didSet {
            self.resetContentFrame()
        }
    }
        
    // Segment Colour
    public var onSelectionColour: UIColor = UIColor.darkGrayColor() {
        didSet {
            if self.isSelected == true {
                self.backgroundColor = self.onSelectionColour
            }
        }
    }
    public var offSelectionColour: UIColor = UIColor.whiteColor() {
        didSet {
            if self.isSelected == false {
                self.backgroundColor = self.offSelectionColour
            }
        }
    }
    private var willOnSelectionColour: UIColor! {
        get {
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var brightness: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            self.onSelectionColour.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            return UIColor(hue: hue, saturation: saturation*0.5, brightness: min(brightness*1.5, 1.0), alpha: alpha)
        }
    }
    
    // Segment Title Text & Colour & Font
    public var title: String? {
        didSet {
            self.label.text = self.title
            
            if let titleText = self.label.text as NSString? {
                self.labelWidth = titleText.boundingRectWithSize(CGSize(width: self.frame.size.width, height: self.frame.size.height), options:NSStringDrawingOptions.UsesLineFragmentOrigin , attributes: [NSFontAttributeName: self.label.font], context: nil).size.width
            }
            else {
                self.labelWidth = 0.0
            }
            
            self.resetContentFrame()
        }
    }
    public var onSelectionTextColour: UIColor = UIColor.whiteColor() {
        didSet {
            if self.isSelected == true {
                self.label.textColor = self.onSelectionTextColour
            }
        }
    }
    public var offSelectionTextColour: UIColor = UIColor.darkGrayColor() {
        didSet {
            if self.isSelected == false {
                self.label.textColor = self.offSelectionTextColour
            }
        }
    }
    public var titleFont: UIFont = UIFont.systemFontOfSize(17.0) {
        didSet {
            self.label.font = self.titleFont
            
            if let titleText = self.label.text as NSString? {
                self.labelWidth = titleText.boundingRectWithSize(CGSize(width: self.frame.size.width + 1.0, height: self.frame.size.height), options:NSStringDrawingOptions.UsesLineFragmentOrigin , attributes: [NSFontAttributeName: self.label.font], context: nil).size.width
            }
            else {
                self.labelWidth = 0.0
            }
            
            self.resetContentFrame()
        }
    }
    
    // Segment Image
    public var onSelectionImage: UIImage? {
        didSet {
            if self.onSelectionImage != nil {
                self.resetContentFrame()
            }
            if self.isSelected == true {
                self.imageView.image = self.onSelectionImage
            }
        }
    }
    public var offSelectionImage: UIImage? {
        didSet {
            if self.offSelectionImage != nil {
                self.resetContentFrame()
            }
            if self.isSelected == false {
                self.imageView.image = self.offSelectionImage
            }
        }
    }
    
    public var badgeTextColor: UIColor = .blackColor() {
        didSet {
            self.badge.textColor = self.badgeTextColor
        }
    }
    
    public var badgeColor: UIColor = .redColor() {
        didSet {
            self.badge.badgeColor = self.badgeColor
        }
    }
    
    ///If setting this text not empty nor nil, it will automatically re-enable badge (hidden = false)
    public var badgeText: String? = "" {
        didSet {
            
            guard let text = badgeText else {
                self.badgeEnabled = false
                return
            }
            
            if text.isEmpty {
                self.badgeEnabled = false
                return
            }
            self.badgeEnabled = true
            self.badge.text = badgeText
            self.layoutIfNeeded()
        }
    }
    
    public var badgeEnabled: Bool = false {
        didSet {
            self.badge.hidden = !badgeEnabled
        }
    }
    
    private var imageView: UIImageView = UIImageView()
    private var badge = SwiftBadge()
    private var label: UILabel = UILabel()
    private var labelWidth: CGFloat = 0.0
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(verticalMargin: CGFloat, onSelectionColour: UIColor, offSelectionColour: UIColor, onSelectionTextColour: UIColor, offSelectionTextColour: UIColor, titleFont: UIFont) {
        
        self.verticalMargin = verticalMargin
        self.onSelectionColour = onSelectionColour
        self.offSelectionColour = offSelectionColour
        self.onSelectionTextColour = onSelectionTextColour
        self.offSelectionTextColour = offSelectionTextColour
        self.titleFont = titleFont
        
        super.init(frame: CGRectZero)
        self.setupUIElements()
    }
    
    
    
    func setupUIElements() {
        
        self.backgroundColor = self.offSelectionColour
        
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(self.imageView)
        self.configureBadge()
        self.positionBadgeToImage()
        
        self.label.textAlignment = NSTextAlignment.Center
        self.label.font = self.titleFont
        self.label.textColor = self.offSelectionTextColour
        self.addSubview(self.label)
    }
    
    private func configureBadge() {
        badge.text = "3"
        badge.insets = CGSize(width: 5, height: 5)
        badge.textColor = UIColor.blackColor()
        badge.font = UIFont.systemFontOfSize(12)
        badge.badgeColor = UIColor.redColor()
//        badge.shadowOpacityBadge = 0.5
//        badge.shadowOffsetBadge = CGSize(width: 0, height: 0)
//        badge.shadowRadiusBadge = 1.0
//        badge.shadowColorBadge = UIColor.blackColor()
    }
    
    private func positionBadgeToImage() {
        imageView.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(NSLayoutConstraint(item: badge, attribute: .Left, relatedBy: .Equal, toItem: imageView, attribute: .Right, multiplier: 1.0, constant: 3))
        constraints.append(NSLayoutConstraint(item: badge, attribute: .CenterY, relatedBy: .Equal, toItem: imageView, attribute: .Top, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: badge, attribute: .Height, relatedBy: .Equal, toItem: imageView, attribute: .Height, multiplier: 0.8, constant: 0))
        //constraints.append(NSLayoutConstraint(item: badge, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: badge, attribute: .Width, multiplier: 1, constant: 0))
        
        self.addConstraints(constraints)
    }
    
    
    // MARK: Update Frame
    private func resetContentFrame() {
        
        var distanceBetween: CGFloat = 0.0
        var imageViewFrame = CGRectMake(0.0, self.verticalMargin, 0.0, self.frame.size.height - self.verticalMargin*2)
        
        if self.onSelectionImage != nil || self.offSelectionImage != nil {
            // Set imageView as a square
            imageViewFrame.size.width = self.frame.size.height - self.verticalMargin*2
            distanceBetween = 5.0
        }
        
        // If there's no text, align imageView centred
        // Else align text centred
        if self.labelWidth == 0.0 {
            imageViewFrame.origin.x = max((self.frame.size.width - imageViewFrame.size.width) / 2.0, 0.0)
        }
        else {
            imageViewFrame.origin.x = max((self.frame.size.width - imageViewFrame.size.width - self.labelWidth) / 2.0 - distanceBetween, 0.0)
        }
        
        self.imageView.frame = imageViewFrame
        
        self.label.frame = CGRectMake(imageViewFrame.origin.x + imageViewFrame.size.width + distanceBetween, self.verticalMargin, self.labelWidth, self.frame.size.height - self.verticalMargin * 2)
    }
    
    // MARK: Selections
    override public func setSelected(selected: Bool, inView view: SMBasicSegmentView) {
        super.setSelected(selected, inView: view)
        if selected {
            self.backgroundColor = self.onSelectionColour
            self.label.textColor = self.onSelectionTextColour
            self.imageView.image = self.onSelectionImage
        }
        else {
            self.backgroundColor = self.offSelectionColour
            self.label.textColor = self.offSelectionTextColour
            self.imageView.image = self.offSelectionImage
        }
    }
    
    // MARK: Handle touch
    override public  func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        if self.isSelected == false {
            self.backgroundColor = self.willOnSelectionColour
        }
    }
    
}