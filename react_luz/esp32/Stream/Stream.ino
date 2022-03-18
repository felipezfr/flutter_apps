/**
   Created by K. Suwatchai (Mobizt)

   Email: k_suwatchai@hotmail.com

   Github: https://github.com/mobizt

   Copyright (c) 2021 mobizt

*/


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

void setup()
{

  Serial.begin(115200);

  FastLED.addLeds<WS2811, DATA_PIN, BRG>(leds, NUM_LEDS);

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

  for (int i = 0; i < NUM_LEDS; i++) //Acendendo os led
  {
    leds[i] = CRGB(255, 100, 10);
  }
  FastLED.show();

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

  if (!Firebase.RTDB.beginStream(&stream, "/users/felipe/quarto/color"))
    Serial.printf("sream begin error, %s\n\n", stream.errorReason().c_str());

  Firebase.RTDB.setStreamCallback(&stream, streamCallback, streamTimeoutCallback);



  /** Timeout options, below is default config.

    //WiFi reconnect timeout (interval) in ms (10 sec - 5 min) when WiFi disconnected.
    config.timeout.wifiReconnect = 10 * 1000;

    //Socket begin connection timeout (ESP32) or data transfer timeout (ESP8266) in ms (1 sec - 1 min).
    config.timeout.socketConnection = 30 * 1000;

    //ESP32 SSL handshake in ms (1 sec - 2 min). This option doesn't allow in ESP8266 core library.
    config.timeout.sslHandshake = 2 * 60 * 1000;

    //Server response read timeout in ms (1 sec - 1 min).
    config.timeout.serverResponse = 10 * 1000;

    //RTDB Stream keep-alive timeout in ms (20 sec - 2 min) when no server's keep-alive event data received.
    config.timeout.rtdbKeepAlive = 45 * 1000;

    //RTDB Stream reconnect timeout (interval) in ms (1 sec - 1 min) when RTDB Stream closed and want to resume.
    config.timeout.rtdbStreamReconnect = 1 * 1000;

    //RTDB Stream error notification timeout (interval) in ms (3 sec - 30 sec). It determines how often the readStream
    //will return false (error) when it called repeatedly in loop.
    config.timeout.rtdbStreamError = 3 * 1000;

  */
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

void loop()
{
  //Flash string (PROGMEM and FPSTR), Arduino String, C++ string, const char, char array, string literal are supported
  //in all Firebase and FirebaseJson functions, unless F() macro is not supported.

  if (dataChanged)
  {
    dataChanged = false;
    //When stream data is available, do anything here...

    Serial.println("Color String: " + color);

    hexToRgb(color);

  }
}
