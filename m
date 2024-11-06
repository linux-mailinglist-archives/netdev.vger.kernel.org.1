Return-Path: <netdev+bounces-142516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DFF9BF769
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 150AFB22F81
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112420D4FC;
	Wed,  6 Nov 2024 19:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F2D209F5F;
	Wed,  6 Nov 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921968; cv=none; b=amF7PZ9mct41vvOb3ilYH1HVYP3GOyA1EoOU41cKMXgNo828sNR8J0h+1nuibngjHPvKBeKGbFHt9wdN3T9V/IMDvZnVBc2qmrtdnFv0XpwvymAn4SSBtCvlitVduvwiyvdxttNrl5lQ5UZRBqLEzQLEaeaoQadmXNejdEoRvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921968; c=relaxed/simple;
	bh=tQJFIIVAr7zhlGtYPHWkAgTf9vswLcNuwpL3LPfc+i0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMeV3mBqPsmdAKIfgxN1KFSCT8QrSVm9/CPzSMkLKso4VSoQFs6G+NEkeBeD16DRaqj18gkXCQh6WtXEn3KJoHqWojkYg8TqV7Nd9KV8zfiRNPTLz3wmTAHfErEfWNkgwGGekq/2gzDfq5AYCgEuECDs0Yztshg3o/oj4zXvnfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XkFpr5Vkhz1SG94;
	Thu,  7 Nov 2024 03:37:40 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id DDB50180019;
	Thu,  7 Nov 2024 03:39:22 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 03:39:21 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 6 Nov 2024 20:39:19 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@kernel.org>,
	"shenjian (K)" <shenjian15@huawei.com>
CC: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, Joerg Roedel
	<jroedel@suse.de>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, shaojijie <shaojijie@huawei.com>, wangpeiyang
	<wangpeiyang1@huawei.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT dependency
Thread-Topic: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT dependency
Thread-Index: AQHbLpKYY9Lsz1VxeUenvFuoDgyBFLKm2vEAgAASuSCAAANu4IAAT+oAgANnArA=
Date: Wed, 6 Nov 2024 19:39:19 +0000
Message-ID: <515b8ae869b94c849d02421d8d8767fd@huawei.com>
References: <20241104082129.3142694-1-arnd@kernel.org>
 <069c9838-b781-4012-934a-d2626fa78212@arm.com>
 <96df804b6d9d467391fda27d90b5227c@huawei.com>
 <a94f95bd661c4978bb843c8a1af73818@huawei.com>
 <29d5918e-cfe2-4b36-b0f1-a1379075dd05@arm.com>
In-Reply-To: <29d5918e-cfe2-4b36-b0f1-a1379075dd05@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUm9iaW4sDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4gSSB3YXMgb24gYSBsZWF2ZSB5
ZXN0ZXJkYXkuDQoNCj4gIEZyb206IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+
DQo+ICBTZW50OiBNb25kYXksIE5vdmVtYmVyIDQsIDIwMjQgNDozNSBQTQ0KPiAgVG86IFNhbGls
IE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgQXJuZCBCZXJnbWFubg0KPiAgPGFybmRA
a2VybmVsLm9yZz47IHNoZW5qaWFuIChLKSA8c2hlbmppYW4xNUBodWF3ZWkuY29tPg0KPiAgDQo+
ICBPbiAyMDI0LTExLTA0IDEwOjUwIGFtLCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gID4+ICAgRnJv
bTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICA+PiAgIFNlbnQ6IE1v
bmRheSwgTm92ZW1iZXIgNCwgMjAyNCAxMDo0MSBBTQ0KPiAgPj4gICBUbzogUm9iaW4gTXVycGh5
IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47IEFybmQgQmVyZ21hbm4NCj4gID4+ICAgPGFybmRAa2Vy
bmVsLm9yZz47IHNoZW5qaWFuIChLKSA8c2hlbmppYW4xNUBodWF3ZWkuY29tPg0KPiAgPj4NCj4g
ID4+ICAgSEkgUm9iaW4sDQo+ICA+Pg0KPiAgPj4gICA+ICBGcm9tOiBSb2JpbiBNdXJwaHkgPHJv
YmluLm11cnBoeUBhcm0uY29tPg0KPiAgPj4gICA+ICBTZW50OiBNb25kYXksIE5vdmVtYmVyIDQs
IDIwMjQgMTA6MjkgQU0NCj4gID4+ICAgPiAgVG86IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVs
Lm9yZz47IHNoZW5qaWFuIChLKQ0KPiAgPj4gICA+IDxzaGVuamlhbjE1QGh1YXdlaS5jb20+OyBT
YWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gID4+ICAgPiAgQ2M6IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBXaWxsIERlYWNvbg0KPiAgPHdpbGxAa2VybmVsLm9y
Zz47DQo+ICA+PiAgID4gSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+OyBpb21tdUBsaXN0
cy5saW51eC5kZXY7IEFuZHJldw0KPiAgTHVubg0KPiAgPj4gICA+IDxhbmRyZXcrbmV0ZGV2QGx1
bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXINCj4gIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsNCj4gID4+
ICAgRXJpYw0KPiAgPj4gICA+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBL
aWNpbnNraQ0KPiAgPGt1YmFAa2VybmVsLm9yZz47DQo+ICA+PiAgID4gUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPjsgc2hhb2ppamllDQo+ICA8c2hhb2ppamllQGh1YXdlaS5jb20+Ow0K
PiAgPj4gICA+IHdhbmdwZWl5YW5nIDx3YW5ncGVpeWFuZzFAaHVhd2VpLmNvbT47DQo+ICBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOw0KPiAgPj4gICA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gID4+ICAgPiAgU3ViamVjdDogUmU6IFtQQVRDSF0gW25ldC1uZXh0XSBuZXQ6IGhuczM6
IGFkZCBJT01NVV9TVVBQT1JUDQo+ICA+PiAgID4gZGVwZW5kZW5jeQ0KPiAgPj4gICA+DQo+ICA+
PiAgID4gIE9uIDIwMjQtMTEtMDQgODoyMSBhbSwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gID4+
ICAgPiAgPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiAgPiAgPiBUaGUgaG5z
MyBkcml2ZXINCj4gIHN0YXJ0ZWQNCj4gID4+ICAgPiBmaWxsaW5nIGlvbW11X2lvdGxiX2dhdGhl
ciBzdHJ1Y3R1cmVzIGl0c2VsZiwgID4gd2hpY2ggcmVxdWlyZXMNCj4gID4+ICAgPiBDT05GSUdf
SU9NTVVfU1VQUE9SVCBpcyBlbmFibGVkOg0KPiAgPj4gICA+ICA+DQo+ICA+PiAgID4gID4gZHJp
dmVycy9uZXQvZXRoZXJuZXQvaGlzaWxpY29uL2huczMvaG5zM19lbmV0LmM6IEluIGZ1bmN0aW9u
DQo+ICA+PiAgID4gICdobnMzX2RtYV9tYXBfc3luYyc6DQo+ICA+PiAgID4gID4gZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaGlzaWxpY29uL2huczMvaG5zM19lbmV0LmM6Mzk1OjE0OiBlcnJvcjoNCj4g
ID4+ICAgPiAnc3RydWN0ICBpb21tdV9pb3RsYl9nYXRoZXInIGhhcyBubyBtZW1iZXIgbmFtZWQg
J3N0YXJ0Jw0KPiAgPj4gICA+ICA+ICAgIDM5NSB8ICBpb3RsYl9nYXRoZXIuc3RhcnQgPSBpb3Zh
Ow0KPiAgPj4gICA+ICA+ICAgICAgICB8ICAgICAgICAgICAgICBeDQo+ICA+PiAgID4gID4gZHJp
dmVycy9uZXQvZXRoZXJuZXQvaGlzaWxpY29uL2huczMvaG5zM19lbmV0LmM6Mzk2OjE0OiBlcnJv
cjoNCj4gID4+ICAgPiAnc3RydWN0ICBpb21tdV9pb3RsYl9nYXRoZXInIGhhcyBubyBtZW1iZXIg
bmFtZWQgJ2VuZCcNCj4gID4+ICAgPiAgPiAgICAzOTYgfCAgaW90bGJfZ2F0aGVyLmVuZCA9IGlv
dmEgKyBncmFudWxlIC0gMTsNCj4gID4+ICAgPiAgPiAgICAgICAgfCAgICAgICAgICAgICAgXg0K
PiAgPj4gICA+ICA+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5l
dC5jOjM5NzoxNDogZXJyb3I6DQo+ICA+PiAgID4gJ3N0cnVjdCAgaW9tbXVfaW90bGJfZ2F0aGVy
JyBoYXMgbm8gbWVtYmVyIG5hbWVkICdwZ3NpemUnDQo+ICA+PiAgID4gID4gICAgMzk3IHwgIGlv
dGxiX2dhdGhlci5wZ3NpemUgPSBncmFudWxlOw0KPiAgPj4gICA+ICA+ICAgICAgICB8ICAgICAg
ICAgICAgICBeDQo+ICA+PiAgID4gID4NCj4gID4+ICAgPiAgPiBBZGQgYSBLY29uZmlnIGRlcGVu
ZGVuY3kgdG8gbWFrZSBpdCBidWlsZCBpbiByYW5kb20NCj4gIGNvbmZpZ3VyYXRpb25zLg0KPiAg
Pj4gICA+ICA+DQo+ICA+PiAgID4gID4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+
DQo+ICA+PiAgID4gID4gQ2M6IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KPiAgPj4g
ICA+ICA+IENjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPiAgPiBDYzoNCj4g
ID4+ICAgPiBpb21tdUBsaXN0cy5saW51eC5kZXYgID4gRml4ZXM6IGYyYzE0ODk5Y2FiYSAoIm5l
dDogaG5zMzogYWRkIHN5bmMNCj4gID4+ICAgPiBjb21tYW5kIHRvIHN5bmMgaW8tcGd0YWJsZSIp
ICA+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4NCj4gID4+ICAgPiA8YXJuZEBhcm5kYi5k
ZT4gID4gLS0tICA+IEkgbm90aWNlZCB0aGF0IG5vIG90aGVyIGRyaXZlciBkb2VzIHRoaXMsIHNv
DQo+ICA+PiAgID4gaXQgd291bGQgYmUgZ29vZCB0byBoYXZlICA+IGEgY29uZmlybWF0aW9uIGZy
b20gdGhlIGlvbW11DQo+ICBtYWludGFpbmVycw0KPiAgPj4gICA+IHRoYXQgdGhpcyBpcyBob3cg
dGhlICA+IGludGVyZmFjZSBhbmQgdGhlIGRlcGVuZGVuY3kgaXMgaW50ZW5kZWQgdG8gYmUNCj4g
ID4+ICAgPiB1c2VkLg0KPiAgPj4gICA+DQo+ICA+PiAgID4gIFdURiBpcyB0aGF0IHBhdGNoIGRv
aW5nIT8gTm8sIHJhbmRvbSBkZXZpY2UgZHJpdmVycyBzaG91bGQNCj4gIGFic29sdXRlbHkNCj4g
ID4+ICAgPiBub3QgIGJlIHBva2luZyBpbnRvIElPTU1VIGRyaXZlciBpbnRlcm5hbHMsIHRoaXMg
aXMgZWdyZWdpb3VzbHkgd3JvbmcNCj4gID4+ICAgPiBhbmQgdGhlICBjb3JyZWN0IGFjdGlvbiBp
cyB0byBkcm9wIGl0IGVudGlyZWx5Lg0KPiAgPj4NCj4gID4+DQo+ICA+PiAgIEFic29sdXRlbHkg
YWdyZWUgd2l0aCBpdC4gU29ycnkgSSBoYXZlbid0IGJlZW4gaW4gdG91Y2ggZm9yIHF1aXRlIHNv
bWUNCj4gIHRpbWUuDQo+ICA+PiAgIExldCBtZSBjYXRjaCB0aGUgd2hvbGUgc3RvcnkuICBGZWVs
IGZyZWUgdG8gZHJvcCB0aGlzIHBhdGNoLg0KPiAgPg0KPiAgPg0KPiAgPiBKdXN0IHRvIG1ha2Ug
aXQgY2xlYXIgSSBtZWFudCB0aGUgY3VscHJpdCBwYXRjaDoNCj4gID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbmV0ZGV2LzIwMjQxMDI1MDkyOTM4LjI5MTI5NTgtMy0NCj4gIHNoYW9qaWppZUBo
dWF3DQo+ICA+IGVpLmNvbS8NCj4gIA0KPiAgUmlnaHQsIGlmIHRoZSBISVAwOSBTTU1VIGhhcyBh
IGJ1ZyB3aGljaCByZXF1aXJlcyBhbg0KPiAgaW9tbXVfZG9tYWluX29wczo6aW90bGJfc3luY19t
YXAgd29ya2Fyb3VuZCwgdGhlbiB0aGUgU01NVSBkcml2ZXINCj4gIHNob3VsZCBkZXRlY3QgdGhl
IEhJUDA5IFNNTVUgYW5kIGltcGxlbWVudCB0aGF0IHdvcmthcm91bmQgZm9yIGl0Lg0KPiAgSE5T
MyB0cnlpbmcgdG8gcmVhY2ggaW4gdG8gdGhlIFNNTVUgZHJpdmVyJ3MgZGF0YSBhbmQgb3Blbi1j
b2RlDQo+ICBpb3RsYl9zeW5jX21hcCBvbiBpdHMgYmVoYWxmIGlzIGp1c3QgYXMgcGxhaW4gaWxs
b2dpY2FsIGFzIGl0IGlzIHVuYWNjZXB0YWJsZS4NCg0KDQpUb3RhbGx5IGFncmVlIHdpdGggdGhh
dC4gIEl0IGJyZWFrcyB0aGUgZGVzaWduIG9mIHRoZSBrZXJuZWwgZnVuZGFtZW50YWxseS4NClRo
aXMgd2FzIGEgbWlzdGFrZSBhbmQgb24gTW9uZGF5IEkndmUgcmVxdWVzdGVkIHRoZSBzdGFrZWhv
bGRlcnMgdG8NCmFkZHJlc3MgaXQgZXhhY3RseSBpbiB0aGUgcmVhbG1zIG9mIHdoYXQgeW91IGhh
dmUgc3VnZ2VzdGVkIGFib3ZlLiANCg0KUmVzdCBhc3N1cmVkLCB3ZSB3aWxsIGFkZHJlc3MgdGhh
dCBpbiB0aGUgY29ycmVjdCB3YXkuIFNvcnJ5LCBpZiB0aGlzIGNhdXNlZA0KYW55IGluY29udmVu
aWVuY2UgdG8gYW55bW9yZSBpbmNsdWRpbmcgdGhlIE1BSU5UQUlORVIgb2YgYG5ldGRldmANCkkg
d291bGQgaGF2ZSBjYXVnaHQgdGhpcyBtdWNoIGVhcmxpZXIgaGFkIEkgYmVlbiBmb2xsb3dpbmcg
dGhlIE1MIGNsb3NlbHkNCmJ1dCB1bmZvcnR1bmF0ZWx5IEkndmUgbm90IGJlZW4gaW4gdG91Y2gg
Zm9yIGxvbmcuDQoNClRoYW5rcyBmb3IgdGhlIGBudWRnZWAgdGhvdWdoIPCfmIoNCg0KQ2hlZXJz
DQpTYWxpbC4NCg0KDQo+ICANCj4gIFRoYW5rcywNCj4gIFJvYmluLg0KDQo=

