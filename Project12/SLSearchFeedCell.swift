//
//  SLSearchFeedCell.swift
//  Project12
//
//  Created by Hicham Abou Jaoude on 2014-07-20.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

class SLSearchFeedCell: UICollectionViewCell {
    
    var header = UIView()
    var profilePhoto = UIImageView()
    var personName = UILabel()
    var subletStreet = UILabel()
    var subletPrice = UILabel()
    var quickInfo = UITextView()
    var footer = UIView()
    
    init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(header)
        self.contentView.addSubview(profilePhoto)
        self.contentView.layer.borderColor = UIColor.blackColor().CGColor
        self.contentView.layer.borderWidth = 0.5
        self.contentView.addSubview(personName)
        self.contentView.addSubview(subletStreet)
        self.contentView.addSubview(subletPrice)
        self.contentView.addSubview(footer)
        self.contentView.addSubview(quickInfo)
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        header.frame = CGRectMake(CGRectGetMinX(self.contentView.frame), CGRectGetMinY(self.contentView.frame), CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame)/7)
        header.backgroundColor = UIColor.whiteColor()
        header.layer.borderColor = UIColor.blackColor().CGColor
        header.layer.borderWidth = 0.5
        profilePhoto.frame = CGRectMake(CGRectGetMinX(header.frame) + 10 , CGRectGetMinY(header.frame) + 10, CGRectGetHeight(header.frame) - 20, CGRectGetHeight(header.frame) - 20)
        profilePhoto.layer.borderColor = UIColor.blackColor().CGColor
        profilePhoto.layer.borderWidth = 0.5
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.height / 2
        profilePhoto.backgroundColor = UIColor.whiteColor()
        profilePhoto.image = UIImage(named: "profile")
        subletStreet.frame = CGRectMake(CGRectGetMaxX(profilePhoto.frame) + 10 , CGRectGetMinY(self.profilePhoto.frame) + 20, CGRectGetWidth(header.frame) - CGRectGetMaxX(profilePhoto.frame) - 20, 23)
        subletStreet.text = "Waterloo, Ontario"
        subletStreet.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        subletPrice.frame = CGRectMake(CGRectGetMinX(self.contentView.frame) + 5, CGRectGetHeight(self.contentView.frame) / 2 + 20 , 50, 20)
        subletPrice.text = "$700"
        footer.frame = CGRectMake(CGRectGetMinX(self.contentView.frame), CGRectGetHeight(self.contentView.frame) / 1.5 + 20, CGRectGetWidth(self.contentView.frame),  CGRectGetHeight(self.contentView.frame) - (CGRectGetHeight(self.contentView.frame) / 1.5 + 20))
        footer.layer.borderColor = UIColor.blackColor().CGColor
        footer.layer.borderWidth = 0.5
        footer.backgroundColor = UIColor.whiteColor()
        quickInfo.frame = CGRectMake(CGRectGetMinX(footer.frame) + 15, CGRectGetMinY(footer.frame) + 15, CGRectGetWidth(footer.frame) - 30, CGRectGetHeight(footer.frame) - 30)
        
    }

}
