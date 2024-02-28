Return-Path: <netdev+bounces-75583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FEB86A9A6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F5D1F2337D
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EF7286AC;
	Wed, 28 Feb 2024 08:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD31DDC5
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108084; cv=none; b=MxI08uOaa9tliyaSn1MoRNH+NKfJF+Q4D3uA2e9rlpcUXbl0r6upxHTqeu+u+n/VXynrJcc4b0wMEKsrVktitY915iM4HSz/fvy8I8zBYrHqUqZFnWOBxNZL04dBX5mvZ7T8o7PsV4W0jf+q7FpFw2Sbxmcslqfy3kjpgIF/fXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108084; c=relaxed/simple;
	bh=orixVQmRCInZaHKcz3Apl+Si/mEvptturuvcqzFu5s0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P1udQFqHwAJLiSRv2BMWwmyuwCabpUOQ7rhhy/QrUZnBPQ0IqT21ZtePXYq9UOD5wcKS6NUj48XARltRA1aeK447UPqiO37gS8dEwlhbihNlUT/yyTybFUQ3sJ4p6zjua2O4ANFMEoAvHwSluN7f0tlB2/VILbIIciOkoBMGc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 08:59:27 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.035; Wed, 28 Feb 2024 08:59:27 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Wei Fang <wei.fang@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Jonas Blixt <jonas.blixt@actia.se>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Subject: Re: Broken networking on iMX8QXP after suspend after upgrading from
 5.10 to 6.1
Thread-Topic: Broken networking on iMX8QXP after suspend after upgrading from
 5.10 to 6.1
Thread-Index: AQHaWpEPpeShfAur10u61GX5crs7mbEQD9jAgA9iWwA=
Date: Wed, 28 Feb 2024 07:59:27 +0000
Message-ID: <521d30d8-91b5-414f-93bd-19f86bba4aa0@actia.se>
References: <1f45bdbe-eab1-4e59-8f24-add177590d27@actia.se>
 <AM5PR04MB3139C082E02B9C1B2049083F88512@AM5PR04MB3139.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR04MB3139C082E02B9C1B2049083F88512@AM5PR04MB3139.eurprd04.prod.outlook.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2921D72955637360
Content-Type: text/plain; charset="utf-8"
Content-ID: <394E203F48C94347B4A15F3ECD10ADE4@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgV2VpLA0KDQpPbiAyLzE5LzI0IDAzOjI1LCBXZWkgRmFuZyB3cm90ZToNCj4gSGkgSm9obiwN
Cj4gDQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogSm9obiBFcm5iZXJn
IDxqb2huLmVybmJlcmdAYWN0aWEuc2U+DQo+PiBTZW50OiAyMDI05bm0MuaciDjml6UgMjE6MTcN
Cj4+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+PiBDYzogSm9uYXMgQmxpeHQgPGpvbmFz
LmJsaXh0QGFjdGlhLnNlPjsgV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+Ow0KPj4gU2hlbndl
aSBXYW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT47IENsYXJrIFdhbmcNCj4+IDx4aWFvbmluZy53
YW5nQG54cC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+OyBIZWluZXINCj4+IEth
bGx3ZWl0IDxoa2FsbHdlaXQxQGdtYWlsLmNvbT47IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGlu
dXgub3JnLnVrPg0KPj4gU3ViamVjdDogQnJva2VuIG5ldHdvcmtpbmcgb24gaU1YOFFYUCBhZnRl
ciBzdXNwZW5kIGFmdGVyIHVwZ3JhZGluZyBmcm9tDQo+PiA1LjEwIHRvIDYuMQ0KPj4NCj4+IEhp
LA0KPj4NCj4+IFdlIGp1c3QgdXBncmFkZWQgdmVuZG9yIGtlcm5lbCBmcm9tIDUuMTAgdG8gNi4x
IGFuZCBlbmRlZCB1cCB3aXRoIGJyb2tlbg0KPj4gbmV0d29ya2luZyBvbiBvdXIgYm9hcmQgIHVu
bGVzcyB3ZSBicmluZyB0aGUgUEhZIHVwIGJlZm9yZSB0aGUgZmlyc3QNCj4+IHN1c3BlbmQgb2Yg
dGhlIHN5c3RlbS4NCj4+DQo+PiBUaGUgbGluayBpcyBicm91Z2h0IHVwIHZpYSBleHRlcm5hbCBz
aWduYWwsIHNvIGl0IGlzIG5vdCBndWFyYW50ZWVkIHRvIGhhdmUgYmVlbg0KPj4gVVAgYmVmb3Jl
IHRoZSBmaXJzdCBzeXN0ZW0gc3VzcGVuZC4NCj4+DQo+PiBXZSdkIGxpa2UgdG8gcnVuIHRoZSBt
YWlubGluZSBrZXJuZWwgYnV0IHdlJ3JlIG5vdCBpbiBhIHBvc2l0aW9uIHRvIGRvIHNvIHlldC4N
Cj4+IEJ1dCB3ZSBob3BlIHdlIGNhbiBnZXQgc29tZSBhZHZpY2Ugb24gdGhpcyBwcm9ibGVtIGFu
eXdheS4NCj4+DQo+PiBXZSBoYXZlIGEgcGVybWFuZW50bHkgcG93ZXJlZCBNaWNyb2NoaXAgTEFO
ODcwMFIgKG1pY3JvY2hpcF90MS5jKQ0KPj4gY29ubmVjdGVkIHRvIGFuIGlNWDhRWFAgKGZlYyks
IHRvIGJlIGFibGUgdG8gd2FrZSB0aGUgc3lzdGVtIHZpYSBuZXR3b3JrIGlmDQo+PiB0aGUgbGlu
ayBpcyB1cC4NCj4+DQo+PiBUaGlzIHNldHVwIHdhcyB3b3JraW5nIGZpbmUgaW4gNS4xMC4NCj4+
DQo+PiBUaGUgb2ZmZW5kaW5nIGNvbW1pdCBhcyBmYXIgYXMgd2UgY291bGQgYmlzZWN0IGl0IGlz
Og0KPj4gNTU3ZDVkYzgzZjY4ICgibmV0OiBmZWM6IHVzZSBtYWMtbWFuYWdlZCBQSFkgUE0iKSBB
bmQgc29tZXdoYXQ6DQo+PiBmYmE4NjNiODE2MDQgKCJuZXQ6IHBoeTogbWFrZSBQSFkgUE0gb3Bz
IGEgbm8tb3AgaWYgTUFDIGRyaXZlciBtYW5hZ2VzDQo+PiBQSFkgUE0iKQ0KPj4NCj4+IElmIHRo
ZSBpbnRlcmZhY2UgaGFzIG5vdCBiZWVuIGJyb3VnaHQgVVAgYmVmb3JlIHRoZSBzeXN0ZW0gc3Vz
cGVuZHMgd2UgY2FuDQo+PiBzZWUgdGhpcyBpbiBkbWVzZzoNCj4+DQo+PiAgICAgICBmZWMgNWIw
NDAwMDAuZXRoZXJuZXQgZXRoMDogTURJTyByZWFkIHRpbWVvdXQNCj4+ICAgICAgIE1pY3JvY2hp
cCBMQU44N3h4IFQxIDViMDQwMDAwLmV0aGVybmV0LTE6MDQ6IFBNOg0KPj4gZHBtX3J1bl9jYWxs
YmFjaygpOiBtZGlvX2J1c19waHlfcmVzdW1lKzB4MC8weGM4IHJldHVybnMgLTExMA0KPj4gICAg
ICAgTWljcm9jaGlwIExBTjg3eHggVDEgNWIwNDAwMDAuZXRoZXJuZXQtMTowNDogUE06IGZhaWxl
ZCB0byByZXN1bWU6DQo+PiBlcnJvciAtMTEwDQo+Pg0KPj4gSW4gdGhpcyBzdGF0ZSBpdCBpcyBp
bXBvc3NpYmxlIHRvIGJyaW5nIHRoZSBsaW5rIHVwIGJlZm9yZSByZW1vdmluZyBhbGwgcG93ZXIN
Cj4+IGZyb20gdGhlIGJvYXJkIGFuZCB0aGVuIHBsdWdnaW5nIGl0IGluIGFnYWluLCBzaW5jZSB0
aGUgUEhZIGlzIHBlcm1hbmVudGx5DQo+PiBwb3dlcmVkLg0KPj4NCj4+IE15IHVuZGVyc3RhbmRp
bmcgaGVyZSBpcyB0aGF0IHNpbmNlIHRoZSBsaW5rIGhhcyBuZXZlciBiZWVuIFVQLA0KPj4gZmVj
X2VuZXRfb3BlbigpIGhhcyBuZXZlciBleGVjdXRlZCwgdGhlcmVmb3IgbWFjX21hbmFnZWRfcG0g
aXMgbm90IHRydWUuDQo+PiBUaGlzIGluIHR1cm4gbWFrZXMgdXMgdGFrZSB0aGUgbm9ybWFsIFBN
IGZsb3cuDQo+PiBMaWtld2lzZSBpbiBmZWNfcmVzdW1lKCkgaWYgdGhlIGludGVyZmFjZSBpcyBu
b3QgcnVubmluZywgdGhlIE1BQyBpc24ndCBlbmFibGVkDQo+PiBiZWNhdXNlIG9uIHRoZSBpTVg4
UVhQIHRoZSBGRUMgaXMgcG93ZXJlZCBkb3duIGluIHRoZSBzdXNwZW5kIHBhdGggYnV0DQo+PiBu
ZXZlciByZS1pbml0aWFsaXplZCBhbmQgZW5hYmxlZCBpbiB0aGUgcmVzdW1lIHBhdGgsIHNvIHRo
ZSBNQUMgaXMgcG93ZXJlZA0KPj4gYmFjayB1cCwgYnV0IHN0aWxsIGRpc2FibGVkLg0KPj4NCj4+
IEFkZGluZyB0aGUgZm9sbG93aW5nIHNlZW1zIHRvIGZpeCB0aGUgaXNzdWUsIGJ1dCBJIHBlcnNv
bmFsbHkgZG9uJ3QgbGlrZSB0aGlzLA0KPj4gYmVjYXVzZSB3ZSBqdXN0IGFsbG93IHRoZSBub24t
bWFjX21hbmFnZWRfcG0gZmxvdyB0byBydW4gbG9uZ2VyIGJ5DQo+PiBlbmFibGluZyB0aGUgTUFD
IGFnYWluIHJhdGhlciB0aGFuIGxldHRpbmcgdGhlIE1BQyBkbyB0aGUgUE0gYXMgY29uZmlndXJl
ZA0KPj4gaW4gZmVjX2VuZXRfb3BlbigpLg0KPj4gV2hhdCB3b3VsZCBiZSB0aGUgY29ycmVjdCB0
aGluZyB0byBkbyBoZXJlPw0KPiANCj4gU29ycnkgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLg0K
DQpJIG11c3QgZXF1YWxseSBhcG9sb2dpemUgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLg0KDQpZ
b3VyIHBhdGNoIGhlbHBlZCBncmVhdGx5IGZpbmRpbmcgdGhlIGFjdHVhbCByb290IGNhdXNlIG9m
IHRoZSBwcm9ibGVtDQood2hpY2ggcHJlLWRhdGVzIDUuMTApOg0KDQpmMTY2Zjg5MGM4ZjAgKCJu
ZXQ6IGV0aGVybmV0OiBmZWM6IFJlcGxhY2UgaW50ZXJydXB0IGRyaXZlbiBNRElPIHdpdGggDQpw
b2xsZWQgSU8iKQ0KDQpIb3cgNS4xMCB3b3JrZWQgZm9yIHVzIGlzIGEgbXlzdGVyeSwgYmVjYXVz
ZSBhIHN1c3BlbmQtcmVzdW1lIGN5Y2xlIGJlZm9yZQ0KbGluayB1cCB3cml0ZXMgdG8gTUlJX0RB
VEEgcmVnaXN0ZXIgYmVmb3JlIGZlY19yZXN0YXJ0KCkgaXMgY2FsbGVkLCB3aGljaA0KcmVzdG9y
ZXMgdGhlIE1JSV9TUEVFRCByZWdpc3RlciwgdHJpZ2dlcmluZyB0aGUgTUlJX0VWRU5UIHF1aXJr
Lg0KDQo+IEhhdmUgeW91IHRyaWVkIHNldHRpbmcgbWFjX21hbmFnZW1lbnRfcG0gdG8gdHJ1ZSBh
ZnRlciBtZGlvYnVzIHJlZ2lzdHJhdGlvbj8NCj4gSnVzdCBsaWtlIGJlbG93Og0KDQpJIGhhdmUg
dGVzdGVkIHlvdXIgcGF0Y2ggYW5kIGl0IGRvZXMgZml4IG15IGlzc3VlLCB3aXRoIHlvdXIgcGF0
Y2ggSSBhbHNvDQpyZWFsaXplZCBhIHNpZGUtZWZmZWN0IG9mIG1hY19tYW5hZ2VkX3BtIGluIHRo
ZSBGRUMgZHJpdmVyLiBUaGUgUEhZIHdpbGwNCm5ldmVyIHN1c3BlbmQgZHVlIHRvIHRoZSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uIG9mIGZlY19zdXNwZW5kKCkgYW5kDQpmZWNfcmVzdW1lKCkuDQoN
CnBoeV9zdXNwZW5kKCkgYW5kIHBoeV9yZXN1bWUoKSBhcmUgbmV2ZXIgY2FsbGVkIGZyb20gRkVD
IGNvZGUuDQoNCk1heSBJIHBpY2sgdXAgeW91ciBwYXRjaCB3aXRoIGEgc2lnbmVkLW9mZiBmcm9t
IHlvdT8gSSB3b3VsZCBsaWtlIHRvIG1ha2UNCml0IGEgc21hbGwgc2VyaWVzIGFkZGluZyBhbHNv
IHN1c3BlbmQvcmVzdW1lIG9mIHRoZSBQSFkuDQoNCklmIHlvdSB3YW50IHRvIHNlbmQgaXQgeW91
cnNlbGYgaW5zdGVhZCwgcGxlYXNlIHBpY2sgdXAgdGhlc2UgdGFnczoNCkZpeGVzOiA1NTdkNWRj
ODNmNjggKCJuZXQ6IGZlYzogdXNlIG1hYy1tYW5hZ2VkIFBIWSBQTSIpDQpDbG9zZXM6IA0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzFmNDViZGJlLWVhYjEtNGU1OS04ZjI0LWFkZDE3
NzU5MGQyN0BhY3RpYS5zZS8NClJlcG9ydGVkLWJ5OiBKb2huIEVybmJlcmcgPGpvaG4uZXJuYmVy
Z0BhY3RpYS5zZT4NClRlc3RlZC1ieTogSm9obiBFcm5iZXJnIDxqb2huLmVybmJlcmdAYWN0aWEu
c2U+DQoNCkFuZCB0aGVuIEkgc2VuZCBhIHNlcGFyYXRlIHBhdGNoIHdpdGggeW91cnMgYXMgYSBk
ZXBlbmRlbmN5Lg0KDQpUaGFua3MhIC8vIEpvaG4gRXJuYmVyZw==

