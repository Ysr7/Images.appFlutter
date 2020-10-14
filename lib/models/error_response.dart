class ErrorResponse {
  String type;
  String message;
  String exceptionType;

  ErrorResponse({this.type, this.message, this.exceptionType});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    type = json['Type'] as String;
    message = json['Message'] as String;
    exceptionType = json['ExceptionType'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Message'] = this.message;
    data['ExceptionType'] = this.exceptionType;
    return data;
  }
}
