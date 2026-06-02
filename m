Return-Path: <netdev+bounces-294130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHlANsCtHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:17:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9CA62C670
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED61308B797
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0363D47D0;
	Tue,  2 Jun 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PeVjx8zf"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD23D5646;
	Tue,  2 Jun 2026 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394845; cv=none; b=WHlvuVnjpSrJYxoNZsFK0TTr6CaZ9vyON7Snn1km2SByXN8JXxlkhkE4CUE2z63nqexSw+/98iZaHqX71C8zv8lqDJ139S5d97WyGpZPXdU2X/NNfBXcOMDcs+RimxEHd9Kripl0TLwMh4Spsx+ho5NaSnlXYSz1FHxpcnaukxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394845; c=relaxed/simple;
	bh=RCrabhRvbFDPAC02/iHDHdWZSJLIr089bUH/mlzoD9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P6XRxtGAWFFhL6Zzd/l28KDpFazClhDW3tj2O+dDgLvsAcHN1QKNV2lzwwlwwGiudebIgKz1l0mkoZ9ocJDw/vAwA9sY85vGxRc/0GE7QolzKldIqfH4Y/kDIIYHD19kzK3lcGRF+gpoc3fW4Bx2CFsomECvDIY8JA05TVmmnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PeVjx8zf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 652A6ooI62836218, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780394810; bh=RCrabhRvbFDPAC02/iHDHdWZSJLIr089bUH/mlzoD9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PeVjx8zf286A0NkaPx4fZXrKFpw4jMHcO4rZF04P7t/Aw3brYlLqRdcl2iXNKy2RS
	 iGCN/1MftbDx2aeVscYMki2J1WfGtA9q4niy36X/YiMbEqxjIW/tOIVEXrkmBXa4mM
	 IQ3DJdNHyoHtTLeKCuizWoB7SK9sgGdCBynC3JZpcAlPTQxXxShkEsztWzPrLZUsMP
	 tlhS3cjwMtoEQR6QSawA+NBQEWpguAc5Tf7dmXiI5W5tz9L57LAPO6HeTwCBt58kam
	 BV3cqNjyRbVNrCuZG208cwiy0aHFu/fblUKau+PK2geJDtb7odyM2Go6q8r4pVhwg6
	 fHEEefDK2Ei2A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 652A6ooI62836218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jun 2026 18:06:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Jun 2026 18:06:50 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Jun 2026 18:06:50 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Tue, 2 Jun 2026 18:06:50 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, Ping-Ke Shih
	<pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH] rtase: Reset TX subqueue when clearing TX ring
Thread-Topic: [PATCH] rtase: Reset TX subqueue when clearing TX ring
Thread-Index: AQHc8Y9HCI3se5iOd0evWU8W1dBEirYpKU4AgAHhoVA=
Date: Tue, 2 Jun 2026 10:06:50 +0000
Message-ID: <611cbfc8d2ac46a0bb0d1f3b42091bd0@realtek.com>
References: <20260601062418.64004-1-justinlai0215@realtek.com>
 <7a5702ba-af01-485d-84fb-f54c9d5269b2@intel.com>
In-Reply-To: <7a5702ba-af01-485d-84fb-f54c9d5269b2@intel.com>
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
X-Rspamd-Queue-Id: 3A9CA62C670
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294130-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:mid,realtek.com:dkim,realtek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

PiBGcm9tOiBKdXN0aW4gTGFpIDxqdXN0aW5sYWkwMjE1QHJlYWx0ZWsuY29tPg0KPiBEYXRlOiBN
b24sIDEgSnVuIDIwMjYgMTQ6MjQ6MTggKzA4MDANCj4gDQo+ID4gcnRhc2VfdHhfY2xlYXIoKSBj
bGVhcnMgdGhlIFRYIHJpbmcgYW5kIHJlc2V0cyB0aGUgcmluZyBpbmRleGVzLg0KPiA+IEhvd2V2
ZXIsIHRoZSBUWCBxdWV1ZSBzdGF0ZSBhbmQgQlFMIGFjY291bnRpbmcgYXJlIG5vdCByZXNldCBh
dCB0aGUNCj4gPiBzYW1lIHRpbWUuDQo+ID4NCj4gPiBUaGlzIG1heSBsZWF2ZSBfX1FVRVVFX1NU
QVRFX1NUQUNLX1hPRkYgYXNzZXJ0ZWQgYWZ0ZXINCj4gPiBydGFzZV9zd19yZXNldCgpLCBwcmV2
ZW50aW5nIG5ldyBUWCBwYWNrZXRzIGZyb20gYmVpbmcgc2NoZWR1bGVkLg0KPiA+DQo+ID4gUmVz
ZXQgdGhlIFRYIHN1YnF1ZXVlIHdoZW4gY2xlYXJpbmcgdGhlIFRYIHJpbmcgc28gdGhlIFRYIHF1
ZXVlIHN0YXRlDQo+ID4gYW5kIEJRTCBhY2NvdW50aW5nIGFyZSByZXN0b3JlZCB0b2dldGhlci4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEp1c3RpbiBMYWkgPGp1c3RpbmxhaTAyMTVAcmVhbHRl
ay5jb20+DQo+IA0KPiBZb3UgbmVlZCB0bzoNCj4gDQo+IDEuIFNwZWNpZnkgdGhlIHRhcmdldCBi
cmFuY2ggaW4gdGhlIHN1YmplY3QgcHJlZml4IChbUEFUQ0ggbmV0XQ0KPiAgICBmb3IgY3JpdGlj
YWwgZml4ZXMsIFtQQVRDSCBuZXQtbmV4dF0gZm9yIGZlYXR1cmVzIGFuZCBtaXNjDQo+ICAgIG5v
bi1jcml0aWNhbCBmaXhlcyBhbmQgaW1wcm92ZW1lbnRzKS4NCj4gMi4gSWYgdGhpcyBpcyBhIGZp
eCB0YXJnZXRpbmcgIm5ldCIsIHlvdSBuZWVkIHRvIHByb3ZpZGUgYSAiRml4ZXM6Ig0KPiAgICB0
YWcgcG9pbnRpbmcgdG8gdGhlIGNvbW1pdCB3aGljaCBpbnRyb2R1Y2VkIHRoaXMgaXNzdWUuDQo+
IDMuIElmIHRoaXMgaXMgYSBmaXggYW5kIHRoZSBidWcgaXMgcHJlc2VudCBpbiBvbGRlciBzdXBw
b3J0ZWQga2VybmVscw0KPiAgICAoTFRTZXMgZXRjKSwgeW91IG5lZWQgdG8gYWRkICJDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZyIgcmlnaHQNCj4gICAgYWZ0ZXIgdGhlICJGaXhlczoiIHRhZy4N
Cj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcnRhc2UvcnRh
c2VfbWFpbi5jIHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9ydGFzZS9y
dGFzZV9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcnRhc2UvcnRh
c2VfbWFpbi5jDQo+ID4gaW5kZXggNDNhNGFhMjc1YjYyLi4xMWU5ZDBmZWVhNjggMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9ydGFzZS9ydGFzZV9tYWluLmMN
Cj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3J0YXNlL3J0YXNlX21haW4u
Yw0KPiA+IEBAIC0yNDAsNiArMjQwLDggQEAgc3RhdGljIHZvaWQgcnRhc2VfdHhfY2xlYXIoc3Ry
dWN0IHJ0YXNlX3ByaXZhdGUgKnRwKQ0KPiA+ICAgICAgICAgICAgICAgcnRhc2VfdHhfY2xlYXJf
cmFuZ2UocmluZywgcmluZy0+ZGlydHlfaWR4LA0KPiBSVEFTRV9OVU1fREVTQyk7DQo+ID4gICAg
ICAgICAgICAgICByaW5nLT5jdXJfaWR4ID0gMDsNCj4gPiAgICAgICAgICAgICAgIHJpbmctPmRp
cnR5X2lkeCA9IDA7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgbmV0ZGV2X3R4X3Jlc2V0X3N1
YnF1ZXVlKHRwLT5kZXYsIGkpOw0KPiANCj4gVGhlIGZpeCBpdHNlbGYgbG9va3Mgb2suDQo+IA0K
PiA+ICAgICAgIH0NCj4gPiAgfQ0KPiANCj4gVGhhbmtzLA0KPiBPbGVrDQoNCkhpIE9sZWssDQoN
ClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KVGhpcyBpcyBhIGJ1ZyBmaXguIEknbGwgcmVzZW5k
IGl0IHRhcmdldGluZyB0aGUgbmV0IHRyZWUgd2l0aA0KdGhlIHByb3BlciBGaXhlcyB0YWcgYW5k
IENjIHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcuDQoNClRoYW5rcywNCkp1c3Rpbg0K

