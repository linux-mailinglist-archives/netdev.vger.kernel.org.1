Return-Path: <netdev+bounces-42912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD847D09A1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB3C280D50
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B5FD51E;
	Fri, 20 Oct 2023 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED2D2EF;
	Fri, 20 Oct 2023 07:40:48 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060CD93;
	Fri, 20 Oct 2023 00:40:46 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39K7eWK013948985, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39K7eWK013948985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Oct 2023 15:40:33 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 20 Oct 2023 15:40:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 20 Oct 2023 15:40:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 20 Oct 2023 15:40:32 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Ferenc Fejes <fejes@inf.elte.hu>, Jakub Kicinski <kuba@kernel.org>
CC: netdev <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: RE: r8152: error when loading the module
Thread-Topic: r8152: error when loading the module
Thread-Index: AQHaAu61PEdzvjx070SbRfjHpmK89LBSKe1Q//+I1ICAAJAQwA==
Date: Fri, 20 Oct 2023 07:40:32 +0000
Message-ID: <d9c75e609001461d8eb0e38c18771cb2@realtek.com>
References: <aff833bb8b202f12feed5b2682f1361f13e37581.camel@inf.elte.hu>
	 <20231019174514.384ccca8@kernel.org>
	 <a05475db018e4e5ea8d24a62e6aab4e4@realtek.com>
 <47d463bce1ef62ecb34b666f21d7dd0d7439ac23.camel@inf.elte.hu>
In-Reply-To: <47d463bce1ef62ecb34b666f21d7dd0d7439ac23.camel@inf.elte.hu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.228.6]
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

RmVyZW5jIEZlamVzIDxmZWplc0BpbmYuZWx0ZS5odT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVy
IDIwLCAyMDIzIDI6MzQgUE0NClsuLi5dDQo+ID4gSG93ZXZlciwgSSBjaGVjayB0aGUgZmlybXdh
cmUgYW5kIGZpbmQgc29tZSB3cm9uZyBjb250ZW50Lg0KPiA+IENvdWxkIHlvdSByZW1vdmUgL2xp
Yi9maXJtd2FyZS9ydGxfbmljL3J0bDgxNTZiLTIuZncgYW5kIHVucGx1ZyB0aGUgZGV2aWNlLg0K
PiA+IFRoZW4sIHBsdWcgdGhlIGRldmljZSBhbmQgY2hlY2sgaXQgYWdhaW4uDQo+IA0KPiBZZXMs
IEknbGwgZG8gdGhhdCwgYnV0IHN0cmFuZ2VseSBlbm91Z2ggdGhlIGVycm9yIGhhcyBkaXNhcHBl
YXJlZCBzaW5jZQ0KPiB0aGVuLiBJIHBsYXllZCB3aXRoIHRoZSBzZXR1cCB5ZXN0ZXJkYXkgYSBs
aXR0bGUgbW9yZS4gVGhlIE5JQyBpcw0KPiBhY3R1YWxseSBidWlsdCBpbnRvIG15IG1vbml0b3Is
IHdoaWNoIGlzIGFsd2F5cyBwb3dlcmVkIG9uIC0gc28NCj4gcmVnYXJkbGVzcyBpZiBteSBsYXB0
b3AgY29ubmVjdGVkIG9yIG5vdCwgdGhlIE5JQyBpcyBwcm9iYWJseSBvbi4gSQ0KPiByZWJvb3Rl
ZCB0byBXaW5kb3dzLCBhbmQgdGhlbiByZWJvb3RlZCB0byBMaW51eCwgYW5kIG1hZ2ljYWxseSB0
aGUgYnVnDQo+IGp1c3QgZGlzYXBwZWFyZWQuDQo+IA0KPiBJcyB0aGlzIHBvc3NpYmxlL21ha2Vz
IHNlbnNlIHRvIHlvdT8NCg0KSSBndWVzcyBpdCBpcyByZWxhdGl2ZSB0byB0aGUgZmlybXdhcmUu
DQpNYXliZSB0aGUgd2luZG93cyBsb2FkIHRoZSBjb3JyZWN0IGZpcm13YXJlLCBhbmQgZml4IGl0
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpIYXllcw0KDQoNCg==

