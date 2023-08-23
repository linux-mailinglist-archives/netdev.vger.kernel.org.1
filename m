Return-Path: <netdev+bounces-30027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645B785A7C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D256281338
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92876C2CF;
	Wed, 23 Aug 2023 14:28:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E98C131
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:28:43 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87133E5F;
	Wed, 23 Aug 2023 07:28:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37NERwIsA030051, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37NERwIsA030051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Aug 2023 22:27:58 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 23 Aug 2023 22:28:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 23 Aug 2023 22:28:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 23 Aug 2023 22:28:20 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>
Subject: RE: [PATCH net-next v6 1/2] net/ethernet/realtek: Add Realtek automotive PCIe driver code
Thread-Topic: [PATCH net-next v6 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Thread-Index: AQHZ1KdKxMskTPV/qUeQjEQ9njC6tK/2FT0AgAHdc4A=
Date: Wed, 23 Aug 2023 14:28:20 +0000
Message-ID: <5ae1444b03f64e7287fc7abb6cd56063@realtek.com>
References: <20230822031805.4752-1-justinlai0215@realtek.com>
 <20230822031805.4752-2-justinlai0215@realtek.com>
 <aa7e5c75-e337-4150-bba5-a139ab4fc02f@lunn.ch>
In-Reply-To: <aa7e5c75-e337-4150-bba5-a139ab4fc02f@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>=20
> > +     do {
> > +             status =3D RTL_R32(tp, ivec->isr_addr);
> > +
> > +             handled =3D 1;
> > +             RTL_W32(tp, ivec->imr_addr, 0x0);
> > +             RTL_W32(tp, ivec->isr_addr, (status & ~FOVW));
> > +
> > +             if ((status & ivec->imr)) {
> > +                     if (likely(napi_schedule_prep(&ivec->napi)))
> > +                             __napi_schedule(&ivec->napi);
> > +             }
> > +     } while (false);
>=20
> Remember i said that if you do something which no other network driver do=
es,
> it is probably wrong. How many drivers have a do {} while (false); loop?
>=20
> Please spend a few days just reading other drivers, and compare your code
> with those drivers. Try to find all the things your driver does which no =
other
> driver has. That code is probably wrong and you should fix it.
>=20
>         Andrew
>=20
Thank you for your suggestions, I will read other drivers and modify some p=
roblems of this driver.

