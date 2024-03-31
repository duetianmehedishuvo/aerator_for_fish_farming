class OrginalDataModel {
  OrginalDataModel({
      this.id, 
      this.adcTemperature, 
      this.adcVoltage, 
      this.do1,
      this.motorStatus, 
      this.phValue, 
      this.phVoltage, 
      this.temperatureC, 
      this.temperatureF,});

  OrginalDataModel.fromJson(dynamic json) {
    id = json['id'];
    adcTemperature = json['adc_temperature'];
    adcVoltage = json['adc_voltage'];
    do1 = json['do'];
    motorStatus = json['motor_status'];
    phValue = json['ph_value'];
    phVoltage = json['ph_voltage'];
    temperatureC = json['temperatureC'];
    temperatureF = json['temperatureF'];
  }
  num? id;
  String? adcTemperature;
  String? adcVoltage;
  String? do1;
  num? motorStatus;
  String? phValue;
  String? phVoltage;
  String? temperatureC;
  String? temperatureF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['adc_temperature'] = adcTemperature;
    map['adc_voltage'] = adcVoltage;
    map['do'] = do1;
    map['motor_status'] = motorStatus;
    map['ph_value'] = phValue;
    map['ph_voltage'] = phVoltage;
    map['temperatureC'] = temperatureC;
    map['temperatureF'] = temperatureF;
    return map;
  }

}