//
//  ViewController.swift
//  FontAndEmojiCollection
//
//  Created by Zenny Chen on 2017/3/14.
//  Copyright © 2017年 CodeLearning Studio. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITabBarDelegate {
    
    static var tabBarHeight: CGFloat = 50.0
    
    private var mTabBar: UITabBar!
    private var mSelectedItemTag = 1
    
    private var mFontsNaviViewController: UINavigationController!
    private let mFontsViewController = FontsViewController()
    private let mEmojiViewController = EmojiViewController()
    private let mSymbolsViewController = SymbolsViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let name = getLocalizedString("CFBundleDisplayName")
        print("The app name is: \(name)")
        
        let util = Utilities.instance
        let viewSize = self.view.frame.size
        
        let item1 = UITabBarItem(title: getLocalizedString("FONT_TITLE"), image: UIImage(named: "baritem_font.png"), tag: 1)
        
        let item2 = UITabBarItem(title: getLocalizedString("EMOJI_TITLE"), image: UIImage(named: "baritem_emoji.png"), tag: 2)
        
        let item3 = UITabBarItem(title: getLocalizedString("SYMBOL_TITLE"), image: UIImage(named: "baritem_more.png"), tag: 3)
        
        let this = type(of: self)
        
        mTabBar = UITabBar(frame: CGRect(x: 0.0, y: viewSize.height - this.tabBarHeight * util.screenScale.height, width: viewSize.width, height: this.tabBarHeight * util.screenScale.height))
        mTabBar.layer.contentsScale = UIScreen.main.nativeScale
        mTabBar.items = [item1, item2, item3]
        mTabBar.delegate = self
        mTabBar.selectedItem = item1
        self.view.addSubview(mTabBar)
        mTabBar.sizeToFit()
        
        this.tabBarHeight = mTabBar.frame.size.height
        
        mTabBar.frame = CGRect(x: 0.0, y: viewSize.height - this.tabBarHeight, width: viewSize.width, height: this.tabBarHeight)
        
        mTabBar.removeFromSuperview()
        
        mFontsNaviViewController = UINavigationController(rootViewController: mFontsViewController)
        mFontsNaviViewController.isToolbarHidden = true;
        mFontsNaviViewController.isNavigationBarHidden = true;
        mFontsNaviViewController.view.frame = self.view.bounds;
        mFontsNaviViewController.view.backgroundColor = .clear
        
        self.view.addSubview(mFontsNaviViewController.view)
        mFontsNaviViewController.view.addSubview(mTabBar)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if mSelectedItemTag == item.tag {
            return
        }
        
        let oldtag = mSelectedItemTag
        mSelectedItemTag = item.tag
        
        mTabBar.removeFromSuperview()
        
        switch oldtag {
        case 1:
            mFontsNaviViewController.view.removeFromSuperview()
            
        case 2:
            mEmojiViewController.view.removeFromSuperview()
            
        case 3:
            mSymbolsViewController.view.removeFromSuperview()
            
        default:
            break
        }
        
        switch mSelectedItemTag {
        case 1:
            mFontsNaviViewController.view.frame = self.view.frame
            mFontsViewController.view.frame = self.view.frame
            self.view.addSubview(mFontsNaviViewController.view)
            mFontsNaviViewController.view.addSubview(mTabBar)
            
        case 2:
            mEmojiViewController.view.frame = self.view.frame
            self.view.addSubview(mEmojiViewController.view)
            mEmojiViewController.view.addSubview(mTabBar)
            
        case 3:
            mSymbolsViewController.view.frame = self.view.frame
            self.view.addSubview(mSymbolsViewController.view)
            mSymbolsViewController.view.addSubview(mTabBar)
            
        default:
            break
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        mTabBar.frame = CGRect(x: 0.0, y: size.height - ViewController.tabBarHeight, width: size.width, height: ViewController.tabBarHeight)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + UInt64(5_000_000)), execute: self.allViewDidAppear)
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    private func allViewDidAppear() {
        mFontsViewController.viewDidAppear(false)
        mEmojiViewController.viewDidAppear(false)
        mSymbolsViewController.viewDidAppear(false)
    }
    
    /**
    override func viewWillTransitionToSize(size: CGSize)
    withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
    {
    [self performSelector:@selector(adjustViewForOrientation) withObject:nil afterDelay:0.1];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    }
 */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

