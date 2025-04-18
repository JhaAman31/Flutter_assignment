# flutter_assignment

A new Flutter project.

## Getting Started

A simple Flutter application demonstrating a news reader app with login and bookmark features.
Built using Clean Architecture and Flutter BLoC for state management.



I have used CLEAN ARCHITECTURE within the application.

Why Clean Architecture ???
Clean Architecture allows :
    a. Clear separation of concerns
    b. Easy testing and debugging
    c. Scalable codebase
    d. Reusability of code across layers (Domain, Data, Presentation)
Layers Used :
    1. Presentation Layer :
         For managing UI and state (Flutter Widgets + BLoC)
    2. Domain Layer :
         For managing business logic (repository,use cases and entities)
    3. Data Layer :
         For handling API calls and caching (repositories, models and data_source)

![image alt](https://github.com/JhaAman31/Flutter_assignment/blob/d7e995d8cb54fc05e8ebafd767e61b38cd8bb9ef/WhatsApp%20Image%202025-04-18%20at%2023.35.35_f9829d37.jpg)
![image alt](https://github.com/JhaAman31/Flutter_assignment/blob/a8f92c26b154496a533cbc49323535057f96455c/WhatsApp%20Image%202025-04-18%20at%2023.35.36_357fa22d.jpg)
Third party packages used :
    1. fpdart             = For managing success and failure (by using Either)
    2. flutter_bloc       = For using Bloc State Management within the application
    3. get_it             = For providing the instance of external sources,interfaces,usecase and blocs
    4. internet_connection_checker_plus = For checking the user's internet connection before calling APIs
    5. http               = For making API calls (fetching news from NewsAPI)
    6. shared_preferences = For storing data locally (like bookmarks and last data from API call)
    7. equatable          = For simplifying the object comparison in Bloc_Event and Bloc_State
    8. webview_flutter    = For showing complete news within the app instead of website
