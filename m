Return-Path: <netdev+bounces-138112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D609AC000
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3329A28131D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D96150980;
	Wed, 23 Oct 2024 07:18:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2464487BE;
	Wed, 23 Oct 2024 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667925; cv=none; b=hfhZ9McT3m0E/jUdZWvxp8N8w1wdfWbLeCm4Uumdi5VYCllCQH39WXEQLFwBLAHR5MhSaQXR+Vo72mU6As8KqOInDcvk2Eiu7Jmgy0CZ9yoSnw3Sc4qdjO2S4MwhCZ3AjF9L1ebLAO1IaO70a7VfqaTUoWYimGt2+KiaYQoXJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667925; c=relaxed/simple;
	bh=UpZL2aAYHgU3lIDNh+bWgrhIqQYbxf7LboRZyyhSAzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ufWHRvzIh6pO9OAwOdYP8VrI5AOruTbgpm5bbVOmHc3asag+rby8p+FZwCx5Y3hZUKz2aNltzYLoWrk1y6CLZJMN7AF01w4Xu5FtgNrOuFvLFeGmbM63OwMRVpM8tOuWIuKHUq3s9iZZBpRPWs7sl5HUprJaeLU99CGFXNUPcxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XYL4c29V1z1ynTm;
	Wed, 23 Oct 2024 15:18:40 +0800 (CST)
Received: from dggpemf100002.china.huawei.com (unknown [7.185.36.19])
	by mail.maildlp.com (Postfix) with ESMTPS id 13F9D1A0188;
	Wed, 23 Oct 2024 15:18:33 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (7.202.181.32) by
 dggpemf100002.china.huawei.com (7.185.36.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 15:18:32 +0800
Received: from kwepemg200005.china.huawei.com ([7.202.181.32]) by
 kwepemg200005.china.huawei.com ([7.202.181.32]) with mapi id 15.02.1544.011;
 Wed, 23 Oct 2024 15:18:32 +0800
From: "wangliang (CI)" <wangliang74@huawei.com>
To: Eric Dumazet <edumazet@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"idosch@nvidia.com" <idosch@nvidia.com>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"lucien.xin@gmail.com" <lucien.xin@gmail.com>, yuehaibing
	<yuehaibing@huawei.com>, zhangchangzhong <zhangchangzhong@huawei.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggbmV0IHYyXSBuZXQ6IGZpeCBjcmFzaCB3aGVuIGNv?=
 =?utf-8?B?bmZpZyBzbWFsbCBnc29fbWF4X3NpemUvZ3NvX2lwdjRfbWF4X3NpemU=?=
Thread-Topic: [PATCH net v2] net: fix crash when config small
 gso_max_size/gso_ipv4_max_size
Thread-Index: AQHbJPx7zpqsHF8R1U2HOQKbqj44u7KTXbAAgACPsaA=
Date: Wed, 23 Oct 2024 07:18:32 +0000
Message-ID: <c9abbcbe45e845a59869d01253db6dd0@huawei.com>
References: <20241023035213.517386-1-wangliang74@huawei.com>
 <CANn89iLpMv8E0=VR=nEBB_AJqR74=GbMvZs4NdESpCjBv7x7iA@mail.gmail.com>
In-Reply-To: <CANn89iLpMv8E0=VR=nEBB_AJqR74=GbMvZs4NdESpCjBv7x7iA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
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

VGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBzdWdnZXN0aW9ucyENCg0KLS0tLS3pgq7ku7bl
jp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+
IA0K5Y+R6YCB5pe26Ze0OiAyMDI05bm0MTDmnIgyM+aXpSAxNDo0NA0K5pS25Lu25Lq6OiB3YW5n
bGlhbmcgKENJKSA8d2FuZ2xpYW5nNzRAaHVhd2VpLmNvbT4NCuaKhOmAgTogZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgaWRvc2NoQG52aWRp
YS5jb207IGt1bml5dUBhbWF6b24uY29tOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgZHNh
aGVybkBrZXJuZWwub3JnOyBsdWNpZW4ueGluQGdtYWlsLmNvbTsgeXVlaGFpYmluZyA8eXVlaGFp
YmluZ0BodWF3ZWkuY29tPjsgemhhbmdjaGFuZ3pob25nIDx6aGFuZ2NoYW5nemhvbmdAaHVhd2Vp
LmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCuS4u+mimDogUmU6IFtQQVRDSCBuZXQgdjJdIG5ldDogZml4IGNyYXNoIHdoZW4gY29uZmln
IHNtYWxsIGdzb19tYXhfc2l6ZS9nc29faXB2NF9tYXhfc2l6ZQ0KDQpPbiBXZWQsIE9jdCAyMywg
MjAyNCBhdCA1OjM04oCvQU0gV2FuZyBMaWFuZyA8d2FuZ2xpYW5nNzRAaHVhd2VpLmNvbT4gd3Jv
dGU6DQo+DQo+IENvbmZpZyBhIHNtYWxsIGdzb19tYXhfc2l6ZS9nc29faXB2NF9tYXhfc2l6ZSB3
aWxsIGxlYWQgdG8gYW4gDQo+IHVuZGVyZmxvdyBpbiBza19kc3RfZ3NvX21heF9zaXplKCksIHdo
aWNoIG1heSB0cmlnZ2VyIGEgQlVHX09OIGNyYXNoLCANCj4gYmVjYXVzZSBzay0+c2tfZ3NvX21h
eF9zaXplIHdvdWxkIGJlIG11Y2ggYmlnZ2VyIHRoYW4gZGV2aWNlIGxpbWl0cy4NCj4gQ2FsbCBU
cmFjZToNCj4gdGNwX3dyaXRlX3htaXQNCj4gICAgIHRzb19zZWdzID0gdGNwX2luaXRfdHNvX3Nl
Z3Moc2tiLCBtc3Nfbm93KTsNCj4gICAgICAgICB0Y3Bfc2V0X3NrYl90c29fc2Vncw0KPiAgICAg
ICAgICAgICB0Y3Bfc2tiX3Bjb3VudF9zZXQNCj4gICAgICAgICAgICAgICAgIC8vIHNrYi0+bGVu
ID0gNTI0Mjg4LCBtc3Nfbm93ID0gOA0KPiAgICAgICAgICAgICAgICAgLy8gdTE2IHRzb19zZWdz
ID0gNTI0Mjg4LzggPSA2NTUzNSAtPiAwDQo+ICAgICAgICAgICAgICAgICB0c29fc2VncyA9IERJ
Vl9ST1VORF9VUChza2ItPmxlbiwgbXNzX25vdykNCj4gICAgIEJVR19PTighdHNvX3NlZ3MpDQo+
IEFkZCBjaGVjayBmb3IgdGhlIG1pbmltdW0gdmFsdWUgb2YgZ3NvX21heF9zaXplIGFuZCBnc29f
aXB2NF9tYXhfc2l6ZS4NCj4NCj4gRml4ZXM6IDQ2ZTZiOTkyYzI1MCAoInJ0bmV0bGluazogYWxs
b3cgR1NPIG1heGltdW1zIHRvIGJlIHNldCBvbiANCj4gZGV2aWNlIGNyZWF0aW9uIikNCj4gRml4
ZXM6IDllZWZlZGQ1OGFlMSAoIm5ldDogYWRkIGdzb19pcHY0X21heF9zaXplIGFuZCBncm9faXB2
NF9tYXhfc2l6ZSANCj4gcGVyIGRldmljZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFdhbmcgTGlhbmcg
PHdhbmdsaWFuZzc0QGh1YXdlaS5jb20+DQo+IC0tLQ0KDQpUaGFua3MgZm9yIHRoaXMgZml4ICEN
Cg0KUmV2aWV3ZWQtYnk6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCg0K

