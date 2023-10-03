Return-Path: <netdev+bounces-37671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8AC7B6934
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CA46D1C203B8
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77A1F934;
	Tue,  3 Oct 2023 12:41:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27972915
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 12:41:01 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77ADB0;
	Tue,  3 Oct 2023 05:40:58 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 393CeLGW11998446, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 393CeLGW11998446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Oct 2023 20:40:23 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Oct 2023 20:40:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 3 Oct 2023 20:40:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 3 Oct 2023 20:40:21 +0800
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
Subject: RE: [PATCH net-next v9 02/13] net:ethernet:realtek:rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v9 02/13] net:ethernet:realtek:rtase: Implement
 the .ndo_open function
Thread-Index: AQHZ8fl23iE5gfcWPUefA6LhXZT8grAvrIqAgAhbNIA=
Date: Tue, 3 Oct 2023 12:40:20 +0000
Message-ID: <f3ff51ce080b441cbfe9309e286fc039@realtek.com>
References: <20230928104920.113511-1-justinlai0215@realtek.com>
 <20230928104920.113511-3-justinlai0215@realtek.com>
 <714dbb7d-3fb8-481e-aba1-01a1be992950@lunn.ch>
In-Reply-To: <714dbb7d-3fb8-481e-aba1-01a1be992950@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h
> > b/drivers/net/ethernet/realtek/rtase/rtase.h
> > index bae04cfea060..5314fceb72a2 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> > @@ -51,8 +51,6 @@
> >
> >  #define RX_BUF_SIZE (1522 + 1)
> >
> > -#define IVEC_NAME_SIZE IFNAMSIZ + 10
> > -
> >
> >
> /***************************************************************
> ******
> > ********/
> >  enum rtase_registers {
> >       RTASE_MAC0   =3D 0x0000,
> > @@ -261,6 +259,8 @@ union rx_desc {
> >  #define RTASE_IDLESLOPE_INT_SHIFT 25
> >  #define RTASE_IDLESLOPE_INT_MASK  GENMASK(31, 25)
> >
> > +#define IVEC_NAME_SIZE IFNAMSIZ + 10
> > +
>=20
> Please try to avoid moving things around which you just added in the prev=
ious
> patch.
>=20
> > +static int rtase_open(struct net_device *dev) {
> > +     struct rtase_private *tp =3D netdev_priv(dev);
> > +     struct rtase_int_vector *ivec =3D &tp->int_vector[0];
> > +     const struct pci_dev *pdev =3D tp->pdev;
> > +     int ret;
> > +     u16 i;
> > +
>=20
> > +     netif_carrier_on(dev);
> > +     netif_wake_queue(dev);
> > +     netdev_info(dev, "link up\n");
>=20
> No need to spam the log with this. Given the hardware architecture, the l=
ink is
> always going to be up.
>=20
>     Andrew

Hi, Andrew
Thank you for your reply, I will modify what you mentioned.

