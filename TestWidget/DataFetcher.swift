//
//  DataFetcher.swift
//  SampleTest
//
//  Created by jinhyuk on 2020/09/21.
//

import Foundation
import Combine

public class DataFetcher: ObservableObject  {
    
    static let shared = DataFetcher()
    
    let dummyDataList = [
        "첫번재 타임라인",
        "두번째 타임라인",
        "세번째 타임라인",
        "네번째 타임라인",
        "다섯번째 타임라인"
    ]
    
    func fetchData(completion :(([String]) -> Void)) {
        
        // YOUR CODE
        completion(dummyDataList)
    }
}

