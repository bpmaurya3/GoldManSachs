# GoldMan Sachs (Practical Exercise) 
========================================

## Summary

Thanks for providing the opportunity and considering for this round. 

This iOS application has the following features:
* After the launch screen, app opens with the list of Pictures along with title, date & explanation.
* Called the API to get the Planets details. JSONDecoder is used to parse the json response.
* On this screen, the PictureList ViewController on top scrolls off the screen.
* First load, I have configured for last 1 month Pictures by providing start & end date as a url params.
* Can load for specific date by chossing a date on top of screen. Later, can clear also & get all data which are in DB.
* Most importantly, supported offline use of application by saving data into Database.
* Lazy loading of images.

Optional features implemented:
* Can make favourite locally, by clicking heart button on detail page.
* Tapping on an row row, shows the picture details screen with full of explanation details.
* This a universal app supporting iPad as well.
* Provided Dark Mode support.

In this project the key View Controllers are PictureListViewController (responsible for showing the Planet details list) and PictureDetailsViewController (Show the detailed view of individual planet, can make favourite). 

The PictureListViewController contains a tableview, who's datasource is dynamically handled in corresponding viewmodel.


## Recommendations

Recommended Xcode version to build the project is Xcode 12.5.1 with minimum supported deployment target iOS 15.5.
 

## Project Structure

To keep the code files readable and uncluttered, below is the folder structure used in the project.

    ├─ Sources ────├─ Coordinator
                   ├─ Network
                   ├─ Utils
                   ├─ ViewControllers
                   ├─ ViewModels
                   ├─ Cells
                   ├─ Databse


## Architecture

* Model-View-ViewModel-Coordinator (MVVM-C)
    * To avoid massive view controllers, MVVM-C is considered in this project.

* __Callback blocks:__ _(one-to-one)_ 

## Xcode build

1. Download GManSChallenge
2. Remove Pods & podfile.lock, reinstall the pod
2. Open `GManSChallenge.xcworkspace` in Xcode
3. Select the `GManSChallenge` scheme
4. Build
