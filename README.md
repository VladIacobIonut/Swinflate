# Swinflate

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Compass.svg?style=flat)](http://cocoadocs.org/docsets/Compass)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
![Platform](https://img.shields.io/cocoapods/p/SwipeCellKit.svg)


<p align="center"><img src="https://github.com/VladIacobIonut/Swinflate/blob/master/ReadmeResources/logo.png"/></p>

## Description

Swinflate aims to encorporate a set of collection view layouts which provide a better and even more fluid experience in collection vieews . It is amongst the goals of this project to make it ruthlessly simple for you to use it in your application.   

## Available layouts

#### SWInflateLayout

<p align="center"><img src="https://github.com/VladIacobIonut/Swinflate/blob/master/ReadmeResources/inflategif.gif" height="350" width="250"/></p>

#### SWHorizontalStackLayout

<p align="center"><img src="https://github.com/VladIacobIonut/Swinflate/blob/master/ReadmeResources/stackgif.gif" height="350" width="250"/></p>

## Requirements

* Swift 4.2
* Xcode 10+
* iOS 11.0+

Installation
------------

**Swinflate** is  available for installation via **Swift Package Manager** and **Carthage**. 

<br>
To install via Carthage, paste the next line your Cartfile:

```
github "https://github.com/VladIacobIonut/Swinflate" ~> 1.0.3
```


Usage
------------

This layouts are designed to work with horizontal collection view of a single row and multiple columns.  

1. Before using it, please import it in the class where your collectionView lies.

```swift
  import Swinflate
```  

2. To implement it, just pass an instance of one of the layout classes enumerated above to the constructor of the collectionView.

######  SWInflateLayout

```swift
  collectionView = UICollectionView(frame: .zero, collectionViewLayout: SWInflateLayout())
```  

######  SWHorizontalStackLayout

```swift
let stackLayout = SWHorizontalStackLayout()
stackLayout.hasStackEffect = true
collectionView = UICollectionView(frame: .zero, collectionViewLayout: stackLayout)
```  

Note 
-  This layout allow you to enable or disable the stack effect by setting the  `hasStackEffect`  property   ( this property is   `false`  by default).
-  Both layouts allow you to enable or disable the paging effect by setting the `isPagingEnabled`  property ( this property is   `true`  by default).
 
3. You should also return the item size for your cells in the  `sizeForItem`   method of the  `UICollectionViewDelegateFlowLayout` .

```swift
extension CustomLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
        }
    }
```  



