Return-Path: <netdev+bounces-46683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A757E5CDB
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 19:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56752814D2
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 18:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673A321B7;
	Wed,  8 Nov 2023 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28C32C7A
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 18:07:59 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571321FEB
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 10:07:59 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A8I7txE6977165, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A8I7txE6977165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Nov 2023 02:07:55 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 9 Nov 2023 02:07:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Nov 2023 02:07:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 9 Nov 2023 02:07:54 +0800
From: Hau <hau@realtek.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd
	<nic_swsd@realtek.com>
Subject: RE: [PATCH net 2/2] r8169: fix network lost after resume on DASH systems
Thread-Topic: [PATCH net 2/2] r8169: fix network lost after resume on DASH
 systems
Thread-Index: AQHaEMOHrsYgF2TLT0Cjycm7GgUKz7Bt7NaAgALOXfA=
Date: Wed, 8 Nov 2023 18:07:54 +0000
Message-ID: <311e24c1d91943aa8bed223fc6768fb7@realtek.com>
References: <20231106151124.9175-1-hau@realtek.com>
 <20231106151124.9175-3-hau@realtek.com>
 <5ff51bab-52ea-4f9a-a1ba-31b26d21a8a4@gmail.com>
In-Reply-To: <5ff51bab-52ea-4f9a-a1ba-31b26d21a8a4@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
x-originating-ip: [172.22.228.56]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

PiA+IERldmljZSB0aGF0IHN1cHBvcnQgREFTSCBtYXkgYmUgcmVzZXRlZCBvciBwb3dlcmVkIG9m
ZiBkdXJpbmcgc3VzcGVuZC4NCj4gPiBTbyBkcml2ZXIgbmVlZHMgdG8gaGFuZGxlIERBU0ggZHVy
aW5nIHN5c3RlbSBzdXNwZW5kIGFuZCByZXN1bWUuIE9yDQo+ID4gREFTSCBmaXJtd2FyZSB3aWxs
IGluZmx1ZW5jZSBkZXZpY2UgYmVoYXZpb3IgYW5kIGNhdXNlcyBuZXR3b3JrIGxvc3QuDQo+ID4N
Cj4gPiBGaXhlczogYjY0NmQ5MDA1M2Y4ICgicjgxNjk6IG1hZ2ljLiIpDQo+ID4gU2lnbmVkLW9m
Zi1ieTogQ2h1bkhhbyBMaW4gPGhhdUByZWFsdGVrLmNvbT4NCj4gDQo+IEFsc28gaGVyZTogY2Mg
c3RhYmxlDQo+IFdpdGggdGhpczoNCj4gDQo+IFJldmlld2VkLWJ5OiBIZWluZXIgS2FsbHdlaXQg
PGhrYWxsd2VpdDFAZ21haWwuY29tPg0KDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlcy4gSSB3aWxs
IHVwZGF0ZSB0aGUgY29kZSBhbmQgc3VibWl0IHRoZSBwYXRjaCBhZ2Fpbi4NCg==

