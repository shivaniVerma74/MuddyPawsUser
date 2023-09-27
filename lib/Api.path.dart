class ApiServicves{

  static const String baseUrl = "https://developmentalphawizz.com/dr_vet_app/app/v1/api/";
  static const String imageUrl = "https://developmentalphawizz.com/dr_vet_app/";

  static const String registerUser = baseUrl+'register_user';
  static const String sendOtpUser = baseUrl+'send_otp_user';
  static const String verifyOtpUser = baseUrl+'verify_otp_user';
  static const String getCat = baseUrl+"get_cat";
  static const String getDoctorByCatid = baseUrl+'get_doctor_by_catid';
  static const String getUserData = baseUrl+"get_user_data";
  static const String getFaqs = baseUrl+'get_faqs';
  static const String getSettings = baseUrl+'get_settings';
  static const String petProfiles = baseUrl+'pet_profiles';
  static const String getPlans = baseUrl+'get_plans';
  static const String bookAppointment = baseUrl +'book_appointment';
  static const String getTimeSlot = baseUrl+'get_time_slot';
  static const String createProfile = baseUrl+'create_profile';
  static const String deleteProfile = baseUrl+'delete_profile';
  static const String getBooking = baseUrl+'get_booking';
  static const String addWallet = baseUrl+'add_wallet';
  static const String walletTransactions = baseUrl+ 'wallet_transactions';
  static const String getSliderImages= baseUrl+'get_slider_images';
}