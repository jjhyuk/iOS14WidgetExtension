//
//  TestWidget.swift
//  TestWidget
//
//  Created by jinhyuk on 2020/09/21.
//

import WidgetKit
import SwiftUI

// 위젯 데이터를 설정하고 업데이트 주기를 관리
// 동적으로 컨텐츠를 가져오므로 매우 중요하다.
struct Provider: TimelineProvider {
    
    // 위젯의 콘텐츠를 표시한다.
    func placeholder(in context: Context) -> DataEntry {
        DataEntry(date: Date(), text: "Comming Soon_PlaceHolder")

    }

    // 위젯을 즉시 표시하는데 사용
    func getSnapshot(in context: Context, completion: @escaping (DataEntry) -> ()) {
        let entry = DataEntry(date: Date(), text: "Comming Soon_GetSnapshot")
        completion(entry)
    }

    // 하나 이상의 Entry를 만드는데 사용한다.
    // 업데이트하는 시간간격 설정이 가능 : Timeline
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DataEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let calendar = Calendar.current
        
        DataFetcher.shared.fetchData { TextList in
            entries = TextList.enumerated().map { offset ,text in
                return DataEntry(date: calendar.date(byAdding: .second, value: offset * 2, to: currentDate)!, text: text )
            }
        }
        

        // atEnd로 표시, 다섯번째 Entry가 표시된 후 사용, 다음 타임라인 트리거
        // after, never 존재
        let timeline = Timeline(entries: entries, policy: .after(Date()))
        completion(timeline)
    }
}

// 위젯의 콘텐츠
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let text: String
//}

// 위젯의 콘텐츠
struct DataEntry: TimelineEntry {
    let date: Date
    let text: String
}

struct TestWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Text(entry.text)
        }
        
    }
}

@main
struct TestWidget: Widget {
    
    // 다른 위젯과 구분하는 식별자
    let kind: String = "widgetSample"

    // 위젯이 디스플레이에 로드되는 곳
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TestWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct TestWidget_Previews: PreviewProvider {
    static var previews: some View {
        TestWidgetEntryView(entry: DataEntry(date: Date(), text: "aaa"))
            
            // WidgetFamily : 위젯의 사이즈 관리
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
