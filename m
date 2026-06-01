Return-Path: <netdev+bounces-293555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJUQD0wbHWoeVwkAu9opvQ
	(envelope-from <netdev+bounces-293555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E99619BDE
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFC02300B3CA
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060633C187;
	Mon,  1 Jun 2026 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="bE8rIVQw"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3E335BBB;
	Mon,  1 Jun 2026 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292420; cv=none; b=e8iNBpq2BuWgNKNdnBbUDL0DhigMVzm1QS/rOfKY/xTRpzL+j+S5f73gA9wyGo1ur5FK3kgunixfkq5xZPPeRGbT2r57k0ERepVwPqf1JBVSj2C4yWkjKkt43/tD+OuV06yQbJIfw439UvMEbwm4EDN1cAvRPcfQfLovxjUiH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292420; c=relaxed/simple;
	bh=z0JUyRvY3y7yOGwxnG+2D6KVK7y1f5teZZ0NfjjSwkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bp6+BRAyD/OV4bGonOLYZUis/odCWjQgciAd5HSUY3SB3y6UnUwUU9WTndnKWmIGbbU/A2lT3DpFjm4UlCMkwPsnlWRS0Qd4GOS+hiuOl+zTC0iEIc2LeAlVMWqItjyEiuutos8e30lpKlwdIbkSZ9hwwVNsc6yCTabCfXHZtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=bE8rIVQw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6515ct8uB1837258, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780292335;
	bh=z0JUyRvY3y7yOGwxnG+2D6KVK7y1f5teZZ0NfjjSwkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bE8rIVQw4SHGApu4tmXdfdnOWq2E4H34xD+U5BC5PBNwE7jd2tr6p0vPMhE7Vz7XN
	 lXCcMnqpw4wLt7GN0g98SA6TvPqA3fOfcEiZxv5fWfe2V3Un2VBKWZEuUCLNslzaro
	 XdIx9jhFf4aI097QXm72eFZCSoWcyZ1Yem41cYtHkLfyeclGVAaSZGZenaaXD94KFj
	 oIgB5ZDlJbbp+qRO+UP4QxHYJQArX6XgvhfFzZyEZCwaoMoYjwtIgCgeFw9PrdtjAR
	 LT/60Wanxa0nm914nNu23u1BCVAJ8f/k1X2NFWWFaqCoR0MAZ5235k+mvKlGnwHhv1
	 rphKria9gBazw==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6515ct8uB1837258
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jun 2026 13:38:55 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Jun 2026 13:38:54 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Mon,
 1 Jun 2026 13:38:54 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Daniel Golle <daniel@makrotopia.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, =?gb2312?B?ucvP/r78?=
	<freddy_gu@realsil.com.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>, =?gb2312?B?QmFsqKJ6cyBUcmlzemth?=
	<info@balika011.hu>
Subject: RE: [PATCH net-next v1 2/2] net: phy: realtek: load firmware for
 RTL8261C
Thread-Topic: [PATCH net-next v1 2/2] net: phy: realtek: load firmware for
 RTL8261C
Thread-Index: AQHc7ncSbPmCu2IClUOase9yNkjBi7Yi1ZUAgAZdTKA=
Date: Mon, 1 Jun 2026 05:38:54 +0000
Message-ID: <ead2cd49c1394c01a404da8e3962ad79@realsil.com.cn>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-3-javen_xu@realsil.com.cn>
 <ahgy9Cce9MmY6KLl@makrotopia.org>
In-Reply-To: <ahgy9Cce9MmY6KLl@makrotopia.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,nxp.com,balika011.hu];
	TAGGED_FROM(0.00)[bounces-293555-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 54E99619BDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pk9uIFRodSwgTWF5IDI4LCAyMDI2IGF0IDAzOjUyOjI2UE0gKzA4MDAsIGphdmVuIHdyb3RlOg0K
Pj4gRnJvbTogSmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4NCj4+IFRoaXMg
cGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBsb2FkaW5nIGZpcm13YXJlLiBEb3dubG9hZCBzb21lIHBh
cmFtZXRlcnMNCj4+IGZvciBSVEw4MjYxQy4NCj4NCj5JJ2QgbGlrZSB0byBicmluZyB0byB5b3Vy
IGF0dGVudGlvbiB0aGF0IHRoZSBPcGVuV3J0IGNvbW11bml0eSBoYXMNCj5pbXBlbWVudGVkIGEg
bW9yZSBjb21wbGV0ZSBzdXBwb3J0IGZvciBpbml0aWFsIHJlZ2lzdGVyIHBhdGNoaW5nIHVzaW5n
IGENCj5leHRyZW1lbHkgc2ltaWxhciBmaXJtd2FyZSBmb3JtYXQuDQo+DQo+aHR0cHM6Ly9naXRo
dWIuY29tL29wZW53cnQvb3BlbndydC9ibG9iL21haW4vdGFyZ2V0L2xpbnV4L2dlbmVyaWMvcGVu
ZGkNCj5uZy02LjE4Lzc0Mi1uZXQtcGh5LXJlYWx0ZWstYWRkLTVHLWFuZC0xMEctUEhZLXN1cHBv
cnQucGF0Y2gNCj4NCj5XZSB1c2VkICdSVEtfUEFUQ0hfT1BfKicgd2hpbGUgdGhpcyBzZXJpZXMg
dXNlcyBvbmx5ICdPUF8qJyBhcyBtYWNybw0KPm5hbWVzIGRlZmluaW5nIHRoZSBpbml0dmFsIHBh
dGNoaW5nIG9wZXJhdGlvbnMuDQo+DQo+QXMgdGhlIHZlbmRvciBkb3duc3RyZWFtIGRyaXZlciBo
YWQgdGhlIG9wZXJhdGlvbnMgaGFyZC1jb2RlZCBpbiB0YWJsZXMNCj5vdXIgY29tbXVuaXR5IGNh
bWUgdXAgd2l0aCBhIHRvb2wgdG8gZ2VuZXJhdGUgdGhlIHBhdGNoaW5nIGJsb2JzIGZyb20gdGhl
DQo+R1BMLWxpY2Vuc2VkIHZlbmRvciBkcml2ZXI6DQo+DQo+aHR0cHM6Ly9naXRodWIuY29tL2Jh
bGlrYTAxMS9yZWFsdGVrX3BoeV9maXJtd2FyZQ0KPg0KPkdpdmVuIHRoZSBzaW1pbGFyaXR5IEkg
d29uZGVyIGlmIHRoaXMgY29kZSBoYXMgYmVlbiB0YWtlbiBmcm9tIEJhbKiienMgVHJpc3prYQ0K
PndvcmsgKHdoaWNoIGNsZWFybHkgcHJlZGF0ZXMgaXQpIHdpdGhvdXQgZ2l2aW5nIGhpbSB0aGUg
ZHVlIGNyZWRpdC4NCg0KVGhhbmsgeW91IGZvciBicmluZ2luZyB0aGlzIHRvIG15IGF0dGVudGlv
biBhbmQgc2hhcmluZyB0aGUgbGlua3MgdG8gdGhlIE9wZW5XcnQgY29tbXVuaXR5J3MgYW5kIEJh
bKiienMgVHJpc3prYSdzIHdvcmsuDQoNCkkgaGF2ZSByZXZpZXdlZCB0aGUgcmVwb3NpdG9yeSBh
bmQgdGhlIHBhdGNoIHlvdSBtZW50aW9uZWQuIEkgd2FudCB0byBjbGFyaWZ5IHRoYXQgb3VyIGNv
ZGUgd2FzIGRldmVsb3BlZCBpbmRlcGVuZGVudGx5LiBTaW5jZSBib3RoIGltcGxlbWVudGF0aW9u
cyBhcmUgdGFja2xpbmcgdGhlIGV4YWN0IHNhbWUgaGFyZHdhcmUgcmVxdWlyZW1lbnRzIGZvciBS
ZWFsdGVrIFBIWXMsIHRoZSBmdW5kYW1lbnRhbCBoYXJkd2FyZSBvcGVyYXRpb25zoapzdWNoIGFz
IHJlYWQsIHdyaXRlLCBtYXNrLCBhbmQgZGVsYXmhqmFyZSBzdHJpY3RseSBkZWZpbmVkIGJ5IHRo
ZSBoYXJkd2FyZS4gSW4gdGhpcyBwYXRjaCwgd2Ugb25seSBrZXB0IHNvbWUgb2YgdGhlIG9wZXJh
dGlvbnMgdGhhdCBhcmUgdXNlZCwgc3VjaCBhcyBvcF9wb2xsLg0KDQpJIGhvcGUgdGhpcyBjbGVh
cnMgdXAgdGhlIG1pc3VuZGVyc3RhbmRpbmcuIA0KDQpCUnMsDQpKYXZlbg0K

