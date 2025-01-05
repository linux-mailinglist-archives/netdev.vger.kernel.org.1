Return-Path: <netdev+bounces-155253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B922A01870
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 08:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488443A35DE
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 07:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0812FB1B;
	Sun,  5 Jan 2025 07:30:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924C5336D;
	Sun,  5 Jan 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736062239; cv=none; b=WNmUPVwDDYZ18flOBmyN43SA7xYK7rrK3DOUHJ/SVaE33r8d3RF7Z94/IbxAQkn0O4JoATXfLwjAwx0HcG4rjDMsvF6Pz6Bafr3lOiek4wDcY/LKcwnWJuXfb0DtxaI9zvuRMWnIn9GBi66R9p5AwVykoIIlW30fxIIMvlONzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736062239; c=relaxed/simple;
	bh=HNe9BFiiNRFRW9DDoyrr+ZG8gM2e9MMFO6tgcFgwI5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/I/ZsoVz6WLKQCT+oRF+chEvCNzGwsFWREcJGol1j2wFezC2hlM3cL12Nt9atXpS9BolEras6yxNbmBXNX2lgA4Bpp7Hqjw/gHee6gDMJbC6ITosHprdSfNrjIxpl+CHytTTt9UJcAvrvRkbjF8Xmy89phbKZ3gAYkpp7eS5L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YQppK0LQcz6M4MD;
	Sun,  5 Jan 2025 15:28:57 +0800 (CST)
Received: from frapeml100004.china.huawei.com (unknown [7.182.85.167])
	by mail.maildlp.com (Postfix) with ESMTPS id 16852140B33;
	Sun,  5 Jan 2025 15:30:27 +0800 (CST)
Received: from frapeml500005.china.huawei.com (7.182.85.13) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 5 Jan 2025 08:30:26 +0100
Received: from frapeml500005.china.huawei.com ([7.182.85.13]) by
 frapeml500005.china.huawei.com ([7.182.85.13]) with mapi id 15.01.2507.039;
 Sun, 5 Jan 2025 08:30:26 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Gongfan (Eric, Chip)" <gongfan1@huawei.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>, Cai Huoqing
	<cai.huoqing@linux.dev>, "Guoxin (D)" <guoxin09@huawei.com>, shenchenyang
	<shenchenyang1@hisilicon.com>, "zhoushuai (A)" <zhoushuai28@huawei.com>,
	"Wulike (Collin)" <wulike1@huawei.com>, "shijing (A)" <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>
Subject: RE: [PATCH net-next v03 0/1] net: hinic3: Add a driver for Huawei 3rd
 gen NIC
Thread-Topic: [PATCH net-next v03 0/1] net: hinic3: Add a driver for Huawei
 3rd gen NIC
Thread-Index: AQHbXEvoj+6B8Sf7+0ymGQKWCbUo3LMDpHGAgAQozAA=
Date: Sun, 5 Jan 2025 07:30:26 +0000
Message-ID: <a8b81321186545708b8babf1805ae7ef@huawei.com>
References: <cover.1735735608.git.gur.stavi@huawei.com>
 <20250102085351.3436779b@kernel.org>
In-Reply-To: <20250102085351.3436779b@kernel.org>
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

PiBPbiBXZWQsIDEgSmFuIDIwMjUgMTU6MDQ6MzAgKzAyMDAgR3VyIFN0YXZpIHdyb3RlOg0KPiAN
Cj4gOigNCj4gDQo+IFRoaXMgdHdvIGRvY3MgYXJlIHJlcXVpcmVkIHJlYWRpbmc6DQo+IA0KPiBo
dHRwczovL2RvY3Mua2VybmVsLm9yZy9uZXh0L21haW50YWluZXIvZmVhdHVyZS1hbmQtZHJpdmVy
LQ0KPiBtYWludGFpbmVycy5odG1sDQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwv
bmV4dC9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2Lmh0bWwNCj4gDQo+IFBsZWFzZSByZWFkIHRo
ZSBtYWlsaW5nIGxpc3QuIFlvdSBwb3N0ZWQgdGhlIHBhdGNoZXMgd2hlbiBuZXQtbmV4dCB3YXMN
Cj4gY2xvc2VkLg0KDQpPSy4gU29ycnkuDQpCdXQgdG9ydmFsZHMvbGludXguZ2l0IHdhcyBhdCBy
YzUuDQpBbmQgbm93IGl0IGlzIGluZGljYXRlZCBhcyBvcGVuOiBodHRwczovL25ldGRldi5ib3Rz
LmxpbnV4LmRldi9uZXQtbmV4dC5odG1sDQpXYXMgbmV0LW5leHQgY2xvc2VkIGZvciB0aGUgaG9s
aWRheXM/DQoNCj4gLS0NCj4gcHctYm90OiBkZWZlcg0KPiBwdi1ib3Q6IGNsb3NlZA0K

