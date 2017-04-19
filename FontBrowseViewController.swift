//
//  FontBrowseViewController.swift
//  FontAndEmojiCollection
//
//  Created by Zenny Chen on 2017/4/1.
//  Copyright © 2017年 CodeLearning Studio. All rights reserved.
//

import UIKit

class FontBrowseViewController: UIViewController {
    
    private var mTitleBanner: UIImageView!
    private var mTitleLabel: UILabel!
    private var mBackButton: UIButton!
    private var mTextView: UITextView!
    
    var baseController: FontsViewController!
    var fontName: String!
    
    /**
    deinit {
        print("FontBrowseViewController dealloced!")
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        let viewSize = self.view.frame.size
        let util = Utilities.instance
        
        let barSize = UIApplication.shared.statusBarFrame.size
        let barHeight = barSize.width < barSize.height ? barSize.width : barSize.height
        let titleFrame = CGRect(x: 0.0, y: barHeight, width: viewSize.width, height: 35.0 * util.screenScale.height)
        
        mTitleBanner = UIImageView(frame: titleFrame)
        mTitleBanner.image = UIImage(named: "title_banner")
        mTitleBanner.isUserInteractionEnabled = true
        self.view.addSubview(mTitleBanner)
        
        let backButtonX = (util.isPhone ? 10.0 : 2.0) * util.screenScale.width
        let backButtonSize = CGSize(width: 32.0 * util.screenScale.width, height: 22.4 * util.screenScale.height)
        
        let labelX = backButtonX + backButtonSize.width
        
        mTitleLabel = UILabel(frame: CGRect(x: labelX, y: titleFrame.origin.y, width: titleFrame.size.width - labelX, height: titleFrame.size.height))
        mTitleLabel.font = UIFont(name: "Helvetica-Bold", size: 18.0 * util.fontScale)
        mTitleLabel.textAlignment = .center
        mTitleLabel.textColor = .white
        mTitleLabel.adjustsFontSizeToFitWidth = true
        mTitleLabel.minimumScaleFactor = 0.4
        mTitleLabel.text = fontName
        self.view.addSubview(mTitleLabel)
        
        mBackButton = UIButton(type: .custom)
        mBackButton.frame = CGRect(x: backButtonX, y: (titleFrame.size.height - backButtonSize.height) * 0.5, width: backButtonSize.width, height: backButtonSize.height)
        mBackButton.setImage(UIImage(named: "baritem_back.png"), for: .normal)
        mBackButton.addTarget(self, action: #selector(backButtonTouched(sender:)), for: .touchUpInside)
        mTitleBanner.addSubview(mBackButton)
        
        let textXPos = 10.0 * util.screenScale.width
        let textYPos = titleFrame.origin.y + titleFrame.size.height
        let textHeight = (viewSize.height - ViewController.tabBarHeight) - textYPos
        mTextView = UITextView(frame: CGRect(x: textXPos, y: textYPos, width: viewSize.width - 2.0 * textXPos, height: textHeight))
        mTextView.textColor = .black
        mTextView.font = UIFont(name: fontName, size: 14.0 * util.fontScale)
        mTextView.isEditable = false
        mTextView.text = getLocalizedString("BROWSE_TEXT")
        self.view.addSubview(mTextView)
    }
    
    func backButtonTouched(sender: UIButton) {
        baseController.fontBrowserDismissed()
        baseController = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let viewSize = self.view.frame.size
        let util = Utilities.instance
        
        let barSize = UIApplication.shared.statusBarFrame.size
        let barHeight = barSize.width < barSize.height ? barSize.width : barSize.height
        let titleFrame = CGRect(x: 0.0, y: barHeight, width: viewSize.width, height: 35.0 * util.screenScale.height)
        
        mTitleBanner.frame = titleFrame
        
        let backButtonX = (util.isPhone ? 10.0 : 2.0) * util.screenScale.width
        let backButtonSize = CGSize(width: 32.0 * util.screenScale.width, height: 22.4 * util.screenScale.height)
        
        let labelX = backButtonX + backButtonSize.width
        
        mTitleLabel.frame = CGRect(x: labelX, y: titleFrame.origin.y, width: titleFrame.size.width - labelX, height: titleFrame.size.height)
        
        mBackButton.frame = CGRect(x: backButtonX, y: (titleFrame.size.height - backButtonSize.height) * 0.5, width: backButtonSize.width, height: backButtonSize.height)
        
        let textXPos = 10.0 * util.screenScale.width
        let textYPos = titleFrame.origin.y + titleFrame.size.height
        let textHeight = (viewSize.height - ViewController.tabBarHeight) - textYPos
        mTextView.frame = CGRect(x: textXPos, y: textYPos, width: viewSize.width - 2.0 * textXPos, height: textHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

