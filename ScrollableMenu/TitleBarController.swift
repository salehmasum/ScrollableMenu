//
//  TestViewController.swift
//  ScrollableMenu
//
//  Created by Saleh Masum on 5/9/2022.
//

import UIKit

class TitleBarController: UIViewController {

    var musicBarButtonItem: UIBarButtonItem!
    var podcastBarButtonItem: UIBarButtonItem!
    
    let container = Container()
    
    let viewControllers: [UIViewController] = [
        HomeController(), HomeController()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavBar()
        setupViews()
        
    }
    
    func setupViews() {
        guard let containerView = container.view else { return }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemGreen
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        musicButtonTapped()
    }
    
    func setupNavBar() {
        navigationItem.leftBarButtonItems = [musicBarButtonItem, podcastBarButtonItem]
        
        //hide bottom shade pixel
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        musicBarButtonItem = makeBarButtonItem(text: "Music", selector: #selector(musicButtonTapped))
        podcastBarButtonItem = makeBarButtonItem(text: "Podcast", selector: #selector(podcastButtonTapped))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeBarButtonItem(text: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: selector, for: .primaryActionTriggered)
        
        let attributes = [NSAttributedString.Key.font:
                            UIFont.preferredFont(forTextStyle: .largeTitle).withTraits(traits: [.traitBold]),
                          NSAttributedString.Key.foregroundColor: UIColor.label]
        
        let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        button.setAttributedTitle(attributedText, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 16)
        return UIBarButtonItem(customView: button)
    }
    
    @objc func musicButtonTapped() {
        if container.children.first == viewControllers[0] {
            return
        }
        container.add(viewControllers[0])
        
//        animateTransition(fromVc: viewControllers[1], toVc: viewControllers[0]) { success in
//            self.viewControllers[1].remove()
//        }
        animateTransition(fromPodcastVc: viewControllers[1], toMusicVc: viewControllers[0]) { success in
            self.viewControllers[1].remove()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.musicBarButtonItem.customView?.alpha = 1.0
            self.podcastBarButtonItem.customView?.alpha = 0.5
        }
    }
    
    @objc func podcastButtonTapped() {
        if container.children.first == viewControllers[1] {
            return
        }
        container.add(viewControllers[1])
        
//        animateTransition(fromVc: viewControllers[0], toVc: viewControllers[1]) { success in
//            self.viewControllers[0].remove()
//        }
        animateTransition(fromMusicVc: viewControllers[0], toPodcastVc: viewControllers[1]) { success in
            self.viewControllers[0].remove()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.podcastBarButtonItem.customView?.alpha = 1.0
            self.musicBarButtonItem.customView?.alpha = 0.5
        }
    }
    
//    func animateTransition(fromVc: UIViewController, toVc: UIViewController, completion: @escaping (Bool) -> Void) {
//        guard
//            let fromView = fromVc.view,
//            let fromIndex = getIndex(forViewController: fromVc),
//            let toView    = toVc.view,
//            let toIndex   = getIndex(forViewController: toVc)
//        else {
//            return
//        }
//
//        let frame = fromVc.view.frame
//        var fromFrameEnd = frame
//        var toFrameStart = frame
//        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
//        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
//        toView.frame = toFrameStart
//
//        UIView.animate(withDuration: 0.5) {
//            fromView.frame = fromFrameEnd
//            toView.frame   = frame
//        } completion: { success in
//            completion(success)
//        }
//
//    }
    
//    func getIndex(forViewController vc: UIViewController) -> Int? {
//        for(index, thisVc) in viewControllers.enumerated() {
//            if thisVc == vc {
//                return index
//            }
//        }
//        return nil
//    }
    
    func animateTransition(fromPodcastVc: UIViewController, toMusicVc: UIViewController, completion: @escaping (Bool) -> Void) {
        guard
            let podcastControllerView = fromPodcastVc.view,
            let musicControllerView   = toMusicVc.view
        else {
            return
        }
        
        let centerFrame = podcastControllerView.frame
        var leftOriginFrame   = centerFrame
        var rightOriginFrame  = centerFrame
        leftOriginFrame.origin.x   = centerFrame.origin.x - centerFrame.width
        rightOriginFrame.origin.x  = centerFrame.origin.x + centerFrame.width
        
        musicControllerView.frame = leftOriginFrame
        
        UIView.animate(withDuration: 0.5) {
            podcastControllerView.frame = rightOriginFrame
            musicControllerView.frame = centerFrame
        } completion: { success in
            completion(success)
        }

    }
    
    func animateTransition(fromMusicVc: UIViewController, toPodcastVc: UIViewController, completion: @escaping (Bool) -> Void) {
        guard
            let musicControllerView = fromMusicVc.view,
            let podcastControllerView   = toPodcastVc.view
        else {
            return
        }
        
        let centerFrame = musicControllerView.frame
        var leftOriginFrame   = centerFrame
        var rightOriginFrame  = centerFrame
        leftOriginFrame.origin.x   = centerFrame.origin.x - centerFrame.width
        rightOriginFrame.origin.x  = centerFrame.origin.x + centerFrame.width
        
        podcastControllerView.frame = rightOriginFrame
        
        UIView.animate(withDuration: 0.5) {
            podcastControllerView.frame = centerFrame
            musicControllerView.frame = leftOriginFrame
        } completion: { success in
            completion(success)
        }

    }
    
    
    
}

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}
