//
//  FullScreenImageViewCOntroller.swift
//  ArtApp
//
//  Created by Виталик Молоков on 15.02.2024.
//

import UIKit

class FullscreenImageViewController: UIViewController {
    
    //MARK: - Properties
    var image: UIImage?

    //MARK: - UI Components
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayouts()
        setupDismissFullscreenImage()
    }
    
    //MARK: - Setups
    private func setupHierarchy() {
        view.backgroundColor = .black
        view.addSubview(imageView)
        
        imageView.image = image
    }
    
    private func setupLayouts() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupDismissFullscreenImage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        view.addGestureRecognizer(tapGesture)
    }

    //MARK: - Actions
    @objc func dismissFullscreenImage() {
        dismiss(animated: true)
    }
}

