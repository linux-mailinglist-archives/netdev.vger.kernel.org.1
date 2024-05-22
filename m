Return-Path: <netdev+bounces-97490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263818CBA66
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 06:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6044282700
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 04:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9344D7580A;
	Wed, 22 May 2024 04:43:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455B626CB;
	Wed, 22 May 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716353022; cv=none; b=QO5DXLbXUHyW2GgCAvIL2ZrbRbpfWKtgAe5pQJy+isB2d1B8V52gNN2tm3NZrLElxkxo9L0GE6bUuNg+R2JqVQZcSiwBzFI/prnF2p8bn2/K5u0LvL0fCmuVb7VH4Glf/xq9YZBmkKN1zxc46d7+NEzxo/P5XgiP2b/FPTtt7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716353022; c=relaxed/simple;
	bh=GifwPNjkmdSh84BrObBoXhtNIvv2Uc6L8fR11qFS1AI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=if2AJP/jkyAuar9n82Ms3ej47w90V0VEhELFlBurtZ7/JWRBhuVrMqCOx2r++4o7CS7g8t/r5bygdzZqxVzvVEw0k9G1Nv+ncYH+ImtcjeHHUkkbo/KynFYG0q+RjrITXGnJy59NnWxwNEuBUUsoF/vU1T1B88/QPWeQzTezu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44M4hCIa93476326, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44M4hCIa93476326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 12:43:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 12:43:12 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 22 May 2024 12:43:11 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266]) by
 RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266%2]) with mapi id
 15.01.2507.035; Wed, 22 May 2024 12:43:11 +0800
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
Thread-Index: AQHaqC9Rjgvgl8xidUGsWwGzPtgZ5LGa66SAgAZDQWCAAA0PoP//58SAgAGQINA=
Date: Wed, 22 May 2024 04:43:11 +0000
Message-ID: <f9133a36bbae41138c3080f8f6282bfd@realtek.com>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-2-justinlai0215@realtek.com>
 <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch>
 <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>
 <97e30c5f-1656-46d0-b06c-3607a90ec96f@lunn.ch>
In-Reply-To: <97e30c5f-1656-46d0-b06c-3607a90ec96f@lunn.ch>
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


> On Tue, May 21, 2024 at 06:20:04AM +0000, Larry Chiu wrote:
> >
> > >> + *  Below is a simplified block diagram of the chip and its relevan=
t
> interfaces.
> > >> + *
> > >> + *               *************************
> > >> + *               *                       *
> > >> + *               *  CPU network device   *
> > >> + *               *                       *
> > >> + *               *   +-------------+     *
> > >> + *               *   |  PCIE Host  |     *
> > >> + *               ***********++************
> > >> + *                          ||
> > >> + *                         PCIE
> > >> + *                          ||
> > >> + *      ********************++**********************
> > >> + *      *            | PCIE Endpoint |             *
> > >> + *      *            +---------------+             *
> > >> + *      *                | GMAC |                  *
> > >> + *      *                +--++--+  Realtek         *
> > >> + *      *                   ||     RTL90xx Series  *
> > >> + *      *                   ||                     *
> > >> + *      *     +-------------++----------------+    *
> > >> + *      *     |           | MAC |             |    *
> > >> + *      *     |           +-----+             |    *
> > >> + *      *     |                               |    *
> > >> + *      *     |     Ethernet Switch Core      |    *
> > >> + *      *     |                               |    *
> > >> + *      *     |   +-----+           +-----+   |    *
> > >> + *      *     |   | MAC |...........| MAC |   |    *
> > >> + *      *     +---+-----+-----------+-----+---+    *
> > >> + *      *         | PHY |...........| PHY |        *
> > >> + *      *         +--++-+           +--++-+        *
> > >> + *      *************||****************||***********
> > >> + *
> > >> + *  The block of the Realtek RTL90xx series is our entire chip
> > >> + architecture,
> > >> + *  the GMAC is connected to the switch core, and there is no PHY i=
n
> between.
> > >
> > >Given this architecture, this driver cannot be used unless there is a =
switch
> > >driver as well. This driver is nearly ready to be merged. So what are =
your
> > >plans for the switch driver? Do you have a first version you can post?=
 That
> > >will reassure us you do plan to release a switch driver, and not use a=
 SDK in
> > >userspace.
> > >
> > >        Andrew
> >
> > Hi Andrew,
> > This GMAC is configured after the switch is boot-up and does not requir=
e a
> > switch driver to work.
>=20
> But if you cannot configure the switch, it is pointless passing the switc=
h
> packets. The Linux architecture is that Linux needs to be able to control=
 the
> switch somehow. There needs to be a driver with the switchdev API on its
> upper side which connects it to the Linux network stack. Ideally the lowe=
r
> side of this driver can directly write switch registers. Alternatively it=
 can make
> some sort of RPC to firmware which configures the switch.
>=20
> Before committing this MAC driver, we will want to be convinced there is =
a
> switchdev driver for the switch.
>=20
>         Andrew


I know what you mean.
But actually this GMAC works like a NIC connected to an Ethernet Switch not=
 a=20
management port, its packets communicating with other ports.

The PCIe Endpoint is a multi-function device, the other function is used to=
=20
control the switch register, we are still working on where to put this driv=
er in=20
Linux. We thought it should be separated into different device drivers, or =
you=20
think we should register two pcie functions in this driver.

Larry

