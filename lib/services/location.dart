class Location {
  double getLatitude(String country) {
    switch (country) {
      case 'United States':
        return 40.71;
      case 'United Kingdom':
        return 51.51;
      case 'UAE':
        return 25.08;
      case 'India':
        return 19.07;
      case 'Japan':
        return 35.69;
      case 'Russia':
        return 55.75;
      case 'Canada':
        return 43.70;
      default:
        return 40.71;
    }
  }

  double getLongitude(String country) {
    switch (country) {
      case 'United States':
        return (-74.01);
      case 'United Kingdom':
        return (-0.13);
      case 'UAE':
        return 55.31;
      case 'India':
        return 72.88;
      case 'Japan':
        return 139.69;
      case 'Russia':
        return 37.62;
      case 'Canada':
        return (-79.42);
      default:
        return (-74.01);
    }
  }

  String getCity(String country) {
    switch (country) {
      case 'United States':
        return 'New York';
      case 'United Kingdom':
        return 'London';
      case 'UAE':
        return 'Dubai';
      case 'India':
        return 'Mumbai';
      case 'Japan':
        return 'Tokyo';
      case 'Russia':
        return 'Moscow';
      case 'Canada':
        return 'Toronto';
      default:
        return 'New York';
    }
  }

  String getCurrencyCode(String country) {
    switch (country) {
      case 'United States':
        return 'usd';
      case 'United Kingdom':
        return 'gbp';
      case 'UAE':
        return 'aed';
      case 'India':
        return 'inr';
      case 'Japan':
        return 'jpy';
      case 'Russia':
        return 'rub';
      case 'Canada':
        return 'cad';
      default:
        return 'usd';
    }
  }
}
