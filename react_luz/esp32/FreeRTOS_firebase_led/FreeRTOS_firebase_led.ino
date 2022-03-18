#if CONFIG_FREERTOS_UNICORE
#define ARDUINO_RUNNING_CORE 0
#else
#define ARDUINO_RUNNING_CORE 1
#endif



#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <FastLED.h>

//Provide the token generation process info.
#include <addons/TokenHelper.h>

//Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>

/* 1. Define the WiFi credentials */
#define WIFI_SSID "Zaffari 2.4GHz"
#define WIFI_PASSWORD "zaffari87"

//For the following credentials, see examples/Authentications/SignInAsUser/EmailPassword/EmailPassword.ino

/* 2. Define the API Key */
#define API_KEY "AIzaSyA9P66z94Y5BwhQl3afU8x1comtb1FWGE0"

/* 3. Define the RTDB URL */
#define DATABASE_URL "https://appledcontroller-default-rtdb.firebaseio.com/" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app

/* 4. Define the user Email and password that alreadey registerd or added in your project */
#define USER_EMAIL "felipezfr@hotmail.com"
#define USER_PASSWORD "felipezfr"


//LEDS
#define NUM_LEDS 50
#define DATA_PIN 23

//Define Firebase Data object
FirebaseData stream;
FirebaseData fbdo;

//LEDS
CRGB leds[NUM_LEDS];

FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;

String color = "";
//int32_t color = 0;

volatile bool dataChanged = false;

void streamCallback(FirebaseStream data)
{
  Serial.printf("sream path, %s\nevent path, %s\ndata type, %s\nevent type, %s\n\n",
                data.streamPath().c_str(),
                data.dataPath().c_str(),
                data.dataType().c_str(),
                data.eventType().c_str());
  //printResult(data); //see addons/RTDBHelper.h
  color = data.to<String>();
  Serial.println(color);

  //This is the size of stream payload received (current and max value)
  //Max payload size is the payload size under the stream path since the stream connected
  //and read once and will not update until stream reconnection takes place.
  //This max value will be zero as no payload received in case of ESP8266 which
  //BearSSL reserved Rx buffer size is less than the actual stream payload.
  Serial.printf("Received stream payload size: %d (Max. %d)\n\n", data.payloadLength(), data.maxPayloadLength());

  //Due to limited of stack memory, do not perform any task that used large memory here especially starting connect to server.
  //Just set this flag and check it status later.
  dataChanged = true;
}

void streamTimeoutCallback(bool timeout)
{
  if (timeout)
    Serial.println("stream timed out, resuming...\n");

  if (!stream.httpConnected())
    Serial.printf("error code: %d, reason: %s\n\n", stream.httpCode(), stream.errorReason().c_str());
}


// define two tasks for Blink & AnalogRead
void TaskFirebase( void *pvParameters );
void TaskLed( void *pvParameters );

// the setup function runs once when you press reset or power the board
void setup() {

  // initialize serial communication at 115200 bits per second:
  Serial.begin(115200);  

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();  

   Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h

  //Or use legacy authenticate method
  //config.database_url = DATABASE_URL;
  //config.signer.tokens.legacy_token = "<database secret>";

  Firebase.begin(&config, &auth);

  Firebase.reconnectWiFi(true); 

  

  // Now set up two tasks to run independently.
  xTaskCreatePinnedToCore(
    TaskFirebase
    ,  "TaskFirebase"   // A name just for humans
    ,  8192  // This stack size can be checked & adjusted by reading the Stack Highwater
    ,  NULL
    ,  2  // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
    TaskLed
    ,  "TaskLed"
    ,  2048  // Stack size
    ,  NULL
    ,  1  // Priority
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);

  // Now the task scheduler, which takes over control of scheduling individual tasks, is automatically started.
}

void loop()
{
  // Empty. Things are done in Tasks.
}

void hexToRgb(String hexValue)
{
  Serial.print("color int func: ");
  Serial.println(hexValue);
  //to RGB

  char str [6];
  hexValue.toCharArray(str, 6);
  int r, g, b;
  sscanf(str, "%02x%02x%02x", &r, &g, &b);

  Serial.println(r);
  Serial.println(g);
  Serial.println(b);

  for (int i = 0; i < NUM_LEDS; i++) //Acendendo os led
  {
    leds[i] = CRGB(r, g, b);
  }
  FastLED.show();
}

/*--------------------------------------------------*/
/*---------------------- Tasks ---------------------*/
/*--------------------------------------------------*/

void TaskLed(void *pvParameters)  // This is a task.
{
  (void) pvParameters;

  Serial.println("Task LED");

  FastLED.addLeds<WS2811, DATA_PIN, BRG>(leds, NUM_LEDS);
  for (int i = 0; i < NUM_LEDS; i++) //Acendendo os led
  {
    leds[i] = CRGB(0, 0, 0);
  }
  FastLED.show();

  for (;;) // A Task shall never return or exit.
  {
    if (dataChanged)
    {
      dataChanged = false;
      //When stream data is available, do anything here...

      Serial.println("Color String: " + color);

      hexToRgb(color);

    }
    //    vTaskDelay(100);  // one tick delay (15ms) in between reads for stability
    //    vTaskDelay(100);  // one tick delay (15ms) in between reads for stability
  }
}

void TaskFirebase(void *pvParameters)  // This is a task.
{
  (void) pvParameters;
  Serial.println("Task Firebase");

  if (!Firebase.RTDB.beginStream(&stream, "/users/felipe/quarto/color"))
    Serial.printf("sream begin error, %s\n\n", stream.errorReason().c_str());

  Firebase.RTDB.setStreamCallback(&stream, streamCallback, streamTimeoutCallback); 

  for (;;)
  {
    //Serial.println("firebase");
    vTaskDelay(100000);  // one tick delay (15ms) in between reads for stability
  }
}
