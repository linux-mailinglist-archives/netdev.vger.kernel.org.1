Return-Path: <netdev+bounces-97693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ACB8CCC46
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066AF282580
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 06:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C6E13BC26;
	Thu, 23 May 2024 06:30:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773F13BAC4;
	Thu, 23 May 2024 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445833; cv=none; b=IC1a1ac3E398uiMHOa9k9a4hqpb8wR0l9/KEg2u0MwBXc0qZOBP0ycFjxDQzn45lUhAuSXEw8QHNjydwyKOQ1Y1Df3A9YKalzDCjL7OLASEJpCEPJQwmEgGmQw8Lv4czDpYlmsdsgJ77WmkmsR0KtiCmVG4wT7Q/qyKPGtmdAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445833; c=relaxed/simple;
	bh=81Q1awJnNJfynjAXnpzDQLqLmBBnJY2qpDFu3JBihuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=smA60nU8IFYSuYK7/FfADHFtO/ksmC9+BiKsyG1m0IHISMxRP4HZAWC8DXw2YdC6UG4kMuPeAAyLHNbSKeoSAeDVFscoK0/97yxhADcvVOdmPbZM+0ITHD0gOgUU2ltzxKqBTZSInn3hok4ilaHQi767CZmQa4Zs1DZLUEkiB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44N6TtYiA615525, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44N6TtYiA615525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 14:29:55 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 14:29:56 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 23 May 2024 14:29:55 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266]) by
 RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266%2]) with mapi id
 15.01.2507.035; Thu, 23 May 2024 14:29:55 +0800
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
Thread-Index: AQHaqC9Rjgvgl8xidUGsWwGzPtgZ5LGa66SAgAZDQWCAAA0PoP//58SAgAGQIND///9jAIAAjjtw//+ocQAAJ0pZ0A==
Date: Thu, 23 May 2024 06:29:55 +0000
Message-ID: <48072595c9c344fea9c268fd81e4d06e@realtek.com>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-2-justinlai0215@realtek.com>
 <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch>
 <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>
 <97e30c5f-1656-46d0-b06c-3607a90ec96f@lunn.ch>
 <f9133a36bbae41138c3080f8f6282bfd@realtek.com>
 <7aab03ba-d8ed-4c9c-8bfd-b2bbed0a922d@lunn.ch>
 <5270598ca3fc4712ac46600fcc844d73@realtek.com>
 <0ec88b78-a9d3-4934-96cb-083b2abf7e2b@lunn.ch>
In-Reply-To: <0ec88b78-a9d3-4934-96cb-083b2abf7e2b@lunn.ch>
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


> > Thank you very much for your clear reply.
> >
> > As I mentioned, it works like a NIC connected to an Ethernet Switch, no=
t a
> > Management port.
> > The packets from this GMAC are routed according to switch rules such as
> > ACL, L2, .... and it does not control packet forwarding through any spe=
cial
> > header or descriptor. In this case, we have our switch tool which is us=
ed
> > for provisioning these rules in advance. Once the switch boots up, the
> > rules will be configured into the switch after the initialization. With=
 this
> > driver and the provisioning by our switch tool, it can make switch forw=
ard
> > the frame as what you want. So it's not a DSA like device.
>=20
> How does spanning tree work? You need to send bridge PDUs out specific
> ports. Or do you not support STP and your network must never have
> loops otherwise it dies in a broadcast storm? That does not sound very
> reliable.
>=20
> There are other protocols which require sending packets out specific
> ports. Are they simply not supported?
>=20
This port is not a CPU port, nor a management port, and therefore does not=
=20
manage any protocols of the switch. These protocols are implemented by the
CPU inside the Ethernet switch core.

> > In another case, we do have other function which is used for controllin=
g
> > the switch registers instead of sending packets from the switch ports.
> > At the meanwhile, we are investigating how to implement the function to
> > Integrate into switchdev.
>=20
> In general, we don't support configuration of hardware from user
> space, which is what your switch tool sounds like. We will want to see
> a switchdev driver of some form.
>=20
> It might be you need to use VLAN overlays, using
> net/dsa/tag_8021q.c. Each port of the switch is given a dedicated
> VLAN, and the switch needs to add/strip the VLAN header. Its not
> great, but it does allow 'simple' switches to have basic functionality
> if they are missing header/dma descriptor support for selecting ports.
>=20
>         Andrew

Typically, a NIC connected to the network may go through a switch, as show
below. Our design saves the two PHYs in the middle and connects to the Host
through PCIe.

This driver just service the transmit/receive packets for one port in the R=
TL90xx
with PCIe interface. Other programs that the switch needs to execute are
managed by the CPU inside the switch core.

*               *************************
*               *                       *
*               *        PC/Host        *
*               *                       *
*               *   +-------------+     *
*               *   |      NIC    |     *
*               ***********++************
*                        | PHY |
*                          ||
*                        | PHY |                 =20
*            +-------------++----------------+   =20
*            |           | MAC |             |   =20
*            |           +-----+             |   =20
*            |                               |   =20
*            |     Ethernet Switch Core      |   =20
*            |                               |   =20
*            |   +-----+           +-----+   |   =20
*            |   | MAC |...........| MAC |   |   =20
*            +---+-----+-----------+-----+---+   =20
*                | PHY |...........| PHY |=20

                            |
                            |
                            |
                            V

*               *************************
*               *                       *
*               *        PC/Host        *
*               *                       *
*               *   +-------------+     *
*               *   |      NIC    |     *
*               ***********++************
*                          ||
*            +-------------++----------------+   =20
*            |           | MAC |             |   =20
*            |           +-----+             |   =20
*            |                               |   =20
*            |     Ethernet Switch Core      |   =20
*            |                               |   =20
*            |   +-----+           +-----+   |   =20
*            |   | MAC |...........| MAC |   |   =20
*            +---+-----+-----------+-----+---+   =20
*                | PHY |...........| PHY |=20

