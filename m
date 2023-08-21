Return-Path: <netdev+bounces-29226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE4782331
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 07:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EFD1C2085D
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 05:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD95C15B3;
	Mon, 21 Aug 2023 05:32:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5341389
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 05:32:30 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3DF0A3;
	Sun, 20 Aug 2023 22:32:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37L5VLoK4004057, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37L5VLoK4004057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Aug 2023 13:31:21 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 21 Aug 2023 13:31:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 21 Aug 2023 13:31:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 21 Aug 2023 13:31:10 +0800
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
Thread-Index: AQHZz4Ya38d07ViN20S7bf3O9T4Qta/q9pcAgAMgk2D//87KAIABzfpQ///CfgCABJnu0A==
Date: Mon, 21 Aug 2023 05:31:09 +0000
Message-ID: <6d35d56f78b7452b9330c3257748fa3c@realtek.com>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
 <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
 <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
 <eb245c85-0909-4a75-830d-afb96ccd5d38@lunn.ch>
 <4951391892534eaeb2da96f052364e4c@realtek.com>
 <4b630aeb-3098-4108-b8dc-7da6e55a7cf1@lunn.ch>
In-Reply-To: <4b630aeb-3098-4108-b8dc-7da6e55a7cf1@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

> > > Is the 'line' speed of the MAC fixed? It operates at one speed, and t=
hat is
> it?
> >
> > Hi, Andrew
> >
>=20
> > The "line" speed of the MAC is fixed 5G, but the throughput will be
> > determined according to the speed of the PCIe link. For example, if
> > the link speed is gen 3, the throughput will be 5G. if the link speed
> > is gen 2, the throughput will be 2.5G. if the link speed is gen 1, the
> > throughput will be 1G.
>=20
> ksettings does not return throughput, it returns the line speed. throughp=
ut is
> determined by a lot of different things, can the CPU handle frames fast e=
nough,
> is the memory bandwidth high enough, what is happening on other ports of
> the PCIe switch etc.
>=20
> There is at least one driver i know of which reports a warning at probe t=
ime, if
> it finds the device is on a bus which cannot support the full bandwidth. =
Maybe
> copy that.
>=20

Hi, Andrew

Thanks for your guidance, we have represented the actual connection speed i=
n the next version.

> > There is no extra fields in DMA descriptors for tagging protocol. The
> > tag added by switch hardware instead of this driver.
>=20
> > > Are the I2C, MDIO and SPI bus masters also hanging off a PCIE
> > > endpoint? Can they probe independently? I'm just want to check this
> > > should not be part of an MFD driver.
> >
>=20
> > The I2C, MDIO and SPI bus masters are not hanging off the PCIE
> > endpoints, but on the switch core.
>=20
> So the switch core is also an PCIE endpoint?

Sorry, please allow me to explain again.
The RTL90xx Series supports I2C, MDC/MDIO and SPI slave to access the regis=
ters of Ethernet Switch Core and the external CPU could manage it via these=
 pins.
You are right, there is a tag protocol in the switch core. But It's for the=
 other ports, usually the cpu port, not this pcie gmac interface.
You can think of this pcie gmac as a NIC connecting to the external etherne=
t switch directly.

>=20
>    Andrew
> .

