//
//  APIManager.swift
//  StatesideTest
//
//  Created by Ernesto Gonzalez on 1/22/18.
//  Copyright © 2018 Ernesto Gonzalez. All rights reserved.
//

import UIKit

class APIManager {

    static let share = APIManager()
    private init() { }

    let endPoint = "http://version1.api.memegenerator.net//Generators_Search?q=insanity&pageIndex=0&pageSize=12&apiKey=demo"
    typealias RequestCompleted = (_ completed: [Meme]?) -> Void
    typealias ImageDownloaded = (_ image: UIImage?) -> Void

    func getMemes(completed: @escaping RequestCompleted) {
        let url = URL(string: endPoint)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completed(nil)
                return
            }

            do {
                let jsonReturn = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                guard let dic = jsonReturn else {
                    completed(nil)
                    return
                }

                if dic["success"] as! Bool {
                    completed(self.getMemesData(withData: data))
                } else {
                    let path = Bundle.main.path(forResource: "Meme", ofType: "json")
                    let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
                    completed(self.getMemesData(withData: data))
                }
            } catch {
                completed(nil)
            }
        }.resume()
    }

    func getMemeImage(url: URL, imageDownloaded: @escaping ImageDownloaded) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                imageDownloaded(nil)
                return
            }

            imageDownloaded(UIImage(data: data!))
        }.resume()
    }

    private func getMemesData(withData data: Data) -> [Meme]? {
        var memes: [Meme]!
        do {
            let memesResult = try JSONDecoder().decode(MemeRoot.self, from: data)
            memes = []
            for meme in memesResult.result {
                memes.append(meme)
            }
        } catch let error {
            print(error)
        }

        return memes
    }
}
