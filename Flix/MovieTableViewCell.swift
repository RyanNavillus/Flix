//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Ryan Sullivan on 1/14/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit
import AlamofireImage
import UIImageColors

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    
    var movie: Movie? {
        didSet {
            setupCell()
        }
    }
    
    var color: UIColor?
    var initialTitleSize: CGFloat = 0
    var initialOverviewSize: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialTitleSize = titleLabel.font.pointSize
        initialOverviewSize = overviewLabel.font.pointSize

        setSize()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func setupCell() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        titleLabel.sizeToFit()
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
        //self.movieImageView.image = movie?.posterPath
        overviewLabel.text = movie.overview
        
        underlineView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 2)
        
        setSize()
        
        layoutSubviews()
    }

    func setUnderlineColor(colors: UIImageColors) {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        colors.secondary.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if brightness < 0.8 {
            self.underlineView.backgroundColor = colors.secondary
            color = colors.secondary
        } else {
            colors.primary.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            if brightness < 0.8 {
                self.underlineView.backgroundColor = colors.primary
                color = colors.primary
            } else {
                self.underlineView.backgroundColor = colors.background
                color = colors.background
            }
        }
    }
    
    func setSize() {
        if UIScreen.main.bounds.height > 1000 {
            titleLabel.font = titleLabel.font.withSize(initialTitleSize*2)
            overviewLabel.font = overviewLabel.font.withSize(initialOverviewSize*2)
        }
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
