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



Third party packages used :
    1. fpdart             = For managing success and failure (by using Either)
    2. flutter_bloc       = For using Bloc State Management within the application
    3. get_it             = For providing the instance of external sources,interfaces,usecase and blocs
    4. internet_connection_checker_plus = For checking the user's internet connection before calling APIs
    5. http               = For making API calls (fetching news from NewsAPI)
    6. shared_preferences = For storing data locally (like bookmarks and last data from API call)
    7. equatable          = For simplifying the object comparison in Bloc_Event and Bloc_State
    8. webview_flutter    = For showing complete news within the app instead of website
