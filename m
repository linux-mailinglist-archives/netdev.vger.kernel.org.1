Return-Path: <netdev+bounces-24826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB10771DA8
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51001C20A08
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C54CC8EF;
	Mon,  7 Aug 2023 09:59:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2DC2D6
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:59:02 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B393DA4;
	Mon,  7 Aug 2023 02:59:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3779vqRY3019363, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3779vqRY3019363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Mon, 7 Aug 2023 17:57:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 7 Aug 2023 17:57:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 7 Aug 2023 17:57:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 7 Aug 2023 17:57:15 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
        Jakub Kicinski
	<kuba@kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>,
        LKML
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: Error 'netif_napi_add_weight() called with weight 256'
Thread-Topic: Error 'netif_napi_add_weight() called with weight 256'
Thread-Index: AQHZw8h1VlKS4AgmjUKpznAl5+SYmK/Tp70AgAAC4ICACvPXQA==
Date: Mon, 7 Aug 2023 09:57:15 +0000
Message-ID: <8fcbab1aa2e14262bea79222bf7a4976@realtek.com>
References: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
 <20230731111330.5211e637@kernel.org>
 <673bc252-2b34-6ef9-1765-9c7cac1e8658@amd.com>
In-Reply-To: <673bc252-2b34-6ef9-1765-9c7cac1e8658@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TGltb25jaWVsbG8sIE1hcmlvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBU
dWVzZGF5LCBBdWd1c3QgMSwgMjAyMyAyOjI0IEFNDQpbLi4uXQ0KPiANCj4gPiBUaGUgY3VzdG9t
IHdlaWdodCBpcyBwcm9iYWJseSBkdWUgdG8gYSBtaXN1bmRlcnN0YW5kaW5nLiBXZSBoYXZlIDIw
MEcNCj4gPiBhZGFwdGVycyB1c2luZyB0aGUgc3RhbmRhcmQgd2VpZ2h0IG9mIDY0LCBJREsgd2h5
IDIuNUcgYWRhcHRlciB3b3VsZA0KPiA+IG5lZWQgYW55dGhpbmcgc3BlY2lhbC4NCj4gDQo+IFBl
cmhhcHMgSGF5ZXMgV2FuZyBjYW4gY29tbWVudCBvbiB0aGlzIChhcyB0aGUgYXV0aG9yIG9mIDE5
NWFhZTMyMWM4MikuDQoNCkkgdGVzdCBvdXIgZGV2aWNlcyBvbiBhbiBFbWJlZGRlZCBzeXN0ZW0u
DQpXZSBmaW5kIHRoZSB0aHJvdWdocHV0IGlzIGxvdy4NCkFuZCBpdCBpcyBjYXVzZWQgYnkgdGhl
IHdlaWdodC4NCk91ciBOQVBJIGZ1bmN0aW9uIG9mdGVuIHVzZXMgdGhlIHdob2xlIGJ1ZGdldC4N
CkZpbmFsbHksIHdlIGluY3JlYXNlIHRoZSB3ZWlnaHQsIGFuZCB0aGUgdGhyb3VnaHB1dCBpcyBn
b29kLg0KDQpCZXN0IFJlZ2FyZHMsDQpIYXllcw0KDQo=

