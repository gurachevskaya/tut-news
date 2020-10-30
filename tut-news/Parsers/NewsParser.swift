//
//  XMLParser.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

class NewsLParser: NSObject {
    
    let recordKey = "item"
    let dictionaryKeys = Set(["title", "link", "description", "atom:name", "pubDate"])
    
    private var news: [News] = []
    var currentDictionary: [String: Any]?
    var currentValue: String?
    
    private var completion: ((Result<[News], AppError>) -> Void)?
    
    
    func parseNews(data: Data, completion: ((Result<[News], AppError>) -> Void)?) -> Void {
        self.completion = completion
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
}


extension NewsLParser: XMLParserDelegate {
    
    func parserDidStartDocument(_ parser: XMLParser) {
        news = []
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == recordKey {
            currentDictionary = [:]
        }
        
        guard currentDictionary != nil else { return }
        
        if dictionaryKeys.contains(elementName) {
            currentValue = ""
        }   else if elementName == "enclosure" {
            currentValue = attributeDict["url"]
        }
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue? += string
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == recordKey {
            let currentNews = News(with: currentDictionary ?? [:])
            news.append(currentNews)
            currentDictionary = nil
        }
        
        guard currentDictionary != nil else { return }
        
        if dictionaryKeys.contains(elementName) {
            if elementName == "atom:name" {
                guard currentValue!.contains("TUT") else { return }
            }
            currentDictionary![elementName] = currentValue
            currentValue = nil
        }
        
        if elementName == "enclosure" {
            currentDictionary!["newsUrl"] = currentValue
            currentValue = nil
        }
    }
    
    
    func parserDidEndDocument(_ parser: XMLParser) {
        guard let completion = completion else { return }
        completion(.success(news))
        resetParserState()
    }
    
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        guard let completion = completion else { return }
        completion(.failure(.invalidData))
        resetParserState()
    }
    
    
    private func resetParserState() {
        completion          = nil
        currentValue        = nil
        currentDictionary   = nil
    }
}
