# RecipesTestApp
 
### Steps to Run the App
1. Make sure you are signed in to your GitHub account in Xcode
2. Hit "Run" 

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
My primary focus is on the big picture and how all of the pieces of the architecture and the patterns interact. This app clearly shows the connection point between the three primary architectural patterns used in their purest forms without need to compromise them. These patterns are MVVM, Navigation Coordinators, and Inversion of Control Dependency Injection.

Each primary architecture pattern is pure and allows for direct teachable moments when mentoring developers as they add to the app. Each pattern can be referenced without need to explain how the other works and the responsibility of each pattern is clear set in place.

- MVVM: Responsible for user interactions and user-facing business logic.
- Navigation Coordinators: Responsible for navigation between views.
- Inversion of Control Dependency Injection: Responsible for dependency injection and resolving instances of classes pre-injected with necessary dependencies.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I took about 5 hours give or take a little with intermittent breaks. I happened to be available all day when I received the invite for this project. There was no special way that I allocated my time, because most of the work has become second nature to me and I methodically worked my way through constructing the app in the following sequence:
- Create the repo and app shell
- Build necessary architecture and pull in dependencies
- Construct shell for Navigation Coordinators and ViewModels
- Build out the Domain Model for fetching recipes
- Integrate the Domain Model (RecipesService) into the RecipesListViewModel and validate that each important state is accounted for.
- Build caching to disk from SDWebImage
- Unit Tests for Domain Model objects (services) and ViewModels.
- Polish

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
The biggest trade-off was bringing in the `SDWebImage` package for image caching to disk. I would have preferred to build it myself, because it is the only part of the package I wanted to use. I am not a fan of `SDWebImage`'s extensive use of the singleton pattern which can make unit testing extremely challenging. The caching is abstracted behind a protocol so it would be easy to swap out at a later date.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The weakest part of this app also happens to be the use of `SDWebImage` due to its extensive use of the singleton pattern. Over time this could make unit testing difficult even though I have currently isolated access to a single file. Other developers may not be as careful. I would prefer to build the caching system internally to avoid this potential issue and remove `SDWebImage` as a dependency.

Additionally there is no logging in the app. During my time at DoorDash, I was in charge of the team meant to improve their telemetry, app performance, and stability. I worked closely with every client team on the Flag Ship DoorDash app to have well-defined events so I acutely understand the importance of robust analytics.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
- `SDWebImageSwiftUI`: This is used because it has the ability to cache images to disk and is a well-regarded package used throughout the industry.
- `Swinject`: This is used for dependency injection. `Swinject` is based on `Ninject` from C# and is very simple and effective without requiring the singletons needed to make Service Locator DI patterns work.
- `SwiftUI.Foundations`: This package is a collection of code that I have developed over time and used in many projects. Most of the time I copy the code I am going to use into the app or an internal SPM package, but for the sake of time I simply brought the dependency in here.

Additional Packages:
- `SDWebImage`: This is brought in from and part of `SDWebImageSwiftUI`. See above.
- `CombineExt`: Is brought in from `SwiftUI.Foundations` and is a collection of Publishers and Extensions for Combine from the Combine Community. It is maintained by many well-regarded open-source developers and used throughout the industry. 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
For more information on the patterns used in this app and how they extend further into a full app with navigation, please see the [MVVM.Demo.SwiftUI](https://github.com/jasonjrr/MVVM.Demo.SwiftUI) repository's README.

The next steps I would take in this app would be to add a robust analytics system to log important events and trace user journeys and performance throughout the app and replace `SDWebImage` with a home-grown caching system.
