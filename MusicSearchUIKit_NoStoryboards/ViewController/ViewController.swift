import UIKit

class ViewController: UIViewController {

    private let viewModel = ContentViewModel()
    private let imageDownloader = ImageDownloader()
    let searchController = UISearchController(searchResultsController: nil)
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var imageTasks = [IndexPath:Task<Void,Never>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Music"
        navigationItem.searchController = searchController
        
        collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        viewModel.onStateDidChange = { [weak self] in
            self?.onStateDidChange()
        }
    }
    private func onStateDidChange() {
        collectionView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchKey = searchController.searchBar
        viewModel.keyword = searchKey.text!
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let musicItem = viewModel.state.results?[indexPath.row] else {
            fatalError("Oh no should not happen")
        }
        let detailViewController = DetailViewController()
        detailViewController.musicItem = musicItem
        //self.present(detailViewController, animated: true)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.state.results?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as! MusicCollectionViewCell
        guard let musicItem = viewModel.state.results?[indexPath.row] else {
            fatalError("Oh no should not happen")
        }
        cell.artistName.text = musicItem.artistName
        cell.trackName.text = musicItem.trackName
        imageTasks[indexPath]?.cancel()
        let myTask = Task {
            @MainActor in
            do {
                cell.musicImage.image = try await imageDownloader.getImage(url: musicItem.artworkUrl60)
            } catch {
                print("get image resulted error")
            }
        }
        imageTasks[indexPath] = myTask
        return cell
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width-16), height: 60)
    }
}


