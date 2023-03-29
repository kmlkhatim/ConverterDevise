# Currency converter

Here is sample code for a simple currency converter in SwiftUI, using an API to retrieve exchange rates:

<img width="558" alt="CaptureIphone" src="https://user-images.githubusercontent.com/122582762/228401460-678ea2c9-d30b-4ec4-87d5-8aa53d2fc30c.png">

The code uses a @State to store the state of the amount, source and end currencies, conversion rate, and converted amount. It also uses an API to retrieve current exchange rates.

The code also uses a NavigationView and a Form to organize the user interface, and uses a Picker to select currencies. Finally, it uses onAppear to retrieve the conversion rate as soon as the view is displayed, and a fetchConversionRate function to retrieve exchange rates via the API.
