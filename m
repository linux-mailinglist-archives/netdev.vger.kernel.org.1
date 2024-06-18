Return-Path: <netdev+bounces-104415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C2390C6F9
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE67E1C217A7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6B714E2F6;
	Tue, 18 Jun 2024 08:17:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40C13A272
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698621; cv=none; b=kReBuar09X6Nzyg2x3HZHhhSKNmGLOPVmZJj7s+6Io71lu+6kMb0xHznJJW+MhIufpurGFIUbwedVSVDUEysbTHeeAznMlm4ly+tRnGczVED0Vz36Yi4xzBWtAfyVE/lHwVmn+Z79em6UW/FEOZdz4OKZUixRfX9zmAAvybExpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698621; c=relaxed/simple;
	bh=N1ntN29m50a0/XydN6Icddd9dyh42nifjfEtvNPNXFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=PPAuQ+02J6DJe/YkJSUk+91MdyDtndhw0hatqmGDcdy1HreZonJkUWyd+7ZMmka+zbqJIddzDECmEZFDrCcj7075lJZFwqITN3AVU47uv4Rrmzhac41Oy7BmNQ8BHddG8mbcUWobiddLQod8TR9LMDM7hJRCkgdJ8/xRwckFwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-46-Y6W86ITBNieeifj1SqsYhw-1; Tue, 18 Jun 2024 09:16:49 +0100
X-MC-Unique: Y6W86ITBNieeifj1SqsYhw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 18 Jun
 2024 09:16:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 18 Jun 2024 09:16:15 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Brett Creeley' <bcreeley@amd.com>, 'Shannon Nelson'
	<shannon.nelson@amd.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "brett.creeley@amd.com" <brett.creeley@amd.com>, "drivers@pensando.io"
	<drivers@pensando.io>
Subject: RE: [PATCH net-next 7/8] ionic: Use an u16 for rx_copybreak
Thread-Topic: [PATCH net-next 7/8] ionic: Use an u16 for rx_copybreak
Thread-Index: AQHau4sD/nDUY/efCkW3PCGaFvsKj7HJXBawgALByQCAARpeYA==
Date: Tue, 18 Jun 2024 08:16:15 +0000
Message-ID: <0cdbc7079c5640ad9cfd2ea8a36eb54c@AcuMS.aculab.com>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
 <20240610230706.34883-8-shannon.nelson@amd.com>
 <1cfefa13c8f34ccca322639a05122d6d@AcuMS.aculab.com>
 <64876a57-9ac4-4725-8af3-67944ba6ea95@amd.com>
In-Reply-To: <64876a57-9ac4-4725-8af3-67944ba6ea95@amd.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogQnJldHQgQ3JlZWxleQ0KPiBTZW50OiAxNyBKdW5lIDIwMjQgMTc6MjUNCj4gDQo+IE9u
IDYvMTUvMjAyNCAyOjIwIFBNLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBT
aGFubm9uIE5lbHNvbg0KPiA+PiBTZW50OiAxMSBKdW5lIDIwMjQgMDA6MDcNCj4gPj4NCj4gPj4g
RnJvbTogQnJldHQgQ3JlZWxleSA8YnJldHQuY3JlZWxleUBhbWQuY29tPg0KPiA+Pg0KPiA+PiBU
byBtYWtlIHNwYWNlIGZvciBvdGhlciBkYXRhIG1lbWJlcnMgb24gdGhlIGZpcnN0IGNhY2hlIGxp
bmUgcmVkdWNlDQo+ID4+IHJ4X2NvcHlicmVhayBmcm9tIGFuIHUzMiB0byB1MTYuICBUaGUgbWF4
IFJ4IGJ1ZmZlciBzaXplIHdlIHN1cHBvcnQNCj4gPj4gaXMgKHUxNiktMSBhbnl3YXkgc28gdGhp
cyBtYWtlcyBzZW5zZS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQnJldHQgQ3JlZWxleSA8
YnJldHQuY3JlZWxleUBhbWQuY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNv
biA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvcGVuc2FuZG8vaW9uaWMvaW9uaWNfZXRodG9vbC5jIHwgMTAgKysrKysrKysrLQ0K
PiA+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L3BlbnNhbmRvL2lvbmljL2lvbmljX2xpZi5oICAg
ICB8ICAyICstDQo+ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
cGVuc2FuZG8vaW9uaWMvaW9uaWNfZXRodG9vbC5jDQo+ID4+IGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvcGVuc2FuZG8vaW9uaWMvaW9uaWNfZXRodG9vbC5jDQo+ID4+IGluZGV4IDkxMTgzOTY1YTZi
Ny4uMjZhY2Q4MmNmNmJjIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9w
ZW5zYW5kby9pb25pYy9pb25pY19ldGh0b29sLmMNCj4gPj4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvcGVuc2FuZG8vaW9uaWMvaW9uaWNfZXRodG9vbC5jDQo+ID4+IEBAIC04NzIsMTAgKzg3
MiwxOCBAQCBzdGF0aWMgaW50IGlvbmljX3NldF90dW5hYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpkYXRhKQ0K
PiA+PiAgIHsNCj4gPj4gICAgICAgIHN0cnVjdCBpb25pY19saWYgKmxpZiA9IG5ldGRldl9wcml2
KGRldik7DQo+ID4+ICsgICAgIHUzMiByeF9jb3B5YnJlYWssIG1heF9yeF9jb3B5YnJlYWs7DQo+
ID4+DQo+ID4+ICAgICAgICBzd2l0Y2ggKHR1bmEtPmlkKSB7DQo+ID4+ICAgICAgICBjYXNlIEVU
SFRPT0xfUlhfQ09QWUJSRUFLOg0KPiA+PiAtICAgICAgICAgICAgIGxpZi0+cnhfY29weWJyZWFr
ID0gKih1MzIgKilkYXRhOw0KPiA+PiArICAgICAgICAgICAgIHJ4X2NvcHlicmVhayA9ICoodTMy
ICopZGF0YTsNCj4gPj4gKyAgICAgICAgICAgICBtYXhfcnhfY29weWJyZWFrID0gbWluX3QodTMy
LCBVMTZfTUFYLCBJT05JQ19NQVhfQlVGX0xFTik7DQo+ID4NCj4gPiBJIGRvdWJ0IHRoYXQgbmVl
ZHMgdG8gYmUgbWluX3QoKSBvciB0aGF0IHlvdSByZWFsbHkgbmVlZCB0aGUgdGVtcG9yYXJ5Lg0K
PiANCj4gSU1ITyB0aGUgdGVtcG9yYXJ5IHZhcmlhYmxlIGhlcmUgbWFrZXMgaXQgbW9yZSByZWFk
YWJsZSB0aGFuIGNvbXBhcmluZw0KPiBkaXJlY3RseSB0byB0aGUgY2FzdGVkL2RlLXJlZmVyZW5j
ZWQgb3BhcXVlIGRhdGEgcG9pbnRlciBhbmQgdGhlbg0KPiBhc3NpZ25pbmcgdG8gdGhlIHJ4X2Nv
cHlicmVhayBtZW1iZXIgaWYgaXQncyBhIHZhbGlkIHZhbHVlLg0KLi4uDQoNCkkgd2FzIHRoaW5r
aW5nIG9mIHRoZSB0ZW1wb3JhcnkgZm9yIHRoZSByZXN1bHQgb2YgbWluKCkuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=


