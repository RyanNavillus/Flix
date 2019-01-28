//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Ryan Sullivan on 1/14/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var movie: Movie? {
        didSet {
        }
    }
    
    var color: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetail()
        setSize()
        
    }
    
    func setupDetail() {
        guard let movie = movie else { return }
        title = movie.title
        overviewLabel.text = movie.overview
        let baseURL = "https://image.tmdb.org/t/p/w500"
        if let posterURL = URL(string: baseURL + movie.posterPath), let movieImageView = imageView {
            //movieImageView.af_setImage(withURL: posterURL)
            movieImageView.af_setImage(withURL: posterURL)
        }
        if let color = color {
            underlineView.backgroundColor = color
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                scrollView.contentSize = CGSize(width: contentView.frame.width, height: contentView.frame.height+32)
    }
    
    func setSize() {
        if UIScreen.main.bounds.height > 1000 {
            imageHeight.constant *= 3
            overviewLabel.font = overviewLabel.font.withSize(overviewLabel.font.pointSize*1.5)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let trailerController = segue.destination as? MovieTrailerViewController {
            trailerController.movie = movie
        }
    }
    

}
