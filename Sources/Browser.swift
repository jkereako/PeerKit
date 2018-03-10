//
//  Browser.swift
//  PeerKit
//
//  Created by JP Simard on 11/3/14.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

import MultipeerConnectivity

final class Browser: NSObject {
    private let mcSession: MCSession
    private let nearbyServiceBrowser: MCNearbyServiceBrowser
    private let peerInvitationTimeout: Double = 30

    init(session: Session, serviceName: String) {
        // The service name must meet the restrictions of RFC 6335:
        //  * Must be 1–15 characters long
        //  * Can contain only ASCII lowercase letters, numbers, and hyphens
        //  * Must contain at least one ASCII letter
        //  * Must not begin or end with a hyphen
        //  * Must not contain hyphens adjacent to other hyphens.

        assert(
            serviceName.count > 1 && serviceName.count < 15,
            "Service Name must be 1 to 15 characters long"
        )
        assert(
            serviceName[serviceName.startIndex] != "-" && serviceName[serviceName.endIndex] != "-",
            "Service Name must not begin or end with a hyphen"
        )
        assert(
            serviceName.range(of: "--") == nil,
            "Service Name must not contain adjacent hyphens"
        )

        let legalCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz0123456789-")

        assert(
            serviceName.rangeOfCharacter(from: legalCharacters.inverted) == nil,
            "Service Name must contain only lowercase letters, decimal digits and hyphens."
        )

        self.mcSession = session.mcSession
        nearbyServiceBrowser = MCNearbyServiceBrowser(
            peer: session.myPeerID, serviceType: serviceName
        )

        super.init()

        nearbyServiceBrowser.delegate = self
    }

    func start() {
        nearbyServiceBrowser.startBrowsingForPeers()
    }

    func stop() {
        nearbyServiceBrowser.delegate = nil
        nearbyServiceBrowser.stopBrowsingForPeers()
    }
}

// MARK: - MCNearbyServiceBrowserDelegate
extension Browser: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID,
                 withDiscoveryInfo info: [String : String]?) {

        browser.invitePeer(peerID, to: mcSession, withContext: nil, timeout: peerInvitationTimeout)
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // unused
    }
}
