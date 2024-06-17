Return-Path: <netdev+bounces-104083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF3A90B19E
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760D11F2878C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D0F199E99;
	Mon, 17 Jun 2024 13:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C8198A34;
	Mon, 17 Jun 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630973; cv=none; b=fMgoGJ+q3HuZDEEvJ9cC30UPaLInueC/xydJ7+FX7ceUEareSb8yvyiNhYCebtlmJ7frHtdmAUtbfOgFLdSUQobKDBpRVx7iOWppcMFD+NFewNOd3d1COggirOR9XBwpws0yHVWeqTzlOHaoH/fkc8RwRPR0v+SgGwIxqdDr9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630973; c=relaxed/simple;
	bh=dmN1xl9dYL2wT6I3eezHhEJnFRaCUhhBxyyStgpeFyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DMru3wVf7HBKfdSMEqDhJrBgrBgUTc8EqU75vL4zD5kzezeN2Zw4NwxlHqZ8vpFRkDMcSDnpL+et+981QEnJAG/LZ9AJ8L0jJzZsPafbOuQpPw1MQUhr0tAgsFLad1Pa/RtorI4nGVEtccKMZG5KO7vDDSuAtx8jAFz+ExXSf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45HDSp4kA3235470, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45HDSp4kA3235470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 21:28:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 21:28:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Jun 2024 21:28:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 17 Jun 2024 21:28:51 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Markus Elfring <Markus.Elfring@web.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Hariprasad Kelam <hkelam@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
        "Larry
 Chiu" <larry.chiu@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: RE: [v20 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [v20 02/13] rtase: Implement the .ndo_open function
Thread-Index: AQHawJ5eL1A+vv787Ey/gTxPzZ037bHL8dBA
Date: Mon, 17 Jun 2024 13:28:51 +0000
Message-ID: <0c57021d0bfc444ebe640aa4c5845496@realtek.com>
References: <20240607084321.7254-3-justinlai0215@realtek.com>
 <1d01ece4-bf4e-4266-942c-289c032bf44d@web.de>
 <ef7c83dea1d849ad94acef81819f9430@realtek.com>
 <6b284a02-15e2-4eba-9d5f-870a8baa08e8@web.de>
In-Reply-To: <6b284a02-15e2-4eba-9d5f-870a8baa08e8@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQo+ID4+IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gaW5jcmVhc2UgdGhlIGFwcGxpY2F0aW9u
IG9mIHNjb3BlLWJhc2VkIHJlc291cmNlDQo+IG1hbmFnZW1lbnQ/DQo+ID4+IGh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEwLXJjMy9zb3VyY2UvaW5jbHVkZS9saW51eC9jbGVh
bg0KPiA+PiB1cC5oI0w4DQo+ID4NCj4gPiBEdWUgdG8gb3VyIHR4IGFuZCByeCBlYWNoIGhhdmlu
ZyBtdWx0aXBsZSBxdWV1ZXMgdGhhdCBuZWVkIHRvIGFsbG9jYXRlDQo+ID4gZGVzY3JpcHRvcnMs
IGlmIGFueSBvbmUgb2YgdGhlIHF1ZXVlcyBmYWlscyB0byBhbGxvY2F0ZSwNCj4gPiBydGFzZV9h
bGxvY19kZXNjKCkgd2lsbCByZXR1cm4gYW4gZXJyb3IuIFRoZXJlZm9yZSwgdXNpbmcgJ2dvdG8n
DQo+ID4gaGVyZSByYXRoZXIgdGhhbiBkaXJlY3RseSByZXR1cm5pbmcgc2VlbXMgdG8gYmUgcmVh
c29uYWJsZS4NCj4gDQo+IFNvbWUgZ290byBjaGFpbnMgY2FuIGJlIHJlcGxhY2VkIGJ5IGZ1cnRo
ZXIgdXNhZ2Ugb2YgYWR2YW5jZWQgY2xlYW51cA0KPiB0ZWNobmlxdWVzLCBjYW4ndCB0aGV5Pw0K
PiANCj4gUmVnYXJkcywNCj4gTWFya3VzDQoNCnJ0YXNlX2FsbG9jX2Rlc2MoKSBpcyB1c2VkIHRv
IGFsbG9jYXRlIERNQSBtZW1vcnkuIA0KSSdkIGxpa2UgdG8gYXNrIGlmIGl0J3MgYmV0dGVyIHRv
IGtlZXAgb3VyIGN1cnJlbnQgbWV0aG9kPw0KDQo=

