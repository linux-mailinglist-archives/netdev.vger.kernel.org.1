Return-Path: <netdev+bounces-27535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6764577C526
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 03:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D71281301
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093417CF;
	Tue, 15 Aug 2023 01:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2717C4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 01:38:36 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9EC9E7;
	Mon, 14 Aug 2023 18:38:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37F1bPoC5018456, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37F1bPoC5018456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Aug 2023 09:37:25 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 15 Aug 2023 09:36:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 15 Aug 2023 09:36:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 15 Aug 2023 09:36:54 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Mario
 Limonciello" <mario.limonciello@amd.com>,
        "bjorn@mork.no" <bjorn@mork.no>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH net-next] eth: r8152: try to use a normal budget
Thread-Topic: [PATCH net-next] eth: r8152: try to use a normal budget
Thread-Index: AQHZzsT4UEeJMIn+UE+i+73nn0/m7a/qj0fw
Date: Tue, 15 Aug 2023 01:36:54 +0000
Message-ID: <1666467ba5ca480fb31f6507248f3476@realtek.com>
References: <20230814153521.2697982-1-kuba@kernel.org>
In-Reply-To: <20230814153521.2697982-1-kuba@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

akub Kicinski <kuba@kernel.org>
> Sent: Monday, August 14, 2023 11:35 PM
[...]
> Mario reports that loading r8152 on his system leads to a:
>=20
>   netif_napi_add_weight() called with weight 256
>=20
> warning getting printed. We don't have any solid data
> on why such high budget was chosen, and it may cause
> stalls in processing other softirqs and rt threads.
> So try to switch back to the default (64) weight.
>=20
> If this slows down someone's system we should investigate
> which part of stopping starting the NAPI poll in this
> driver are expensive.
>=20
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Link:
> https://lore.kernel.org/all/0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com
> /
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes


