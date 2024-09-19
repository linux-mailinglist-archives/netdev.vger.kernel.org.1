Return-Path: <netdev+bounces-128902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D697C615
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF27281E8C
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC881991D0;
	Thu, 19 Sep 2024 08:42:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79E1990C1
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735367; cv=none; b=oXRwLgnnH70vnbkHvnzfLqvSVsNM8JPW5vzMry6b22oCIXcZ+w3XqRiZw8griw7t/eLvM/z2azJCG4w/88/niCdCbWhNa+AFrVKZ98nGmv1U2WkdD7LjevimkBts2GN82n+/4Tn6N3Wj8pNyBgDxBGQvHfH6OF8p5xbhdtjPrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735367; c=relaxed/simple;
	bh=YvVRopY5m2rLxyTiLQzQUKKHIUlbSWq4wZLpxmiPzR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oJH47gijf5nkGneUOkEmcECnBpO8XcPyah2IeXrm/Aazo9Iay9112K34xBj6VDX1IETDsd/JuvTX2/Hpjb3raS5kquWmNpRL4V+1L88jHB66EHbq/bxmWj5FXj10QzNrI7ZW9KkdzMuB0FjJG6IV+3HfsTHSqwcB8yfplitFL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X8TXS721Wz2QTwS;
	Thu, 19 Sep 2024 16:42:00 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 501001402DE;
	Thu, 19 Sep 2024 16:42:40 +0800 (CST)
Received: from kwepemm000018.china.huawei.com (7.193.23.4) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 16:42:39 +0800
Received: from kwepemm000018.china.huawei.com ([7.193.23.4]) by
 kwepemm000018.china.huawei.com ([7.193.23.4]) with mapi id 15.01.2507.039;
 Thu, 19 Sep 2024 16:42:39 +0800
From: chengyechun <chengyechun1@huawei.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Jay Vosburgh <j.vosburgh@gmail.com>, =?gb2312?B?o6xBbmR5IEdvc3BvZGFyZWs=?=
	<andy@greyhouse.net>
Subject: =?gb2312?B?tPC4tDogW0Rpc2N1c3NdUXVlc3Rpb25zIGFib3V0IGFjdGl2ZSBzbGF2ZSBz?=
 =?gb2312?Q?elect_in_bonding_8023ad?=
Thread-Topic: [Discuss]Questions about active slave select in bonding 8023ad
Thread-Index: AdsKZKjErjnqndRMTZCIcmgDUhEG9gACy1PA
Date: Thu, 19 Sep 2024 08:42:39 +0000
Message-ID: <b2785db6fbe9421ca6510ca92ddfa650@huawei.com>
References: <c464627d07434469b363134ad10e3b4c@huawei.com>
In-Reply-To: <c464627d07434469b363134ad10e3b4c@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVyZSBpcyBwYXRjaDoNCg0KU3ViamVjdDogW1BBVENIXSBib25kaW5nOiBlbmFibGUgYmVzdCBz
bGF2ZSBhZnRlciBzd2l0Y2ggdW5kZXIgY29uZGl0aW9uIDNhDQotLS0NCmRyaXZlcnMvbmV0L2Jv
bmRpbmcvYm9uZF8zYWQuYyB8IDIgKysNCjEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF8zYWQuYyBiL2RyaXZlcnMv
bmV0L2JvbmRpbmcvYm9uZF8zYWQuYw0KaW5kZXggYWUwMzkzZGZmLi44NDk0NDIwZWQgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfM2FkLmMNCisrKyBiL2RyaXZlcnMvbmV0
L2JvbmRpbmcvYm9uZF8zYWQuYw0KQEAgLTE4MTksNiArMTgxOSw4IEBAIHN0YXRpYyB2b2lkIGFk
X2FnZ19zZWxlY3Rpb25fbG9naWMoc3RydWN0IGFnZ3JlZ2F0b3IgKmFnZywNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgX19kaXNhYmxlX3BvcnQocG9ydCk7DQogICAgICAgICAgICAg
ICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgfQ0KKyAgICAgICAgICAgICAgIHBvcnQgPSBi
ZXN0LT5sYWdfcG9ydHM7DQorICAgICAgICAgICAgICAgX19lbmJhbGVfcG9ydChwb3J0KTsNCiAg
ICAgICAgICAgICAgICAvKiBTbGF2ZSBhcnJheSBuZWVkcyB1cGRhdGUuICovDQogICAgICAgICAg
ICAgICAgKnVwZGF0ZV9zbGF2ZV9hcnIgPSB0cnVlOw0KICAgICAgICB9DQotLQ0KDQotLS0tLdPK
vP7Urbz+LS0tLS0NCreivP7IyzogY2hlbmd5ZWNodW4gDQq3osvNyrG85DogMjAyNMTqOdTCMTnI
1SAxNToyMg0KytW8/sjLOiAnbmV0ZGV2QHZnZXIua2VybmVsLm9yZycgPG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc+DQqzrcvNOiAnSmF5IFZvc2J1cmdoJyA8ai52b3NidXJnaEBnbWFpbC5jb20+OyAn
o6xBbmR5IEdvc3BvZGFyZWsnIDxhbmR5QGdyZXlob3VzZS5uZXQ+DQrW98ziOiBbRGlzY3Vzc11R
dWVzdGlvbnMgYWJvdXQgYWN0aXZlIHNsYXZlIHNlbGVjdCBpbiBib25kaW5nIDgwMjNhZA0KDQpI
aSBhbGwsDQpSZWNlbnRseaOsSSdtIGhhdmluZyBhIHByb2JsZW0gc3RhcnRpbmcgYm9uZC4gSXQn
cyBhbiBvY2Nhc2lvbmFsIHByb2JsZW0uDQpBZnRlciB0aGUgc2xhdmUgYW5kIGJvbmQgYXJlIGNv
bmZpZ3VyZWQsIHRoZSBuZXR3b3JrIGZhaWxzIHRvIGJlIHJlc3RhcnRlZC4gVGhlIGZhaWx1cmUg
Y2F1c2UgaXMgYXMgZm9sbG93czoNCqGwL2V0Yy9zeXNjb25maWcvbmV0d29yay1zY3JpcHRzL2lm
dXAtZXRoWzI3NDcxMjldOiBFcnJvciwgc29tZSBvdGhlciBob3N0ICgpIGFscmVhZHkgdXNlcyBh
ZGRyZXNzIDEuMS4xLjM5LqGxDQpXaGVuIHRoZSBuZXR3b3JrIHVzZXMgYXJwaW5nIHRvIGNoZWNr
IHdoZXRoZXIgYW4gSVAgYWRkcmVzcyBjb25mbGljdCBvY2N1cnMsIGFuIGVycm9yIG9jY3Vycywg
YnV0IHRoZSBJUCBhZGRyZXNzIGNvbmZsaWN0IGlzIG5vdCBjYXVzZWQuIHRoaXMgaXMgdmVyeSBz
dHJhbmdlLg0KVGhlIGtlcm5lbCB2ZXJzaW9uIDUuMTAgaXMgdXNlZC4gVGhlIGJvbmQgY29uZmln
dXJhdGlvbiBpcyBhcyBmb2xsb3dzOg0KDQpCT05ESU5HX09QVFM9J21vZGU9NCBtaWltb249MTAw
IGxhY3BfcmF0ZT1mYXN0IHhtaXRfaGFzaF9wb2xpY3k9bGF5ZXIzKzQnDQpUWVBFPUJvbmQNCkJP
TkRJTkdfTUFTVEVSPXllcw0KQk9PVFBST1RPPXN0YXRpYw0KTk1fQ09OVFJPTExFRD1ubw0KSVBW
NF9GQUlMVVJFX0ZBVEFMPW5vDQpJUFY2SU5JVD15ZXMNCklQVjZfQVVUT0NPTkY9eWVzDQpJUFY2
X0RFRlJPVVRFPXllcw0KSVBWNl9GQUlMVVJFX0ZBVEFMPW5vDQpJUFY2X0FERFJfR0VOX01PREU9
c3RhYmxlLXByaXZhY3kNCk5BTUU9Ym9uZDANCkRFVklDRT1ib25kMA0KT05CT09UPXllcw0KSVBB
RERSPTEuMS4xLjM4DQpORVRNQVNLPTI1NS4yNTUuMC4wDQpJUFY2QUREUj0xOjE6MTo6MzkvNjQN
Cg0KVGhlIHNsYXZlIGNvbmZpZ3VyYXRpb24gaXMgYXMgZm9sbG93czogYW5kIEkgaGF2ZSBmb3Vy
IHNpbWlsYXIgc2xhdmVzIGVucDEzczAsZW5wMTRzMCxlbnAxNXMwDQoNCk5BTUU9ZW5wMTJzMA0K
REVWSUNFPWVucDEyczANCkJPT1RQUk9UTz1ub25lDQpPTkJPT1Q9eWVzDQpVU0VSQ1RMPW5vDQpO
TV9DT05UUk9MTEVEPW5vDQpNQVNURVI9Ym9uZDANClNMQVZFPXllcw0KSVBWNklOSVQ9eWVzDQpJ
UFY2X0FVVE9DT05GPXllcw0KSVBWNl9ERUZST1VURT15ZXMNCklQVjZfRkFJTFVSRV9GQVRBTD1u
bw0KDQpBZnRlciBJIGRpc2NvdmVyZWQgdGhpcyBwcm9ibGVtLCBJIHJlc3RhcnRlZCB0aGUgbmV0
d29yayBtdWx0aXBsZSB0aW1lcyBhbmQgaXQgYWx3YXlzIGhhcHBlbmVkIG9uY2Ugb3IgdHdpY2Uu
DQpBZnRlciBzb21lIGRlYnVnZ2luZywgaXQgaXMgZm91bmQgdGhhdCB0aGUgYm9uZCBpbnRlcmZh
Y2UgZG9lcyBub3QgaGF2ZSBhbiBhdmFpbGFibGUgc2xhdmUgd2hlbiB0aGUgYXJwaW5nIHBhY2tl
dCBpcyBzZW50LiBBcyBhIHJlc3VsdCwgdGhlIGFycGluZyBwYWNrZXQgZmFpbHMgdG8gYmUgc2Vu
dC4NCldoZW4gdGhlIHByb2JsZW0gb2NjdXJzLCB0aGUgYWN0aXZlIHNsYXZlIG5vZGUgaXMgc3dp
dGNoZWQgZnJvbSBlbnAxMnMwIHRvIGVucDEzczAuIEhvd2V2ZXIsIHRoZSBiYWNrdXAgb2YgZW5w
MTNzMCBpcyBub3QgY2hhbmdlZCBmcm9tIDEgdG8gMCBpbW1lZGlhdGVseSBhZnRlciB0aGUgc3dp
dGNob3ZlciBpcyBjb21wbGV0ZS4gVGhpcyBpcyBhIG1lY2hhbmlzbSBvciBidWc/DQoNCkFmdGVy
IHRoaW5raW5nIGFib3V0IGl0LCBJIGhhdmUgYSBkb3VidCBhYm91dCB0aGUgc2VsZWN0IG9mIGFj
dGl2ZSBzbGF2ZS4gSW4gdGhlIGFkX2FnZ19zZWxlY3Rpb25fdGVzdCBmdW5jdGlvbiwgaWYgY29u
ZGl0aW9uIDNhIGlzIG1ldCwgdGhhdCBpcywgaWYgKF9fYWdnX2hhc19wYXJ0bmVyKGN1cnIpICYm
ICFfX2FnZ19oYXNfcGFydG5lcihiZXN0KSmjrGFuZCBhZnRlciB0aGUgYWN0aXZlIHNsYXZlIHN3
aXRjaCBpcyBzdWNjZXNzZnVsLCB3aHkgbm90IGVuYWJsZV9wb3J0IHRoZSBiZXN0IHNsYXZlIGlu
IGFkX2FnZ19zZWxlY3Rpb25fbG9naWM/DQo=

