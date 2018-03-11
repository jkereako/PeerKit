//
//  Session.swift
//  PeerKit
//
//  Created by JP Simard on 11/3/14.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

import MultipeerConnectivity

final public class Session: NSObject {
    var delegate: SessionDelegate?
    public private(set) var myPeerID: MCPeerID
    public private(set) var mcSession: MCSession
    public private(set) var serviceName: String
    
    public init(displayName: String, serviceName: String) {
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

        self.serviceName = serviceName
        myPeerID = MCPeerID(displayName: displayName)
        mcSession = MCSession(peer: myPeerID)

        super.init()

        mcSession.delegate = self
    }
    
    public func disconnect() {
        self.delegate = nil
        mcSession.delegate = nil
        mcSession.disconnect()
    }
}

// MARK: - MCSessionDelegate
extension Session: MCSessionDelegate {
    public func session(_ session: MCSession, peer peerID: MCPeerID,
                        didChange state: MCSessionState) {
        switch state {
        case .connecting:
            delegate?.isConnecting(toPeer: peerID)
        case .connected:
            delegate?.didConnect(toPeer: peerID)
        case .notConnected:
            delegate?.didDisconnect(fromPeer: peerID)
        }
    }
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        delegate?.didReceiveData(data: data, fromPeer: peerID)
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream,
                        withName streamName: String, fromPeer peerID: MCPeerID) {
        // unused
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName
        resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // unused
    }
    
    public func session(_ session: MCSession,
                        didFinishReceivingResourceWithName resourceName: String,
                        fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // unused
    }
}
