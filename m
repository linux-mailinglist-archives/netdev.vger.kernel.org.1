Return-Path: <netdev+bounces-195224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED336ACEE15
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A5A1893D65
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80344219317;
	Thu,  5 Jun 2025 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="NT07QpkT"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21056215062;
	Thu,  5 Jun 2025 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120746; cv=pass; b=DEDiOL4u1IOdadNnQX9p10RcCt4/bJ+LzAdkm51hBse9b2kG/6VFAt+XBNXqNTNT93KH8wLXxSH5yPjdrhWKcHUoQMSuw06FtfhPqPQaQ/pXBXg20KoBrOZvoFxSUJPkMmpdP/4QzqpehZopUWXM1neMT0VwK9v0g4cSxuBcDKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120746; c=relaxed/simple;
	bh=3KAXOZuaBz9Dv9DJEb/iDjXU7Oc5bKzSDIHRfogA5wY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FwSS6Y23cMSCTvwb+2gxfXFZKAAMggufTBRWv0qEN8ZtiwljQeIp5pXPiT+mtwB5aSanpULm+qPA93MRaIeQDxB5ygb+SqU5Y9rVSHD0En/njktE0triVpDMxVgFRKelpMVt1s7oawYtjOkMWOOBmYSzwfoN8p6ZVwgTlU/uh/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=NT07QpkT; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1749120715; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O0k20jIieuJVJKHzhP6vy+maShQ2Fr0s32WLWJN6YvFFCwSH3M+JgJV7VXCvAJWZKdrLcj6Gu5pYGyianIBw7m1yvcXTCiTWKicR0Lg2FaDhpsgY+cvbuT+F3L17Cve2zzgMyZxWywK9V/I3O/Xrzck/i/xsuZPUIDQ9uD74kP4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749120715; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SAie0uRwKxnup3S4O6PlgMQP08g2PVUJ7Grj8M8zYe8=; 
	b=RQgAd0ptaTx1pINDT1scDu83sXABgeHMku4IKELEV4B3F/6Sb/yqYtRE47W4yeVaQzmESiiV941NytlTnyyX07GP8UXaoeIBJMrvYPMAnIiFzjEfSC6mROBvdX7QBiPL7tkTYt43TNZcbA6YJBAZIoVd8GKixrysQvW6zJTKLkI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749120715;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=SAie0uRwKxnup3S4O6PlgMQP08g2PVUJ7Grj8M8zYe8=;
	b=NT07QpkTvINCnNHuF7k1rEu84BUpvfkjM28N9wyo12B0nwJJo1Qcpb9kaLdwR+QY
	WL97IiJLjfiDdKNHum9quO7RyNOilSxEX3qk24d0qqD6BTubJREnSg++plcamVJwvlv
	bzxrG8eSKXIMy75eHjNjUSR1MK5p3xkAFfmuSGleAbBOAyo+xl5ezVQY15Jy7hZy47D
	tk/3kF0TlS/eA7Qv/3Zar+zmEZClS1gFkiQYw+xSGHqmygob2+iBEmmXFdmOMcjig6F
	0O70DEsRaB+HU+IwHbzaNqFS2M5nw9/FMApIq8Lk/4KQZf24Vh35CXww+sXtk4ZDNxf
	irNLb2Ve+Q==
Received: by mx.zohomail.com with SMTPS id 1749120712498839.2967324276685;
	Thu, 5 Jun 2025 03:51:52 -0700 (PDT)
Message-ID: <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
From: Icenowy Zheng <uwu@icenowy.me>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Heiner Kallweit
 <hkallweit1@gmail.com>,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Jun 2025 18:51:43 +0800
In-Reply-To: <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
	 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
	 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
	 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
	 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-06-05=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 10:41 +0100=EF=BC=
=8CRussell King (Oracle)=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Jun 05, 2025 at 05:06:43PM +0800, Icenowy Zheng wrote:
> > In addition, analyzing existing Ethernet drivers, I found two
> > drivers
> > with contradition: stmicro/stmmac/dwmac-qcom-ethqos.c and
> > ti/icssg/icssg_prueth.c .
> >=20
> > The QCOM ETHQOS driver enables the MAC's TX delay if the phy_mode
> > is
> > rgmii or rgmii-rxid, and the PRU ETH driver, which works on some
> > MAC
> > with hardcoded TX delay, rejects rgmii and rgmii-rxid, and patches
> > rgmii-id or rgmii-txid to remove the txid part.
>=20
> No, this is wrong.
>=20
> First, it does not reject any RGMII mode. See qcom_ethqos_probe() and
> the switch() in there. All four RGMII modes are accepted.

Well my sentence have its subject switched here. I mean the TI PRU ETH
driver is rejecting modes.

>=20
> The code in ethqos_rgmii_macro_init() is the questionable bit, but
> again, does _not_ do any rejection of any RGMII mode. It simply sets
> the transmit clock phase shift according to the mode, and the only
> way this can work is if the board does not provide the required
> delay.
>=20
> This code was not reviewed by phylib maintainers, so has slipped
> through the review process. It ought to be using the delay properties
> to configure the MAC.
>=20
> > The logic of QCOM ETHQOS clearly follows the original DT binding,
> > which
>=20
> Let's make this clear. "original DT binding" - no, nothing has
> *actually* changed with the DT binding - the meaning of the RGMII
> modes have not changed. The problem is one of interpretation, and
> I can tell you from personal experience that getting stuff documented
> so that everyone gets the same understanding is nigh on impossible.
> People will pick holes, and deliberately interpret whatever is
> written
> in ways that it isn't meant to - and the more words that are used the
> more this happens.

Well I am not sure, considering two examples I raised here (please note
I am comparing QCOM ETHQOS and TI PRUETH two drivers, they have
contrary handling of RGMII modes, and one matches the old binding
document, one matches the new one).

>=20
> The RGMII modes have been documented in
> Documentation/networking/phy.rst
> (Documentation/networking/phy.txt predating) since:

I checked the document here, and it seems that it's against the changed
binding document (it matches the original one):

The phy.rst document says:
```
* PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting
any
  internal delay by itself, it assumes that either the Ethernet MAC (if
capable)
  or the PCB traces insert the correct 1.5-2ns delay
```

The changed binding document says:
```
# If the PCB does not add these delays via extra long traces,
# 'rgmii-id' should be used. Here, 'id' refers to 'internal delay',
# where either the MAC or PHY adds the delay.
```

In the case of MAC inserting delays, the phy.rst document assumes it's
PHY_INTERFACE_MODE_RGMII but the changed binding document assumes it's
'rgmii-id'.

> commit bf8f6952a233f5084431b06f49dc0e1d8907969e
> Author: Florian Fainelli <f.fainelli@gmail.com>
> Date:=C2=A0=C2=A0 Sun Nov 27 18:45:14 2016 -0800
>=20
> =C2=A0=C2=A0=C2=A0 Documentation: net: phy: Add blurb about RGMII
>=20
> =C2=A0=C2=A0=C2=A0 RGMII is a recurring source of pain for people with Gi=
gabit
> Ethernet
> =C2=A0=C2=A0=C2=A0 hardware since it may require PHY driver and MAC drive=
r level
> =C2=A0=C2=A0=C2=A0 configuration hints. Document what are the expectation=
s from
> PHYLIB and
> =C2=A0=C2=A0=C2=A0 what options exist.
>=20
> =C2=A0=C2=A0=C2=A0 Reviewed-by: Martin Blumenstingl
> <martin.blumenstingl@googlemail.com>
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> =C2=A0=C2=A0=C2=A0 Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
> > describes "rgmii-id" as `RGMII with internal RX and TX delays
> > provided
> > by the PHY, the MAC should not add the RX or TX delays in this
> > case`
> > (the driver skips the delay for rgmii-id). The logic of PRU ETH
> > follows
> > the logic of the new DT binding. This shows that the DT binding
> > patch
> > is not a simple clarification, but a change of meanings.
>=20
> Let me say again. Nothing has changed. There is no "old binding" or
> "new binding". If you think there is, then it's down to
> misinterpretation.
>=20
> This is precisely why I've been opposed to documenting these
> properties
> in the binding document _and_ Documentation/networking/phy.* because
> keeping them both in sync is going to be a pain, leading to ambiguity
> and misinterpretation.
>=20
> > > If you want the kernel to not touch the PHY, use
> > >=20
> > > phy-mode =3D 'internal'
> >=20
> > This sounds weird, and may introduce side effect on the MAC side.
> >=20
> > Well we might need to allow PHY to have phy-mode property in
> > addition
> > to MAC, in this case MAC phy-mode=3D'rgmii*' and PHY phy-
> > mode=3D'internal'
> > might work?
>=20
> I'm not convinced that adding more possibilities to the problem
> (i.o.w.
> the idea that phy=3Dmode =3D "internal" can be used to avoid the delays
> being messed with) is a good idea - not at this point, because as you
> point out MACs (and PHYs) won't know that they need to be configured
> for RGMII mode. "internal" doesn't state this, and if we do start
> doing
> this, we'll end up with "internal" selecting RGMII mode which may
> work
> for some platforms but not all.
>=20
> So, IMHO this is a bad idea.
>=20
> > > > In addition, the Linux kernel contains a "Generic PHY" driver
> > > > for
> > > > any
> > > > 802.1 c22 PHYs to work, without setting any delays.
> > >=20
> > > genphy is best effort, cross your fingers, it might work if you
> > > are
> > > luckily. Given the increasing complexity of PHYs, it is becoming
> > > less
> > > and less likely to work. From a Maintainers perspective, i only
> > > care
> > > if the system works with the proper PHY driver for the
> > > hardware. Anything else is unmaintainable.
> >=20
> > Well this sounds unfortunate but reasonable.
>=20
> We're already in this state with PHYs faster than gigabit, because
> IEEE 802.3 in their wisdom did not define where the 1000BASE-T
> autoneg parameters appear in the register space. As a result, vendors
> have done their own thing, and every vendor / PHY is different.
> Without access to this key data, phylib has no way to know the
> negotiation results. Thus, a generic PHY driver that works correctly
> for PHYs > 1G just isn't possible.
>=20
> I expect that in years to come, we'll see IEEE 802.3 updated with
> the 1G registers for Clause 45 PHYs, but the boat has already sailed
> so this would be totally pointless as there will be too many PHYs
> out there doing their own thing for whatever IEEE 802.3 says about
> this to have any relevence what so ever. Just like they did with
> 2500BASE-X, which is a similar mess due to IEEE 802.3 being way too
> late.
>=20
> I hope that there isn't going to be more of this, because each time
> it happens, the IEEE 802.3 "standard" less relevant.
>=20


