Return-Path: <netdev+bounces-97913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC7D8CDF9E
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 05:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644F52819F5
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 03:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E69F23776;
	Fri, 24 May 2024 03:03:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948E36D;
	Fri, 24 May 2024 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716519822; cv=none; b=Ou5QfNDdzx/zMDWQU5Q0gs+NZpfRIQUa9awndi5c7WRtTxWn95zJUkpxUtohDnUL6NFkUUylHwSK0St4wYu8ZVLy+4UL8mygFLDVkVU1y8Pp49GnoEntXBQfrqWmZWUOCOWKExaNZlKjtT9kvs5XcwWzMbCsEpRwFQskIuLSXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716519822; c=relaxed/simple;
	bh=5CLxUi2MFwPXEOjZabtcR3HhcMOMCaeZv1f2kTCmVow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IO4OBCg2vSQOL0VlaAAcFIsHVqSaO8+8+FPxZg3kZsa4nTMEBPxRuUu3QO9Be4NfEPHDH6VHVcVYKeZ9sGtqjWN83LJ3RNWlDICHjiDDQMudS5iNw277LH6ySP9qEHHFB5rg/k9/GXyEO7yah9AGeNeX+gTb5tFej0vrs80IUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44O335wH41667479, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44O335wH41667479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 11:03:05 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 11:03:06 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 24 May 2024 11:03:05 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266]) by
 RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266%2]) with mapi id
 15.01.2507.035; Fri, 24 May 2024 11:03:05 +0800
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
Thread-Index: AQHaqC9Rjgvgl8xidUGsWwGzPtgZ5LGa66SAgAZDQWCAAA0PoP//58SAgAGQIND///9jAIAAjjtw//+ocQAAJ0pZ0AAFn2cAACqCRCA=
Date: Fri, 24 May 2024 03:03:05 +0000
Message-ID: <6dfaf8a97a9a4689ae642e4f909c7704@realtek.com>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-2-justinlai0215@realtek.com>
 <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch>
 <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>
 <97e30c5f-1656-46d0-b06c-3607a90ec96f@lunn.ch>
 <f9133a36bbae41138c3080f8f6282bfd@realtek.com>
 <7aab03ba-d8ed-4c9c-8bfd-b2bbed0a922d@lunn.ch>
 <5270598ca3fc4712ac46600fcc844d73@realtek.com>
 <0ec88b78-a9d3-4934-96cb-083b2abf7e2b@lunn.ch>
 <48072595c9c344fea9c268fd81e4d06e@realtek.com>
 <8c6ad434-ba3a-4acf-9b10-9dff8efd4ee5@lunn.ch>
In-Reply-To: <8c6ad434-ba3a-4acf-9b10-9dff8efd4ee5@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
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


> On Thu, May 23, 2024 at 06:29:55AM +0000, Larry Chiu wrote:
> >
> > > > Thank you very much for your clear reply.
> > > >
> > > > As I mentioned, it works like a NIC connected to an Ethernet Switch=
,
> not a
> > > > Management port.
> > > > The packets from this GMAC are routed according to switch rules suc=
h
> as
> > > > ACL, L2, .... and it does not control packet forwarding through any
> special
> > > > header or descriptor. In this case, we have our switch tool which i=
s
> used
> > > > for provisioning these rules in advance. Once the switch boots up, =
the
> > > > rules will be configured into the switch after the initialization. =
With this
> > > > driver and the provisioning by our switch tool, it can make switch
> forward
> > > > the frame as what you want. So it's not a DSA like device.
> > >
> > > How does spanning tree work? You need to send bridge PDUs out
> specific
> > > ports. Or do you not support STP and your network must never have
> > > loops otherwise it dies in a broadcast storm? That does not sound ver=
y
> > > reliable.
> > >
> > > There are other protocols which require sending packets out specific
> > > ports. Are they simply not supported?
> > >
> > This port is not a CPU port, nor a management port, and therefore does
> not
> > manage any protocols of the switch. These protocols are implemented by
> the
> > CPU inside the Ethernet switch core.
>=20
> So STP is on the switch CPU. Linux will run PTP as a leaf node, and
> rely on the switch also running PTP to manage PTP between the upstream
> port and the downstream port towards linux. IGMP snooping runs on the
> switch, and needs to listen to IGMP joins Linux sends out, etc.
>=20
Yes, STP, IGMP snooping, ... are working as you said. However, PTP may
have other special design to synchronize time with the other ports, and I
may not be able to explain in detail here.

> Do you have Linux running on the switch CPU? So you can reuse all the
> existing networking code and applications like ptp4l, or have the
> re-invented it all?
>=20
No, because this chip is used in automotive area and there are many safety =
and
security considerations. But AGL may be considered in the future.

> > This driver just service the transmit/receive packets for one port in t=
he
> RTL90xx
> > with PCIe interface. Other programs that the switch needs to execute ar=
e
> > managed by the CPU inside the switch core.
>=20
> So you are following the 40 year old model, a cable to an external
> device. Just be aware, it is an external device. Your interface to it
> is SNMP, telnet, http. It is very unlikely a kernel driver will be
> allowed to communicate with the switch.
>=20
>         Andrew

You are correct.
I think that is because it's not a CPU port, nor a management port.


