String convertDateTimeToString(DateTime dateTime){
 //year in->yyyy
  String year=dateTime.year.toString();
 //month in->mm
  String month=dateTime.month.toString();
  if(month.length==1){
    month='0$month';
  }
  //day in->dd
  String day=dateTime.day.toString();
  if(day.length==1){
    day='0$day';
  }

  String yyyymmdd=year+month+day;
  return yyyymmdd;
}