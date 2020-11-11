//
//  TestWidget.swift
//  TestWidget
//
//  Created by astafeev on 11/11/20.
//

import WidgetKit
import SwiftUI
import os.log

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> TestWidgetEntry {
        TestWidgetEntry(date: Date(),
                        firstWord: "--",
                        secondWord: "--",
                        thirdWord: "--")
    }

    func getSnapshot(in context: Context, completion: @escaping (TestWidgetEntry) -> ()) {
        let entry = TestWidgetEntry(date: Date(),
                                    firstWord: "--",
                                    secondWord: "--",
                                    thirdWord: "--")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [TestWidgetEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let words = TestWidgetManager.shared.lastWords()
        let entry = TestWidgetEntry(date: currentDate,
                                    firstWord: words[0],
                                    secondWord: words[1],
                                    thirdWord: words[2])
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .never)
        os_log("Timeline has been updated")
        completion(timeline)
    }
}

struct TestWidgetEntry: TimelineEntry {
    var date: Date
    
    let firstWord: String
    let secondWord: String
    let thirdWord: String
}

struct TestWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Group {
                        Text(entry.firstWord)
                            .offset(y: -10)
                        Text(entry.secondWord)
                        Text(entry.thirdWord)
                            .offset(y: 10)
                    }
                    .font(.body)
                    .minimumScaleFactor(0.75)
                    .background(Color(.clear))
                    .foregroundColor(.black)
                }
                if widgetFamily == .systemMedium {
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(.all)
        .background(ContainerRelativeShape().fill(Color(.yellow)))
    }
}

@main
struct TestWidget: Widget {
    let kind: String = "TestWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TestWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("AddWord App Widget")
        .description("This widget will show last 3 added words.")
    }
}

struct TestWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TestWidgetEntryView(entry: TestWidgetEntry(date: Date(),
                                                       firstWord: "rat",
                                                       secondWord: "Joy",
                                                       thirdWord: "window"))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            TestWidgetEntryView(entry: TestWidgetEntry(date: Date(),
                                                       firstWord: "Oxygen",
                                                       secondWord: "Alma Mater",
                                                       thirdWord: "Pfertzegentackle"))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
