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
}

