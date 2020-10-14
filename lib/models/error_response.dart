class ErrorResponse {
  String type;
  String message;
  String exceptionType;

  ErrorResponse({this.type, this.message, this.exceptionType});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    message = json['Message'];
    exceptionType = json['ExceptionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Message'] = this.message;
    data['ExceptionType'] = this.exceptionType;
    return data;
  }
}
