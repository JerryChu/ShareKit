//
//  ViewController.swift
//  ShareKit-Demo
//
//  Created by JerryChu on 2018/9/2.
//  Copyright © 2018 JerryChu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let items = {
        return ["QQ好友 分享图片", "QQ好友 分享页面", "QQ好友 分享音频", "QQ空间 分享视频",
                "微信好友 分享图片", "微信好友 分享页面", "微信好友 分享音频", "微信朋友圈 分享视频"]
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.row {
        case 0:
            ShareHelper.shareImage(ImageModel(), to: .qqFriend)
        case 1:
            ShareHelper.shareURL(URLModel(), to: .qqFriend)
        case 2:
            ShareHelper.shareURL(AudioModel(), to: .qqFriend)
        case 3:
            ShareHelper.shareURL(VideoModel(), to: .qZone)
        case 4:
            ShareHelper.shareImage(ImageModel(), to: .weChatSession)
        case 5:
            ShareHelper.shareURL(URLModel(), to: .weChatSession)
        case 6:
            ShareHelper.shareURL(AudioModel(), to: .weChatSession)
        case 7:
            ShareHelper.shareURL(VideoModel(), to: .weChatTimeline)
        default:
            return
        }
    }

}
