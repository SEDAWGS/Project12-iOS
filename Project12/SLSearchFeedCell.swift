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
        self.contentView.addSubview(header)
        self.contentView.addSubview(profilePhoto)
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
        profilePhoto.frame = CGRectMake(CGRectGetMinX(self.header.frame) + 15 , CGRectGetMinY(self.header.frame) + 15, CGRectGetWidth(self.header.frame), CGRectGetHeight(self.header.frame) - 30)
        //subletStreet.frame =
        
    }

}
