class Job {
  String company;
  String logoUrl;
  bool isMark;
  String title;
  String location;
  String time;
  List<String> req;
  Job(this.company, this.logoUrl, this.isMark, this.title, this.location,
      this.time, this.req);

  static List<Job> generateJobs() {
    return [
      Job(
        'The Bridge',
        'assets/images/Bridge.png',
        false,
        'Principle Product Design',
        'Lac 1 level 1 2236 Tunis, Tunisie',
        '3 mounths',
        [
          'Creative with an eye for shape and colour',
          'Understand different materials and production method',
        ],
      ),
      Job(
        '9antra.tn-The Bridge,',
        'assets/images/Bridge.png',
        false,
        'Principle Product Design',
        'Lac 1 level 1 2236 Tunis, Tunisie',
        '3 mounths',
        [
          'Creative with an eye for shape and colour',
          'Understand different materials and production method',
        ],
      ),
      Job(
        '9antra.tn-The Bridge,',
        'assets/images/Bridge.png',
        false,
        'Principle Product Design',
        'Lac 1 level 1 2236 Tunis, Tunisie',
        '3 mounths',
        [
          'Creative with an eye for shape and colour',
          'Understand different materials and production method',
        ],
      ),
    ];
  }
}
