//
//  SymbolsViewController.swift
//  FontAndEmojiCollection
//
//  Created by Zenny Chen on 2017/3/29.
//  Copyright © 2017年 CodeLearning Studio. All rights reserved.
//

import UIKit

class SymbolsViewController: UIViewController, UIScrollViewDelegate {
    
    private var mTitleBanner: UIImageView!
    private var mTitleLabel: UILabel!
    private var mScrollView: UIScrollView!
    private var mPageControl: UIPageControl!
    private var mTextView: UITextView!
    
    private var mCurrPageIndex = 0
    
    private let mSymbolList = [
        "¡!¿?⸘‽“”‘’‛‟.,‚„'′″´˝^°❢¸˛¨`˙˚ªº…:;&_¯–❣",
        "‑—§#⁊¶†‡@%‰‱¦|/\\ˉˆ˘ˇ-‒~*‼︎⁇⁈⁉︎❛❜❝❞$€¥¢£₽₨₩",
        "฿₺₮₱₭₴₦৲৳૱௹₹₲₪₡₶₫៛₵₢₸₤₳₥₠₣₰₧⌘⌥⇧‹›«»<>⟨⟩",
        "《》❨❩()❮❯{}[]〔〕【】〖〗❪❫❴❵❲❳❬❭⎧⎫⎡⎤⎛⎞⎨⎬⎜⎟⎣⎦⎝⎠",
        "+−-×÷±∓∔=¬∩∪∝∞ℵℶℷℸℏℇ∀∁∂℮∃∄∅∆∇⊂⊃⊄⊅⊆⊇⊈⊉⊊⊋∈",
        "∉∊∋∌∍∧∨<>≤≥≦≧≨≩≪≫≭≮≯≰≱≲≳≴≶≷≸≹≺≻≼≽≾≿⊀⊁∎∏∐",
        "∑∼∽∕∖∗∘∙√∛∜∟∠∡∢∣∤∥∦∫∬∭∮∯∰∱∲∳⨀℅℆⊳ℌℑ℞ℳ℃℉℀℁",
        "⁻⁼⁽⁾⁺⌠⎮⌡∴∵∶∷∸∹∺∻∼∽∾∿≀≁≂≃≄≅≆≇≈≉≊≋≌≍≎≏≐≑≒≓",
        "≔≕≖≗≘≙≚≛≜≝≞≟≠≡≢≣≬⊌⊍⊎⊏⊐⊑⊒⊓⊔&⅋⊕⊖⊗⊘⊙⊚⊛⊜⊝⊞⊟⊠",
        "⊡⊢⊣⊤⊥⊦⊧⊨⊩⊪⊫⊬⊭⊮⊯⊰⊱⊲⊳⊴⊵⊶⊷⊸⊹⊺⊻⊼⊽⊾⊿⋀⋁⋂⋃⋄⋅⋆⋇⋈",
        "♙⚀⚁⚂⚃⚄⚅☻☹☺︎☕︎✌︎✍✎✏︎✐☉☿♀♁♂♃♄♅®©℗™℠№ªº℔℥ℨℬℊµΩℹ︎"
    ]

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
        self.view.addSubview(mTitleBanner)
        
        mTitleLabel = UILabel(frame: titleFrame)
        mTitleLabel.font = UIFont(name: "Helvetica-Bold", size: 18.0 * util.fontScale)
        mTitleLabel.textAlignment = .center
        mTitleLabel.textColor = .white
        mTitleLabel.text = getLocalizedString("SYMBOL_TITLE")
        self.view.addSubview(mTitleLabel)
        
        self.createAndAddScrollView()
        
        let scrollViewY = mScrollView.frame.origin.y
        let scrollViewHeight = mScrollView.frame.size.height
        
        let isLandscape = viewSize.width > viewSize.height
        
        let textX = 20.0 * util.screenScale.width
        let textY = scrollViewY + scrollViewHeight + (isLandscape ? 0.0 : 20.0 * util.screenScale.height)
        let textWidth = viewSize.width - 40.0 * util.screenScale.width
        let textHeight = viewSize.height - textY - ViewController.tabBarHeight
        
        mTextView = UITextView(frame: CGRect(x: textX, y: textY, width: textWidth, height: textHeight))
        mTextView.font = UIFont(name: "Helvetica", size: 16.0 * util.fontScale)
        mTextView.isEditable = false
        self.view.addSubview(mTextView)
    }
    
    func createAndAddScrollView() {
        
        let util = Utilities.instance
        let viewSize = self.view.frame.size
        let isLandscape = viewSize.width > viewSize.height
        
        let scrollViewY = mTitleBanner.frame.origin.y + mTitleBanner.frame.size.height
        let remainHeight = viewSize.height - ViewController.tabBarHeight - scrollViewY
        let scrollViewHeight =  (remainHeight - 20.0 * util.screenScale.height) * (isLandscape ? 0.66 : 0.6)
        
        if mScrollView != nil {
            mScrollView.removeFromSuperview()
        }
        
        mScrollView = UIScrollView(frame: CGRect(x: 0.0, y: scrollViewY, width: viewSize.width, height: scrollViewHeight))
        mScrollView.backgroundColor = .gray
        mScrollView.bounces = true
        mScrollView.alwaysBounceHorizontal = true
        mScrollView.alwaysBounceVertical = false
        mScrollView.isPagingEnabled = true
        mScrollView.showsVerticalScrollIndicator = false
        mScrollView.showsHorizontalScrollIndicator = false
        let nPages = mSymbolList.count
        mScrollView.contentSize = CGSize(width: viewSize.width * CGFloat(nPages), height: scrollViewHeight)
        mScrollView.delegate = self
        
        let pageControlHeight = 30.0 * util.screenScale.height
        let buttonWidth: CGFloat
        let gapWidth: CGFloat
        let gapHeight: CGFloat
        let rowCount: Int, colCount: Int
        
        if isLandscape {
            buttonWidth = (viewSize.width - 60.0 * util.screenScale.width) / 10.0
            gapWidth = 60.0 * util.screenScale.width / 11.0
            gapHeight = 0.0
            rowCount = 4
            colCount = 10
        }
        else {
            buttonWidth = (viewSize.width - 60.0 * util.screenScale.width) / 8.0
            gapWidth = 60.0 * util.screenScale.width / 9.0
            gapHeight = (scrollViewHeight - 6.0 * buttonWidth - pageControlHeight) / 6.0
            rowCount = 5
            colCount = 8
        }
        
        var xPos = CGFloat(0.0)
        
        // 对mScrollView上的视图内容做初始化
        
        for symbolPage in mSymbolList {
            
            var charIndex = symbolPage.startIndex
            var y = CGFloat(0.0)
            
            // 行循环，一共rowCount行
            for _ in 0 ..< rowCount {
                
                var x = xPos
                y += gapHeight
                
                // 列循环，一共colCount列
                for _ in 0 ..< colCount {
                    x += gapWidth
                    
                    let button = UIButton(type: .system)
                    button.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonWidth)
                    button.setTitle(String(symbolPage.characters[charIndex]), for: .normal)
                    button.addTarget(self, action: #selector(emojiButtonTouched(sender:)), for: .touchUpInside)
                    button.titleLabel?.font = UIFont(name: "Helvetica", size: 24.0 * util.fontScale)
                    button.setTitleColor(.yellow, for: .normal)
                    mScrollView.addSubview(button)
                    
                    charIndex = symbolPage.characters.index(after: charIndex)
                    x += buttonWidth
                }
                
                y += buttonWidth
            }
            
            xPos += viewSize.width
        }
        
        self.view.addSubview(mScrollView)
        
        mScrollView.setContentOffset(CGPoint(x: CGFloat(mCurrPageIndex) * self.view.frame.size.width, y: 0.0), animated: false)
        
        // 添加page control
        let pageY = scrollViewY + scrollViewHeight - pageControlHeight - 10.0 * util.screenScale.height
        let pageFrame = CGRect(x: 0.0, y: pageY, width: viewSize.width, height: pageControlHeight)
        
        if mPageControl != nil {
            mPageControl.removeFromSuperview()
        }
        
        mPageControl = UIPageControl(frame: pageFrame)
        mPageControl.numberOfPages = mSymbolList.count
        mPageControl.addTarget(self, action: #selector(pageValueChanged(sender:)), for: .valueChanged)
        self.view.addSubview(mPageControl)
        
        mPageControl.currentPage = mCurrPageIndex
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let viewSize = self.view.frame.size
        let util = Utilities.instance
        let isLandscape = viewSize.width > viewSize.height
        
        let barSize = UIApplication.shared.statusBarFrame.size
        let barHeight = barSize.width < barSize.height ? barSize.width : barSize.height
        let titleFrame = CGRect(x: 0.0, y: barHeight, width: viewSize.width, height: 35.0 * util.screenScale.height)
        
        mTitleBanner.frame = titleFrame
        mTitleLabel.frame = titleFrame
        
        self.createAndAddScrollView()
        
        let textX = 20.0 * util.screenScale.width
        let textY = mScrollView.frame.origin.y + mScrollView.frame.size.height + (isLandscape ? 0.0 : 20.0 * util.screenScale.height)
        let textWidth = viewSize.width - 40.0 * util.screenScale.width
        let textHeight = viewSize.height - textY - ViewController.tabBarHeight
        
        mTextView.frame = CGRect(x: textX, y: textY, width: textWidth, height: textHeight)
    }
    
    func emojiButtonTouched(sender: UIButton!) {
        let title = sender.title(for: .normal)!
        
        var nCodePoints = 0
        var codePoints = [UInt32(0), UInt32(0)]
        
        for value in title.unicodeScalars {
            codePoints[nCodePoints] = value.value
            nCodePoints += 1
        }
        
        var utf16Codes = [UInt16(0), UInt16(0)]
        
        var index = 0
        for value in title.utf16 {
            utf16Codes[index] = value
            index += 1
        }
        
        index = 0;
        
        var utf8Codes = [UInt8](repeating: 0, count: 8)
        
        for value in title.utf8 {
            utf8Codes[index] = value
            index += 1
        }
        
        let codePointStr = nCodePoints == 1 ? String(format: "0x%.6X", codePoints[0]) : String(format: "0x%.6X, 0x%.6X", codePoints[0], codePoints[1])
        let utf16Str = String(format: "0x%.4X_%.4X", utf16Codes[0], utf16Codes[1])
        let utf8Str = nCodePoints == 1 ? String(format: "0x%.2X_%.2X_%.2X_%.2X", utf8Codes[0], utf8Codes[1], utf8Codes[2], utf8Codes[3]) : String(format: "0x%.2X_%.2X_%.2X, 0x%.2X_%.2X_%.2X", utf8Codes[0], utf8Codes[1], utf8Codes[2], utf8Codes[3], utf8Codes[4], utf8Codes[5])
        
        let line1Str = "\(title) Unicode code point: \(codePointStr)"
        let line2Str = "UTF-16 code: \(utf16Str)"
        let line3Str = "UTF-8 code: \(utf8Str)"
        let text = "\(line1Str)\n\n\(line2Str)\n\n\(line3Str)"
        
        mTextView.text = text
    }
    
    func pageValueChanged(sender: UIPageControl!) {
        let oldIndex = mCurrPageIndex
        mCurrPageIndex = sender.currentPage
        
        if oldIndex != mCurrPageIndex {
            mScrollView.setContentOffset(CGPoint(x: CGFloat(mCurrPageIndex) * self.view.frame.size.width, y: 0.0), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        mCurrPageIndex = Int(scrollView.contentOffset.x / self.view.frame.size.width + 0.4)
        mPageControl.currentPage = mCurrPageIndex
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

