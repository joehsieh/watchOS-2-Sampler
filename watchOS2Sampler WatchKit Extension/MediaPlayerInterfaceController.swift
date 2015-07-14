//
//  MediaPlayerInterfaceController.swift
//  watchOS2Sampler
//
//  Created by joehsieh on 2015/7/14.
//  Copyright © 2015年 Shuichi Tsutsumi. All rights reserved.
//

import WatchKit
import Foundation

class MediaPlayerInterfaceController: WKInterfaceController {
    override func awakeWithContext(context: AnyObject?) {
        let myBundle = NSBundle.mainBundle()
        if let movieURL = myBundle.URLForResource("sample_clip1", withExtension: "m4v") {
            self.presentMediaPlayerControllerWithURL(movieURL,
                options: [WKMediaPlayerControllerOptionsAutoplayKey: true],
                completion: { (didPlayToEnd : Bool,
                    endTime : NSTimeInterval,
                    error : NSError?) -> Void in
                    if let anErrorOccurred = error {
                        // Handle the error.
                    }
                    // Perform other tasks
            })
        }
    }
}
