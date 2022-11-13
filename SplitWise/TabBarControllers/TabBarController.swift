import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .gray
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: UINavigationController(rootViewController: ContactListViewController()),
                title: "Contact List",
                image: UIImage.init(systemName: "house.fill")
            ),
            generateVC(
                viewController: UINavigationController(rootViewController: GroupListViewController()),
                title: "Group List",
                image: UIImage.init(systemName: "person.fill")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}
