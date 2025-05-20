# Video Journey: Your Personal Video Browser

An iOS application built with Swift for browsing and playing your favorite videos. Load videos from local files or stream from network sources, all managed seamlessly with Core Data integration.

## Features

- Video listing and browsing using a `UITableView` (`MasterViewController`).
- Custom video player built with `AVFoundation` (`Player.swift`), supporting standard playback controls (play, pause, stop, seek) and managing playback/buffering states.
- Loading video data from a local JSON file (`VideoData.json`).
- Capability to load video data from a remote network source via URL (`ServiceHelper.swift`).
- Core Data integration for managing application data, including setup of the Core Data stack (`AppDelegate`).
- Use of a `VideoModel` to structure and handle video data throughout the application.
- Display of video metadata in the list, such as video name, duration, and poster image (`VideoListcell`).
- A dedicated detail view (`DetailViewController`) for displaying selected video information and embedding the video player.
- Communication of player events (e.g., ready, state changes, buffering) through a delegate pattern (`PlayerDelegate`).
- Integration of a custom Heads-Up Display (HUD) element (indicated by the presence of `MBProgressHUD` in the `Frameworks` directory).
- Utilization of a `UISplitViewController` for the main UI layout, managed in `AppDelegate`.
- Pull-to-refresh functionality in the video list to reload data.
- Asynchronous network data fetching using `NSURLSession`.
- Basic error handling placeholders and failure callbacks, particularly for network operations.

## Prerequisites

Before you begin, ensure you have Xcode 7.x installed, as the project is configured for Swift 2.x and targets iOS 9.0.

## Installation

1.  **Obtain the Code:**
    Clone the repository to your local machine using Git:
    ```bash
    git clone <repository_url> 
    ```
    (Replace `<repository_url>` with the actual URL of the repository).

2.  **Open in Xcode:**
    Navigate to the cloned directory and open the `VideoBrowser.xcodeproj` file in Xcode.

3.  **Run the Project (Initial Run):**
    Select an iOS Simulator from the scheme menu in Xcode (e.g., iPhone 6s running iOS 9.0 or later). Click the **Run** button (or press **Cmd+R**) to build and run the project. The app will launch, and by default, it loads videos from the local `VideoData.json`. Videos from the network source might not load at this point if you switch to it, due to the self-signed certificate issue.

4.  **Install Self-Signed Certificate on Simulator (for Network Data):**
    If you intend to test loading data from the network server (`https://s18613401.onlinehome-server.com:9443`), you need to install its self-signed SSL certificate on the simulator. This step is necessary because the server uses a certificate not issued by a default trusted Certificate Authority (CA), and iOS blocks such connections for security.

    a.  With the simulator running, press **Cmd+Shift+H** to return to the Home screen.
    b.  Open the **Safari** browser on the simulator.
    c.  In Safari's address bar, type the URL for the certificate: `http://s18613401.onlinehome-server.com:8080/server.crt` and press **Go**.
    d.  Safari will display information about the certificate and prompt you to install it. Tap **Install** when prompted. You may see warnings about the certificate's authenticity; proceed by tapping **Install** again.
    e.  If prompted, enter your simulator's passcode (if one is set).
    f.  After installation, the certificate profile will be added to the simulator. You can typically verify installed profiles under **Settings > General > Profile** or **Settings > General > Device Management > Profile** (the exact path may vary slightly with iOS versions). Ensure it is trusted if further steps are presented.

5.  **Relaunch the Application:**
    If you installed the certificate and modified the code to use the network source (see Usage section), stop the application in Xcode (e.g., by pressing **Cmd+.** or using the Stop button) and then run it again (**Cmd+R**). The app should now be able to connect to the network server and load videos.

## Usage

1.  **Launching the Application:**
    After successfully completing the installation steps, the application will launch on the selected iOS Simulator or device when run from Xcode.

2.  **Browsing Videos:**
    *   Upon launch, the main screen (Master View) displays a list of videos. By default, this list is populated from the local `VideoData.json` file.
    *   Each video entry shows the video's name, duration, and a poster image.
    *   You can scroll through the list if it exceeds the screen height.
    *   A refresh button (if configured with a pull-to-refresh or a bar button in the storyboard and linked to the `refreshData` IBAction) can be used to reload the video list. As per the current code, `refreshData` also loads from the local JSON file unless modified.

3.  **Selecting and Playing a Video:**
    *   Tap on any video in the list to view its details and start playback.
    *   This will navigate you to the Detail View, where the video will begin playing automatically in an embedded player.
    *   The video's name is also displayed at the top of the Detail View.

4.  **Video Playback:**
    *   Playback starts automatically once a video is selected.
    *   The video player is a custom implementation (`Player.swift`) using Apple's `AVFoundation` framework.
    *   While the player manages playback states (playing, paused, buffering, etc.), explicit on-screen user controls (like custom play/pause buttons, scrub bar) are not part of this custom UI. Standard system interactions with video content, if enabled by default for `AVPlayerLayer`, might apply.
    *   To return to the video list from the player view, use the back navigation button provided by the `UINavigationController`.

5.  **Switching Data Sources (Local JSON vs. Network):**
    The application is initially configured to load video data from the local `VideoData.json` file in `viewDidLoad()` and `refreshData()`. To switch to loading data from the network:
    *   Open the `VideoBrowser/MasterViewController.swift` file in Xcode.
    *   **In `viewDidLoad()` method:**
        *   Comment out the line: `self.loadDataFromJsonFile()`
        *   Uncomment the line: `//self.loadDataOverNetwork()` (change it to `self.loadDataOverNetwork()`)
    *   **In `refreshData(sender: AnyObject)` method:**
        *   Comment out the line: `self.loadDataFromJsonFile()`
        *   Uncomment the line: `//self.loadDataOverNetwork()` (change it to `self.loadDataOverNetwork()`)
    *   Re-run the application. Remember to install the self-signed certificate (see Installation Step 4) for the network data to load and play correctly.
    *   To revert to using the local JSON data, simply reverse these code changes.

## Frameworks and Libraries Used

The VideoBrowser project utilizes the following third-party or significant custom components:

1.  **MBProgressHUD**
    *   **Purpose**: Used for displaying a Heads-Up Display (HUD) to show activity or progress indicators to the user. The files `HUD.h` and `HUD.m` appear to be helper classes for using `MBProgressHUD`.
    *   **Location**: Found in the `Frameworks/HUD/` directory.
    *   **License**: MIT License. Both `MBProgressHUD.h` (Copyright (c) 2011 Matej Bukovinski) and `HUD.h` (Copyright (c) 2011 Marin Todorov) include MIT license terms.

2.  **Player.swift (Custom Video Player)**
    *   **Purpose**: A custom-built video player component using `AVFoundation` for handling video playback within the application. It manages player states, buffering, and basic playback operations.
    *   **Location**: `VideoBrowser/Player.swift`.
    *   **License**: As part of the overall project, its license would be governed by the main `LICENSE` file of the VideoBrowser application (which is the MIT License, as per the `LICENSE` file in the root of the repository).

## License

This project is licensed under the Apache License, Version 2.0.

Key aspects of the Apache License 2.0 include:
*   **Permissions**: You are free to use, reproduce, and distribute the work or derivative works.
*   **Conditions**: You must give recipients a copy of the license, cause modified files to carry prominent notices of changes, and retain all copyright, patent, trademark, and attribution notices from the original work (excluding those not pertaining to the derivative work). If a `NOTICE` file is included, its attribution notices must be included in derivative works.
*   **Grant of Patent License**: Contributors grant a patent license for their contributions. This license can terminate if you institute patent litigation against any entity alleging the Work or a Contribution infringes a patent.
*   **No Warranty**: The software is provided "AS IS" without warranties of any kind.
*   **Limitation of Liability**: Contributors are not liable for damages arising from the use or inability to use the work.

For the full license text, please see the `LICENSE` file in the root of the repository.
