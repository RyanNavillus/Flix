//
//  MovieCollectionViewController.swift
//  Flix
//
//  Created by Ryan Sullivan on 1/25/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieCollectionCell"

class MovieCollectionViewController: UICollectionViewController {

    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 4
            layout.minimumInteritemSpacing = 4
            
            let width = view.frame.size.width
            let height = view.frame.size.height
            layout.itemSize = CGSize(width: width/2 - 2, height: height/3 - 8)
        }
        
        title = "Currently In Theaters"
        //save count
        var completed = 0
        let apiManager = FlixAPIManager.sharedInstance()
        apiManager.getSimilar { movies in
            for movie in movies {
                print(movie.title)
                self.movies.append(movie)
            }
            self.collectionView.reloadData()
        }
    }

        // Register cell classes
        //self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell {
            if let movieImageView = cell.movieImageView {
                movieImageView.image = nil
            }
            if movies.count > indexPath.row {
                cell.movie = movies[indexPath.row]
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            return cell
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if let detailViewController = segue.destination as? MovieDetailViewController,
            let movieCell = sender as? MovieCollectionViewCell {
            detailViewController.movie = movieCell.movie
            detailViewController.color = movieCell.color
        }
        // Pass the selected object to the new view controller.
    }
}
