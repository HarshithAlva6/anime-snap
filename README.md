# anime-snap

python -m venv .venv
rm -rf venv (already existed from VScode)
source .venv/bin/activate

touch requirements.txt
python3 -m pip install --upgrade pip
pip install -r requirements.txt
mkdir app
uvicorn app.main:app --reload

/search?name=One%20Piece

ssh-keygen -t ed25519 -C "harshalva.titan@csu.fullerton.edu"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
Save it in GitHub → Settings → SSH and GPG keys → New SSH key
git remote set-url origin git@github.com:HarshithAlva6/anime-snap.git
git push

(ssh-add --apple-use-keychain ~/xcode)
(chmod 600 ~/xcode)
(sudo rm -r ~/xcode)


IOS
Add the key: App Transport Security Settings (this may auto-complete).

Expand this new setting.

Click the + button next to it and add the key: Allow Arbitrary Loads to YES.

# Building Backend with Python and Frontend with SwiftUI
 
iOS Developer -
Apple used to use Objective C for the development of apps for iOS and macOS, but since 2014 Swift has become the primary language for app development. Object and protocol-oriented.
https://www.hackingwithswift.com/100/swiftui

iOS Architecture -
MVC is used for simple apps, while MVVM is considered when the app is large and complex.
Core OS - The Core OS layer in iOS is the foundation. This layer includes the kernel, which manages system resources and hardware abstraction, and device drivers that facilitate communication between the OS and hardware. 
Core Service - The Core Services layer in iOS provides essential system services that support app development by offering a wide range of fundamental frameworks and capabilities. 
Cocoa Touch layer - Provides key frameworks, user interface elements, gestures, animations, and event handling to develop apps. Key components include UIKit for managing the graphical user interface, Foundation for essential data and network access, and Core Motion for handling device motion data. Additionally, frameworks like GameKit, MapKit, MessageUI, EventKit, and AVFoundation extend functionality for gaming, mapping, communication, event management, and multimedia.

OOP - Objects hold data and methods
Functional programming - Code is written using pure functions, avoiding changing state and mutable data. 
Automatic Reference Counting (ARC) - Inserting memory management method calls during compilation, though it still uses reference counting. ARC provides memory to store info about the object instance. ARC will not deallocate an instance as long as at least one active reference to that instance still exists.
ViewController Lifecycle - Sequence of methods called as a view controller transitions between states. It begins with initialization, followed by loading the view, appearing on screen, disappearing, and potentially being deallocated. Key methods include viewDidLoad(), viewWillAppear(), viewDidAppear(), viewWillDisappear(), and viewDidDisappear().
Concurrency in iOS development refers to executing multiple tasks simultaneously. Grand Central Dispatch (GCD) is a low-level API that manages concurrent operations through queues, while async/await is a modern Swift feature that simplifies asynchronous code. 
UIKit is a fundamental framework for building user interfaces in iOS applications. 
https://developer.apple.com/documentation/uikit

Basic Interfaces -
