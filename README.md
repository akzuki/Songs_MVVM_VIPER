# Songs_MVVM_VIPER

This project demonstrates the Model-View-ViewModel Coordinator (MVVM-C) architecture with RxSwift and also VIPER on iOS.
<br/>
The first screen `Login` uses MVVM-C & RxSwift while the next screen `ListSong` uses VIPER and delegates.

This project also covers Unit Tests, Storyboard, Nibs and programmatic UIs.

## Screenshots
`Login`: MVVM-C & RxSwift. Storyboard
<br/>
<img src="https://github.com/akzuki/Songs_MVVM_VIPER/blob/master/Screenshots/login.png" height="400">

`ListSong` VIPER. Programmatic UIs
<br/>
<img src="https://github.com/akzuki/Songs_MVVM_VIPER/blob/master/Screenshots/listsong.png" height="400">

## Unit tests
ViewModels & Presenters & Interactors are covered by unit tests.
<br/>
To run the unit tests, simply hit `Cmd + U` in Xcode.
//TODO: Add more test cases

## Requirements
Xcode 9 + Swift 4

## Project Structure
```
Songs_MVVM_VIPER
├──AppDelegate
├──Protocols
├──Entities
├──Base
├──Utility
├──Service
├──Scenes
│   ├──Login
│   │   ├──Coordinator
│   │   ├──ViewModel
│   │   ├──ViewController
│   ├──ListSong
│   │   ├──Wireframe
│   │   ├──Interactor
│   │   ├──Presenter
│   │   ├──ViewController
│   ├──SongDetail
│   │   ├──Wireframe
│   │   ├──Interactor
│   │   ├──Presenter
│   │   ├──ViewController
├──Main.storyboard
