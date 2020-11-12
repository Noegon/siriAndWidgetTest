//
//  WidgetView.swift
//  TestWidgetExtension
//
//  Created by astafeev on 11/11/20.
//

import SwiftUI
import WidgetKit


struct WidgetData {
    let date: Date
    let firstWord: String
    let secondWord: String
    let thirdWord: String
}

extension WidgetData {
    static let previewData = WidgetData(date: Date(),
                                        firstWord: "bat",
                                        secondWord: "rat",
                                        thirdWord: "hat")
}


struct WidgetView: View {
    let data: WidgetData
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("1. \(data.firstWord)")
                        .offset(y: -15)
                        .font(.body)
                        .truncationMode(.tail)
                        .lineLimit(1)
                        .background(Color(.clear))
                        .foregroundColor(.black)
                    HStack(alignment: .center) {
                        Text("2. \(data.secondWord)")
                            .font(.body)
                            .truncationMode(.tail)
                            .lineLimit(1)
                            .background(Color(.clear))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .background(Color(.systemPurple).padding(.vertical, -10))
                    .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: -10.0))
                    Text("3. \(data.thirdWord)")
                        .offset(y: 15)
                        .font(.body)
                        .truncationMode(.tail)
                        .lineLimit(1)
                        .background(Color(.clear))
                        .foregroundColor(.black)
                    Spacer()
                }
                Spacer()
            }
            .background(ContainerRelativeShape().fill(Color(.systemYellow)))
            
        }
        .padding(.all, 10)
        .background(ContainerRelativeShape().fill(Color(.systemPurple)))
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            WidgetView(data: .previewData).previewContext(WidgetPreviewContext(family: .systemSmall))
            WidgetView(data: .previewData).previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
