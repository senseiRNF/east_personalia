import 'dart:convert';

import 'package:east_personalia/services/local_services/local_json/local_company_json.dart';
import 'package:east_personalia/services/local_services/local_json/local_user_json.dart';

String userInit = jsonEncode(
  LocalUserJson(
    userId: 'admin1',
    password: 'password',
    profilePictURL: 'https://i.pinimg.com/736x/5b/f9/4e/5bf94e940fac9c5a1d7080f41ecf26af.jpg',
    username: 'Sepuh Ngoding',
    identityNumber: '0123456789',
    placeOfBirth: 'Bogor',
    dateOfBirth: '1990-01-01',
    gender: 'L',
    phone: '0123456789',
    email: 'sepuh.ngoding@gmail.com',
    address: 'Jl. Puh Sepuh No.1, Jonggol, Bogor',
    emergencyNumber: '0123456789',
    npwp: '0123456789',
    company: 'Sepuh IT Consulting',
    level: 'IT Administrator',
    role: 'admin',
  ).toJson(),
);

String companyInit = jsonEncode(
  LocalCompanyJson(
    companyId: 'puhsepuh1',
    companyName: 'Sepuh IT Consulting',
    companyIdentityNumber: '0123456789',
    companyType: 'Konsultan IT',
    dateOfEstablishment: '2020-01-01',
    companyPhone: '0123456789',
    companyEmail: 'sepuh.consulting@gmail.com',
    companyAddress: 'Jl. Sepuh Raya No.5, Jonggol, Bogor',
    companyRegion: 'JABODETABEK',
    companyPIC: 'Sepuh Ngoding',
  ).toJson(),
);