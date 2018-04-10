//
//  File.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 10..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import Foundation

class HolidayDataLoader {
    struct Contstant {
        static let cellIdentifier = "HolidayCell"
        static let title = "date"
        static let subTitle = "subtitle"
        static let weatherImage = "image"
        static let dataResource = "HolidayJsonData"
    }
    private var json: Array<Dictionary<String,String>> = []
    private static var holidayDataLoader = HolidayDataLoader()
    private init() {
        // json 데이터 가져오기
        guard let urlPath = Bundle.main.path(forResource: Contstant.dataResource, ofType: "json") else {
            return
        }
        // Array 형태로 데이터 변환
        if let contents = try? String(contentsOfFile: urlPath).data(using: .utf8) ?? Data() {
            guard let jsonData = try? JSONSerialization.jsonObject(with: contents, options: []) as? Array<Dictionary<String,String>> ?? [] else {
                return
            }
            json = jsonData
        }
    }
    
    func countJsonData() -> Int {
        return json.count
    }
    
    func takeOutTitle(_ index: IndexPath) -> String {
        guard let title = json[index.row][Contstant.title] else {
            return ""
        }
        return title
    }
    
    func takeOutSubTitle(_ index: IndexPath) -> String {
        guard let subTitle = json[index.row][Contstant.subTitle] else {
            return ""
        }
        return subTitle
    }
    
    func takeOutImage(_ index: IndexPath) -> String {
        guard let image = json[index.row][Contstant.weatherImage] else {
            return ""
        }
        return image
    }

    static func sharedInstance() -> HolidayDataLoader {
        return holidayDataLoader
    }
}
