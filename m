Return-Path: <netdev+bounces-141480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3689BB162
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1510F282B24
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41E1B2192;
	Mon,  4 Nov 2024 10:40:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6881B218D;
	Mon,  4 Nov 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716858; cv=none; b=Lkr8mzowOqAC/aQOotoYmg5xeVPqqAx5Qkz8j8W5LHudW3kmvaP9tq1/22wCDknEQUmyDHL6aJpIf2qf2rEqpdG1qO+2Z11TAMU3uLPF3QJjGzLQnC69TmoOL89jLbwp6x2Yeaw8dwa+t3qtfu+y2mSTip7SGXW2j40Dj4I7p2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716858; c=relaxed/simple;
	bh=m6opQSBcWWbuVEdYYZk/8Nf7W4rLK+/ozTtoizYvE0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OR517a00Y/VNEj2f6g1oxl9Vyu6Pwtjzf8uaxcKwYb9sYlyme+XvEO8WFofZgyfinItdD+IacB53QITjOQr6NDp3Q1HN9kw4bqSKRGiq8Tlk5AYPlG2vCTv2secZHaURiHS+vu8u1n+brnMi6p4BKGuAYUpBkGI8evcHF7ELjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xhnv62zP0z1JB6K;
	Mon,  4 Nov 2024 18:36:18 +0800 (CST)
Received: from kwepemk500014.china.huawei.com (unknown [7.202.194.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A50F1A0188;
	Mon,  4 Nov 2024 18:40:52 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemk500014.china.huawei.com (7.202.194.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Nov 2024 18:40:51 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 4 Nov 2024 11:40:49 +0100
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
Thread-Index: AQHbLpKYY9Lsz1VxeUenvFuoDgyBFLKm2vEAgAASuSA=
Date: Mon, 4 Nov 2024 10:40:49 +0000
Message-ID: <96df804b6d9d467391fda27d90b5227c@huawei.com>
References: <20241104082129.3142694-1-arnd@kernel.org>
 <069c9838-b781-4012-934a-d2626fa78212@arm.com>
In-Reply-To: <069c9838-b781-4012-934a-d2626fa78212@arm.com>
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

SEkgUm9iaW4sDQoNCj4gIEZyb206IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+
DQo+ICBTZW50OiBNb25kYXksIE5vdmVtYmVyIDQsIDIwMjQgMTA6MjkgQU0NCj4gIFRvOiBBcm5k
IEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+OyBzaGVuamlhbiAoSykNCj4gIDxzaGVuamlhbjE1
QGh1YXdlaS5jb20+OyBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gIENj
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVs
Lm9yZz47DQo+ICBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT47IGlvbW11QGxpc3RzLmxp
bnV4LmRldjsgQW5kcmV3IEx1bm4NCj4gIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBT
LiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+ICBEdW1hemV0IDxlZHVtYXpl
dEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47DQo+ICBQYW9s
byBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBzaGFvamlqaWUgPHNoYW9qaWppZUBodWF3ZWku
Y29tPjsNCj4gIHdhbmdwZWl5YW5nIDx3YW5ncGVpeWFuZzFAaHVhd2VpLmNvbT47IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7DQo+ICBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ICBTdWJq
ZWN0OiBSZTogW1BBVENIXSBbbmV0LW5leHRdIG5ldDogaG5zMzogYWRkIElPTU1VX1NVUFBPUlQN
Cj4gIGRlcGVuZGVuY3kNCj4gIA0KPiAgT24gMjAyNC0xMS0wNCA4OjIxIGFtLCBBcm5kIEJlcmdt
YW5uIHdyb3RlOg0KPiAgPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiAg
Pg0KPiAgPiBUaGUgaG5zMyBkcml2ZXIgc3RhcnRlZCBmaWxsaW5nIGlvbW11X2lvdGxiX2dhdGhl
ciBzdHJ1Y3R1cmVzIGl0c2VsZiwNCj4gID4gd2hpY2ggcmVxdWlyZXMgQ09ORklHX0lPTU1VX1NV
UFBPUlQgaXMgZW5hYmxlZDoNCj4gID4NCj4gID4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaGlzaWxp
Y29uL2huczMvaG5zM19lbmV0LmM6IEluIGZ1bmN0aW9uDQo+ICAnaG5zM19kbWFfbWFwX3N5bmMn
Og0KPiAgPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2VuZXQuYzoz
OTU6MTQ6IGVycm9yOiAnc3RydWN0DQo+ICBpb21tdV9pb3RsYl9nYXRoZXInIGhhcyBubyBtZW1i
ZXIgbmFtZWQgJ3N0YXJ0Jw0KPiAgPiAgICAzOTUgfCAgaW90bGJfZ2F0aGVyLnN0YXJ0ID0gaW92
YTsNCj4gID4gICAgICAgIHwgICAgICAgICAgICAgIF4NCj4gID4gZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaGlzaWxpY29uL2huczMvaG5zM19lbmV0LmM6Mzk2OjE0OiBlcnJvcjogJ3N0cnVjdA0KPiAg
aW9tbXVfaW90bGJfZ2F0aGVyJyBoYXMgbm8gbWVtYmVyIG5hbWVkICdlbmQnDQo+ICA+ICAgIDM5
NiB8ICBpb3RsYl9nYXRoZXIuZW5kID0gaW92YSArIGdyYW51bGUgLSAxOw0KPiAgPiAgICAgICAg
fCAgICAgICAgICAgICAgXg0KPiAgPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9oaXNpbGljb24vaG5z
My9obnMzX2VuZXQuYzozOTc6MTQ6IGVycm9yOiAnc3RydWN0DQo+ICBpb21tdV9pb3RsYl9nYXRo
ZXInIGhhcyBubyBtZW1iZXIgbmFtZWQgJ3Bnc2l6ZScNCj4gID4gICAgMzk3IHwgIGlvdGxiX2dh
dGhlci5wZ3NpemUgPSBncmFudWxlOw0KPiAgPiAgICAgICAgfCAgICAgICAgICAgICAgXg0KPiAg
Pg0KPiAgPiBBZGQgYSBLY29uZmlnIGRlcGVuZGVuY3kgdG8gbWFrZSBpdCBidWlsZCBpbiByYW5k
b20gY29uZmlndXJhdGlvbnMuDQo+ICA+DQo+ICA+IENjOiBXaWxsIERlYWNvbiA8d2lsbEBrZXJu
ZWwub3JnPg0KPiAgPiBDYzogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+DQo+ICA+IENj
OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiAgPiBDYzogaW9tbXVAbGlz
dHMubGludXguZGV2DQo+ICA+IEZpeGVzOiBmMmMxNDg5OWNhYmEgKCJuZXQ6IGhuczM6IGFkZCBz
eW5jIGNvbW1hbmQgdG8gc3luYyBpby1wZ3RhYmxlIikNCj4gID4gU2lnbmVkLW9mZi1ieTogQXJu
ZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gID4gLS0tDQo+ICA+IEkgbm90aWNlZCB0aGF0
IG5vIG90aGVyIGRyaXZlciBkb2VzIHRoaXMsIHNvIGl0IHdvdWxkIGJlIGdvb2QgdG8gaGF2ZQ0K
PiAgPiBhIGNvbmZpcm1hdGlvbiBmcm9tIHRoZSBpb21tdSBtYWludGFpbmVycyB0aGF0IHRoaXMg
aXMgaG93IHRoZQ0KPiAgPiBpbnRlcmZhY2UgYW5kIHRoZSBkZXBlbmRlbmN5IGlzIGludGVuZGVk
IHRvIGJlIHVzZWQuDQo+ICANCj4gIFdURiBpcyB0aGF0IHBhdGNoIGRvaW5nIT8gTm8sIHJhbmRv
bSBkZXZpY2UgZHJpdmVycyBzaG91bGQgYWJzb2x1dGVseSBub3QNCj4gIGJlIHBva2luZyBpbnRv
IElPTU1VIGRyaXZlciBpbnRlcm5hbHMsIHRoaXMgaXMgZWdyZWdpb3VzbHkgd3JvbmcgYW5kIHRo
ZQ0KPiAgY29ycmVjdCBhY3Rpb24gaXMgdG8gZHJvcCBpdCBlbnRpcmVseS4NCg0KDQpBYnNvbHV0
ZWx5IGFncmVlIHdpdGggaXQuIFNvcnJ5IEkgaGF2ZW4ndCBiZWVuIGluIHRvdWNoIGZvciBxdWl0
ZSBzb21lIHRpbWUuIExldA0KbWUgY2F0Y2ggdGhlIHdob2xlIHN0b3J5LiAgRmVlbCBmcmVlIHRv
IGRyb3AgdGhpcyBwYXRjaC4NCg0KVGhhbmtzDQpTYWxpbC4NCg0KPiAgDQo+ICBUaGFua3MsDQo+
ICBSb2Jpbi4NCj4gIA0KPiAgPiAtLS0NCj4gID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9oaXNp
bGljb24vS2NvbmZpZyB8IDEgKw0KPiAgPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiAgPg0KPiAgPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaGlzaWxpY29u
L0tjb25maWcNCj4gID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9oaXNpbGljb24vS2NvbmZpZw0K
PiAgPiBpbmRleCA2NTMwMmM0MWJmYjEuLjc5MGVmYzhkMmRlNiAxMDA2NDQNCj4gID4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaGlzaWxpY29uL0tjb25maWcNCj4gID4gKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaGlzaWxpY29uL0tjb25maWcNCj4gID4gQEAgLTkxLDYgKzkxLDcgQEAg
Y29uZmlnIEhOU19FTkVUDQo+ICA+ICAgY29uZmlnIEhOUzMNCj4gID4gICAJdHJpc3RhdGUgIkhp
c2lsaWNvbiBOZXR3b3JrIFN1YnN5c3RlbSBTdXBwb3J0IEhOUzMgKEZyYW1ld29yaykiDQo+ICA+
ICAgCWRlcGVuZHMgb24gUENJDQo+ICA+ICsJZGVwZW5kcyBvbiBJT01NVV9TVVBQT1JUDQo+ICA+
ICAgCXNlbGVjdCBORVRfREVWTElOSw0KPiAgPiAgIAlzZWxlY3QgUEFHRV9QT09MDQo+ICA+ICAg
CWhlbHANCj4gIA0KDQo=

