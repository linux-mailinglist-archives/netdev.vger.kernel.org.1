Return-Path: <netdev+bounces-70235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D7084E204
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4575F1C2214A
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFEC76404;
	Thu,  8 Feb 2024 13:31:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E04763F4
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399119; cv=none; b=si6z2h87MPh58m/HlJBfXM1Cg4g1VNUV5V99v7qeI7WWB1b1aHVyFbIuVU+aaoAkH8RAtWMXoKiY7dxoXOqBd7Azoj4Ty9gzLyCKmNDVF1iHdUVf58wGj6bSQhZMIL5TzvWUyS0k4A6VeEXQdmao/gm12+kYfwZ0n6S7xo6NTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399119; c=relaxed/simple;
	bh=udTYw3Ugz5zc35x12XyFENhW+FnzOlfbUy32MS+l/vc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XG2dmaGYv4KVOHAAeUb6q1tYzqprMpNTOOymA7cjdlCZwes6v62HABX7C3DGa2CSsyFwUoeGN98HZXBBK8RZIxi7ASnjHMleDd0M4E9kfDRWJ86ScTsuF/v3wdzfUzdarahrPyg+PkMd+bttx2xFPqQGx+fuIXPFWFuIK0FojrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 14:16:43 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.035; Thu, 8 Feb 2024 14:16:43 +0100
From: John Ernberg <john.ernberg@actia.se>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Jonas Blixt <jonas.blixt@actia.se>, Wei Fang <wei.fang@nxp.com>, "Shenwei
 Wang" <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
Subject: Broken networking on iMX8QXP after suspend after upgrading from 5.10
 to 6.1
Thread-Topic: Broken networking on iMX8QXP after suspend after upgrading from
 5.10 to 6.1
Thread-Index: AQHaWpEPpeShfAur10u61GX5crs7mQ==
Date: Thu, 8 Feb 2024 13:16:43 +0000
Message-ID: <1f45bdbe-eab1-4e59-8f24-add177590d27@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2958D72955617062
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFB60E921363D9418C3AEF9772A54E22@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQoNCldlIGp1c3QgdXBncmFkZWQgdmVuZG9yIGtlcm5lbCBmcm9tIDUuMTAgdG8gNi4xIGFu
ZCBlbmRlZCB1cCB3aXRoIGJyb2tlbg0KbmV0d29ya2luZyBvbiBvdXIgYm9hcmQgIHVubGVzcyB3
ZSBicmluZyB0aGUgUEhZIHVwIGJlZm9yZSB0aGUgZmlyc3QNCnN1c3BlbmQgb2YgdGhlIHN5c3Rl
bS4NCg0KVGhlIGxpbmsgaXMgYnJvdWdodCB1cCB2aWEgZXh0ZXJuYWwgc2lnbmFsLCBzbyBpdCBp
cyBub3QgZ3VhcmFudGVlZCB0bw0KaGF2ZSBiZWVuIFVQIGJlZm9yZSB0aGUgZmlyc3Qgc3lzdGVt
IHN1c3BlbmQuDQoNCldlJ2QgbGlrZSB0byBydW4gdGhlIG1haW5saW5lIGtlcm5lbCBidXQgd2Un
cmUgbm90IGluIGEgcG9zaXRpb24gdG8gZG8gc28NCnlldC4gQnV0IHdlIGhvcGUgd2UgY2FuIGdl
dCBzb21lIGFkdmljZSBvbiB0aGlzIHByb2JsZW0gYW55d2F5Lg0KDQpXZSBoYXZlIGEgcGVybWFu
ZW50bHkgcG93ZXJlZCBNaWNyb2NoaXAgTEFOODcwMFIgKG1pY3JvY2hpcF90MS5jKSBjb25uZWN0
ZWQNCnRvIGFuIGlNWDhRWFAgKGZlYyksIHRvIGJlIGFibGUgdG8gd2FrZSB0aGUgc3lzdGVtIHZp
YSBuZXR3b3JrIGlmIHRoZSBsaW5rDQppcyB1cC4NCg0KVGhpcyBzZXR1cCB3YXMgd29ya2luZyBm
aW5lIGluIDUuMTAuDQoNClRoZSBvZmZlbmRpbmcgY29tbWl0IGFzIGZhciBhcyB3ZSBjb3VsZCBi
aXNlY3QgaXQgaXM6DQo1NTdkNWRjODNmNjggKCJuZXQ6IGZlYzogdXNlIG1hYy1tYW5hZ2VkIFBI
WSBQTSIpDQpBbmQgc29tZXdoYXQ6DQpmYmE4NjNiODE2MDQgKCJuZXQ6IHBoeTogbWFrZSBQSFkg
UE0gb3BzIGEgbm8tb3AgaWYgTUFDIGRyaXZlciBtYW5hZ2VzIA0KUEhZIFBNIikNCg0KSWYgdGhl
IGludGVyZmFjZSBoYXMgbm90IGJlZW4gYnJvdWdodCBVUCBiZWZvcmUgdGhlIHN5c3RlbSBzdXNw
ZW5kcyB3ZSBjYW4NCnNlZSB0aGlzIGluIGRtZXNnOg0KDQogICAgIGZlYyA1YjA0MDAwMC5ldGhl
cm5ldCBldGgwOiBNRElPIHJlYWQgdGltZW91dA0KICAgICBNaWNyb2NoaXAgTEFOODd4eCBUMSA1
YjA0MDAwMC5ldGhlcm5ldC0xOjA0OiBQTTogDQpkcG1fcnVuX2NhbGxiYWNrKCk6IG1kaW9fYnVz
X3BoeV9yZXN1bWUrMHgwLzB4YzggcmV0dXJucyAtMTEwDQogICAgIE1pY3JvY2hpcCBMQU44N3h4
IFQxIDViMDQwMDAwLmV0aGVybmV0LTE6MDQ6IFBNOiBmYWlsZWQgdG8gcmVzdW1lOiANCmVycm9y
IC0xMTANCg0KSW4gdGhpcyBzdGF0ZSBpdCBpcyBpbXBvc3NpYmxlIHRvIGJyaW5nIHRoZSBsaW5r
IHVwIGJlZm9yZSByZW1vdmluZyBhbGwNCnBvd2VyIGZyb20gdGhlIGJvYXJkIGFuZCB0aGVuIHBs
dWdnaW5nIGl0IGluIGFnYWluLCBzaW5jZSB0aGUgUEhZIGlzDQpwZXJtYW5lbnRseSBwb3dlcmVk
Lg0KDQpNeSB1bmRlcnN0YW5kaW5nIGhlcmUgaXMgdGhhdCBzaW5jZSB0aGUgbGluayBoYXMgbmV2
ZXIgYmVlbiBVUCwNCmZlY19lbmV0X29wZW4oKSBoYXMgbmV2ZXIgZXhlY3V0ZWQsIHRoZXJlZm9y
IG1hY19tYW5hZ2VkX3BtIGlzIG5vdCB0cnVlLg0KVGhpcyBpbiB0dXJuIG1ha2VzIHVzIHRha2Ug
dGhlIG5vcm1hbCBQTSBmbG93Lg0KTGlrZXdpc2UgaW4gZmVjX3Jlc3VtZSgpIGlmIHRoZSBpbnRl
cmZhY2UgaXMgbm90IHJ1bm5pbmcsIHRoZSBNQUMgaXNuJ3QNCmVuYWJsZWQgYmVjYXVzZSBvbiB0
aGUgaU1YOFFYUCB0aGUgRkVDIGlzIHBvd2VyZWQgZG93biBpbiB0aGUgc3VzcGVuZCBwYXRoDQpi
dXQgbmV2ZXIgcmUtaW5pdGlhbGl6ZWQgYW5kIGVuYWJsZWQgaW4gdGhlIHJlc3VtZSBwYXRoLCBz
byB0aGUgTUFDIGlzDQpwb3dlcmVkIGJhY2sgdXAsIGJ1dCBzdGlsbCBkaXNhYmxlZC4NCg0KQWRk
aW5nIHRoZSBmb2xsb3dpbmcgc2VlbXMgdG8gZml4IHRoZSBpc3N1ZSwgYnV0IEkgcGVyc29uYWxs
eSBkb24ndCBsaWtlDQp0aGlzLCBiZWNhdXNlIHdlIGp1c3QgYWxsb3cgdGhlIG5vbi1tYWNfbWFu
YWdlZF9wbSBmbG93IHRvIHJ1biBsb25nZXIgYnkNCmVuYWJsaW5nIHRoZSBNQUMgYWdhaW4gcmF0
aGVyIHRoYW4gbGV0dGluZyB0aGUgTUFDIGRvIHRoZSBQTSBhcyBjb25maWd1cmVkDQppbiBmZWNf
ZW5ldF9vcGVuKCkuDQpXaGF0IHdvdWxkIGJlIHRoZSBjb3JyZWN0IHRoaW5nIHRvIGRvIGhlcmU/
DQoNCi0tLS0tLS0tLSA+OCAtLS0tLS0NCiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlY19tYWluLmMgfCAyICsrDQogIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIA0K
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KaW5kZXggYTliNjFm
Y2Y5YjVjLi42YmU1ZjM4ODM1ODIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
cmVlc2NhbGUvZmVjX21haW4uYw0KKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlY19tYWluLmMNCkBAIC00NjkwLDYgKzQ2OTAsOCBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51
c2VkIGZlY19yZXN1bWUoc3RydWN0IGRldmljZSANCipkZXYpDQogICAgICAgICAgICAgICAgIHJl
dCA9IGZlY19yZXN0b3JlX21paV9idXMobmRldik7DQogICAgICAgICAgICAgICAgIGlmIChyZXQg
PCAwKQ0KICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQorICAgICAgIH0gZWxz
ZSB7DQorICAgICAgICAgICAgICAgZmVjX3Jlc3RhcnQobmRldik7DQogICAgICAgICB9DQogICAg
ICAgICBydG5sX3VubG9jaygpOw0KDQotLQ0KDQpUaGFua3MhIC8vIEpvaG4gRXJuYmVyZw==

