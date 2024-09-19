Return-Path: <netdev+bounces-128883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89CF97C4CB
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 09:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59800B213C6
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 07:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F41922DF;
	Thu, 19 Sep 2024 07:22:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A722098
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730551; cv=none; b=Pz8e2VzjObEIzOzhgA98dAMgiv0fAmwHmrIgbmqZFvThrLqJvNzm9IpS0ztVxDEnD1I0Yqga+S1TrLBNkiyYb/+YJEiGLAdaPRt5gAecMreG5WPBNOT0MHsHZSo+Tp4g/bWRQeFbb+7bx374u2OOCl4vStWyjTuBgvpw9Hnp1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730551; c=relaxed/simple;
	bh=k/u3oo65fD534gkdUGpk8YrYHrLidiMaY1KBvybQwF0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P4gR4l7jXX0TPJcnvajcv0lOfiyCplKzEJ4i+anIFYeFGhjgOjHttkRVGyNNOd52FWe1gSTVZ+EVBiI9B8navcU4ruwHfE/BTA9wR6v2hgDjpYoTTY2rgkeWW7U5lh1lBlDSy9WEGKqxB/P9QtpAlf2/BH9+T3pyQ3lKuwQLGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X8Rmc1kcgz1ym26;
	Thu, 19 Sep 2024 15:22:24 +0800 (CST)
Received: from kwepemm000019.china.huawei.com (unknown [7.193.23.135])
	by mail.maildlp.com (Postfix) with ESMTPS id D51A214022F;
	Thu, 19 Sep 2024 15:22:23 +0800 (CST)
Received: from kwepemm000018.china.huawei.com (7.193.23.4) by
 kwepemm000019.china.huawei.com (7.193.23.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 15:22:23 +0800
Received: from kwepemm000018.china.huawei.com ([7.193.23.4]) by
 kwepemm000018.china.huawei.com ([7.193.23.4]) with mapi id 15.01.2507.039;
 Thu, 19 Sep 2024 15:22:23 +0800
From: chengyechun <chengyechun1@huawei.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Jay Vosburgh <j.vosburgh@gmail.com>, =?gb2312?B?o6xBbmR5IEdvc3BvZGFyZWs=?=
	<andy@greyhouse.net>
Subject: [Discuss]Questions about active slave select in bonding 8023ad
Thread-Topic: [Discuss]Questions about active slave select in bonding 8023ad
Thread-Index: AdsKZKjErjnqndRMTZCIcmgDUhEG9g==
Date: Thu, 19 Sep 2024 07:22:23 +0000
Message-ID: <c464627d07434469b363134ad10e3b4c@huawei.com>
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

SGkgYWxsLA0KUmVjZW50bHmjrEknbSBoYXZpbmcgYSBwcm9ibGVtIHN0YXJ0aW5nIGJvbmQuIEl0
J3MgYW4gb2NjYXNpb25hbCBwcm9ibGVtLg0KQWZ0ZXIgdGhlIHNsYXZlIGFuZCBib25kIGFyZSBj
b25maWd1cmVkLCB0aGUgbmV0d29yayBmYWlscyB0byBiZSByZXN0YXJ0ZWQuIFRoZSBmYWlsdXJl
IGNhdXNlIGlzIGFzIGZvbGxvd3M6DQqhsC9ldGMvc3lzY29uZmlnL25ldHdvcmstc2NyaXB0cy9p
ZnVwLWV0aFsyNzQ3MTI5XTogRXJyb3IsIHNvbWUgb3RoZXIgaG9zdCAoKSBhbHJlYWR5IHVzZXMg
YWRkcmVzcyAxLjEuMS4zOS6hsQ0KV2hlbiB0aGUgbmV0d29yayB1c2VzIGFycGluZyB0byBjaGVj
ayB3aGV0aGVyIGFuIElQIGFkZHJlc3MgY29uZmxpY3Qgb2NjdXJzLCBhbiBlcnJvciBvY2N1cnMs
IGJ1dCB0aGUgSVAgYWRkcmVzcyBjb25mbGljdCBpcyBub3QgY2F1c2VkLiB0aGlzIGlzIHZlcnkg
c3RyYW5nZS4NClRoZSBrZXJuZWwgdmVyc2lvbiA1LjEwIGlzIHVzZWQuIFRoZSBib25kIGNvbmZp
Z3VyYXRpb24gaXMgYXMgZm9sbG93czoNCg0KQk9ORElOR19PUFRTPSdtb2RlPTQgbWlpbW9uPTEw
MCBsYWNwX3JhdGU9ZmFzdCB4bWl0X2hhc2hfcG9saWN5PWxheWVyMys0Jw0KVFlQRT1Cb25kDQpC
T05ESU5HX01BU1RFUj15ZXMNCkJPT1RQUk9UTz1zdGF0aWMNCk5NX0NPTlRST0xMRUQ9bm8NCklQ
VjRfRkFJTFVSRV9GQVRBTD1ubw0KSVBWNklOSVQ9eWVzDQpJUFY2X0FVVE9DT05GPXllcw0KSVBW
Nl9ERUZST1VURT15ZXMNCklQVjZfRkFJTFVSRV9GQVRBTD1ubw0KSVBWNl9BRERSX0dFTl9NT0RF
PXN0YWJsZS1wcml2YWN5DQpOQU1FPWJvbmQwDQpERVZJQ0U9Ym9uZDANCk9OQk9PVD15ZXMNCklQ
QUREUj0xLjEuMS4zOA0KTkVUTUFTSz0yNTUuMjU1LjAuMA0KSVBWNkFERFI9MToxOjE6OjM5LzY0
DQoNClRoZSBzbGF2ZSBjb25maWd1cmF0aW9uIGlzIGFzIGZvbGxvd3M6IGFuZCBJIGhhdmUgZm91
ciBzaW1pbGFyIHNsYXZlcyBlbnAxM3MwLGVucDE0czAsZW5wMTVzMA0KDQpOQU1FPWVucDEyczAN
CkRFVklDRT1lbnAxMnMwDQpCT09UUFJPVE89bm9uZQ0KT05CT09UPXllcw0KVVNFUkNUTD1ubw0K
Tk1fQ09OVFJPTExFRD1ubw0KTUFTVEVSPWJvbmQwDQpTTEFWRT15ZXMNCklQVjZJTklUPXllcw0K
SVBWNl9BVVRPQ09ORj15ZXMNCklQVjZfREVGUk9VVEU9eWVzDQpJUFY2X0ZBSUxVUkVfRkFUQUw9
bm8NCg0KQWZ0ZXIgSSBkaXNjb3ZlcmVkIHRoaXMgcHJvYmxlbSwgSSByZXN0YXJ0ZWQgdGhlIG5l
dHdvcmsgbXVsdGlwbGUgdGltZXMgYW5kIGl0IGFsd2F5cyBoYXBwZW5lZCBvbmNlIG9yIHR3aWNl
Lg0KQWZ0ZXIgc29tZSBkZWJ1Z2dpbmcsIGl0IGlzIGZvdW5kIHRoYXQgdGhlIGJvbmQgaW50ZXJm
YWNlIGRvZXMgbm90IGhhdmUgYW4gYXZhaWxhYmxlIHNsYXZlIHdoZW4gdGhlIGFycGluZyBwYWNr
ZXQgaXMgc2VudC4gQXMgYSByZXN1bHQsIHRoZSBhcnBpbmcgcGFja2V0IGZhaWxzIHRvIGJlIHNl
bnQuDQpXaGVuIHRoZSBwcm9ibGVtIG9jY3VycywgdGhlIGFjdGl2ZSBzbGF2ZSBub2RlIGlzIHN3
aXRjaGVkIGZyb20gZW5wMTJzMCB0byBlbnAxM3MwLiBIb3dldmVyLCB0aGUgYmFja3VwIG9mIGVu
cDEzczAgaXMgbm90IGNoYW5nZWQgZnJvbSAxIHRvIDAgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIHN3
aXRjaG92ZXIgaXMgY29tcGxldGUuIFRoaXMgaXMgYSBtZWNoYW5pc20gb3IgYnVnPw0KDQpBZnRl
ciB0aGlua2luZyBhYm91dCBpdCwgSSBoYXZlIGEgZG91YnQgYWJvdXQgdGhlIHNlbGVjdCBvZiBh
Y3RpdmUgc2xhdmUuIEluIHRoZSBhZF9hZ2dfc2VsZWN0aW9uX3Rlc3QgZnVuY3Rpb24sIGlmIGNv
bmRpdGlvbiAzYSBpcyBtZXQsIHRoYXQgaXMsIGlmIChfX2FnZ19oYXNfcGFydG5lcihjdXJyKSAm
JiAhX19hZ2dfaGFzX3BhcnRuZXIoYmVzdCkpo6xhbmQgYWZ0ZXIgdGhlIGFjdGl2ZSBzbGF2ZSBz
d2l0Y2ggaXMgc3VjY2Vzc2Z1bCwgd2h5IG5vdCBlbmFibGVfcG9ydCB0aGUgYmVzdCBzbGF2ZSBp
biBhZF9hZ2dfc2VsZWN0aW9uX2xvZ2ljPw0K

