//
//  MovieTrailerViewController.swift
//  FlixApp
//
//  Created by Anh Nguyen on 2/25/21.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {
    
    var movieId: Int!
    var videos = [[String: Any]]()
    @IBOutlet var trailerView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        trailerView = WKWebView(frame: .zero, configuration: webConfiguration)
        trailerView.uiDelegate = self
        view = trailerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // explicitly cast movieId into string or else url is printed weird >:b
        let id = String(self.movieId)
        // get the trailer info
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
              print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? [String: Any]

                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                self.videos = dataDictionary?["results"] as! [[String: Any]]
                let subtitledTrailer = self.videos[1]
                let trailerYoutubeKey = subtitledTrailer["key"] as! String
                
                // setting Youtube URL to trailer
                let youtubeUrl = "https://www.youtube.com/watch?v="
                let trailerUrl = URL(string: youtubeUrl + trailerYoutubeKey)
                let trailerRequest = URLRequest(url: trailerUrl!)
                self.trailerView.load(trailerRequest)
             }
          }
          task.resume()

    }
    
    @IBAction func closeTrailer(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
