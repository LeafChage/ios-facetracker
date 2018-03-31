# ios-facetracker
UnityでARKitを開発していてストレスで死にそうになっている人のための
ノンストレスライフ提供アプリ

# How To Use
- UnityでUDP受信用のコードを書きます。
- このgitにあるiosアプリをiPhoneXで起動します
- Unity開発PCのIPアドレスいれて
- 指定しているPort番号を入れれば
- ノンストレスUnityライフが送れます。


```cs
// Unityのコードはこんな感じで書きました
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

public class UDPServer
{
      private UdpClient udpServer;
      private Thread thread;
      private string message;
      public string Message {
            get{ return this.message; }
      }

      public UDPServer(int port)
      {
            this.udpServer = new UdpClient(port);

            this.thread = new Thread(new ThreadStart(ThreadMethod));
            this.thread.Start();
      }

      public void ThreadClose()
      {
            this.udpServer.Close();
            this.thread.Abort();
      }

      private void ThreadMethod()
      {
            while (true)
            {
                  IPEndPoint remoteEP = null;
                  byte[] data = this.udpServer.Receive(ref remoteEP);
                  string text = Encoding.ASCII.GetString(data);
                  Debug.Log(text);

                  this.message = text;
            }
      }
}
```

```cs
// 呼び出し側
public class AnythingObject {
      private UDPServer server;
      void Start() {
            this.server = new UDPServer(3000);
      }

      void Update() {
            var parameters = this.parseSentMessage(this.server.Message());
            foreach(KeyValuePair<string, float> pair in parameters){
                  Debug.Log (pair.Key + " " + pair.Value);
            }
      }

      void OnApplciationQuit() {
            this.server.ThreadClose();
      }

      // debug用の情報をパースする
      private Dictionary<string, float> parseSentMessage(string sentData) {
          Dictionary<string, float> dict = new Dictionary<string, float>();
          if (sentData != null || sentData == "")
          {
              string[] datas = sentData.Split('&');

              if (datas.Length > 0)
              {
                  foreach (string data in datas)
                  {
                      string[] d = data.Split('=');
                      if (d.Length == 2)
                      {
                          float value = 0;
                          float.TryParse(d[1], out value);
                          dict[d[0]] = value;
                      }
                  }
              }
          }
          return dict;
      }
}
```

こんな感じのものをどこかで呼び出せばいいと思います。


