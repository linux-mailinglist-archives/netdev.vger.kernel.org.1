Return-Path: <netdev+bounces-41113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0DA7C9D13
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 03:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC891C208B8
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 01:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6381369;
	Mon, 16 Oct 2023 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391CA15B5
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 01:50:39 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0DFA9;
	Sun, 15 Oct 2023 18:50:36 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39G1nsa271867289, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39G1nsa271867289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Oct 2023 09:49:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 16 Oct 2023 09:49:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 16 Oct 2023 09:49:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 16 Oct 2023 09:49:53 +0800
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
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v9 08/13] net:ethernet:realtek:rtase: Implement net_device_ops
Thread-Topic: [PATCH net-next v9 08/13] net:ethernet:realtek:rtase: Implement
 net_device_ops
Thread-Index: AQHZ8fl5hDe6qB9qzkmKif0/hXC9sLAvvsaAgAxiTMCAACtGAIAPdWXA
Date: Mon, 16 Oct 2023 01:49:53 +0000
Message-ID: <a3e8d48600984a70b23c72ce7edbc1d2@realtek.com>
References: <20230928104920.113511-1-justinlai0215@realtek.com>
 <20230928104920.113511-9-justinlai0215@realtek.com>
 <b28a3ea6-d75e-45e0-8b87-0b062b5c3a64@lunn.ch>
 <99dfcd7363dc412f877730fab4a9f7dd@realtek.com>
 <f4bcf3e9-d059-4403-a2b7-508806da9631@lunn.ch>
In-Reply-To: <f4bcf3e9-d059-4403-a2b7-508806da9631@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
> > > > +static void rtase_tx_timeout(struct net_device *dev, unsigned int
> > > > +txqueue) {
> > > > +     rtase_sw_reset(dev);
> > >
> > > Do you actually see this happening? The timeout is set pretty high,
> > > i think 5 seconds. If it does happen, it probably means you have a
> > > hardware/firmware bug. So you want to be noisy here, so you get to
> > > know about these problems, rather than silently work around them.
> >
> > I would like to ask if we can dump some information that will help us
> > understand the cause of the problem before doing the reset? And should
> > we use netdev_warn to print this information?
>=20
> You might want to look at 'devlink health'.
>=20
>     Andrew

Thank you for your suggestion.

