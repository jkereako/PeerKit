//
//  Transceiver.swift
//  PeerKit
//
//  Created by JP Simard on 11/3/14.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

import MultipeerConnectivity

final public class Transceiver {
    let session: Session
    let advertiser: Advertiser
    let browser: Browser

    public init(displayName: String, serviceName: String) {
        session = Session(displayName: displayName, serviceName: serviceName)
        advertiser = Advertiser(session: session)
        browser = Browser(session: session)

        session.delegate = self
    }

    func advertise() {
        advertiser.start()
    }

    func browse() {
        browser.start()
    }

    func stop() {
        session.delegate = nil
        advertiser.stop()
        browser.stop()
        session.disconnect()
    }
}

// MARK: - SessionDelegate
extension Transceiver: SessionDelegate {
    public func isConnecting(toPeer peer: MCPeerID) {
        // unused
    }
    public func didConnect(toPeer peer: MCPeerID) {
        // unused
    }
    public func didDisconnect(fromPeer peer: MCPeerID) {
        // unused
    }
    public func didReceiveData(data: Data, fromPeer peer: MCPeerID) {
        // unused
    }
}
