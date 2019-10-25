//
//  ViewController.swift
//  flixster_2019
//
//  Created by KimlyT. on 10/17/19.
//  Copyright © 2019 KimlyT. All rights reserved.
//

import AlamofireImage
import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
  //MARK: -variables
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String: Any]] ()  // creation of an array of a dicitonary
    //MARK: -Network call
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self //table view functions won't work without
        tableView.delegate = self   // these
        
        print("Hello")
        //Network request snippet
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
              self.movies = dataDictionary["results"]as! [[String: Any]] // download from api and                                                           //store it in movies which                                                         //is an array of dictionary
              self.tableView.reloadData() //need this call to reload the table view
                                          //functions mutiple time with update data
              print(dataDictionary) //print the api on the console
              print(self.movies.count)  // there are 20 dictionaries
           }
        }
        task.resume()
        
    }
    
    //MARK: -Table View functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count  //return 20 rows
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           //let cell = UITableViewCell() //display only plain cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell //display the whole UI                                                        //in MovieCell
                
           let movie = movies[indexPath.row] // movie store one dictinary at a time
           let title = movie["title"] as! String // title must be a string
           
        
           //cell.textLabel!.text = title //plain text title, swift optional ! or ? 
            cell.titleLabel.text = title  //in the story board , the title will go into titleLabel
        
            let synopsis = movie["overview"] as! String //store the overview dictionary
            cell.synopsisLabel.text = synopsis //display it in the synopsisLabel on the
                                               //screen, configure how many lines you need on
                                              // the story board
        
        
            let baseUrl = "https://image.tmdb.org/t/p/w185"
            let posterPath = movie["poster_path"] as! String
            let posterUrl = URL(string: baseUrl + posterPath) //create URL to pull the
                                                             // poster image
            //At this point install cocoapod and do
            // 1. Go to the termial and to your project directory
            // 2. pod init
            // 3. open Podfile and add:  pod 'AlamofireImage' which is a library file
            // 4. pod install on the terminal
            // 5. Close the porject and open the new work space created on Xcode
             
            cell.posterView.af_setImage(withURL: posterUrl!)
           
            return cell // return the items of the row
    }
    //MARK: -part2 features
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            
        print("Loading up the details screen")//checking if the segue way work, message
                                              //print when tap to the next screen
        
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        //Pass the selected movie to the detail view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


}

