//
//  SMSegmentView.swift
//
//  Created by Si MA on 03/01/2015.
//  Copyright (c) 2015 Si Ma. All rights reserved.
//

import UIKit

/*
  Keys for segment properties
*/

// This is mainly for the top/bottom margin of the imageView
let keyContentVerticalMargin = "VerticalMargin"

// The colour when the segment is under selected/unselected
let keySegmentOnSelectionColour = "OnSelectionBackgroundColour"
let keySegmentOffSelectionColour = "OffSelectionBackgroundColour"

// The colour of the text in the segment for the segment is under selected/unselected
let keySegmentOnSelectionTextColour = "OnSelectionTextColour"
let keySegmentOffSelectionTextColour = "OffSelectionTextColour"

// The font of the text in the segment
let keySegmentTitleFont = "TitleFont"

public class SMSegmentView: SMBasicSegmentView {
    
    @IBInspectable public var segmentVerticalMargin: CGFloat = 5.0 {
        didSet {
            for segment in self.segments as! [SMSegment] {
                segment.verticalMargin = self.segmentVerticalMargin
            }
        }
    }
    
   
    // Segment Colour
    @IBInspectable public var segmentOnSelectionColour: UIColor = UIColor.darkGrayColor() {
        didSet {
            for segment in self.segments as! [SMSegment] {
                segment.onSelectionColour = self.segmentOnSelectionColour
            }
        }
    }
    @IBInspectable public var segmentOffSelectionColour: UIColor = UIColor.whiteColor() {
        didSet {
            for segment in self.segments as! [SMSegment] {
                segment.offSelectionColour = self.segmentOffSelectionColour
            }
        }
    }
    
    // Segment Title Text Colour & Font
    @IBInspectable public var segmentOnSelectionTextColour: UIColor = UIColor.whiteColor() {
        didSet {
            for segment in self.segments as! [SMSegment] {
                segment.onSelectionTextColour = self.segmentOnSelectionTextColour
            }
        }
    }
    @IBInspectable public var segmentOffSelectionTextColour: UIColor = UIColor.darkGrayColor() {
        didSet {
            for segment in self.segments as! [SMSegment] {
                segment.offSelectionTextColour = self.segmentOffSelectionTextColour
            }
        }
    }
    @IBInspectable public var segmentTitleFont: UIFont = UIFont.systemFontOfSize(17.0) {
        didSet {
            for segment in self.segments as! [SMSegment] {
                segment.titleFont = self.segmentTitleFont
            }
        }
    }
    
    public var segmentBadgeTextColor: UIColor = UIColor.blackColor() {
        didSet {
            for segment in self.segments as! [SMSegment] {
                segment.badgeTextColor = self.segmentBadgeTextColor
            }
        }
    }
    
    public var segmentBadgeColor: UIColor = UIColor.blackColor() {
        didSet {
            for segment in self.segments as! [SMSegment] {
                segment.badgeColor = self.segmentBadgeColor
            }
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    
    public init(frame: CGRect, separatorColour: UIColor, separatorWidth: CGFloat, segmentProperties: Dictionary<String, AnyObject>?) {
        
        super.init(frame: frame)
        
        self.separatorColour = separatorColour
        self.separatorWidth = separatorWidth
        
        if let margin = segmentProperties?[keyContentVerticalMargin] as? Float {
            self.segmentVerticalMargin = CGFloat(margin)
        }
        
        if let onSelectionColour = segmentProperties?[keySegmentOnSelectionColour] as? UIColor {
            self.segmentOnSelectionColour = onSelectionColour
        }
        else {
            self.segmentOnSelectionColour = UIColor.darkGrayColor()
        }
        
        if let offSelectionColour = segmentProperties?[keySegmentOffSelectionColour] as? UIColor {
            self.segmentOffSelectionColour = offSelectionColour
        }
        else {
            self.segmentOffSelectionColour = UIColor.whiteColor()
        }
        
        if let onSelectionTextColour = segmentProperties?[keySegmentOnSelectionTextColour] as? UIColor {
            self.segmentOnSelectionTextColour = onSelectionTextColour
        }
        else {
            self.segmentOnSelectionTextColour = UIColor.whiteColor()
        }
        
        if let offSelectionTextColour = segmentProperties?[keySegmentOffSelectionTextColour] as? UIColor {
            self.segmentOffSelectionTextColour = offSelectionTextColour
        }
        else {
            self.segmentOffSelectionTextColour = UIColor.darkGrayColor()
        }
        
        if let titleFont = segmentProperties?[keySegmentTitleFont] as? UIFont {
            self.segmentTitleFont = titleFont
        }
        else {
            self.segmentTitleFont = UIFont.systemFontOfSize(17.0)
        }
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    
    public func addSegmentWithTitle(title: String?, onSelectionImage: UIImage?, offSelectionImage: UIImage?, badgeText: String) -> SMSegment {
        
        let segment = SMSegment(verticalMargin: self.segmentVerticalMargin, onSelectionColour: self.segmentOnSelectionColour, offSelectionColour: self.segmentOffSelectionColour, onSelectionTextColour: self.segmentOnSelectionTextColour, offSelectionTextColour: self.segmentOffSelectionTextColour, titleFont: self.segmentTitleFont)
        
        segment.title = title
        segment.onSelectionImage = onSelectionImage
        segment.offSelectionImage = offSelectionImage
        segment.badgeColor = segmentBadgeColor
        segment.badgeTextColor = segmentBadgeTextColor
        segment.badgeText = badgeText
        super.addSegment(segment)
        
        return segment
    }
    
    ///If badge is empty string, will not show badge
    public func badgeText(text: String?, forSegmentIndex: Int) {
        if let segment = self.segments[forSegmentIndex] as? SMSegment {
            segment.badgeText = text
        }
    }
    
    public func enableBadge(enable: Bool, forSegmentIndex: Int) {
        if let segment = self.segments[forSegmentIndex] as? SMSegment {
            segment.badgeEnabled = enable
        }
    }
    
}
