
// Creating a tiny url from a given url of any length with no repeats \\


import UIKit


let datasize = 10000
var uRLKey = [String : String]()
var uniqueKeys = [String : Bool]()
var uRLQueue = [String]()
var hashValueTruncater = 99



func base64(url: String) -> String? {
    
    let URL = url.hashValue % hashValueTruncater
    let utf8URL = String(URL).dataUsingEncoding(NSUTF8StringEncoding)
    let base64URL = utf8URL?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    let customLink = "http://" + base64URL!
    
    if uniqueKeys[customLink] == nil {
        uniqueKeys[customLink] = true
        return customLink
    } else {
        base64(customLink)
        hashValueTruncater = hashValueTruncater * 10
    }
    return customLink
}

func shortenURL(uRL: String) -> String? {
    
    if uRLKey[uRL] == nil {
        
        guard let customLink = base64(uRL) else { return nil }
        uRLKey[uRL] = customLink
        uRLQueue.append(uRL)
        
        if uRLQueue.count > datasize {
            uniqueKeys[uRLKey[uRLQueue[0]]!] = nil
            uRLKey[uRLQueue.removeFirst()] = nil
        }
        
        return customLink
        
    } else {
        guard let customLink = uRLKey[uRL] else { return nil }
        
        for index in 0..<uRLQueue.count {
            if uRLQueue[index] == uRL {
                uRLQueue.append(uRLQueue.removeAtIndex(index))
            }
        }
        return customLink
    }
}

shortenURL("http://test.com")

for number in 0...10001{
    shortenURL("http://test\(number).com")
}

for (key, value) in uRLKey {
    print("key: \(key) value:", value)
}
for value in uRLQueue {
    print(value)
}


