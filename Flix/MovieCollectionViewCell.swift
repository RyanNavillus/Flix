//
//  MovieCollectionViewCell.swift
//  Flix
//
//  Created by Ryan Sullivan on 1/25/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit
import UIImageColors

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movie: Movie? {
        didSet {
            setupCell()
        }
    }
    var color: UIColor?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //
    }
    
    override required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCell() {
        guard let movie = movie else { return }
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        if let posterURL = URL(string: baseURL + movie.posterPath), let movieImageView = movieImageView {
            //movieImageView.af_setImage(withURL: posterURL)
            movieImageView.af_setImage(withURL: posterURL,
                                       placeholderImage: nil,
                                       filter: nil,
                                       progress: nil,
                                       progressQueue: DispatchQueue.main,
                                       imageTransition: .noTransition,
                                       runImageTransitionIfCached: false) { (response) in
                                        if let data = response.data, var image = UIImage(data: data) {
                                            image.getColors { (colors) in
                                                self.setUnderlineColor(colors: colors)
                                            }
                                        }
            }
        }
    }
    
    func setUnderlineColor(colors: UIImageColors) {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        colors.secondary.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if brightness < 0.8 {
            color = colors.secondary
        } else {
            colors.primary.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            if brightness < 0.8 {
                color = colors.primary
            } else {
                color = colors.background
            }
        }
    }
}
