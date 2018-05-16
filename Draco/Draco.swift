//
//  Draco.swift
//  Draco
//
//  Created by Volodymyr Boichentsov on 16/05/2018.
//  Copyright © 2018 3D4Medical LLC. All rights reserved.
//

import Foundation

/// Decompress draco data
///
/// - Parameter data: draco compressed data
/// - Returns: Indices data for triangles primitives, Vertices data and stride for vertices data
public func uncompressDracoData(_ data:Data, triangleStrip:Bool = false) -> (Data, Data, Int) {
    
    var indicies:Data = Data()
    var verticies:Data = Data()
    var stride:Int = 0
    data.withUnsafeBytes {(uint8Ptr: UnsafePointer<Int8>) in
        
        var verts:UnsafeMutablePointer<Float>?
        var lengthVerts:UInt = 0
        
        var inds:UnsafeMutablePointer<UInt32>?
        var lengthInds:UInt = 0
        
        var descsriptors:UnsafeMutablePointer<DAttributeDescriptor>?
        var descsriptorsCount:UInt = 0
        
        if draco_decode(uint8Ptr, UInt(data.count), &verts, &lengthVerts, &inds, &lengthInds, &descsriptors, &descsriptorsCount, triangleStrip) {
            
            indicies = Data.init(bytes: UnsafeRawPointer(inds)!, count: Int(lengthInds)*4)
            verticies = Data.init(bytes: UnsafeRawPointer(verts)!, count: Int(lengthVerts)*4)
            for i in 0..<descsriptorsCount {
                stride += Int(descsriptors![Int(i)].size);
            }
            
            descsriptors?.deinitialize(count: Int(descsriptorsCount))
            descsriptors?.deallocate()
            verts?.deinitialize(count: Int(lengthVerts))
            verts?.deallocate()
            inds?.deinitialize(count: Int(lengthInds))
            inds?.deallocate()
        }
    }
    
    return (indicies, verticies, stride)
}

