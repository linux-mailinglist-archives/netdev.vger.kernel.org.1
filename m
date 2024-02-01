Return-Path: <netdev+bounces-67794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3BC844F31
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F3D1F29317
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 02:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300441773E;
	Thu,  1 Feb 2024 02:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77654EEBB
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706755051; cv=none; b=SWPzjbP/BgIXOvNzMIYtYOJTqXim+BVG+HDiHqduanpOeavKsYLLG+1/sSSBTAjMX6Ovif74U+ocpv6ooa7PpnE6p+pMzKiY6UH+syM9w5etJ7SM+yW9lotRpprgs9jgKJ/LS6iMHW69SFxu/YPuzbJQhUWbQgjEtoRTTWypjmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706755051; c=relaxed/simple;
	bh=dgI8lcSuVxm53L1NUW9BOMDaQWvxYFllCM9Z0rOuFfo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6P2R7TIAX2CEPHfQ8IudsfNd8i6o/cX/ibr21TwrXsLdTFBRh3SYX+3XCPhiDiDPL6LqpXPrJuXOXK2862/nWyIlb34zo1EwuqrRX45qIARjDsp5+nkIqa1gsPfH0E6Da23RcDhNoojXZZ6h4lep7VoFmy1CQJz/ejP94wc8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4112b3j151253154, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4112b3j151253154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 10:37:03 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 1 Feb 2024 10:37:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 10:37:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 1 Feb 2024 10:37:02 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Yunsheng Lin <linyunsheng@huawei.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: Report on abnormal behavior of "page_pool" API
Thread-Topic: Report on abnormal behavior of "page_pool" API
Thread-Index: AdpUF0sHyRotE8/qT3KY+LT6QKnbOv//kgwA//5TtLA=
Date: Thu, 1 Feb 2024 02:37:02 +0000
Message-ID: <c686cf0065b74c139e34c4c7dd700301@realtek.com>
References: <305a3c3dfc854be6bbd058e2d54c855c@realtek.com>
 <e9beff86-ba0e-ad3c-1972-16cdc3b29ab3@huawei.com>
In-Reply-To: <e9beff86-ba0e-ad3c-1972-16cdc3b29ab3@huawei.com>
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

PiBPbiAyMDI0LzEvMzEgMTU6MzEsIEp1c3RpbiBMYWkgd3JvdGU6DQo+ID4gVG8gd2hvbSBpdCBt
YXkgY29uY2VybiwNCj4gPg0KPiA+IEkgaG9wZSB0aGlzIGVtYWlsIGZpbmRzIHlvdSB3ZWxsLiBJ
IGFtIHdyaXRpbmcgdG8gcmVwb3J0IGEgYmVoYXZpb3INCj4gPiB3aGljaCBzZWVtcyB0byBiZSBh
Ym5vcm1hbC4NCj4gPg0KPiA+IFdoZW4gSSByZW1vdmUgdGhlIG1vZHVsZSwgSSBjYWxsIHBhZ2Vf
cG9vbF9kZXN0cm95KCkgdG8gcmVsZWFzZSB0aGUNCj4gDQo+IFdoaWNoIG1vZHVsZT8NClRoZSBQ
Q0llIGRyaXZlcg0KPiANCj4gPiBwYWdlX3Bvb2wsIGJ1dCB0aGlzIG1lc3NhZ2UgYXBwZWFycywg
cGFnZV9wb29sX3JlbGVhc2VfcmV0cnkoKSBzdGFsbGVkDQo+ID4gcG9vbCBzaHV0ZG93biAxMDI0
IGluZmxpZ2h0IDEyMCBzZWMuIFRoZW4gSSB0cmllZCB0byByZXR1cm4gdGhlIHBhZ2UNCj4gPiB0
byBwYWdlX3Bvb2wgYmVmb3JlIGNhbGxpbmcgcGFnZV9wb29sX2Rlc3Ryb3koKSwgc28gSSBjYWxs
ZWQNCj4gPiBwYWdlX3Bvb2xfcHV0X2Z1bGxfcGFnZSgpIGZpcnN0LCBidXQgYWZ0ZXIgZG9pbmcg
c28sIHRoaXMgbWVzc2FnZSB3YXMNCj4gPiBwcmludGVkLCBwYWdlX3Bvb2xfZW1wdHlfcmluZygp
IHBhZ2VfcG9vbCByZWZjbnQgMCB2aW9sYXRpb24sIGFuZCB0aGUNCj4gDQo+IEFzIHdlIGhhdmUg
InBhZ2VfcmVmX2NvdW50KHBhZ2UpID09IDEiIGNoZWNraW5nIHRvIGFsbG93IHJlY3ljbGluZyBw
YWdlIGluDQo+IHBvb2wtPnJpbmc6DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y2LjgtcmMyL3NvdXJjZS9uZXQvY29yZS9wYWdlX3Bvb2wuYyNMNjU0DQo+IA0KPiBJdCBzZWVt
cyBzb21lYm9keSBpcyBzdGlsbCB1c2luZyB0aGUgcGFnZSBhbmQgbWFuaXB1bGF0aW5nIF9yZWZj
b3VudCB3aGlsZSB0aGUNCj4gcGFnZSBpcyBzaXR0aW5nIGluIHRoZSBwb29sLT5yaW5nPw0KDQpJ
IHdpbGwgY29uZmlybSB0aGlzIHBhcnQgYWdhaW4sIHRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4N
Cj4gDQo+IA0KPiA+IGNvbXB1dGVyIGNyYXNoZWQuDQo+ID4NCj4gPiBJIHdvdWxkIGxpa2UgdG8g
YXNrIHdoYXQgY291bGQgYmUgY2F1c2luZyB0aGlzIGFuZCBob3cgSSBzaG91bGQgZml4IGl0Lg0K
PiANCj4gTm90IHN1cmUgaWYgeW91IHJlYWQgdGhlIGJlbG93IGRvYyBmb3IgcGFnZV9wb29sLCB1
bmRlcnN0YW5kaW5nIHRoZSBpbnRlcm5hbA0KPiBkZXRhaWwgYW5kIHRoZSBBUEkgdXNhZ2VzIG1h
eSBoZWxwIHlvdSBkZWJ1Z2luZyB0aGUgcHJvYmxlbToNCj4gRG9jdW1lbnRhdGlvbi9uZXR3b3Jr
aW5nL3BhZ2VfcG9vbC5yc3QNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5LiBJIGhhdmUgcmVh
ZCB0aGlzIGRvY3VtZW50LCBidXQgSSB3aWxsIHN0dWR5IGl0IGFnYWluLg0KPiANCj4gPg0KPiA+
IFRoZSBpbmZvcm1hdGlvbiBvbiBteSB3b3JraW5nIGVudmlyb25tZW50IGlzOiBVYnVudHUyMy4x
MCwgbGludXgNCj4gPiBrZXJuZWwgNi40LCA2LjUsIDYuNg0KPiA+DQo+ID4gVGhhbmsgeW91IGZv
ciB5b3VyIHRpbWUgYW5kIGVmZm9ydHMsIEkgYW0gbG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVw
bHkuDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gSnVzdGluDQo+ID4NCj4gPiAuDQo+ID4N
Cg==

