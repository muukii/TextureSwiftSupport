//
//  MethodChain.swift
//  TextureSwiftSupport
//
//  Created by muukii on 2019/10/09.
//  Copyright © 2019 muukii. All rights reserved.
//

import Foundation
import UIKit

public enum Edge: Int8, CaseIterable {
  
  case top = 0
  case left = 1
  case bottom = 2
  case right = 3
  
  public struct Set: OptionSet {
    
    public var rawValue: Int8
    public var isEmpty: Bool {
      rawValue == 0
    }
    
    public init(rawValue: Int8) {
      self.rawValue = rawValue
    }
    
    static let top: Set = .init(rawValue: 1 << 1)
    static let left: Set = .init(rawValue: 1 << 2)
    static let bottom: Set = .init(rawValue: 1 << 3)
    static let right: Set = .init(rawValue: 1 << 4)

    static var horizontal: Set {
      [.left, .right]
    }
    
    static var vertical: Set {
      [.top, .bottom]
    }
    
    static var all: Set {
      [.top, .bottom, .right, left]
    }
    
  }
  
}


// MARK: - Padding
extension _ASLayoutElementType {
  
  public func padding(_ padding: CGFloat) -> InsetLayout<Self> {
    InsetLayout(insets: .init(top: padding, left: padding, bottom: padding, right: padding)) {
      self
    }
  }
  
  public func padding(_ edgeInsets: UIEdgeInsets) -> InsetLayout<Self> {
    InsetLayout(insets: edgeInsets) {
      self
    }
  }
  
  public func padding(_ edges: Edge.Set, padding: CGFloat) -> InsetLayout<Self> {
    
    var insets = UIEdgeInsets.zero
    
    if edges.contains(.top) {
      insets.top = padding
    }
    
    if edges.contains(.left) {
      insets.left = padding
    }
    
    if edges.contains(.bottom) {
      insets.bottom = padding
    }
    
    if edges.contains(.right) {
      insets.right = padding
    }
    
    return InsetLayout(insets: insets) {
      self
    }
  }
}

// MARK: - Background

extension _ASLayoutElementType {
  
  public func background<Background: _ASLayoutElementType>(_ backgroundContent: Background) -> BackgroundLayout<Background, Self> {
    BackgroundLayout(content: { self }, background: { backgroundContent })
  }
    
  public func overlay<Overlay: _ASLayoutElementType>(_ overlayContent: Overlay) -> OverlayLayout<Overlay, Self> {
    OverlayLayout(content: { self }, overlay: { overlayContent })
  }
}