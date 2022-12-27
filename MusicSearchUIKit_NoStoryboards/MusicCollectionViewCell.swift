import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    static let identifier = "MusicCollectionViewCell"
    
    var musicImage: UIImageView!
    var artistName: UILabel!
    var trackName: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        musicImage = UIImageView()
        artistName = UILabel()
        trackName = UILabel()
        musicImage.applyShadow()
        
        //Horizontal Stack View
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 15.0
        horizontalStackView.addArrangedSubview(musicImage)
        //Vertical Stack View
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.addArrangedSubview(artistName)
        verticalStackView.addArrangedSubview(trackName)
        
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(horizontalStackView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
