Return-Path: <netdev+bounces-28794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD6C780B6F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5561C21619
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84E9182D6;
	Fri, 18 Aug 2023 11:56:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F7182CF
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:56:54 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 720052D4F;
	Fri, 18 Aug 2023 04:56:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37IBu8jZ5023526, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37IBu8jZ5023526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Aug 2023 19:56:08 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 18 Aug 2023 19:56:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 18 Aug 2023 19:56:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 18 Aug 2023 19:56:28 +0800
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
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek automotive PCIe driver code
Thread-Topic: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Thread-Index: AQHZz4Ya38d07ViN20S7bf3O9T4Qta/q9pcAgAMgk2D//87KAIABzfpQ
Date: Fri, 18 Aug 2023 11:56:28 +0000
Message-ID: <4951391892534eaeb2da96f052364e4c@realtek.com>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
 <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
 <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
 <eb245c85-0909-4a75-830d-afb96ccd5d38@lunn.ch>
In-Reply-To: <eb245c85-0909-4a75-830d-afb96ccd5d38@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

> On Thu, Aug 17, 2023 at 07:32:07AM +0000, Justin Lai wrote:
> > > On Tue, Aug 15, 2023 at 10:37:55PM +0800, Justin Lai wrote:
> > > > This patch is to add the ethernet device driver for the PCIe
> > > > interface of Realtek Automotive Ethernet Switch, applicable to
> > > > RTL9054, RTL9068,
> > > RTL9072, RTL9075, RTL9068, RTL9071.
> > > >
> > > > Below is a simplified block diagram of the chip and its relevant
> interfaces.
> > > >
> > > >           *************************
> > > >           *                       *
> > > >           *  CPU network device   *
> > > >           *    ____________       *
> > > >           *   |            |      *
> > > >           *   |  PCIE Host |      *
> > > >           *************************
> > > >                     ||
> > > >                    PCIE
> > > >                     ||
> > > >   ****************************************
> > > >   *          | PCIE Endpoint |           *
> > > >   *          |---------------|           *
> > > >   *              | GMAC |                *
> > > >   *              |------|  Realtek       *
> > > >   *                 ||   RTL90xx Series  *
> > > >   *                 ||                   *
> > > >   *    _____________||______________     *
> > > >   *   |            |MAC|            |    *
> > > >   *   |            |---|            |    *
> > > >   *   |                             |    *
> > > >   *   |     Ethernet Switch Core    |    *
> > > >   *   |                             |    *
> > > >   *   |  -----             -----    |    *
> > > >   *   |  |MAC| ............|MAC|    |    *
> > > >   *   |__|___|_____________|___|____|    *
> > > >   *      |PHY| ............|PHY|         *
> > > >   *      -----             -----         *
> > > >   *********||****************||***********
> > > > This driver is mainly used to control GMAC, but does not control
> > > > the switch
> > > core, so it is not the same as DSA.
> > > > In addition, the GMAC is not directly connected to the PHY, but
> > > > directly connected to the mac of the switch core, so there is no
> > > > need for PHY
> > > handing.
> > >
> > > So this describes your board? Is the MAC and the swtich two separate
> > > chips? Is it however possible to connect the GMAC to a PHY? Could
> > > some OEM purchase the chipset and build a board with a PHY? We write
> > > MAC drivers around what the MAC can do, not what one specific board
> allows.
> > >
> > > What MAC drivers do to support being connected to a switch like this
> > > is use a fixed-link PHY, via phylink. This gives a virtual PHY, which=
 supports
> one speed.
> > > The MAC driver then just uses the phylink API as normal.
> > >
> > > On your board, how is the switch controlled? Is there an MDIO bus as
> > > part of the MAC? If so, you should add an MDIO bus master driver.
> >
> >
> > Hi, Andrew
> >
> > The block of the Realtek RTL90xx series is our entire chip
> > architecture, the GMAC is connected to the switch core, and there is
> > no PHY in between. So customers don't need to consider that.
>=20
> O.K. It would of been helpful if you had said this right at the beginning=
. It is
> good to point out anything unusual with your hardware, otherwise reviewer=
s
> are going to make wrong assumptions, and then ask lots of questions.
>=20
> Is the 'line' speed of the MAC fixed? It operates at one speed, and that =
is it?

Hi, Andrew

The "line" speed of the MAC is fixed 5G, but the throughput will be determi=
ned according to the speed of the PCIe link. For example, if the link speed=
 is gen 3, the throughput will be 5G. if the link speed is gen 2, the throu=
ghput will be 2.5G. if the link speed is gen 1, the throughput will be 1G.

> What about pause? You cannot negotiate pause, but can it be forced?
We do not support negotiate pause, but it can be forced.
=20
> > We have some externally controlled interfaces to control switch core,
> > such as I2C, MDIO, SPI, etc., but these are not controlled by GMAC .
>=20
> And just for conformation, there is no extra fields in the DMA descriptor=
s, etc,
> to help the switch? You will at some point write a DSA driver for the swi=
tch,
> and there will be a tagging protocol, extra headers added to the frame, i=
n
> order to direct frames out the correct port of the switch?

There is no extra fields in DMA descriptors for tagging protocol. The tag a=
dded by switch hardware instead of this driver.
>=20
> Are the I2C, MDIO and SPI bus masters also hanging off a PCIE endpoint? C=
an
> they probe independently? I'm just want to check this should not be part =
of an
> MFD driver.

The I2C, MDIO and SPI bus masters are not hanging off the PCIE endpoints, b=
ut on the switch core.
>=20
> Is there a public data sheet for this device?

We currently do not have a public data sheet to provide.
>=20
>         Andrew
>=20

