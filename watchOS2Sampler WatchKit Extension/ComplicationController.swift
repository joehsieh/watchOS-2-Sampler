//
//  ComplicationController.swift
//  watchOS2Sampler WatchKit Extension
//
//  Created by Shuichi Tsutsumi on 2015/06/10.
//  Copyright © 2015年 Shuichi Tsutsumi. All rights reserved.
//

import ClockKit

struct Event {
	var name: String
	var shortName: String?
	var genre: String
	var startDate: NSDate
	var length: NSTimeInterval
}

let hour: NSTimeInterval = 60 * 60
let day: NSTimeInterval = hour * 24

let events = [
	Event(name: "ObjctiveC 讀書會", shortName: nil, genre: "研討會", startDate: NSDate(), length: hour),
	Event(name: "大雄演唱會", shortName: nil, genre: "娛樂", startDate: NSDate(timeIntervalSinceNow: hour), length: hour),
	Event(name: "熊麻吉電影首映會", shortName: nil, genre: "娛樂", startDate: NSDate(timeIntervalSinceNow: hour * 8), length: hour),

]
class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(NSDate())
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(NSDate(timeIntervalSinceNow: day))
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
	func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
		// Call the handler with the current timeline entry

		let event = events[0]
		let template = CLKComplicationTemplateModularLargeStandardBody()

		template.headerTextProvider = CLKTimeIntervalTextProvider(startDate: event.startDate, endDate: NSDate(timeInterval: event.length, sinceDate: event.startDate))
		template.body1TextProvider = CLKSimpleTextProvider(text: event.name, shortText: event.shortName)
		template.body2TextProvider = CLKSimpleTextProvider(text: event.genre, shortText: nil)

		let entry = CLKComplicationTimelineEntry(date: NSDate(timeInterval: hour * -0.25, sinceDate: event.startDate), complicationTemplate: template)
		handler(entry)
	}

    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
	func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
		// Call the handler with the timeline entries after to the given date

		var entries: [CLKComplicationTimelineEntry] = []

		for event in events
		{
			if entries.count < limit && event.startDate.timeIntervalSinceDate(date) > 0
			{
				let template = CLKComplicationTemplateModularLargeStandardBody()

				template.headerTextProvider = CLKTimeIntervalTextProvider(startDate: event.startDate, endDate: NSDate(timeInterval: event.length, sinceDate: event.startDate))
				template.body1TextProvider = CLKSimpleTextProvider(text: event.name, shortText: event.shortName)
				template.body2TextProvider = CLKSimpleTextProvider(text: event.genre, shortText: nil)

				let entry = CLKComplicationTimelineEntry(date: NSDate(timeInterval: hour * -0.25, sinceDate: event.startDate), complicationTemplate: template)
				entries.append(entry)
			}
		}

		handler(entries)
	}

    // MARK: - Update Scheduling

    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
	func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
		// This method will be called once per supported complication, and the results will be cached
		let template = CLKComplicationTemplateModularLargeStandardBody()

		template.headerTextProvider = CLKTimeIntervalTextProvider(startDate: NSDate(), endDate: NSDate(timeIntervalSinceNow: 60 * 60 * 1.5))
		template.body1TextProvider = CLKSimpleTextProvider(text: "Show Name", shortText: "Name")
		template.body2TextProvider = CLKSimpleTextProvider(text: "Show Genre", shortText: nil)

		handler(template)
	}

}
