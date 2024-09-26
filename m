Return-Path: <netdev+bounces-129873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F58986A65
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 03:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CEB1C21897
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 01:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4075150990;
	Thu, 26 Sep 2024 01:24:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2A2C18C
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 01:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727313892; cv=none; b=dxvw2r6GaGbupp0/bi47+/jhn+sr6N9P8zVbG/EhEb3Gyhtq/Vi1PFDBZGxMJ5CCCOMdMUG2LQMMt0l6PjsCcb71UBz/eMCntOd8sXDv8ZhMvj9MIdX85PaGgLpRLROqdweHVG02EJX0NG25D0fY/SnJL2WiPyWI4L5PvtIolJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727313892; c=relaxed/simple;
	bh=z2FkN7Uv8WpIEuaoeQKJ+Q276JtcRn/m+/KcAq2vM4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fuiT66EqPNJdLSnyETquA8EeAOx96CeiUYeMcltDjoT1w5uJhTD3u68xl2Sq80V0t67R3qWYxDa4uMEd0gQ4srbthysQTqWw+pWMteqQfQX5qrHjrSPuOzdfcWCcJsBk+WjYW6ljviyL0vDlrNgWM5+fhqxqa9QcfQaibYWWtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XDbTX46vrzySJ9;
	Thu, 26 Sep 2024 09:23:44 +0800 (CST)
Received: from dggpemf100016.china.huawei.com (unknown [7.185.36.236])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FBDA1800CF;
	Thu, 26 Sep 2024 09:24:46 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (7.185.36.197) by
 dggpemf100016.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Sep 2024 09:24:46 +0800
Received: from dggpemf500016.china.huawei.com ([7.185.36.197]) by
 dggpemf500016.china.huawei.com ([7.185.36.197]) with mapi id 15.02.1544.011;
 Thu, 26 Sep 2024 09:24:46 +0800
From: chengyechun <chengyechun1@huawei.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Jay Vosburgh <j.vosburgh@gmail.com>, =?gb2312?B?o6xBbmR5IEdvc3BvZGFyZWs=?=
	<andy@greyhouse.net>
Subject: =?gb2312?B?tPC4tDogW0Rpc2N1c3NdUXVlc3Rpb25zIGFib3V0IGFjdGl2ZSBzbGF2ZSBz?=
 =?gb2312?Q?elect_in_bonding_8023ad?=
Thread-Topic: [Discuss]Questions about active slave select in bonding 8023ad
Thread-Index: AdsKZKjErjnqndRMTZCIcmgDUhEG9gACy1PAAVC4CFA=
Date: Thu, 26 Sep 2024 01:24:45 +0000
Message-ID: <7b0d827769974176835440fe5211522a@huawei.com>
References: <c464627d07434469b363134ad10e3b4c@huawei.com>
 <b2785db6fbe9421ca6510ca92ddfa650@huawei.com>
In-Reply-To: <b2785db6fbe9421ca6510ca92ddfa650@huawei.com>
Accept-Language: en-US
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

SSBob3BlIHRvIGdldCBhIHJlcGx5LCBpZiBJIGhhdmUgYW55IHF1ZXN0aW9ucyBhYm91dCB0aGlu
a2luZywgcGxlYXNlIGxldCBtZSBrbm93LCB0aGFuayB5b3UuDQoNCi0tLS0t08q8/tStvP4tLS0t
LQ0Kt6K8/sjLOiBjaGVuZ3llY2h1biANCreiy83KsbzkOiAyMDI0xOo51MIxOcjVIDE2OjQzDQrK
1bz+yMs6ICduZXRkZXZAdmdlci5rZXJuZWwub3JnJyA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz4N
CrOty806ICdKYXkgVm9zYnVyZ2gnIDxqLnZvc2J1cmdoQGdtYWlsLmNvbT47ICejrEFuZHkgR29z
cG9kYXJlaycgPGFuZHlAZ3JleWhvdXNlLm5ldD4NCtb3zOI6ILTwuLQ6IFtEaXNjdXNzXVF1ZXN0
aW9ucyBhYm91dCBhY3RpdmUgc2xhdmUgc2VsZWN0IGluIGJvbmRpbmcgODAyM2FkDQoNCkhlcmUg
aXMgcGF0Y2g6DQoNClN1YmplY3Q6IFtQQVRDSF0gYm9uZGluZzogZW5hYmxlIGJlc3Qgc2xhdmUg
YWZ0ZXIgc3dpdGNoIHVuZGVyIGNvbmRpdGlvbiAzYQ0KLS0tDQpkcml2ZXJzL25ldC9ib25kaW5n
L2JvbmRfM2FkLmMgfCAyICsrDQoxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfM2FkLmMgYi9kcml2ZXJzL25ldC9i
b25kaW5nL2JvbmRfM2FkLmMgaW5kZXggYWUwMzkzZGZmLi44NDk0NDIwZWQgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfM2FkLmMNCisrKyBiL2RyaXZlcnMvbmV0L2JvbmRp
bmcvYm9uZF8zYWQuYw0KQEAgLTE4MTksNiArMTgxOSw4IEBAIHN0YXRpYyB2b2lkIGFkX2FnZ19z
ZWxlY3Rpb25fbG9naWMoc3RydWN0IGFnZ3JlZ2F0b3IgKmFnZywNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgX19kaXNhYmxlX3BvcnQocG9ydCk7DQogICAgICAgICAgICAgICAgICAg
ICAgICB9DQogICAgICAgICAgICAgICAgfQ0KKyAgICAgICAgICAgICAgIHBvcnQgPSBiZXN0LT5s
YWdfcG9ydHM7DQorICAgICAgICAgICAgICAgX19lbmJhbGVfcG9ydChwb3J0KTsNCiAgICAgICAg
ICAgICAgICAvKiBTbGF2ZSBhcnJheSBuZWVkcyB1cGRhdGUuICovDQogICAgICAgICAgICAgICAg
KnVwZGF0ZV9zbGF2ZV9hcnIgPSB0cnVlOw0KICAgICAgICB9DQotLQ0KDQotLS0tLdPKvP7Urbz+
LS0tLS0NCreivP7IyzogY2hlbmd5ZWNodW4NCreiy83KsbzkOiAyMDI0xOo51MIxOcjVIDE1OjIy
DQrK1bz+yMs6ICduZXRkZXZAdmdlci5rZXJuZWwub3JnJyA8bmV0ZGV2QHZnZXIua2VybmVsLm9y
Zz4NCrOty806ICdKYXkgVm9zYnVyZ2gnIDxqLnZvc2J1cmdoQGdtYWlsLmNvbT47ICejrEFuZHkg
R29zcG9kYXJlaycgPGFuZHlAZ3JleWhvdXNlLm5ldD4NCtb3zOI6IFtEaXNjdXNzXVF1ZXN0aW9u
cyBhYm91dCBhY3RpdmUgc2xhdmUgc2VsZWN0IGluIGJvbmRpbmcgODAyM2FkDQoNCkhpIGFsbCwN
ClJlY2VudGx5o6xJJ20gaGF2aW5nIGEgcHJvYmxlbSBzdGFydGluZyBib25kLiBJdCdzIGFuIG9j
Y2FzaW9uYWwgcHJvYmxlbS4NCkFmdGVyIHRoZSBzbGF2ZSBhbmQgYm9uZCBhcmUgY29uZmlndXJl
ZCwgdGhlIG5ldHdvcmsgZmFpbHMgdG8gYmUgcmVzdGFydGVkLiBUaGUgZmFpbHVyZSBjYXVzZSBp
cyBhcyBmb2xsb3dzOg0KobAvZXRjL3N5c2NvbmZpZy9uZXR3b3JrLXNjcmlwdHMvaWZ1cC1ldGhb
Mjc0NzEyOV06IEVycm9yLCBzb21lIG90aGVyIGhvc3QgKCkgYWxyZWFkeSB1c2VzIGFkZHJlc3Mg
MS4xLjEuMzkuobENCldoZW4gdGhlIG5ldHdvcmsgdXNlcyBhcnBpbmcgdG8gY2hlY2sgd2hldGhl
ciBhbiBJUCBhZGRyZXNzIGNvbmZsaWN0IG9jY3VycywgYW4gZXJyb3Igb2NjdXJzLCBidXQgdGhl
IElQIGFkZHJlc3MgY29uZmxpY3QgaXMgbm90IGNhdXNlZC4gdGhpcyBpcyB2ZXJ5IHN0cmFuZ2Uu
DQpUaGUga2VybmVsIHZlcnNpb24gNS4xMCBpcyB1c2VkLiBUaGUgYm9uZCBjb25maWd1cmF0aW9u
IGlzIGFzIGZvbGxvd3M6DQoNCkJPTkRJTkdfT1BUUz0nbW9kZT00IG1paW1vbj0xMDAgbGFjcF9y
YXRlPWZhc3QgeG1pdF9oYXNoX3BvbGljeT1sYXllcjMrNCcNClRZUEU9Qm9uZA0KQk9ORElOR19N
QVNURVI9eWVzDQpCT09UUFJPVE89c3RhdGljDQpOTV9DT05UUk9MTEVEPW5vDQpJUFY0X0ZBSUxV
UkVfRkFUQUw9bm8NCklQVjZJTklUPXllcw0KSVBWNl9BVVRPQ09ORj15ZXMNCklQVjZfREVGUk9V
VEU9eWVzDQpJUFY2X0ZBSUxVUkVfRkFUQUw9bm8NCklQVjZfQUREUl9HRU5fTU9ERT1zdGFibGUt
cHJpdmFjeQ0KTkFNRT1ib25kMA0KREVWSUNFPWJvbmQwDQpPTkJPT1Q9eWVzDQpJUEFERFI9MS4x
LjEuMzgNCk5FVE1BU0s9MjU1LjI1NS4wLjANCklQVjZBRERSPTE6MToxOjozOS82NA0KDQpUaGUg
c2xhdmUgY29uZmlndXJhdGlvbiBpcyBhcyBmb2xsb3dzOiBhbmQgSSBoYXZlIGZvdXIgc2ltaWxh
ciBzbGF2ZXMgZW5wMTNzMCxlbnAxNHMwLGVucDE1czANCg0KTkFNRT1lbnAxMnMwDQpERVZJQ0U9
ZW5wMTJzMA0KQk9PVFBST1RPPW5vbmUNCk9OQk9PVD15ZXMNClVTRVJDVEw9bm8NCk5NX0NPTlRS
T0xMRUQ9bm8NCk1BU1RFUj1ib25kMA0KU0xBVkU9eWVzDQpJUFY2SU5JVD15ZXMNCklQVjZfQVVU
T0NPTkY9eWVzDQpJUFY2X0RFRlJPVVRFPXllcw0KSVBWNl9GQUlMVVJFX0ZBVEFMPW5vDQoNCkFm
dGVyIEkgZGlzY292ZXJlZCB0aGlzIHByb2JsZW0sIEkgcmVzdGFydGVkIHRoZSBuZXR3b3JrIG11
bHRpcGxlIHRpbWVzIGFuZCBpdCBhbHdheXMgaGFwcGVuZWQgb25jZSBvciB0d2ljZS4NCkFmdGVy
IHNvbWUgZGVidWdnaW5nLCBpdCBpcyBmb3VuZCB0aGF0IHRoZSBib25kIGludGVyZmFjZSBkb2Vz
IG5vdCBoYXZlIGFuIGF2YWlsYWJsZSBzbGF2ZSB3aGVuIHRoZSBhcnBpbmcgcGFja2V0IGlzIHNl
bnQuIEFzIGEgcmVzdWx0LCB0aGUgYXJwaW5nIHBhY2tldCBmYWlscyB0byBiZSBzZW50Lg0KV2hl
biB0aGUgcHJvYmxlbSBvY2N1cnMsIHRoZSBhY3RpdmUgc2xhdmUgbm9kZSBpcyBzd2l0Y2hlZCBm
cm9tIGVucDEyczAgdG8gZW5wMTNzMC4gSG93ZXZlciwgdGhlIGJhY2t1cCBvZiBlbnAxM3MwIGlz
IG5vdCBjaGFuZ2VkIGZyb20gMSB0byAwIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBzd2l0Y2hvdmVy
IGlzIGNvbXBsZXRlLiBUaGlzIGlzIGEgbWVjaGFuaXNtIG9yIGJ1Zz8NCg0KQWZ0ZXIgdGhpbmtp
bmcgYWJvdXQgaXQsIEkgaGF2ZSBhIGRvdWJ0IGFib3V0IHRoZSBzZWxlY3Qgb2YgYWN0aXZlIHNs
YXZlLiBJbiB0aGUgYWRfYWdnX3NlbGVjdGlvbl90ZXN0IGZ1bmN0aW9uLCBpZiBjb25kaXRpb24g
M2EgaXMgbWV0LCB0aGF0IGlzLCBpZiAoX19hZ2dfaGFzX3BhcnRuZXIoY3VycikgJiYgIV9fYWdn
X2hhc19wYXJ0bmVyKGJlc3QpKaOsYW5kIGFmdGVyIHRoZSBhY3RpdmUgc2xhdmUgc3dpdGNoIGlz
IHN1Y2Nlc3NmdWwsIHdoeSBub3QgZW5hYmxlX3BvcnQgdGhlIGJlc3Qgc2xhdmUgaW4gYWRfYWdn
X3NlbGVjdGlvbl9sb2dpYz8NCg==

