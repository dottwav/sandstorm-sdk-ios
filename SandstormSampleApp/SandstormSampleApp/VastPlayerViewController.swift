//
//  VastPlayerViewController.swift
//  AdTonosVastPlayerSampleApp
//
//  Created by Mateusz Wojnar on 06/12/2021.
//

import UIKit
import SandstormSDK
import ThunderSDK

class VastPlayerViewController: UIViewController {

    @IBOutlet weak var statusButton: UILabel!
    private let sandstorm = ATSandstormSDK.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        //App should be in active state to start due to IDFA permission.
        NotificationCenter.default.addObserver(self, selector: #selector(startAdTonos), name: UIApplication.didBecomeActiveNotification, object: nil)
        //Add an observer to be notified by callbacks related to the SDK setup.
        sandstorm.add(thunderObserver: self)
        //Add an observer to be notified by player-related callbacks.
        sandstorm.add(sandstormObserver: self)
    }

    @objc private func startAdTonos(){
        //Start AdTonosSDK with all consents if it is not started.
        if !sandstorm.isStarted {
            sandstorm.start(with: .allowAll)
        }
    }

    private func requestForAds(adType: VastAdType){
        guard sandstorm.isStarted else {
            statusButton.text = "adTonos is not yet started"
            return
        }

        guard !sandstorm.isAdAvailable else {
            statusButton.text = "The ad was already prepared"
            return
        }

        //Creates builder instance for further usage.
        let builder = sandstorm.createBuilder()
            .set(adTonosKey: "KT267qyGPudAugiSt") //Sets developer key.
            .set(lang: "en") //Sets user language if different than a system defined
            .set(adType: adType) //Sets the type of ad (default is .regular).

        statusButton.text = "Requesting ads..."
        //Requests ads to be loaded for playing
        _ = sandstorm.requestForAds(with: builder)
    }

    @IBAction func requestForBannerAds(_ sender: Any) {
        requestForAds(adType: .bannerAd)
    }
    
    @IBAction func requestForRegularAds(_ sender: Any) {
        requestForAds(adType: .regular)
    }

    @IBAction func play(_ sender: Any) {
        if sandstorm.isAdAvailable {
            _ = sandstorm.playAd()
        }
    }

    @IBAction func pause(_ sender: Any) {
        if sandstorm.isAdAvailable {
            _ = sandstorm.pauseAd()
        }
    }

    @IBAction func clear(_ sender: Any) {
        sandstorm.clear()
    }

    @IBAction func onBannerPositionChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            //Sets the position of the banner at the top of the screen.
            sandstorm.setAdBannerPosition(.top)
        }
        else if sender.selectedSegmentIndex == 1 {
            //Sets the position of the banner at the bottom of the screen.
            sandstorm.setAdBannerPosition(.bottom)
        }
    }

    deinit {
        sandstorm.clear()
        sandstorm.remove(thunderObserver: self)
        sandstorm.remove(sandstormObserver: self)
        NotificationCenter.default.removeObserver(self)
    }
}

extension VastPlayerViewController: ThunderObserver {
    func onStarted(success: Bool, error: ThunderError?) {
        if success {
            statusButton.text = "Thunder is started."
            //SDK is started, so we can create a builder and do request for ads.
            requestForAds(adType: .regular)
        }
    }
}

extension VastPlayerViewController: SandstormObserver {
    func onCleared() {
        statusButton.text = "Ads are cleared."
    }

    func onVastAdsLoaded() {
        statusButton.text = "Single ad is loaded and ready to play"
    }

    func onVastError(_ error: SandstormError) {
        statusButton.text = "Error occurred during ads request or any ads interaction like playing, pausing"
    }

    func onVastAdsAvabilityExpired() {
        statusButton.text = "Ads expired."
    }

    func onVastAdsStarted() {
        statusButton.text = "Sequence of one or more ads in VAST starts to play"
    }

    func onVastAdPaused() {
        statusButton.text = "Single ad is paused"
    }

    func onVastAdPlayStarted() {
        statusButton.text = "Single ad is played"
    }

    func onVastAdsEnded() {
        statusButton.text = "Sequence of one or more VAST ads has ended"
    }
}

