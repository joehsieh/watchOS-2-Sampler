//
//  VideoPlayerViewController.swift
//  watchOS2Sampler
//
//  Created by joehsieh on 2015/7/14.
//  Copyright © 2015年 Shuichi Tsutsumi. All rights reserved.
//

import WatchKit
import Foundation

class VideoPlayerInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var movie: WKInterfaceMovie!
    
    override func awakeWithContext(context: AnyObject?) {
        let myBundle = NSBundle.mainBundle()
        if let movieURL = myBundle.URLForResource("sample_clip1", withExtension: "m4v") {
            self.movie.setMovieURL(movieURL)
            let image = WKImage(imageName: "Sample1")
            self.movie.setPosterImage(image)            
        }
    }
}
