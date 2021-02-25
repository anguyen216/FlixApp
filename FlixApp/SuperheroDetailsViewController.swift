//
//  SuperheroDetailsViewController.swift
//  FlixApp
//
//  Created by Anh Nguyen on 2/25/21.
//

import UIKit
import AlamofireImage

class SuperheroDetailsViewController: UIViewController {
    
    var movie: [String: Any]!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UITextView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // add movie title and synopsis
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        // get movie poster
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        posterView.af.setImage(withURL: posterUrl!)
        
        // set white border to poster view
        posterView.layer.masksToBounds = true
        posterView.layer.borderWidth = 1
        posterView.layer.borderColor = UIColor.white.cgColor
        
        // get movie backdrop poster
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        backdropView.af.setImage(withURL: backdropUrl!)
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
