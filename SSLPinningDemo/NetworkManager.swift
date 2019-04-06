

import Alamofire
class NetworkManager {
    
    var manager: SessionManager?
    static let networkManager = NetworkManager()

    init() {
      
    }
    
    public func pinningWithPublicKey(){
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "www.google.co.uk": .pinPublicKeys(
                publicKeys: ServerTrustPolicy.publicKeys(),
                validateCertificateChain: true,
                validateHost: true
            )
        ]
        manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        manager!.request("https://www.google.co.uk").response { response in
            if response.error == nil {
                print("Success")
                print(response.response?.statusCode)
            } else {
                print("Error")
                
            }
        }
    }
    
    public func testPinning() {
        let certificates: [SecCertificate] = getCertificates()
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "www.google.co.uk": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            )
        ]
        manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        NetworkManager.networkManager.manager!.request("https://www.google.co.uk").response { response in
            if response.error == nil {
                print("Success")
                print(response.response?.statusCode)
            } else {
                print("Error")
               
            }
        }
    }
    
    private func getCertificates() -> [SecCertificate] {
        let url = Bundle.main.url(forResource: "google", withExtension: "cer")!
        let localCertificate = try! Data(contentsOf: url) as CFData

        guard let certificate = SecCertificateCreateWithData(nil, localCertificate)
            else {
                return []
        }
        return [certificate]
    }

}
