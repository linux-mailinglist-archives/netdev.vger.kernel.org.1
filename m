Return-Path: <netdev+bounces-40022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520D27C56A7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B903282438
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80FE2032D;
	Wed, 11 Oct 2023 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5FC1F17E;
	Wed, 11 Oct 2023 14:21:27 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20295A7;
	Wed, 11 Oct 2023 07:21:25 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39BEL7p044148019, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39BEL7p044148019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 22:21:07 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 11 Oct 2023 22:21:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 11 Oct 2023 22:21:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 11 Oct 2023 22:21:06 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: "'Forest Crossman'" <cyrozap@gmail.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: r8152: "ram code speedup mode fail" error with latest RTL8156B firmware
Thread-Topic: r8152: "ram code speedup mode fail" error with latest RTL8156B
 firmware
Thread-Index: AQHZ+khmGvk6W8eY4k2TgkKkfMuCILBEIEiA
Date: Wed, 11 Oct 2023 14:21:06 +0000
Message-ID: <000701d9fc4e$2c178d90$8446a8b0$@realtek.com>
References: <CAO3ALPxXSkRVu4UO+TXse47FCFimfN+dYjvssocmaRQ3zdMDpg@mail.gmail.com>
In-Reply-To: <CAO3ALPxXSkRVu4UO+TXse47FCFimfN+dYjvssocmaRQ3zdMDpg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-ms-exchange-messagesentrepresentingtype: 1
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <B11C6DBF0E9D26498E7D2FBCDE50B652@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rm9yZXN0IENyb3NzbWFuIDxjeXJvemFwQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBPY3Rv
YmVyIDksIDIwMjMgODozMyBBTQ0KWy4uLl0NCj4gSGksIGFsbCwNCj4gDQo+IFdoaWxlIGxvb2tp
bmcgYXQgbXkga2VybmVsIGxvZyB0b2RheSBJIG5vdGljZWQgdGhlIGZvbGxvd2luZyBlcnJvcjoN
Cj4gDQo+ID4gcjgxNTIgNi0xOjEuMDogcmFtIGNvZGUgc3BlZWR1cCBtb2RlIGZhaWwNCj4gDQo+
IFRoZSBlcnJvciBhcHBlYXJzIHdoZW4gdXNpbmcgdGhlIGxhdGVzdCBSVEw4MTU2QiBmaXJtd2Fy
ZSAoMDQvMjcvMjMpLCBidXQNCj4gbm90IHdoZW4gdXNpbmcgdGhlIHByZXZpb3VzIHZlcnNpb24g
b2YgdGhlIGZpcm13YXJlICgwNC8xNS8yMSkuDQo+IA0KPiBJIGhhdmVuJ3QgcmVhbGx5IG5vdGlj
ZWQgYW55IG1hbGZ1bmN0aW9uIG9yIGRlZ3JhZGF0aW9uIGluIHRoZSBwZXJmb3JtYW5jZSBvZg0K
PiBteSBSVEw4MTU2QiBkZXZpY2UsIGJ1dCBJIGZpZ3VyZWQgSSdkIGJyaW5nIHRoaXMgdG8geW91
ciBhdHRlbnRpb24gYW55d2F5cyBqdXN0DQo+IGluIGNhc2UgZWl0aGVyIHNvbWV0aGluZyByZWFs
bHkgaXMgd3Jvbmcgd2l0aCB0aGUgZmlybXdhcmUgb3IgdGhlIGRyaXZlciBpcw0KPiBzaW1wbHkg
cHJpbnRpbmcgdGhlIGVycm9yIGJ5IG1pc3Rha2UuDQoNCkkgdGhpbmsgaXQgaXMgY2F1c2VkIGJ5
IHRoZSBjb250ZW50IG9mIHRoZSBmaXJtd2FyZSBvZiB0aGUgUEhZLg0KSSB3b3VsZCBjaGVjayBp
dC4NCg0KQmVzdCBSZWdhcmRzLA0KSGF5ZXMNCg0KDQo=

