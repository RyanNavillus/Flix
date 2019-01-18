//
//  MovieTableViewController.swift
//  Flix
//
//  Created by Ryan Sullivan on 1/14/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        tableView.separatorInset.left = 16
        
        title = "Currently In Theaters"
        //save count
        var completed = 0
        let apiManager = FlixAPIManager.sharedInstance()
        apiManager.getPageCount { (count) in
            for page in 1..<10 {
                apiManager.getMovies(page: page) { movies in
                    for movie in movies {
                        print(movie.title)
                        self.movies.append(movie)
                    }
                    completed += 1
                    if completed == 9 {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UIScreen.main.bounds.height
        if height < 1000 {
            return 192
        } else {
            return 192 * 2
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell {
            cell.movieImageView.image = nil
            cell.titleLabel.text = ""
            cell.overviewLabel.text = ""
            if movies.count > indexPath.row {
                cell.movie = movies[indexPath.row]
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show detail controller
        //performSegue(withIdentifier: "Detail", sender: tableView.cellForRow(at: indexPath))
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if let detailViewController = segue.destination as? MovieDetailViewController,
            let movieCell = sender as? MovieTableViewCell {
            detailViewController.movie = movieCell.movie
            detailViewController.color = movieCell.color
        }
        // Pass the selected object to the new view controller.
    }

}
