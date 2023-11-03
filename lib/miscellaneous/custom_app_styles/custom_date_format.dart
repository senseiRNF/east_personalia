import 'package:intl/intl.dart';

class CustomDateFormatter {
  final DateTime data;
  final bool usingDay;
  
  const CustomDateFormatter({
    required this.data,
    required this.usingDay,
  });
  
  String shortDMY() {
    String? convertedDay;
    
    if(usingDay) {
      switch(data.weekday) {
        case 1:
          convertedDay = 'Sen, ';
          break;
        case 2:
          convertedDay = 'Sel, ';
          break;
        case 3:
          convertedDay = 'Rab, ';
          break;
        case 4:
          convertedDay = 'Kam, ';
          break;
        case 5:
          convertedDay = 'Jum, ';
          break;
        case 6:
          convertedDay = 'Sab, ';
          break;
        case 7:
          convertedDay = 'Min, ';
          break;
        default:
          convertedDay = null;
          break;
      }
    }
    
    return "${convertedDay ?? ''}${DateFormat('dd/MM/yyyy').format(data)}";
  }
  
  String mediumDMY() {
    String? convertedDay;

    if(usingDay) {
      switch(data.weekday) {
        case 1:
          convertedDay = 'Senin, ';
          break;
        case 2:
          convertedDay = 'Selasa, ';
          break;
        case 3:
          convertedDay = 'Rabu, ';
          break;
        case 4:
          convertedDay = 'Kamis, ';
          break;
        case 5:
          convertedDay = 'Jumat, ';
          break;
        case 6:
          convertedDay = 'Sabtu, ';
          break;
        case 7:
          convertedDay = 'Minggu, ';
          break;
        default:
          convertedDay = null;
          break;
      }
    }
    
    return "${convertedDay ?? ''}${DateFormat('dd MMM yyyy').format(data)}";
  }
  
  String longDMY() {
    String? convertedDay;

    if(usingDay) {
      switch(data.weekday) {
        case 1:
          convertedDay = 'Senin, ';
          break;
        case 2:
          convertedDay = 'Selasa, ';
          break;
        case 3:
          convertedDay = 'Rabu, ';
          break;
        case 4:
          convertedDay = 'Kamis, ';
          break;
        case 5:
          convertedDay = 'Jumat, ';
          break;
        case 6:
          convertedDay = 'Sabtu, ';
          break;
        case 7:
          convertedDay = 'Minggu, ';
          break;
        default:
          convertedDay = null;
          break;
      }
    }
    
    return "${convertedDay ?? ''}${DateFormat('dd MMMM yyyy').format(data)}";
  }
}