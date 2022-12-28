import UIKit
import AVKit

class DetailViewController: UIViewController {
    
    private let musicPlayer = AVPlayer()
    private let imageDownloader = ImageDownloader()
    let musicImage = UIImageView()
    let artistName = UILabel()
    let trackName = UILabel()
    let collectionName = UILabel()
    let playButton = UIButton(type: .system)
    var musicItem: MusicItemModel? {
        didSet {
            getMusicItemDetails()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getMusicItemDetails()
        
    }
    func getMusicItemDetails() {
        
        if let musicItem = musicItem {
            Task {
                musicImage.image = await getImage(url: musicItem.artworkUrl100)
            }
            artistName.text = musicItem.artistName
            collectionName.text = musicItem.collectionName
            trackName.text = musicItem.trackName
        }
        
        playButton.setTitle("Play", for: .normal)
        view.addSubview(musicImage)
        view.addSubview(artistName)
        view.addSubview(trackName)
        view.addSubview(collectionName)
        view.addSubview(playButton)
        setConstraints()
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    func getImage(url: String) async -> UIImage {
        var image = UIImage()
        do {
            image = try await imageDownloader.getImage(url: url)
        } catch {
            print(error)
        }
        return image
    }
    func setConstraints() {
        musicImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height * 0.2).isActive = true
        musicImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: UIScreen.main.bounds.width * 0.35).isActive = true
        artistName.topAnchor.constraint(equalTo: musicImage.topAnchor, constant: 150).isActive = true
        artistName.leftAnchor.constraint(equalTo: musicImage.leftAnchor, constant:0).isActive = true
        trackName.topAnchor.constraint(equalTo: artistName.topAnchor, constant: 25).isActive = true
        trackName.leftAnchor.constraint(equalTo: artistName.leftAnchor, constant:0).isActive = true
        collectionName.topAnchor.constraint(equalTo: trackName.topAnchor, constant: 25).isActive = true
        collectionName.leftAnchor.constraint(equalTo: trackName.leftAnchor, constant:0).isActive = true
        playButton.topAnchor.constraint(equalTo: collectionName.topAnchor, constant: 25).isActive = true
        playButton.leftAnchor.constraint(equalTo: collectionName.leftAnchor, constant:0).isActive = true
    }
}

