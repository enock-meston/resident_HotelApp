class Api{
  static String ServerIp = "http://192.168.8.111/";
  static String ServerName = ServerIp + "resident_hotel_api/";

  static String UserRegistration = ServerName+"new_account.php";
  static String SelectUser = ServerName+"selectUser.php";
  static String addtUser = ServerName+"addUser.php";
  static String deleteUser = ServerName+"deleteUser.php";
//   room
static String addRoom = ServerName+"add_room.php";
static String viewRoom = ServerName+"view_room.php";

// client
static String client_new_account = ServerName+"client_new_account.php";
static String viewClient = ServerName+"view_client.php";

// login
  static String user_login = ServerName+"user_login.php";
  static String client_login = ServerName+"client/login.php";

//   food and beverage
static String save_food_and_beverage = ServerName+"save_food_and_beverage.php";
static String get_food_and_beverages = ServerName+"get_food_and_beverages.php";
}
