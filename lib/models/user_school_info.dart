// ignore_for_file: non_constant_identifier_names

class UserSchoolInfo {
  final String SCHUL_NM;           // school name
  final String SD_SCHUL_CODE;      // school code
  final String ATPT_OFCDC_SC_CODE; // atpt code
  final String LCTN_SC_NM;         // city
  final String ORG_RDNMA;          // address
  final String SCHUL_KND_SC_NM;    // school type

  UserSchoolInfo({
    required this.SCHUL_NM,
    required this.SD_SCHUL_CODE,
    required this.ATPT_OFCDC_SC_CODE,
    required this.LCTN_SC_NM,
    required this.ORG_RDNMA,
    required this.SCHUL_KND_SC_NM,
  });

  UserSchoolInfo.fromJson(Map<String, dynamic> json)
    : SCHUL_NM = json['SCHUL_NM'],
      SD_SCHUL_CODE = json['SD_SCHUL_CODE'],
      ATPT_OFCDC_SC_CODE = json['ATPT_OFCDC_SC_CODE'],
      LCTN_SC_NM = json['LCTN_SC_NM'],
      ORG_RDNMA = json['ORG_RDNMA'],
      SCHUL_KND_SC_NM = json['SCHUL_KND_SC_NM'];

  Map<String, dynamic> toJson() => {
    'SCHUL_NM': SCHUL_NM,
    'SD_SCHUL_CODE': SD_SCHUL_CODE,
    'ATPT_OFCDC_SC_CODE': ATPT_OFCDC_SC_CODE,
    'LCTN_SC_NM': LCTN_SC_NM,
    'ORG_RDNMA': ORG_RDNMA,
    'SCHUL_KND_SC_NM': SCHUL_KND_SC_NM,
  };
}

const Map<String, String> schoolTypeMap = {
  "초등학교": "els",
  "중학교": "mis",
  "고등학교": "his",
};