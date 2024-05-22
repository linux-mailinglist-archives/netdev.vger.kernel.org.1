Return-Path: <netdev+bounces-97592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029DD8CC37F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2570E1C20A6C
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1B17554;
	Wed, 22 May 2024 14:48:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BBD51E;
	Wed, 22 May 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389311; cv=none; b=Rqzj3bQ2kexjJQlXDoIOym5BCu4szfTFuJ9qdwOmxGVXGXb9MGSd4DOHaQod4hpm2QioyUiGCXyPSN1+P+6sdXcBIJcV9CtSN0dnnosWzTaeYozDn0PQTxMuLZojMV/i/v1b3irgi/urmBabKMUV9ulu1i7u8BEa9ivjlu/j89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389311; c=relaxed/simple;
	bh=kYiyoSu3eTSAEKyoGgy3/Zfqf9x9YulTGRuz7nOqDJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+1LI4UPfEW0pmQ7t71Eh5jqS/CH4R4ZYoJVAYErc3vK4S8GsrOHqKOuIGe1qAZ8o5JdVX+ANqwmDXj5N+frl3piQnfbGCeJLCmUxh9EH/wR4l+KUwqFOf1954ZtMbQPOLeA9lrroH3NRS/+gDKkwGR+8GUXRXOL2vAZN36GMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44MEloWB34024535, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44MEloWB34024535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 22:47:50 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 22:47:50 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 22 May 2024 22:47:50 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266]) by
 RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266%2]) with mapi id
 15.01.2507.035; Wed, 22 May 2024 22:47:50 +0800
From: Larry Chiu <larry.chiu@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Justin Lai <justinlai0215@realtek.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org" <horms@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: RE: [PATCH net-next v19 01/13] rtase: Add pci table supported in this module
Thread-Topic: [PATCH net-next v19 01/13] rtase: Add pci table supported in
 this module
Thread-Index: AQHaqC9Rjgvgl8xidUGsWwGzPtgZ5LGa66SAgAZDQWCAAA0PoP//58SAgAGQIND///9jAIAAjjtw
Date: Wed, 22 May 2024 14:47:50 +0000
Message-ID: <5270598ca3fc4712ac46600fcc844d73@realtek.com>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-2-justinlai0215@realtek.com>
 <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch>
 <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>
 <97e30c5f-1656-46d0-b06c-3607a90ec96f@lunn.ch>
 <f9133a36bbae41138c3080f8f6282bfd@realtek.com>
 <7aab03ba-d8ed-4c9c-8bfd-b2bbed0a922d@lunn.ch>
In-Reply-To: <7aab03ba-d8ed-4c9c-8bfd-b2bbed0a922d@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=20
> On Wed, May 22, 2024 at 04:43:11AM +0000, Larry Chiu wrote:
> >
> > > On Tue, May 21, 2024 at 06:20:04AM +0000, Larry Chiu wrote:
> > > >
> > > > >> + *  Below is a simplified block diagram of the chip and its rel=
evant
> > > interfaces.
> > > > >> + *
> > > > >> + *               *************************
> > > > >> + *               *                       *
> > > > >> + *               *  CPU network device   *
> > > > >> + *               *                       *
> > > > >> + *               *   +-------------+     *
> > > > >> + *               *   |  PCIE Host  |     *
> > > > >> + *               ***********++************
> > > > >> + *                          ||
> > > > >> + *                         PCIE
> > > > >> + *                          ||
> > > > >> + *      ********************++**********************
> > > > >> + *      *            | PCIE Endpoint |             *
> > > > >> + *      *            +---------------+             *
> > > > >> + *      *                | GMAC |                  *
> > > > >> + *      *                +--++--+  Realtek         *
> > > > >> + *      *                   ||     RTL90xx Series  *
> > > > >> + *      *                   ||                     *
> > > > >> + *      *     +-------------++----------------+    *
> > > > >> + *      *     |           | MAC |             |    *
> > > > >> + *      *     |           +-----+             |    *
> > > > >> + *      *     |                               |    *
> > > > >> + *      *     |     Ethernet Switch Core      |    *
> > > > >> + *      *     |                               |    *
> > > > >> + *      *     |   +-----+           +-----+   |    *
> > > > >> + *      *     |   | MAC |...........| MAC |   |    *
> > > > >> + *      *     +---+-----+-----------+-----+---+    *
> > > > >> + *      *         | PHY |...........| PHY |        *
> > > > >> + *      *         +--++-+           +--++-+        *
> > > > >> + *      *************||****************||***********
> > > > >> + *
> > > > >> + *  The block of the Realtek RTL90xx series is our entire chip
> > > > >> + architecture,
> > > > >> + *  the GMAC is connected to the switch core, and there is no P=
HY
> in
> > > between.
> > > > >
> > > > >Given this architecture, this driver cannot be used unless there i=
s a
> switch
> > > > >driver as well. This driver is nearly ready to be merged. So what =
are
> your
> > > > >plans for the switch driver? Do you have a first version you can p=
ost?
> That
> > > > >will reassure us you do plan to release a switch driver, and not u=
se a
> SDK in
> > > > >userspace.
> > > > >
> > > > >        Andrew
> > > >
> > > > Hi Andrew,
> > > > This GMAC is configured after the switch is boot-up and does not
> require a
> > > > switch driver to work.
> > >
> > > But if you cannot configure the switch, it is pointless passing the s=
witch
> > > packets. The Linux architecture is that Linux needs to be able to con=
trol
> the
> > > switch somehow. There needs to be a driver with the switchdev API on
> its
> > > upper side which connects it to the Linux network stack. Ideally the
> lower
> > > side of this driver can directly write switch registers. Alternativel=
y it can
> make
> > > some sort of RPC to firmware which configures the switch.
> > >
> > > Before committing this MAC driver, we will want to be convinced there=
 is
> a
> > > switchdev driver for the switch.
> > >
> > >         Andrew
> >
> >
> > I know what you mean.
> > But actually this GMAC works like a NIC connected to an Ethernet Switch
> not a
> > management port, its packets communicating with other ports.
>=20
> Linux has two different models for switches.
>=20
> The first is switchdev. Linux has a netdev per port of the switch, and
> use you those netdev's to manage the switch, just as if they are
> individual NICs.
>=20
> The second is very, very old, since the beginning of Ethernet
> switches. The cable comes out of the machine and plugs into the
> switch. Linux has no idea there is a switch there, the switch is just
> part of the magic if networking. This also means Linux cannot manage
> the switch, it is a different box, a different administration domain.
>=20
> The second model does not really work here. The switch is not in
> another box at the end of a cable. It is integrated into the SoC!
>=20
> > The PCIe Endpoint is a multi-function device, the other function is use=
d to
> > control the switch register, we are still working on where to put this =
driver
> in
> > Linux. We thought it should be separated into different device drivers,=
 or
> you
> > think we should register two pcie functions in this driver.
>=20
> Look at the architecture of other switch drivers. There are two broad
> categories.
>=20
> 1) Pure switchdev drivers, e.g. mellanox, sparx5, prestera. There is
> one driver which provides both the netdev interfaces per port, and
> implements the switchdev API for managing the switch.
>=20
> 2) DSA + switchdev, e.g. mv88e6xxx, rtl8365, starfigher2, etc. These
> use a conventional NIC to provide the conduit to pass packets to the
> switch. These packets have additional headers, added by a tag driver,
> indicating which port a packet should go out. And there is a switch
> driver, which makes use of the DSA framework to manage the switch. DSA
> provides the netdev per port.
>=20
> This is actually something i ask you about with version 1 of the
> patches. I've forget what your answer was, and we concentrated on
> getting your code up to mainline quality. Now it is time to go back to
> that question.
>=20
> How do you control where a packet passed over this GMAC NIC goes
> within the switch? Is there an additional header? Are their fields in
> the DMA descriptor?
>=20
> If your hardware is DSA like, you can write another driver which binds
> to a different PCI function. If however you use DMA descriptors, you
> need a pure switchdev driver, one driver which binds to multiple PCI
> functions.
>=20
>         Andrew

Thank you very much for your clear reply.

As I mentioned, it works like a NIC connected to an Ethernet Switch, not a
Management port.
The packets from this GMAC are routed according to switch rules such as
ACL, L2, .... and it does not control packet forwarding through any special
header or descriptor. In this case, we have our switch tool which is used=20
for provisioning these rules in advance. Once the switch boots up, the=20
rules will be configured into the switch after the initialization. With thi=
s=20
driver and the provisioning by our switch tool, it can make switch forward=
=20
the frame as what you want. So it's not a DSA like device.

In another case, we do have other function which is used for controlling=20
the switch registers instead of sending packets from the switch ports.
At the meanwhile, we are investigating how to implement the function to
Integrate into switchdev.

