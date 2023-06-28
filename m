Return-Path: <netdev+bounces-14366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D0D7407C6
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 03:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5402810E2
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 01:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5811377;
	Wed, 28 Jun 2023 01:49:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1B1376
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 01:49:43 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCB3226AB;
	Tue, 27 Jun 2023 18:49:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35S1mxv27015071, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35S1mxv27015071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Wed, 28 Jun 2023 09:48:59 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 28 Jun 2023 09:48:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 28 Jun 2023 09:48:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 28 Jun 2023 09:48:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: You Kangren <youkangren@vivo.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        "open list:MAC80211" <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
CC: "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: =?utf-8?B?UkU6IFtQQVRDSF0gd2lmae+8mm1hYzgwMjExOiBSZXBsYWNlIHRoZSB0ZXJu?= =?utf-8?Q?ary_conditional_operator_with_max()?=
Thread-Topic: =?utf-8?B?W1BBVENIXSB3aWZp77yabWFjODAyMTE6IFJlcGxhY2UgdGhlIHRlcm5hcnkg?=
 =?utf-8?Q?conditional_operator_with_max()?=
Thread-Index: AQHZqBvNKITprNb9K06+yWJl2zb8J6+fcjiA
Date: Wed, 28 Jun 2023 01:48:31 +0000
Message-ID: <9e4e3bf85ed945e7b0c8d5d389065670@realtek.com>
References: <20230626104829.1896-1-youkangren@vivo.com>
In-Reply-To: <20230626104829.1896-1-youkangren@vivo.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.69.188]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWW91IEthbmdyZW4gPHlv
dWthbmdyZW5Adml2by5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAyNiwgMjAyMyA2OjQ4IFBN
DQo+IFRvOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PjsgRGF2aWQg
Uy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpl
dEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFi
ZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IG9wZW4NCj4gbGlzdDpNQUM4MDIxMSA8bGludXgtd2ly
ZWxlc3NAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0Ok5FVFdPUktJTkcgW0dFTkVSQUxdIDxu
ZXRkZXZAdmdlci5rZXJuZWwub3JnPjsNCj4gb3BlbiBsaXN0IDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPg0KPiBDYzogb3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb207IHlvdWthbmdyZW5A
dml2by5jb20NCj4gU3ViamVjdDogW1BBVENIXSB3aWZp77yabWFjODAyMTE6IFJlcGxhY2UgdGhl
IHRlcm5hcnkgY29uZGl0aW9uYWwgb3BlcmF0b3Igd2l0aCBtYXgoKQ0KDQpUaGUgc2VtaWNvbG9u
IG9mICJ3aWZp77yaIiBpcyBkaWZmZXJlbnQgZnJvbSBvdGhlcnMuDQoNCj4gDQo+IFJlcGxhY2Ug
dGhlIHRlcm5hcnkgY29uZGl0aW9uYWwgb3BlcmF0b3Igd2l0aCBtYXgoKSB0byBtYWtlIHRoZSBj
b2RlIGNsZWFuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb3UgS2FuZ3JlbiA8eW91a2FuZ3JlbkB2
aXZvLmNvbT4NCj4gLS0tDQo+ICBuZXQvbWFjODAyMTEvdGRscy5jIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbmV0L21hYzgwMjExL3RkbHMuYyBiL25ldC9tYWM4MDIxMS90ZGxzLmMNCj4gaW5kZXggYTRh
ZjNiNzY3NWVmLi45ZjhiMDg0MmE2MTYgMTAwNjQ0DQo+IC0tLSBhL25ldC9tYWM4MDIxMS90ZGxz
LmMNCj4gKysrIGIvbmV0L21hYzgwMjExL3RkbHMuYw0KPiBAQCAtOTQ2LDcgKzk0Niw3IEBAIGll
ZWU4MDIxMV90ZGxzX2J1aWxkX21nbXRfcGFja2V0X2RhdGEoc3RydWN0IGllZWU4MDIxMV9zdWJf
aWZfZGF0YSAqc2RhdGEsDQo+ICAgICAgICAgaW50IHJldDsNCj4gICAgICAgICBzdHJ1Y3QgaWVl
ZTgwMjExX2xpbmtfZGF0YSAqbGluazsNCj4gDQo+IC0gICAgICAgbGlua19pZCA9IGxpbmtfaWQg
Pj0gMCA/IGxpbmtfaWQgOiAwOw0KPiArICAgICAgIGxpbmtfaWQgPSBtYXgobGlua19pZCwgMCk7
DQoNCk9yaWdpbmFsIGxvZ2ljIG1lYW5zICJpZiBsaW5rX2lkIDwgMCwgdGhlbiB1c2UgZGVmYXVs
dCBsaW5rICgwKSIgaW5zdGVhZCBvZg0KImFsd2F5cyB1c2UgbGlua19pZCBsYXJnZXIgdGhhbiBv
ciBlcXVhbCB0byAwIi4gU28sIEkgdGhpbmsgbWF4KGxpbmtfaWQsIDApIGNvdWxkDQpjYXVzZSBt
aXN1bmRlcnN0YW5kaW5nLiANCg0KPiAgICAgICAgIHJjdV9yZWFkX2xvY2soKTsNCj4gICAgICAg
ICBsaW5rID0gcmN1X2RlcmVmZXJlbmNlKHNkYXRhLT5saW5rW2xpbmtfaWRdKTsNCj4gICAgICAg
ICBpZiAoV0FSTl9PTighbGluaykpDQo+IC0tDQo+IDIuMzkuMA0KPiANCj4gDQo+IC0tLS0tLVBs
ZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWls
Lg0K

