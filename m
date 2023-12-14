Return-Path: <netdev+bounces-57400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88F781307C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9955D1F2110A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80924D131;
	Thu, 14 Dec 2023 12:46:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DAEA3;
	Thu, 14 Dec 2023 04:46:08 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BECjnwoF839887, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BECjnwoF839887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 20:45:49 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 14 Dec 2023 20:45:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 14 Dec 2023 20:45:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 14 Dec 2023 20:45:48 +0800
From: JustinLai0215 <justinlai0215@realtek.com>
To: Paolo Abeni <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>, Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v14 07/13] rtase: Implement a function to receive packets
Thread-Topic: [PATCH net-next v14 07/13] rtase: Implement a function to
 receive packets
Thread-Index: AQHaKbuc5PsGtCK8iE+X+AXG8s/kd7Ck67gAgAPXhbA=
Date: Thu, 14 Dec 2023 12:45:48 +0000
Message-ID: <c60d16ae820249b48fb12c38e7b28e78@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	 <20231208094733.1671296-8-justinlai0215@realtek.com>
 <18552cff6fe32d4c21b4751cd6be4ff4757c63e8.camel@redhat.com>
In-Reply-To: <18552cff6fe32d4c21b4751cd6be4ff4757c63e8.camel@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

PiBPbiBGcmksIDIwMjMtMTItMDggYXQgMTc6NDcgKzA4MDAsIEp1c3RpbiBMYWkgd3JvdGU6DQo+
ID4gSW1wbGVtZW50IHJ4X2hhbmRsZXIgdG8gcmVhZCB0aGUgaW5mb3JtYXRpb24gb2YgdGhlIHJ4
IGRlc2NyaXB0b3IsDQo+ID4gdGhlcmVieSBjaGVja2luZyB0aGUgcGFja2V0IGFjY29yZGluZ2x5
IGFuZCBzdG9yaW5nIHRoZSBwYWNrZXQgaW4gdGhlDQo+ID4gc29ja2V0IGJ1ZmZlciB0byBjb21w
bGV0ZSB0aGUgcmVjZXB0aW9uIG9mIHRoZSBwYWNrZXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKdXN0aW4gTGFpIDxqdXN0aW5sYWkwMjE1QHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vbmV0L2V0aGVybmV0L3JlYWx0ZWsvcnRhc2UvcnRhc2VfbWFpbi5jICAgfCAxNDggKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNDggaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcnRhc2UvcnRh
c2VfbWFpbi5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3J0YXNlL3J0YXNl
X21haW4uYw0KPiA+IGluZGV4IGVlZTc5MmVhNDc2MC4uODNhMTE5Mzg5MTEwIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcnRhc2UvcnRhc2VfbWFpbi5jDQo+
ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9ydGFzZS9ydGFzZV9tYWluLmMN
Cj4gPiBAQCAtNDUxLDYgKzQ1MSwxNTQgQEAgc3RhdGljIHZvaWQgcnRhc2VfcnhfcmluZ19jbGVh
cihzdHJ1Y3QgcnRhc2VfcmluZw0KPiAqcmluZykNCj4gPiAgICAgICB9DQo+ID4gIH0NCj4gPg0K
PiA+ICtzdGF0aWMgaW50IHJ0YXNlX2ZyYWdtZW50ZWRfZnJhbWUodTMyIHN0YXR1cykgew0KPiA+
ICsgICAgIHJldHVybiAoc3RhdHVzICYgKFJYX0ZJUlNUX0ZSQUcgfCBSWF9MQVNUX0ZSQUcpKSAh
PQ0KPiA+ICsgICAgICAgICAgICAgKFJYX0ZJUlNUX0ZSQUcgfCBSWF9MQVNUX0ZSQUcpOyB9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBydGFzZV9yeF9jc3VtKGNvbnN0IHN0cnVjdCBydGFzZV9w
cml2YXRlICp0cCwgc3RydWN0IHNrX2J1ZmYNCj4gKnNrYiwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCB1bmlvbiByeF9kZXNjICpkZXNjKSB7DQo+ID4gKyAgICAgdTMyIG9wdHMy
ID0gbGUzMl90b19jcHUoZGVzYy0+ZGVzY19zdGF0dXMub3B0czIpOw0KPiA+ICsNCj4gPiArICAg
ICAvKiByeCBjc3VtIG9mZmxvYWQgKi8NCj4gPiArICAgICBpZiAoKChvcHRzMiAmIFJYX1Y0Rikg
JiYgIShvcHRzMiAmIFJYX0lQRikpIHx8IChvcHRzMiAmIFJYX1Y2RikpIHsNCj4gPiArICAgICAg
ICAgICAgIGlmICgoKG9wdHMyICYgUlhfVENQVCkgJiYgIShvcHRzMiAmIFJYX1RDUEYpKSB8fA0K
PiA+ICsgICAgICAgICAgICAgICAgICgob3B0czIgJiBSWF9VRFBUKSAmJiAhKG9wdHMyICYgUlhf
VURQRikpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHNrYi0+aXBfc3VtbWVkID0gQ0hF
Q0tTVU1fVU5ORUNFU1NBUlk7DQo+ID4gKyAgICAgICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX05PTkU7DQo+ID4gKyAg
ICAgICAgICAgICB9DQo+ID4gKyAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgIHNrYi0+
aXBfc3VtbWVkID0gQ0hFQ0tTVU1fTk9ORTsNCj4gPiArICAgICB9DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyB2b2lkIHJ0YXNlX3J4X3ZsYW5fc2tiKHVuaW9uIHJ4X2Rlc2MgKmRlc2MsIHN0
cnVjdCBza19idWZmDQo+ID4gKypza2IpIHsNCj4gPiArICAgICB1MzIgb3B0czIgPSBsZTMyX3Rv
X2NwdShkZXNjLT5kZXNjX3N0YXR1cy5vcHRzMik7DQo+ID4gKw0KPiA+ICsgICAgIGlmICghKG9w
dHMyICYgUlhfVkxBTl9UQUcpKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4g
PiArICAgICBfX3ZsYW5faHdhY2NlbF9wdXRfdGFnKHNrYiwgaHRvbnMoRVRIX1BfODAyMVEpLCBz
d2FiMTYob3B0czIgJg0KPiA+ICtWTEFOX1RBR19NQVNLKSk7IH0NCj4gPiArDQo+ID4gK3N0YXRp
YyB2b2lkIHJ0YXNlX3J4X3NrYihjb25zdCBzdHJ1Y3QgcnRhc2VfcmluZyAqcmluZywgc3RydWN0
DQo+ID4gK3NrX2J1ZmYgKnNrYikgew0KPiA+ICsgICAgIHN0cnVjdCBydGFzZV9pbnRfdmVjdG9y
ICppdmVjID0gcmluZy0+aXZlYzsNCj4gPiArDQo+ID4gKyAgICAgbmFwaV9ncm9fcmVjZWl2ZSgm
aXZlYy0+bmFwaSwgc2tiKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCByeF9oYW5kbGVyKHN0
cnVjdCBydGFzZV9yaW5nICpyaW5nLCBpbnQgYnVkZ2V0KSB7DQo+ID4gKyAgICAgY29uc3Qgc3Ry
dWN0IHJ0YXNlX3ByaXZhdGUgKnRwID0gcmluZy0+aXZlYy0+dHA7DQo+ID4gKyAgICAgdTMyIHBr
dF9zaXplLCBjdXJfcngsIGRlbHRhLCBlbnRyeSwgc3RhdHVzOw0KPiA+ICsgICAgIHVuaW9uIHJ4
X2Rlc2MgKmRlc2NfYmFzZSA9IHJpbmctPmRlc2M7DQo+ID4gKyAgICAgc3RydWN0IG5ldF9kZXZp
Y2UgKmRldiA9IHRwLT5kZXY7DQo+ID4gKyAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYjsNCj4gPiAr
ICAgICB1bmlvbiByeF9kZXNjICpkZXNjOw0KPiA+ICsgICAgIGludCB3b3JrZG9uZSA9IDA7DQo+
ID4gKw0KPiA+ICsgICAgIGlmICghcmluZy0+ZGVzYykNCj4gPiArICAgICAgICAgICAgIHJldHVy
biB3b3JrZG9uZTsNCj4gDQo+IFdoeSBpcyB0aGUgYWJvdmUgdGVzdCByZXF1aXJlZD8gSG93IGNh
biBiZSByaW5nLT5kZXNjIE5VTEwgaGVyZT8NCg0KVGhpcyBpcyB1bm5lY2Vzc2FyeSBqdWRnbWVu
dCBhbmQgSSB3aWxsIHJlbW92ZSBpdC4NCj4gDQo=

