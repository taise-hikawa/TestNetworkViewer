import UIKit
//import SVProgressHUD

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel! // 名前
    @IBOutlet weak var emailLabel: UILabel! // メールアドレス
    @IBOutlet weak var introductionLabel: UILabel! // 自己紹介
    @IBOutlet weak var dateLabel: UILabel! // 取得日時
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.initialize()
            // プロフィール取得API
            self.executeGetUserApi()
        }

        private func initialize() {
            [nameLabel, emailLabel, introductionLabel, dateLabel].forEach {
                $0.text = ""
            }
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    }

    // MARK: - Network
    extension ViewController {
        private func executeGetUserApi() {
            let network = NetworkLayer()

            network.setStartHandler {()->() in
//                SVProgressHUD.show(withStatus: "Loading...")
            }
            network.setErrorHandler {(error: NSError)->() in
                // 通信失敗時
//                SVProgressHUD.dismiss()
                print("通信に失敗しました")
            }
            network.setFinishHandler {(result: Any?)->() in
                // 通信成功時 (※ローディングポップアップの挙動を確認するためにワザと待たせています)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
//                    SVProgressHUD.dismiss()

                    guard let data = result as? UserModel else { return }
                    // サーバーから取得した値を各パラメータにセットし画面へ表示
                    self.nameLabel.text = data.name
                    self.emailLabel.text = data.email
                    self.introductionLabel.text = data.introduction
                    self.dateLabel.text = data.date
                }
            }

            // パラメータセット
            let userId = 1
            // API実行
            network.requestApi(api: .profile(userId), parameters: nil, headers: nil)
        }
    }
