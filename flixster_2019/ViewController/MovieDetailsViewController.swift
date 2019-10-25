//
//  MovieDetailsViewController.swift
//  flixster_2019
//
//  Created by KimlyT. on 10/25/19.
//  Copyright © 2019 KimlyT. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    var movie: [String:Any]! //declare a movie dictionary

    override func viewDidLoad() {
        super.viewDidLoad()

        print(movie["title"] as Any) //check if the seque way works by printing the
                                    //title from the movie dictionary everytime the cell is
                                    //tapped
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
           
        synopsisLabel.sizeToFit() //make the text fit into the label box
        titleLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        posterView.af_setImage(withURL: posterUrl!)//fetch poster image from api
           
           
        //don't forget to import AlamofireImage at the top of this file
        //run the program
           
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        backdropView.af_setImage(withURL: backdropUrl!) //fetch backdrop image from api
           
           
           
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
