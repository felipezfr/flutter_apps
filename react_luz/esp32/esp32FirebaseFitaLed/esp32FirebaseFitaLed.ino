#include <FirebaseESP32.h>
#include <WiFi.h>
#include <FastLED.h>

// Set these to run example.
#define FIREBASE_HOST "appledcontroller.firebaseapp.com"
#define FIREBASE_AUTH "1y1k62Olr2uKz26QJS1yZY5FrkmxxVa7mkO22w90"
#define WIFI_SSID "Zaffari 2.4GHz"
#define WIFI_PASSWORD "zaffari87"

#define NUM_LEDS 50
#define DATA_PIN 23

#define port23 23
#define port22 22
#define LED 19
#define PRESENCE_PIN 36

#define TEMPERATURE_PIN 4

// Publique a cada 5 min
#define PUBLISH_INTERVAL 2000

FirebaseData firebaseData;
CRGB leds[NUM_LEDS];

float humidity;
float temperature;
bool port23Value = false;
bool last = true;


unsigned long previousMillis = 0;
unsigned long currentMillis = 0;

void setupPins()
{

  FastLED.addLeds<WS2811, DATA_PIN, RGB>(leds, NUM_LEDS);
  pinMode(DATA_PIN, OUTPUT);
  pinMode(port23, OUTPUT);
  digitalWrite(port23, LOW);
  pinMode(port22, OUTPUT);
  digitalWrite(port22, LOW);
  pinMode(LED, OUTPUT);
  digitalWrite(LED, LOW);
  pinMode(PRESENCE_PIN, INPUT);

  pinMode(TEMPERATURE_PIN, INPUT);

  for (int i = 0; i < NUM_LEDS; i++) //Acendo os led
  {
    leds[i] = CRGB(0, 0, 0);
  }
  FastLED.show();
}

void setupWifi()
{
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());
}

void setupFirebase()
{
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.setBool(firebaseData, "port23", false);
  Firebase.setBool(firebaseData, "port22", false);
}

void setup()
{
  Serial.begin(115200);

  setupPins();
  setupWifi();

  setupFirebase();

 
}

void loop()
{
  currentMillis = millis();
  // Apenas publique quando passar o tempo determinado
  if (currentMillis - previousMillis >= PUBLISH_INTERVAL)
  {
    previousMillis = currentMillis;

    // Obtem os dados do sensor DHT
    humidity = analogRead(34);
    temperature = analogRead(35);

    humidity = map(humidity, 0, 4095, 100, 0);
    temperature = map(temperature, 0, 4095, 0, 150);
    Serial.print("Temperatura: ");
    Serial.println(temperature);
    Serial.print("Umidade: ");
    Serial.println(humidity);
    if (!isnan(humidity) && !isnan(temperature))
    {
      // Manda para o firebase
      Firebase.pushFloat(firebaseData, "temperature", temperature);
      Firebase.pushFloat(firebaseData, "humidity", humidity);
      Firebase.setFloat(firebaseData, "temperature2", temperature);

      if(temperature > 30){
        digitalWrite(LED, HIGH);
        Serial.println("LED LIGADO");
      }
      else{
        digitalWrite(LED, LOW);
      }
      
    }
    else
    {
      Serial.println("Error Publishing");
    }
  }

  // Verifica o valor da lampada no firebase
  Firebase.get(firebaseData, "port22");
  bool port22Value = firebaseData.boolData();

  digitalWrite(port22, port22Value ? HIGH : LOW);
  //Serial.print("Port22Value: ");
  //Serial.println(port22Value);

  Firebase.get(firebaseData, "port23");
  port23Value = firebaseData.boolData();

  //Serial.print("Port23Value: ");
  //Serial.println(port23Value);


  if (port23Value == true && last == true)
  {
    last = false;

    for (int i = 0; i < NUM_LEDS; i++) //Acendendo os led
    {
      leds[i] = CRGB(255, 100, 10);
    }
    FastLED.show();
  }
  if (port23Value == false && last == false)
  {
    last = true;
    for (int i = 0; i < NUM_LEDS; i++) //Acendo os led conforme o sinal
    {
      leds[i] = CRGB(0, 0, 0);
    }
    FastLED.show();
  }
}
