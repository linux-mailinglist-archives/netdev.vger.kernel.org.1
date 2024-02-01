Return-Path: <netdev+bounces-67795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D8F844F38
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD731F2ABB1
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 02:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47E83FE0;
	Thu,  1 Feb 2024 02:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67739FD8
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 02:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706755340; cv=none; b=pXKi7eO2pDEbUi5z6nluqZU2BBkvs1vMD9Q11JfTiaPBXO8f6Aw5yx1CnLyRIWz+vfsFaxlx+ZvPnqDEhzxgWQcNJtjwOhi1iJoFqBm8Rg4DEGeTnayoVngl5qj1tl3RTrfWS5+B5ns72+quFqzttsTLDIjbBZt8rN2/5mGaBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706755340; c=relaxed/simple;
	bh=MB6fmo7Q7TnvjnAOzwLKOXDRp6hH41uoiSYOpLgQElQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqSbLY9iFG24NLtsj995QW6UweBumQBXuiP0dy7MX3fXvo2sw4fKvhTHMblmln0A+SQ3200RTgJANhxgjGe3s395JRfpp3fqLkAaNIXjt4CwhaSaN05ir1dRWk7FRGBlgSVDSH11B9Vi/9rtFXzhi5CVxysM5QdW4JVDHZ0bT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4112g9Eg91254840, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4112g9Eg91254840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 10:42:10 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 1 Feb 2024 10:42:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 10:42:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 1 Feb 2024 10:42:08 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: Report on abnormal behavior of "page_pool" API
Thread-Topic: Report on abnormal behavior of "page_pool" API
Thread-Index: AdpUF0sHyRotE8/qT3KY+LT6QKnbOgAH3lQAACAyoiA=
Date: Thu, 1 Feb 2024 02:42:08 +0000
Message-ID: <da6442a9f6c7427a82dab3becd646e8b@realtek.com>
References: <305a3c3dfc854be6bbd058e2d54c855c@realtek.com>
 <b113bbb6-6e17-4aa8-b922-aaf6056d142a@engleder-embedded.com>
In-Reply-To: <b113bbb6-6e17-4aa8-b922-aaf6056d142a@engleder-embedded.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

PiBPbiAzMS4wMS4yNCAwODozMSwgSnVzdGluIExhaSB3cm90ZToNCj4gPiBUbyB3aG9tIGl0IG1h
eSBjb25jZXJuLA0KPiA+DQo+ID4gSSBob3BlIHRoaXMgZW1haWwgZmluZHMgeW91IHdlbGwuIEkg
YW0gd3JpdGluZyB0byByZXBvcnQgYSBiZWhhdmlvcg0KPiA+IHdoaWNoIHNlZW1zIHRvIGJlIGFi
bm9ybWFsLg0KPiA+DQo+ID4gV2hlbiBJIHJlbW92ZSB0aGUgbW9kdWxlLCBJIGNhbGwgcGFnZV9w
b29sX2Rlc3Ryb3koKSB0byByZWxlYXNlIHRoZQ0KPiA+IHBhZ2VfcG9vbCwgYnV0IHRoaXMgbWVz
c2FnZSBhcHBlYXJzLCBwYWdlX3Bvb2xfcmVsZWFzZV9yZXRyeSgpIHN0YWxsZWQNCj4gPiBwb29s
IHNodXRkb3duIDEwMjQgaW5mbGlnaHQgMTIwIHNlYy4NCj4gDQo+IEkgaGFkIGEgcHJvYmxlbSB3
aXRoIHRoZSBzYW1lIG1lc3NhZ2U6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8y
MDIzMDMxMTIxMzcwOS40MjYyNS0xLWdlcmhhcmRAZW5nbGVkZXItZQ0KPiBtYmVkZGVkLmNvbS8N
Cj4gDQo+IENvdWxkIGl0IGJlIHRoZSBzYW1lIHByb2JsZW0/DQoNCkl0IGRvZXNuJ3Qgc2VlbSB0
byBiZSB0aGUgc2FtZS4gQWx0aG91Z2ggdGhlIGVycm9yIG1lc3NhZ2UgaXMgc2ltaWxhciwgSSBh
bSBub3QgdXNpbmcgdGhlIHhkcCBhcGkuDQo+IA0KPiBHZXJoYXJkDQoNCg==

