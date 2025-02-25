class School {
  final String schoolName;
  final String schoolCode;
  final String atptCode;
  final String city;
  final String address;

  School({
    required this.schoolName,
    required this.schoolCode,
    required this.atptCode,
    required this.city,
    required this.address,
  });

  School.fromJson(Map<String, dynamic> json)
      : schoolName = json['SCHUL_NM'],
        schoolCode = json['SD_SCHUL_CODE'],
        atptCode = json['ATPT_OFCDC_SC_CODE'],
        city = json['LCTN_SC_NM'],
        address = json['ORG_RDNMA'];
  
  Map<String, dynamic> toJson() => {
    'schoolName': schoolName,
    'schoolCode': schoolCode,
    'atptCode': atptCode,
    'city': city,
    'address': address,
  };
  
}
