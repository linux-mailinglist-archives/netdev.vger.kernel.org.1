Return-Path: <netdev+bounces-103964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0794D90A97F
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B29F1C20C96
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77D219148E;
	Mon, 17 Jun 2024 09:26:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3441C93;
	Mon, 17 Jun 2024 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616383; cv=none; b=hsLHC+kUhgfXVWyC+adHHxmHX/kKCw0HLO4oOzdUZiZrYPZS8Po1g75btkQ3ywEUv8CcWLd5iX4Hy3IFOr5KAUyLHhocc5ichPuHULnbxj4tuf0gVJ9zntNXLnXhuQhdP0hCFLXY6Utx5+r4xD7It+uaP/B3kfH9OODPg6FeetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616383; c=relaxed/simple;
	bh=nBQ2GhCBA10yY2URSohFxOvV8YiMfVEXuNlHnEDQFlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k2NWMKj0x0SD60e/tszqfStJZUkWF7nf8qxF3lBmoXLsaB2c5kufC6tgWKx67+DvVOcR9yG2E85MBaUvIPEjhBwKA0mh0Eyxn148LWk6sLAy8wKsf+JlDnBQwIZ4jSvSmhqMFQyuEdy3CVOpglwWFQ6Qysdb5puy/WAUPr/o3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H9PmrF63039315, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H9PmrF63039315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 17:25:48 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 17:25:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Jun 2024 17:25:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 17 Jun 2024 17:25:48 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Markus Elfring <Markus.Elfring@web.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Hariprasad Kelam <hkelam@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
        "Larry
 Chiu" <larry.chiu@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: RE: [PATCH net-next v20 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v20 02/13] rtase: Implement the .ndo_open
 function
Thread-Index: AQHauLcAyXSzhD5SFEe6XVVt5DMYqbHE1SSAgAayoAA=
Date: Mon, 17 Jun 2024 09:25:48 +0000
Message-ID: <ef7c83dea1d849ad94acef81819f9430@realtek.com>
References: <20240607084321.7254-3-justinlai0215@realtek.com>
 <1d01ece4-bf4e-4266-942c-289c032bf44d@web.de>
In-Reply-To: <1d01ece4-bf4e-4266-942c-289c032bf44d@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiDigKYNCj4gPiB3aGVuIHJlcXVlc3RpbmcgaXJxLCBiZWNhdXNlIHRoZSBmaXJzdCBncm91cCBv
ZiBpbnRlcnJ1cHRzIG5lZWRzIHRvDQo+ID4gcHJvY2VzcyBtb3JlIGV2ZW50cywgdGhlIG92ZXJh
bGwgc3RydWN0dXJlIHdpbGwgYmUgZGlmZmVyZW50IGZyb20NCj4gPiBvdGhlciBncm91cHMgb2Yg
aW50ZXJydXB0cywgc28gaXQgbmVlZHMgdG8gYmUgcHJvY2Vzc2VkIHNlcGFyYXRlbHkuDQo+IA0K
PiBDYW4gc3VjaCBhIGNoYW5nZSBkZXNjcmlwdGlvbiBiZWNvbWUgY2xlYXJlciBhbnlob3c/DQoN
CkRvIHlvdSB0aGluayBpdCdzIG9rIGlmIEkgY2hhbmdlIHRoZSBkZXNjcmlwdGlvbiB0byB0aGUg
Zm9sbG93aW5nPw0KIldoZW4gcmVxdWVzdGluZyBpbnRlcnJ1cHQsIGJlY2F1c2UgdGhlIGZpcnN0
IGdyb3VwIG9mIGludGVycnVwdHMgbmVlZHMNCnRvIHByb2Nlc3MgbW9yZSBldmVudHMsIHRoZSBv
dmVyYWxsIHN0cnVjdHVyZSBhbmQgaW50ZXJydXB0IGhhbmRsZXIgd2lsbA0KYmUgZGlmZmVyZW50
IGZyb20gb3RoZXIgZ3JvdXBzIG9mIGludGVycnVwdHMsIHNvIGl0IG5lZWRzIHRvIGJlIGhhbmRs
ZWQNCnNlcGFyYXRlbHkuIFRoZSBmaXJzdCBzZXQgb2YgaW50ZXJydXB0IGhhbmRsZXJzIG5lZWQg
dG8gaGFuZGxlIHRoZQ0KaW50ZXJydXB0IHN0YXR1cyBvZiBSWFEwIGFuZCBUWFEwLCBUWFE0fjcs
IHdoaWxlIG90aGVyIGdyb3VwcyBvZg0KaW50ZXJydXB0IGhhbmRsZXJzIHdpbGwgaGFuZGxlIHRo
ZSBpbnRlcnJ1cHQgc3RhdHVzIG9mIFJYUTEmVFhRMSBvcg0KUlhRMiZUWFEyIG9yIFJYUTMmVFhR
MyBhY2NvcmRpbmcgdG8gdGhlIGludGVycnVwdCB2ZWN0b3IuIg0KDQo+IA0KPiANCj4g4oCmDQo+
ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9ydGFzZS9ydGFzZV9tYWluLmMN
Cj4g4oCmDQo+ID4gK3N0YXRpYyBpbnQgcnRhc2VfYWxsb2NfZGVzYyhzdHJ1Y3QgcnRhc2VfcHJp
dmF0ZSAqdHApIHsNCj4g4oCmDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIG5ldGRldl9lcnIo
dHAtPmRldiwgIkZhaWxlZCB0byBhbGxvY2F0ZSBkbWENCj4gbWVtb3J5IG9mICINCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAidHggZGVzY3JpcHRvci5cbiIp
Ow0KPiDigKYNCj4gDQo+IFdvdWxkIHlvdSBsaWtlIHRvIGtlZXAgdGhlIG1lc3NhZ2UgKGZyb20g
c3VjaCBzdHJpbmcgbGl0ZXJhbHMpIGluIGEgc2luZ2xlIGxpbmU/DQo+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVl
L0RvY3VtZQ0KPiBudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdD9oPXY2LjEwLXJjMyNu
MTE2DQo+IA0KDQpZZXMsIEkgd2lsbCBtYWtlIGNvcnJlY3Rpb25zIHRvIGtlZXAgdGhlIG1lc3Nh
Z2UgaW4gYSBzaW5nbGUgbGluZS4NCg0KPiANCj4g4oCmDQo+ID4gK3N0YXRpYyBpbnQgcnRhc2Vf
YWxsb2Nfcnhfc2tiKGNvbnN0IHN0cnVjdCBydGFzZV9yaW5nICpyaW5nLA0KPiDigKYNCj4gPiAr
ew0KPiDigKYNCj4gPiArICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiID0gTlVMTDsNCj4g4oCmDQo+
ID4gKyAgICAgaW50IHJldCA9IDA7DQo+IOKApg0KPiA+ICsgICAgIGlmICghcGFnZSkgew0KPiA+
ICsgICAgICAgICAgICAgbmV0ZGV2X2Vycih0cC0+ZGV2LCAiZmFpbGVkIHRvIGFsbG9jIHBhZ2Vc
biIpOw0KPiA+ICsgICAgICAgICAgICAgZ290byBlcnJfb3V0Ow0KPiDigKYNCj4gPiArICAgICBp
ZiAoIXNrYikgew0KPiDigKYNCj4gPiArICAgICAgICAgICAgIG5ldGRldl9lcnIodHAtPmRldiwg
ImZhaWxlZCB0byBidWlsZCBza2JcbiIpOw0KPiA+ICsgICAgICAgICAgICAgZ290byBlcnJfb3V0
Ow0KPiA+ICsgICAgIH0NCj4g4oCmDQo+ID4gKyAgICAgcmV0dXJuIHJldDsNCj4gDQo+IEkgZmlu
ZCB0aGUgZm9sbG93aW5nIHN0YXRlbWVudCBtb3JlIGFwcHJvcHJpYXRlLg0KPiANCj4gICAgICAg
ICByZXR1cm4gMDsNCg0KVGhhbmsgeW91LCBJIHdpbGwgbWFrZSB0aGUgY2hhbmdlcy4NCg0KPiAN
Cj4gDQo+ID4gKw0KPiA+ICtlcnJfb3V0Og0KPiA+ICsgICAgIGlmIChza2IpDQo+ID4gKyAgICAg
ICAgICAgICBkZXZfa2ZyZWVfc2tiKHNrYik7DQo+IA0KPiBXaHkgd291bGQgeW91IGxpa2UgdG8g
cmVwZWF0IHN1Y2ggYSBjaGVjayBhZnRlciBpdCBjYW4gYmUgZGV0ZXJtaW5lZCBmcm9tIHRoZQ0K
PiBjb250cm9sIGZsb3cgdGhhdCB0aGUgdXNlZCB2YXJpYWJsZSBjb250YWlucyBzdGlsbCBhIG51
bGwgcG9pbnRlcj8NCg0KSW5kZWVkLCBpdCBzZWVtcyB1bm5lY2Vzc2FyeSB0byBtYWtlIHRoaXMg
anVkZ21lbnQgaGVyZSwgSSB3aWxsIHJlbW92ZSBpdC4NCg0KPiANCj4gDQo+ID4gKw0KPiA+ICsg
ICAgIHJldCA9IC1FTk9NRU07DQo+ID4gKyAgICAgcnRhc2VfbWFrZV91bnVzYWJsZV9ieV9hc2lj
KGRlc2MpOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+IOKApg0KPiAN
Cj4gSXQgc2VlbXMgdGhhdCB0aGUgZm9sbG93aW5nIHN0YXRlbWVudCBjYW4gYmUgbW9yZSBhcHBy
b3ByaWF0ZS4NCj4gDQo+ICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQoNCk9rLCBJIHdpbGwgbW9k
aWZ5IGl0Lg0KDQo+IA0KPiANCj4gTWF5IHRoZSBsb2NhbCB2YXJpYWJsZSDigJxyZXTigJ0gYmUg
b21pdHRlZCBoZXJlPw0KDQpZZXMsIGl0IHNlZW1zIGxpa2UgInJldCIgaXMgbm8gbG9uZ2VyIG5l
ZWRlZC4NCg0KPiANCj4gDQo+IOKApg0KPiA+ICtzdGF0aWMgaW50IHJ0YXNlX29wZW4oc3RydWN0
IG5ldF9kZXZpY2UgKmRldikgew0KPiDigKYNCj4gPiArICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4g
PiArICAgICBpdmVjID0gJnRwLT5pbnRfdmVjdG9yWzBdOw0KPiA+ICsgICAgIHRwLT5yeF9idWZf
c3ogPSBSVEFTRV9SWF9CVUZfU0laRTsNCj4gPiArDQo+ID4gKyAgICAgcmV0ID0gcnRhc2VfYWxs
b2NfZGVzYyh0cCk7DQo+ID4gKyAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgIGdvdG8g
ZXJyX2ZyZWVfYWxsX2FsbG9jYXRlZF9tZW07DQo+IOKApg0KPiANCj4gSSBzdWdnZXN0IHRvIHJl
dHVybiBkaXJlY3RseSBhZnRlciBzdWNoIGEgcmVzb3VyY2UgYWxsb2NhdGlvbiBmYWlsdXJlLg0K
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvdHJlZS9Eb2N1bWUNCj4gbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5y
c3Q/aD12Ni4xMC1yYzMjbjUzMg0KPiANCj4gDQo+IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8g
aW5jcmVhc2UgdGhlIGFwcGxpY2F0aW9uIG9mIHNjb3BlLWJhc2VkIHJlc291cmNlDQo+IG1hbmFn
ZW1lbnQ/DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEwLXJjMy9zb3Vy
Y2UvaW5jbHVkZS9saW51eC9jbGVhbnVwLmgjTDgNCg0KRHVlIHRvIG91ciB0eCBhbmQgcnggZWFj
aCBoYXZpbmcgbXVsdGlwbGUgcXVldWVzIHRoYXQgbmVlZCB0bw0KYWxsb2NhdGUgZGVzY3JpcHRv
cnMsIGlmIGFueSBvbmUgb2YgdGhlIHF1ZXVlcyBmYWlscyB0byBhbGxvY2F0ZSwNCnJ0YXNlX2Fs
bG9jX2Rlc2MoKSB3aWxsIHJldHVybiBhbiBlcnJvci4gVGhlcmVmb3JlLCB1c2luZyAnZ290bycN
CmhlcmUgcmF0aGVyIHRoYW4gZGlyZWN0bHkgcmV0dXJuaW5nIHNlZW1zIHRvIGJlIHJlYXNvbmFi
bGUuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0K

