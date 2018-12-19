# Swinflate

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Compass.svg?style=flat)](http://cocoadocs.org/docsets/Compass)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
![Platform](https://img.shields.io/cocoapods/p/SwipeCellKit.svg)


<p align="center"><img src="https://github.com/VladIacobIonut/Swinflate/blob/master/ReadmeResources/logo.png"/></p>

Swinflate aims to encorporate a set of collection view layouts which provide a better and even more fluid experience in collection vieews . It is amongst the goals of this project to make it ruthlessly simple for you to use it in your application.   

## Available layouts

#### SWInflateLayout

<p align="center"><img src="https://github.com/VladIacobIonut/Swinflate/blob/master/ReadmeResources/swinflate.gif" height="400" width="300"/></p>


## Requirements

* Swift 4.2
* Xcode 10+
* iOS 11.0+

Installation
------------

Carthage

```
github "https://github.com/VladIacobIonut/Swinflate" ~> 0.0.1
```


Usage
------------

#### SWInflateLayout

This layout is designed to work with horizontal collection view of a single row and multiple columns.  

1. Before using it, please import in the class where your collectionView lies

```swift
  import Swinflate
```  

2. To implement it, just pass an instance of the SWInflateLayout class to the constructor of the collectionView

```swift
  collectionView = UICollectionView(frame: .zero, collectionViewLayout: SWInflateLayout())
```  

3. You should also return the item size for your cells in the ```swift sizeForItem```   method of the ```swift UICollectionViewDelegateFlowLayout  ```  

```swift
extension CustomLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
        }
    }
```  
