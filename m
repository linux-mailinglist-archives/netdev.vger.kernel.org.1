Return-Path: <netdev+bounces-141482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441BA9BB185
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0042728198C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E781B218D;
	Mon,  4 Nov 2024 10:50:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2F1AF4EE;
	Mon,  4 Nov 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717444; cv=none; b=cIfCF5gVZnIuCBQe1QfcEiqW/y/8f7fMn1tnUPGpOwlSEmVwIFh2FX30aSf59JTkAEorNXF+MzHpL3XOoCn8KxYzu7u7hisixqFjwKzOl8ahXJDwld5NxIfuDdW2Nx3I1w3dhpYAwaoGm402qFQ20IWarQ8OrPhcq99CDMKxdaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717444; c=relaxed/simple;
	bh=tDUPqFlzUQ349uAn3DvY3us+uvn8X20tEegN8qRe5OI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ddh2aG+6TaZvjhQ+SGTMX3bKn8jcVoGj3USzCI6iEum/2lS7k6RwYkIfnEaZM8aGbbKRt3hVk/Py92HQqtERqPa6uaw3oS6Zw2oi9/iv2Boufitf688ViglmxX08hAlOPD/fb1CBMNJ7Y5VIP3JTA5eMWo/IoMi/HeySAHR4V8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xhp8Z3CZ3z6K69D;
	Mon,  4 Nov 2024 18:47:58 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 08D1E140AB8;
	Mon,  4 Nov 2024 18:50:39 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 11:50:38 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 4 Nov 2024 11:50:38 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Salil Mehta <salil.mehta@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@kernel.org>, "shenjian (K)" <shenjian15@huawei.com>
CC: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, Joerg Roedel
	<jroedel@suse.de>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, shaojijie <shaojijie@huawei.com>, wangpeiyang
	<wangpeiyang1@huawei.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT dependency
Thread-Topic: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT dependency
Thread-Index: AQHbLpKYY9Lsz1VxeUenvFuoDgyBFLKm2vEAgAASuSCAAANu4A==
Date: Mon, 4 Nov 2024 10:50:38 +0000
Message-ID: <a94f95bd661c4978bb843c8a1af73818@huawei.com>
References: <20241104082129.3142694-1-arnd@kernel.org>
	<069c9838-b781-4012-934a-d2626fa78212@arm.com>
 <96df804b6d9d467391fda27d90b5227c@huawei.com>
In-Reply-To: <96df804b6d9d467391fda27d90b5227c@huawei.com>
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

PiAgRnJvbTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICBTZW50OiBN
b25kYXksIE5vdmVtYmVyIDQsIDIwMjQgMTA6NDEgQU0NCj4gIFRvOiBSb2JpbiBNdXJwaHkgPHJv
YmluLm11cnBoeUBhcm0uY29tPjsgQXJuZCBCZXJnbWFubg0KPiAgPGFybmRAa2VybmVsLm9yZz47
IHNoZW5qaWFuIChLKSA8c2hlbmppYW4xNUBodWF3ZWkuY29tPg0KPiAgDQo+ICBISSBSb2JpbiwN
Cj4gIA0KPiAgPiAgRnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4g
ID4gIFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAyNCAxMDoyOSBBTQ0KPiAgPiAgVG86IEFy
bmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz47IHNoZW5qaWFuIChLKQ0KPiAgPiA8c2hlbmpp
YW4xNUBodWF3ZWkuY29tPjsgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+
ICA+ICBDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IFdpbGwgRGVhY29uIDx3aWxs
QGtlcm5lbC5vcmc+Ow0KPiAgPiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT47IGlvbW11
QGxpc3RzLmxpbnV4LmRldjsgQW5kcmV3IEx1bm4NCj4gID4gPGFuZHJldytuZXRkZXZAbHVubi5j
aD47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47DQo+ICBFcmljDQo+ICA+
IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJu
ZWwub3JnPjsNCj4gID4gUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgc2hhb2ppamll
IDxzaGFvamlqaWVAaHVhd2VpLmNvbT47DQo+ICA+IHdhbmdwZWl5YW5nIDx3YW5ncGVpeWFuZzFA
aHVhd2VpLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+ICA+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gID4gIFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFtuZXQtbmV4dF0gbmV0
OiBobnMzOiBhZGQgSU9NTVVfU1VQUE9SVA0KPiAgPiBkZXBlbmRlbmN5DQo+ICA+DQo+ICA+ICBP
biAyMDI0LTExLTA0IDg6MjEgYW0sIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+ICA+ICA+IEZyb206
IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+ICA+ICA+IFRoZSBobnMzIGRyaXZlciBzdGFy
dGVkDQo+ICA+IGZpbGxpbmcgaW9tbXVfaW90bGJfZ2F0aGVyIHN0cnVjdHVyZXMgaXRzZWxmLCAg
PiB3aGljaCByZXF1aXJlcw0KPiAgPiBDT05GSUdfSU9NTVVfU1VQUE9SVCBpcyBlbmFibGVkOg0K
PiAgPiAgPg0KPiAgPiAgPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMz
X2VuZXQuYzogSW4gZnVuY3Rpb24NCj4gID4gICdobnMzX2RtYV9tYXBfc3luYyc6DQo+ICA+ICA+
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5ldC5jOjM5NToxNDog
ZXJyb3I6DQo+ICA+ICdzdHJ1Y3QgIGlvbW11X2lvdGxiX2dhdGhlcicgaGFzIG5vIG1lbWJlciBu
YW1lZCAnc3RhcnQnDQo+ICA+ICA+ICAgIDM5NSB8ICBpb3RsYl9nYXRoZXIuc3RhcnQgPSBpb3Zh
Ow0KPiAgPiAgPiAgICAgICAgfCAgICAgICAgICAgICAgXg0KPiAgPiAgPiBkcml2ZXJzL25ldC9l
dGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2VuZXQuYzozOTY6MTQ6IGVycm9yOg0KPiAgPiAn
c3RydWN0ICBpb21tdV9pb3RsYl9nYXRoZXInIGhhcyBubyBtZW1iZXIgbmFtZWQgJ2VuZCcNCj4g
ID4gID4gICAgMzk2IHwgIGlvdGxiX2dhdGhlci5lbmQgPSBpb3ZhICsgZ3JhbnVsZSAtIDE7DQo+
ICA+ICA+ICAgICAgICB8ICAgICAgICAgICAgICBeDQo+ICA+ICA+IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5ldC5jOjM5NzoxNDogZXJyb3I6DQo+ICA+ICdzdHJ1
Y3QgIGlvbW11X2lvdGxiX2dhdGhlcicgaGFzIG5vIG1lbWJlciBuYW1lZCAncGdzaXplJw0KPiAg
PiAgPiAgICAzOTcgfCAgaW90bGJfZ2F0aGVyLnBnc2l6ZSA9IGdyYW51bGU7DQo+ICA+ICA+ICAg
ICAgICB8ICAgICAgICAgICAgICBeDQo+ICA+ICA+DQo+ICA+ICA+IEFkZCBhIEtjb25maWcgZGVw
ZW5kZW5jeSB0byBtYWtlIGl0IGJ1aWxkIGluIHJhbmRvbSBjb25maWd1cmF0aW9ucy4NCj4gID4g
ID4NCj4gID4gID4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+ICA+ICA+IENj
OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NCj4gID4gID4gQ2M6IFJvYmluIE11cnBo
eSA8cm9iaW4ubXVycGh5QGFybS5jb20+ICA+IENjOg0KPiAgPiBpb21tdUBsaXN0cy5saW51eC5k
ZXYgID4gRml4ZXM6IGYyYzE0ODk5Y2FiYSAoIm5ldDogaG5zMzogYWRkIHN5bmMNCj4gID4gY29t
bWFuZCB0byBzeW5jIGlvLXBndGFibGUiKSAgPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5u
DQo+ICA+IDxhcm5kQGFybmRiLmRlPiAgPiAtLS0gID4gSSBub3RpY2VkIHRoYXQgbm8gb3RoZXIg
ZHJpdmVyIGRvZXMgdGhpcywgc28NCj4gID4gaXQgd291bGQgYmUgZ29vZCB0byBoYXZlICA+IGEg
Y29uZmlybWF0aW9uIGZyb20gdGhlIGlvbW11IG1haW50YWluZXJzDQo+ICA+IHRoYXQgdGhpcyBp
cyBob3cgdGhlICA+IGludGVyZmFjZSBhbmQgdGhlIGRlcGVuZGVuY3kgaXMgaW50ZW5kZWQgdG8g
YmUNCj4gID4gdXNlZC4NCj4gID4NCj4gID4gIFdURiBpcyB0aGF0IHBhdGNoIGRvaW5nIT8gTm8s
IHJhbmRvbSBkZXZpY2UgZHJpdmVycyBzaG91bGQgYWJzb2x1dGVseQ0KPiAgPiBub3QgIGJlIHBv
a2luZyBpbnRvIElPTU1VIGRyaXZlciBpbnRlcm5hbHMsIHRoaXMgaXMgZWdyZWdpb3VzbHkgd3Jv
bmcNCj4gID4gYW5kIHRoZSAgY29ycmVjdCBhY3Rpb24gaXMgdG8gZHJvcCBpdCBlbnRpcmVseS4N
Cj4gIA0KPiAgDQo+ICBBYnNvbHV0ZWx5IGFncmVlIHdpdGggaXQuIFNvcnJ5IEkgaGF2ZW4ndCBi
ZWVuIGluIHRvdWNoIGZvciBxdWl0ZSBzb21lIHRpbWUuDQo+ICBMZXQgbWUgY2F0Y2ggdGhlIHdo
b2xlIHN0b3J5LiAgRmVlbCBmcmVlIHRvIGRyb3AgdGhpcyBwYXRjaC4NCg0KDQpKdXN0IHRvIG1h
a2UgaXQgY2xlYXIgSSBtZWFudCB0aGUgY3VscHJpdCBwYXRjaDoNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL25ldGRldi8yMDI0MTAyNTA5MjkzOC4yOTEyOTU4LTMtc2hhb2ppamllQGh1YXdlaS5j
b20vDQoNCg0KPiAgDQo+ICBUaGFua3MNCj4gIFNhbGlsLg0KPiAgDQo+ICA+DQo+ICA+ICBUaGFu
a3MsDQo+ICA+ICBSb2Jpbi4NCj4gID4NCj4gID4gID4gLS0tDQo+ICA+ICA+ICAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaGlzaWxpY29uL0tjb25maWcgfCAxICsNCj4gID4gID4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCj4gID4gID4NCj4gID4gID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9LY29uZmlnDQo+ICA+ICA+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaGlzaWxpY29uL0tjb25maWcNCj4gID4gID4gaW5kZXggNjUzMDJjNDFiZmIxLi43
OTBlZmM4ZDJkZTYgMTAwNjQ0ICA+IC0tLQ0KPiAgPiBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2hp
c2lsaWNvbi9LY29uZmlnDQo+ICA+ICA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2ls
aWNvbi9LY29uZmlnDQo+ICA+ICA+IEBAIC05MSw2ICs5MSw3IEBAIGNvbmZpZyBITlNfRU5FVA0K
PiAgPiAgPiAgIGNvbmZpZyBITlMzDQo+ICA+ICA+ICAgCXRyaXN0YXRlICJIaXNpbGljb24gTmV0
d29yayBTdWJzeXN0ZW0gU3VwcG9ydCBITlMzIChGcmFtZXdvcmspIg0KPiAgPiAgPiAgIAlkZXBl
bmRzIG9uIFBDSQ0KPiAgPiAgPiArCWRlcGVuZHMgb24gSU9NTVVfU1VQUE9SVA0KPiAgPiAgPiAg
IAlzZWxlY3QgTkVUX0RFVkxJTksNCj4gID4gID4gICAJc2VsZWN0IFBBR0VfUE9PTA0KPiAgPiAg
PiAgIAloZWxwDQo+ICA+DQoNCg==

