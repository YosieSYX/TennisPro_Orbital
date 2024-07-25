//
//  PhotoPickerProtocol.swift
//  TennisPro_Orbital
//
//  Created by 杨清如 on 23/7/24.
//

import Foundation
import PhotosUI

protocol PhotoPickerProtocol {
    func loadTransferable(type:Data.Type) async throws -> Data?
    
}
