//
//  SLTextFieldCell.swift
//  Project12
//
//  Created by Hicham Abou Jaoude on 2014-07-19.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//



class SLTextFieldCell: UITableViewCell {
    
    var textField = UITextField()
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        textField.font  = UIFont(name: "HelveticaNeue-Light" , size: 16.0)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(textField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = CGRectMake(CGRectGetMinX(self.contentView.frame) + 15, CGRectGetMinY(self.contentView.frame), CGRectGetWidth(self.contentView.frame) - 15, CGRectGetHeight(self.contentView.frame))
    }

}
