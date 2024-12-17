Return-Path: <netdev+bounces-152460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CB69F404A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF70188D45B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC4A84D3E;
	Tue, 17 Dec 2024 01:59:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9D54728
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400767; cv=none; b=LEWj97uUuRderL8O1PnfFijwSylTm+9NClg/m8xIWuJmiVTuLDwSxpLxOqPJQL3qwsUinSrnPpwfvkooK+m0s/ZzJSujkUsKabRPHhL3c93oMSW3zMI68412ewplx+mReKEBJWf1Z7r+CdDSFPluZrapRkrzV0lEnTOiPQni+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400767; c=relaxed/simple;
	bh=N5J0G0ri/Gcwl51wKOlsvQtPYpkDHR4N9OG5xj714uQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeGFS5q6MYN9wHQQhanHGuXOK6L22klJq23fc2FLwhEKXp0A4EoKJDEWa4GfsR2rFpC8rEv4nLD9CTPb5YUdkL6RPhHqclDaqbDQnpUqGnz+3YBtjKvEMMfbXth6NvLM4C3mTX6a950ANq4vVSWZUXb9ma65bLvqsXspAa+d+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "saeedm@nvidia.com"
	<saeedm@nvidia.com>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
CC: "Li,Shuo(ACG CCN)" <lishuo02@baidu.com>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXVtuZXQtbmV4dF0g?=
 =?utf-8?B?bmV0L21seDVlOiBhdm9pZCB0byBjYWxsIG5ldF9kaW0gYW5kIGRpbV91cGRh?=
 =?utf-8?Q?te=5Fsample?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bbmV0LW5leHRdIG5ldC9tbHg1?=
 =?utf-8?B?ZTogYXZvaWQgdG8gY2FsbCBuZXRfZGltIGFuZCBkaW1fdXBkYXRlX3NhbXBs?=
 =?utf-8?Q?e?=
Thread-Index: AQHbTIudu7NT/W4pY0SUTIvqLP2csLLo3wKAgADUNJA=
Date: Tue, 17 Dec 2024 01:58:29 +0000
Message-ID: <b1d25fe8fa06420c8420d0f2ee81e1ed@baidu.com>
References: <20241212114723.38844-1-lirongqing@baidu.com>
 <ca8b58c7-d60f-4e55-9fb5-73d9a1359758@linux.dev>
In-Reply-To: <ca8b58c7-d60f-4e55-9fb5-73d9a1359758@linux.dev>
Accept-Language: zh-CN, en-US
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
X-FEAS-Client-IP: 172.31.51.45
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

DQo+IE9uIDEyLzEyLzIwMjQgMTE6NDcsIExpIFJvbmdRaW5nIHdyb3RlOg0KPiA+IEhpZ2ggY3B1
IHVzYWdlIGZvciBuZXRfZGltIGlzIHNlZW4gc3RpbGwgYWZ0ZXIgY29tbWl0IDYxYmYwMDA5YTc2
NQ0KPiA+ICgiZGltOiBwYXNzIGRpbV9zYW1wbGUgdG8gbmV0X2RpbSgpIGJ5IHJlZmVyZW5jZSIp
LCB0aGUgY2FsbGluZw0KPiA+IG5ldF9kaW0gY2FuIGJlIGF2b2lkIHVuZGVyIG5ldHdvcmsgbG93
IHRocm91Z2hwdXQgb3IgcGluZ3BvbmcgbW9kZSBieQ0KPiA+IGNoZWNraW5nIHRoZSBldmVudCBj
b3VudGVyLCBldmVuIHVuZGVyIGhpZ2ggdGhyb3VnaHB1dCwgaXQgbWF5YmUgb25seQ0KPiA+IHJ4
IG9yIHR4IGRpcmVjdGlvbg0KPiA+DQo+ID4gQW5kIGRvbid0IGluaXRpYWxpemUgZGltX3NhbXBs
ZSB2YXJpYWJsZSwgc2luY2UgaXQgd2lsbCBnZXRzDQo+ID4gb3ZlcndyaXR0ZW4gYnkgZGltX3Vw
ZGF0ZV9zYW1wbGUNCj4gDQo+IGRpbV91cGRhdGVfc2FtcGxlIGRvZXNuJ3QgaW5pdCBkaW1fc2Ft
cGxlOjpjb21wX2N0ciwgd2hpY2ggaXMgbGF0ZXIgdXNlZCBpbg0KPiBuZXRfZGltKCktPmRpbV9j
YWxjX3N0YXRzKCkuIFRoaXMgY2hhbmdlIGNhbiBicmluZyB1bmluaXRpYWxpemVkIG1lbW9yeSB0
byB0aGUNCj4gd2hvbGUgY2FsY3VsYXRpb24uIEtlZXAgaXQgaW5pdGlhbGl6ZWQuDQo+IA0KDQpJ
IHNlZSB0aGF0IGNvbXBfY3RyIGlzIG9ubHkgZm9yIFJETUEgZGltLCBzbyBpdCBpcyBiZXN0IHRv
IG1vdmUgdGhlIGNvbXBfY3RyIGNhbGN1bGF0aW9uIHRvIGEgUkRNQSBkaW0gcmVsYXRlZCBmdW5j
dGlvbi4NCg0KVG8gdGhpcyBwYXRjaCwgbW92ZSB0aGUgaW5pdGlhbGl6YXRpb24gYmVmb3JlIGRp
bV91cGRhdGVfc2FtcGxlKCkgdG8gYXZvaWQgdW5uZWNlc3NhcnkgaW5pdGlhbGl6YXRpb24NCg0K
VGhhbmtzDQoNCi1MaQ0K

