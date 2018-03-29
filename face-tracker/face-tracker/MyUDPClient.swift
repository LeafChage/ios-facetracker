//
//  UDPClient.swift
//  face-tracker
//
//  Created by takaya kusanagi on 2018/03/29.
//  Copyright © 2018年 takaya kusanagi. All rights reserved.
//

import SwiftSocket

class MyUDPClient {
    private var client: UDPClient?
    
    public init(address: String , port: Int32) {
        self.client = UDPClient(address: address, port: port)
    }
    
    public func send(data: String) -> Bool {
        if let client = self.client {
            switch client.send(string: data) {
            case .success:
                return true
            case .failure(let err):
                print(err)
                return false
            }
        }else{
            return false
        }
        
    }
}
