//
//  SessionDelegate.swift
//  PeerKit
//
//  Created by Jeff Kereakoglow on 3/9/18.
//  Copyright © 2018 JP Simard. All rights reserved.
//

import MultipeerConnectivity

public protocol SessionDelegate: class {
    func isConnecting(toPeer peer: MCPeerID)
    func didConnect(toPeer peer: MCPeerID)
    func didDisconnect(fromPeer peer: MCPeerID)
    func didReceiveData(data: Data, fromPeer peer: MCPeerID)
}
