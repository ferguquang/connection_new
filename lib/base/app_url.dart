
class AppUrl {
  // DEV
  // static const String baseURL = "http://dev-api.lione.vn/api/";

  // RELEASE
  // static const String baseURL = "http://gateway.dev.axe.vn/gateway/";
  static const String baseURL = "http://gateway.uat.axe.vn/gateway/";

  static const String url_google_doc = "https://docs.google.com/gview?embedded=true&url=";

  // login
  static const String login = "auth/account/login";

  static const String getListJob = "axe-core/job/get-list-data-entry-by-user";
  static const String sendListJob = "axe-core/job/send-data-entry-result";
  static const String getBase64Image = "file/stg-file/get-file-by-instanceId";

  static const String getListCheckJob = "axe-core/job/get-list-data-check-by-user";
  static const String sendListCheckJob = "axe-core/job/send-data-check-result";
}