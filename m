Return-Path: <netdev+bounces-42887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593777D0809
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862731F22331
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D1B653;
	Fri, 20 Oct 2023 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC296AA4;
	Fri, 20 Oct 2023 05:59:39 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7480BD60;
	Thu, 19 Oct 2023 22:59:37 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39K5xKbL53842227, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39K5xKbL53842227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Oct 2023 13:59:20 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 20 Oct 2023 13:59:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 20 Oct 2023 13:59:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 20 Oct 2023 13:59:18 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>, Ferenc Fejes <fejes@inf.elte.hu>
CC: netdev <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: RE: r8152: error when loading the module
Thread-Topic: r8152: error when loading the module
Thread-Index: AQHaAu61PEdzvjx070SbRfjHpmK89LBSKe1Q
Date: Fri, 20 Oct 2023 05:59:18 +0000
Message-ID: <a05475db018e4e5ea8d24a62e6aab4e4@realtek.com>
References: <aff833bb8b202f12feed5b2682f1361f13e37581.camel@inf.elte.hu>
 <20231019174514.384ccca8@kernel.org>
In-Reply-To: <20231019174514.384ccca8@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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

Wy4uLl0NCj4gPiBPbiBteSBtYWNoaW5lIHI4MTUyIG1vZHVsZSBsb2FkaW5nIHRha2VzIGFib3V0
IG9uZSBtaW51dGUuDQo+ID4NCj4gPiBJdHMgYSBEZWJpYW4gU2lkOg0KPiA+IHVuYW1lIC1hDQo+
ID4gTGludXggcGMgNi41LjAtMi1hbWQ2NCAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIERlYmlhbiA2
LjUuNi0xICgyMDIzLTEwLTA3KSB4ODZfNjQgR05VL0xpbnV4DQo+IA0KPiBEaWQgdGhpcyBkZXZp
Y2Ugd29yayBmaW5lIHdpdGggb2xkZXIga2VybmVscyBvciB0aGlzIGlzIHRoZSBvbmx5IG9uZQ0K
PiB5b3UgdHJpZWQ/IFRoZSBjb2RlIGRvZXNuJ3Qgc2VlbSB0byBoYXZlIGNoYW5nZWQgYWxsIHRo
YXQgbXVjaCBzaW5jZQ0KPiBSVEw4MTU2QiBzdXBwb3J0IHdhcyBhZGRlZC4NCj4gDQo+ID4gZG1l
c2c6DQo+ID4NCj4gPg0KPiA+IFsgIDg5OS41MjIzMDZdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3
IGRldmljZSBkcml2ZXIgcjgxNTItY2Znc2VsZWN0b3INCj4gPiBbICA4OTkuNjAxMjk1XSByODE1
Mi1jZmdzZWxlY3RvciAyLTEuMzogcmVzZXQgU3VwZXJTcGVlZCBVU0IgZGV2aWNlIG51bWJlciA0
IHVzaW5nIHhoY2lfaGNkDQo+ID4gWyAgOTI3Ljc4OTUyNl0gcjgxNTIgMi0xLjM6MS4wOiBmaXJt
d2FyZTogZGlyZWN0LWxvYWRpbmcgZmlybXdhcmUgcnRsX25pYy9ydGw4MTU2Yi0yLmZ3DQo+ID4g
WyAgOTQyLjAzMzkwNV0gcjgxNTIgMi0xLjM6MS4wOiBsb2FkIHJ0bDgxNTZiLTIgdjIgMDQvMjcv
MjMgc3VjY2Vzc2Z1bGx5DQoNClNvbWVvbmUgcmVwb3J0cyB0aGVyZSBpcyBhbiBlcnJvciBtZXNz
YWdlIHdoZW4gbG9hZGluZyBydGw4MTU2Yi0yIHYyIDA0LzI3LzIzLg0KCXI4MTUyIDYtMToxLjA6
IHJhbSBjb2RlIHNwZWVkdXAgbW9kZSBmYWlsDQoNCkkgZG9uJ3QgZmluZCB0aGUgc2FtZSBtZXNz
YWdlIGZvciB5b3UuDQpIb3dldmVyLCBJIGNoZWNrIHRoZSBmaXJtd2FyZSBhbmQgZmluZCBzb21l
IHdyb25nIGNvbnRlbnQuDQpDb3VsZCB5b3UgcmVtb3ZlIC9saWIvZmlybXdhcmUvcnRsX25pYy9y
dGw4MTU2Yi0yLmZ3IGFuZCB1bnBsdWcgdGhlIGRldmljZS4NClRoZW4sIHBsdWcgdGhlIGRldmlj
ZSBhbmQgY2hlY2sgaXQgYWdhaW4uDQoNCj4gPiBbICA5NTYuMjY5NDQ0XSAtLS0tLS0tLS0tLS1b
IGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gPiBbICA5NTYuMjY5NDQ3XSBXQVJOSU5HOiBDUFU6
IDcgUElEOiAyMTEgYXQgZHJpdmVycy9uZXQvdXNiL3I4MTUyLmM6NzY2OCByODE1NmJfaHdfcGh5
X2NmZysweDE0MTcvMHgxNDMwIFtyODE1Ml0NCj4gPiBbICA5NTYuMjY5NDU4XSBNb2R1bGVzIGxp
bmtlZCBpbjogcjgxNTIoKykgaGlkX2xvZ2l0ZWNoX2hpZHBwIHVoaWQgY2NtDQoNCg0KQmVzdCBS
ZWdhcmRzLA0KSGF5ZXMNCg0KDQo=

