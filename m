Return-Path: <netdev+bounces-103954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B615E90A83A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 10:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67AE11F253EC
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD3190041;
	Mon, 17 Jun 2024 08:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32018C35F;
	Mon, 17 Jun 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612085; cv=none; b=tTLdrE9NIZpUz//TaCDel9mCg0N1u1flm2x30VjJG6qFs0JLqnupWZAiQ4dPZ8n9NcbGxgpbndf7uhBaObEJVbrpljIY2D8dPr/gNrn/Tw90/JbblMZQlxZOCXGWgkXOAs+rkN9msq6EUJj9IT0vMVbAPgAOEJ/GCDMUVkC5jLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612085; c=relaxed/simple;
	bh=MzDAuvDpK2yIeIxijUrlToeJQ83pB/6Qyxzx833IYvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BPbEQm/FKAFUw4gFunj02W/8Bz81saaHNjaJQg4dmZZXh6Kk5jKDKC0vXPeDPE4PEw4UZLbbuVXwySIEM36ElByoMQ2SWrLbdiLStqUq/4W1qConMB7XdUmRdBBMQIUCReFe67UWJCq0yxfLaKRBvwxMfIa5qm18vexaqabHCZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H8E7gxC2969343, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H8E7gxC2969343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 16:14:07 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 16:14:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Jun 2024 16:14:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 17 Jun 2024 16:14:07 +0800
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
Subject: RE: [PATCH net-next v20 01/13] rtase: Add pci table supported in this module
Thread-Topic: [PATCH net-next v20 01/13] rtase: Add pci table supported in
 this module
Thread-Index: AQHauLbXxklvPmnlCU+HuxncPxS2kLHE6RYAgAasGQA=
Date: Mon, 17 Jun 2024 08:14:07 +0000
Message-ID: <3e4dc0f5c9a449f7905f436e097f80f6@realtek.com>
References: <20240607084321.7254-2-justinlai0215@realtek.com>
 <bb0e9957-816e-4e36-b85c-6c5501e76a8a@web.de>
In-Reply-To: <bb0e9957-816e-4e36-b85c-6c5501e76a8a@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

PiA+IEFkZCBwY2kgdGFibGUgc3VwcG9ydGVkIGluIHRoaXMgbW9kdWxlLCBhbmQgaW1wbGVtZW50
IHBjaV9kcml2ZXINCj4gPiBmdW5jdGlvbiB0byBpbml0aWFsaXplIHRoaXMgZHJpdmVyLCByZW1v
dmUgdGhpcyBkcml2ZXIsIG9yIHNodXRkb3duIHRoaXMgZHJpdmVyLg0KPiANCj4gQ2FuIGEgc3Vt
bWFyeSBwaHJhc2UgbGlrZSDigJxBZGQgc3VwcG9ydCBmb3IgYSBQQ0kgdGFibGXigJ0gYmUgYSBi
aXQgbmljZXI/DQo+IA0KDQpZZXMsIHRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9uLiBJIHdp
bGwgbWFrZSB0aGUgY2hhbmdlLg0KDQo+IA0KPiDigKYNCj4gPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9yZWFsdGVrL3J0YXNlL3J0YXNlX21haW4uYw0KPiA+IEBAIC0wLDAgKzEsNjQwIEBA
DQo+IOKApg0KPiA+ICtzdGF0aWMgaW50IHJ0YXNlX2luaXRfb25lKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNl
X2lkICplbnQpIHsNCj4g4oCmDQo+ID4gKyAgICAgLyogaWRlbnRpZnkgY2hpcCBhdHRhY2hlZCB0
byBib2FyZCAqLw0KPiA+ICsgICAgIGlmICghcnRhc2VfY2hlY2tfbWFjX3ZlcnNpb25fdmFsaWQo
dHApKSB7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2
LCAtRU5PREVWLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInVua25v
d24gY2hpcCB2ZXJzaW9uLCBjb250YWN0DQo+IHJ0YXNlICINCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJtYWludGFpbmVycyAoc2VlIE1BSU5UQUlORVJTDQo+IGZpbGUp
XG4iKTsNCj4gPiArICAgICB9DQo+IOKApg0KPiANCj4gKiBNYXkgY3VybHkgYnJhY2tldHMgYmUg
b21pdHRlZCBoZXJlPw0KPiANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lDQo+IG50YXRpb24vcHJv
Y2Vzcy9jb2Rpbmctc3R5bGUucnN0P2g9djYuMTAtcmMzI24xOTcNCj4gDQo+ICogV291bGQgeW91
IGxpa2UgdG8ga2VlcCB0aGUgbWVzc2FnZSAoZnJvbSBzdWNoIHN0cmluZyBsaXRlcmFscykgaW4g
YSBzaW5nbGUNCj4gbGluZT8NCj4gDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZQ0KPiBudGF0aW9u
L3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdD9oPXY2LjEwLXJjMyNuMTE2DQo+IA0KDQpUaGFuayB5
b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbnMsIEkgd2lsbCBtYWtlIGNoYW5nZXMgYmFzZWQgb24gYm90
aCBvZiB0aGUNCnN1Z2dlc3Rpb25zIG1lbnRpb25lZCBhYm92ZS4NCg0KPiANCj4g4oCmDQo+ID4g
KyAgICAgZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX0lQX0NTVU07DQo+ID4gKyAgICAgZGV2LT5m
ZWF0dXJlcyB8PSBORVRJRl9GX0hJR0hETUE7DQo+IOKApg0KPiA+ICsgICAgIGRldi0+aHdfZmVh
dHVyZXMgfD0gTkVUSUZfRl9SWEFMTDsNCj4gPiArICAgICBkZXYtPmh3X2ZlYXR1cmVzIHw9IE5F
VElGX0ZfUlhGQ1M7DQo+IOKApg0KPiANCj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0byByZWR1
Y2Ugc3VjaCBhc3NpZ25tZW50IHN0YXRlbWVudHMgKGlmIGFsbCBkZXNpcmVkDQo+IHNvZnR3YXJl
IG9wdGlvbnMgd291bGQgYmUgcGFzc2VkIGF0IG9uY2UpPw0KDQpJIHRoaW5rIHlvdXIgc3VnZ2Vz
dGlvbiBpcyBmZWFzaWJsZSwgYW5kIEkgd2lsbCBtb2RpZnkgaXQgYWNjb3JkaW5nbHkuDQoNCj4g
DQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0KDQo=

