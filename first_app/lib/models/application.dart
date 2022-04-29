class Application {
  String position;
  String company;
  String status;
  String time;
  String logo;

  Application(this.position, this.company, this.status, this.time, this.logo);
}

List<Application> getApplications() {
  return <Application>[
    Application("Flutter UI / UX Designer", "The Bridge", "Delivered",
        "3 mounths", "assets/images/Bridge.png"),
    Application("Product Designer", "Google LLC", "Opened", "60",
        "assets/images/Bridge.png"),
    Application("UI / UX Designer", "Uber Technologies Inc.", "Cancelled", "55",
        "assets/images/Bridge.png"),
    Application("Lead UI / UX Designer", "Apple Inc.", "Delivered", "80",
        "assets/images/Bridge.png"),
    Application("Flutter UI Designer", "Amazon Inc.", "Not selected", "60",
        "assets/images/Bridge.jpg"),
  ];
}
