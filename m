Return-Path: <netdev+bounces-25860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C23577604E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8111C21221
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EFD18AFE;
	Wed,  9 Aug 2023 13:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4CE182D4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:13:00 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94C942100;
	Wed,  9 Aug 2023 06:12:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 379DBfAnA009807, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 379DBfAnA009807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Aug 2023 21:11:41 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 9 Aug 2023 21:11:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 9 Aug 2023 21:11:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 9 Aug 2023 21:11:57 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Limonciello, Mario" <mario.limonciello@amd.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Paul
 Menzel" <pmenzel@molgen.mpg.de>
Subject: RE: Error 'netif_napi_add_weight() called with weight 256'
Thread-Topic: Error 'netif_napi_add_weight() called with weight 256'
Thread-Index: AQHZw8h1VlKS4AgmjUKpznAl5+SYmK/Tp70AgAAC4ICACvPXQP//7sWAgANr4sA=
Date: Wed, 9 Aug 2023 13:11:57 +0000
Message-ID: <ba9b777754f7493ba14faa2dab7d8d59@realtek.com>
References: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
	<20230731111330.5211e637@kernel.org>
	<673bc252-2b34-6ef9-1765-9c7cac1e8658@amd.com>
	<8fcbab1aa2e14262bea79222bf7a4976@realtek.com>
 <20230807093727.5249f517@kernel.org>
In-Reply-To: <20230807093727.5249f517@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, August 8, 2023 12:37 AM
[...]
> > I test our devices on an Embedded system.
> > We find the throughput is low.
> > And it is caused by the weight.
> > Our NAPI function often uses the whole budget.
> > Finally, we increase the weight, and the throughput is good.
>=20
> Could it possibly be related to handling of aggregation?
> Problem must lay somewhere in USB specifics, since as I said
> there are 100Gbps devices running fine with budget of 64.

I think it depends on the platform.
Most of the platforms don't have the same situation.
Besides, I think the platform with 100Gbps device may
have faster CPU than that one which I test.

What would happen, if I set the weight to 256 on the platform
which runs well for the weight of 64?
Doesn't it only influence the slow platform?

Best Regards,
Hayes


