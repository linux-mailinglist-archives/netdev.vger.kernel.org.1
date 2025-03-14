Return-Path: <netdev+bounces-174901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD57EA612F7
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D891B63EB7
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1F512FF6F;
	Fri, 14 Mar 2025 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="aykI/lnr"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0E2E336A;
	Fri, 14 Mar 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960037; cv=none; b=pkPcSPD6e2+x7Xw9mkNgPWdWf/oPOYj35d3/gbTZNMGC+em2VZiygVmGuj6sNb6ZT3MB1gXeYna/vvntDFFcoZJT5dpN4uWics2xcaZvf7m/Dy0XqNFx5CBtzi4b/IurlnrYeNU8zozQ3Z3OtX3n+aK+GKtsoYy/Sfr1LQPcH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960037; c=relaxed/simple;
	bh=u4278IkgLF+DuxgJvdtq4Czwtfa7UaWou22TGEdAdGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Db/bqo9pPaYFb+n5F/+JykgWLCrAabALfqGOE36AkLKE4GKVMarW1SibSBEyIasOlKyvqDzAWibNDAd4VMOWjLu0AFtQSYs6qcoHu+0WFNCMsoFV9IuoLHr/H5SYSk/LRUICXT/PI8bSKqk6TJYK0ELCz7DWb1wx0QlJIS36k2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=aykI/lnr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52EDkiAP33121006, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741960004; bh=u4278IkgLF+DuxgJvdtq4Czwtfa7UaWou22TGEdAdGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aykI/lnricLIoZUMXdk6UPG5nUtabM/zCImjXnA4DU+mnrm2I/vE9FaurEuzXvp6X
	 hs4BFvg5qufA4UdyY8YmcriKXQg3BXZXh1aE2c3XO40g407r5zYDK1TeEBG56Xg/dd
	 8pJVAt573LNkcYO42hOnHPUB5T/Hg65YXNqYeL9/d2e+JrARVL1QEgLntVmFm8Tx6W
	 qimvbJBlO3XI53A6dBi2K5yS3JayhGxr9U5mH0iduW8kyXeBrewJiPyTYu2T5qGvKK
	 Hae8+qP6p4QWcx4ZAUeDPMQc7Fl62mMLDELvOXFhzSmbSV4MCCXcwIQZrOwGeG2p45
	 +93mhnvZWB1Qg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52EDkiAP33121006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 21:46:44 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Mar 2025 21:46:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 14 Mar 2025 21:46:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 14 Mar 2025 21:46:40 +0800
From: Hau <hau@realtek.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd <nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] r8169: disable RTL8126 ZRX-DC timeout
Thread-Topic: [PATCH net-next 2/2] r8169: disable RTL8126 ZRX-DC timeout
Thread-Index: AQHblLW9r8Cevm0ooU+Gat1ylFmKb7Nx+kaAgACq6RA=
Date: Fri, 14 Mar 2025 13:46:40 +0000
Message-ID: <e626009d93cd4d5188b35ea5315b42ba@realtek.com>
References: <20250314075013.3391-1-hau@realtek.com>
 <20250314075013.3391-3-hau@realtek.com>
 <ecfc71d3-47b6-4f17-b081-69452e7884ac@gmail.com>
In-Reply-To: <ecfc71d3-47b6-4f17-b081-69452e7884ac@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBFeHRlcm5hbCBtYWlsIDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSB0aGUg
b3JnYW5pemF0aW9uLiBEbyBub3QNCj4gcmVwbHksIGNsaWNrIGxpbmtzLCBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kDQo+IGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiANCj4gT24gMTQuMDMuMjAyNSAwODo1MCwgQ2h1bkhh
byBMaW4gd3JvdGU6DQo+ID4gRGlzYWJsZSBpdCBkdWUgdG8gaXQgZG9zZSBub3QgbWVldCBaUlgt
REMgc3BlY2lmaWNhdGlvbi4gSWYgaXQgaXMNCj4gPiBlbmFibGVkLA0KPiANCj4gZG9zZSAtPiBk
b2VzDQo+IA0KPiA+IGRldmljZSB3aWxsIGV4aXQgTDEgc3Vic3RhdGUgZXZlcnkgMTAwbXMuIERp
c2FibGUgaXQgZm9yIHNhdmluZyBtb3JlDQo+ID4gcG93ZXIgaW4gTDEgc3Vic3RhdGUuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuSGFvIExpbiA8aGF1QHJlYWx0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYyB8IDE2ICsr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21h
aW4uYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4g
PiBpbmRleCAzYzY2M2ZjYTA3ZDMuLmRmYzk2YjA5Yjg1ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+ID4gQEAgLTI4NTIsNiArMjg1Miwy
MSBAQCBzdGF0aWMgdTMyIHJ0bF9jc2lfcmVhZChzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCwN
Cj4gaW50IGFkZHIpDQo+ID4gICAgICAgICAgICAgICBSVExfUjMyKHRwLCBDU0lEUikgOiB+MDsg
IH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBydGxfZGlzYWJsZV96cnhkY190aW1lb3V0KHN0cnVj
dCBydGw4MTY5X3ByaXZhdGUgKnRwKSB7DQo+ID4gKyAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXYg
PSB0cC0+cGNpX2RldjsNCj4gPiArICAgICB1OCB2YWw7DQo+ID4gKw0KPiA+ICsgICAgIGlmIChw
ZGV2LT5jZmdfc2l6ZSA+IDB4MDg5MCAmJg0KPiA+ICsgICAgICAgICBwY2lfcmVhZF9jb25maWdf
Ynl0ZShwZGV2LCAweDA4OTAsICZ2YWwpID09IFBDSUJJT1NfU1VDQ0VTU0ZVTA0KPiAmJg0KPiA+
ICsgICAgICAgICBwY2lfd3JpdGVfY29uZmlnX2J5dGUocGRldiwgMHgwODkwLCB2YWwgJiB+QklU
KDApKSA9PQ0KPiBQQ0lCSU9TX1NVQ0NFU1NGVUwpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm47
DQo+ID4gKw0KPiA+ICsgICAgIG5ldGRldl9ub3RpY2Vfb25jZSh0cC0+ZGV2LA0KPiA+ICsgICAg
ICAgICAgICAgIk5vIG5hdGl2ZSBhY2Nlc3MgdG8gUENJIGV4dGVuZGVkIGNvbmZpZyBzcGFjZSwg
ZmFsbGluZyBiYWNrIHRvDQo+IENTSVxuIik7DQo+ID4gKyAgICAgcnRsX2NzaV93cml0ZSh0cCwg
MHgwODkwLCBydGxfY3NpX3JlYWQodHAsIDB4MDg5MCkgJiB+QklUKDApKTsgfQ0KPiA+ICsNCj4g
DQo+IERvZXMgdGhlIGRhdGFzaGVldCBoYXZlIGEgbmFtZSBmb3IgdGhpcyBleHRlbmRlZCBjb25m
aWcgc3BhY2UgcmVnaXN0ZXIgYW5kDQo+IGJpdCAwPw0KPiBUaGlzIHdvdWxkIGJlIGJldHRlciB0
aGFuIHVzaW5nIG1hZ2ljIG51bWJlcnMuDQoNCkkgd2lsbCB0cnkgdG8gZ2V0IHRoZSBuYW1lIG9m
IHRoaXMgYml0Lg0KDQo+IEkgdGhpbmsgd2UgY2FuIGZhY3RvciBvdXQgdGhlIGV4dGVuZGVkIGNv
bmZpZyBzcGFjZSBhY2Nlc3MgdG8gYSBoZWxwZXIuIFRoZQ0KPiBzYW1lIGNvZGUgd2UgaGF2ZSBp
biBhbm90aGVyIHBsYWNlIGFscmVhZHkuIEJ1dCB0aGlzIGNhbiBiZSBkb25lIGFzIGENCj4gZm9s
bG93LXVwLg0KPiANCj4gPiAgc3RhdGljIHZvaWQgcnRsX3NldF9hc3BtX2VudHJ5X2xhdGVuY3ko
c3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAsIHU4DQo+ID4gdmFsKSAgew0KPiA+ICAgICAgIHN0
cnVjdCBwY2lfZGV2ICpwZGV2ID0gdHAtPnBjaV9kZXY7IEBAIC0zODI0LDYgKzM4MzksNyBAQCBz
dGF0aWMNCj4gPiB2b2lkIHJ0bF9od19zdGFydF84MTI1ZChzdHJ1Y3QgcnRsODE2OV9wcml2YXRl
ICp0cCkNCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBydGxfaHdfc3RhcnRfODEyNmEoc3RydWN0IHJ0
bDgxNjlfcHJpdmF0ZSAqdHApICB7DQo+ID4gKyAgICAgcnRsX2Rpc2FibGVfenJ4ZGNfdGltZW91
dCh0cCk7DQo+ID4gICAgICAgcnRsX3NldF9kZWZfYXNwbV9lbnRyeV9sYXRlbmN5KHRwKTsNCj4g
PiAgICAgICBydGxfaHdfc3RhcnRfODEyNV9jb21tb24odHApOw0KPiA+ICB9DQoNCg==

