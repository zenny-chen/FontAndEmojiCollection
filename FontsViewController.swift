//
//  FontsViewController.swift
//  FontAndEmojiCollection
//
//  Created by Zenny Chen on 2017/3/16.
//  Copyright © 2017年 CodeLearning Studio. All rights reserved.
//

import UIKit

class FontsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var mTitleBanner: UIImageView!
    private var mTitleLabel: UILabel!
    private var mTableView: UITableView!
    private var mFamilyNames = UIFont.familyNames
    private var mFontTableCells = [[UITableViewCell]]()
    private var mFontBrowseController: FontBrowseViewController?

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
        mTitleLabel.text = getLocalizedString("FONT_TITLE")
        self.view.addSubview(mTitleLabel)
        
        let tableViewYPos = titleFrame.origin.y + titleFrame.size.height
        let tableViewHeight = (viewSize.height - ViewController.tabBarHeight) - tableViewYPos
        
        createTableCells()
        
        mTableView = UITableView(frame: CGRect(x: 0.0, y: tableViewYPos, width: viewSize.width, height: tableViewHeight), style: .grouped)
        mTableView.dataSource = self
        mTableView.delegate = self
        self.view.addSubview(mTableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let viewSize = self.view.frame.size
        let util = Utilities.instance
        
        let barSize = UIApplication.shared.statusBarFrame.size
        let barHeight = barSize.width < barSize.height ? barSize.width : barSize.height
        let titleFrame = CGRect(x: 0.0, y: barHeight, width: viewSize.width, height: 35.0 * util.screenScale.height)
        
        mTitleBanner.frame = titleFrame
        mTitleLabel.frame = titleFrame
        
        let tableViewYPos = titleFrame.origin.y + titleFrame.size.height
        let tableViewHeight = (viewSize.height - ViewController.tabBarHeight) - tableViewYPos
        mTableView.frame = CGRect(x: 0.0, y: tableViewYPos, width: viewSize.width, height: tableViewHeight)
        
        mFontBrowseController?.viewDidAppear(false)
    }
    
    private func createTableCells() {
        
        mFamilyNames.sort(by: <)
        
        for familyName in mFamilyNames {
            var fontNames = UIFont.fontNames(forFamilyName: familyName)
            fontNames.sort(by: <)
            
            var cells = [UITableViewCell]()
            for name in fontNames {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "")
                cell.accessoryType = .disclosureIndicator
                let label = cell.textLabel!
                label.text = name
                label.font = UIFont(name: name, size: 14.0 * Utilities.instance.fontScale)
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.7
                cells.append(cell)
            }
            
            mFontTableCells.append(cells)
        }
    }
    
    func fontBrowserDismissed() {
        mFontBrowseController = nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mFontTableCells.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return mFamilyNames
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mFontTableCells[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return mFontTableCells[indexPath.section][indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = mFontTableCells[indexPath.section][indexPath.row]
        
        mFontBrowseController = FontBrowseViewController()
        guard let controller = mFontBrowseController else {
            return
        }
        controller.baseController = self
        controller.fontName = cell.textLabel!.text
        
        self.navigationController?.pushViewController(controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
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

