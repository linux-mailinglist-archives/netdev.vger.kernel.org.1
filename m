Return-Path: <netdev+bounces-195196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0A6ACEC96
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EA93A3335
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947C2063FD;
	Thu,  5 Jun 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="kCmiJ2Jg"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144672632;
	Thu,  5 Jun 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749114450; cv=pass; b=LycqJ55M2r/KOLz5vG5M8clWyEF6Pv5xZoVEwGTE/oOpnlDWnxR2XD8KXhCjTMKqhbcyTnr00cPZe6ZZXHkmwueHURmlg9X+UfOf6KnsY/U8+bU6jIuerkV3IAPE4Jv/6GVtbVfjZDidNMPeRdMgrz/XbcTSsyFDCa+H1TVbLSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749114450; c=relaxed/simple;
	bh=YuXZNoDSxY8ZWsSaAxsDie1qYj+/azass5LBkX7s62Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tyIriIwkWTQssELcMXgPkq96nEj3ioG/7tTNlXzsDBzaoBM6ZD+XUdNYm5G3kGad+N+mrnwsJF79QtLgVjT0s+oVCIFg5Q0K2A26bFQDfrGi85l0zZMqfe1584GD5Uccidvph6CqjH4QlyOl9B9mLzDK60NzlJHCH1R7OuJmXM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=kCmiJ2Jg; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1749114413; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rjpt6qKRGn1eCDaHHFbnqdBmTl76gZ190K07Ep3xd/PpgpOZ9XV2M9SugdtLLsU+MR6MgwaPRt5B7OAhrJq0UkiQeIARFTgZ8oZ8U3dOvew23tIFyt7jj01aBhTRo6XkkWLPael/RfcwhDAsbGZdTokP5CJ8p3g1MFa0uEnVDPc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749114413; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YuXZNoDSxY8ZWsSaAxsDie1qYj+/azass5LBkX7s62Q=; 
	b=DQ8PQndLRHC4Z3ricZaTjtD8dhyd/fXFDdta90KS5gHqayp870u7ymwVdhXxmFvnHQtevBI/EpbHgyfwVMsSSKFopWK5/I4S1/Z+CYGGBsyQPL6+bhiKWbcpGdeIw34d3aMBc8/svfEWRvD/+m+aihybJYJ4GGYT/LYYx6YUafs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749114413;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=YuXZNoDSxY8ZWsSaAxsDie1qYj+/azass5LBkX7s62Q=;
	b=kCmiJ2JgxugIAbfP2AU7osvpY1sZq4U3VgU77Gy2+wGCjjcQFtOom4lxV2vPN46B
	jCEmUOZzXu2+hfiPeKP6B+y1NUo8at5iihGDSGEhUoqLu/HYVp66HYSuxSkG7VEdwiX
	OwvqW36pL3paH38laOB0y7BDPVc6VBRA3PsHx1jJ4DM7z4h/a/rei6ecLYtIZASRzCT
	stxkblh0fhfEt42lVpFoNACtdnwYD/tt5vuuE51LOCcbgsj93eW6JUJGOtfElF3BWg5
	NUBxmAd6fWBhPTgYHOTc6c/Q4BS7ZXs0iTr82ubr1UP3wlfMz3+SsH7O82gyyFg/nMZ
	Thm8NXWeOg==
Received: by mx.zohomail.com with SMTPS id 174911440997793.93705801338638;
	Thu, 5 Jun 2025 02:06:49 -0700 (PDT)
Message-ID: <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
From: Icenowy Zheng <uwu@icenowy.me>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chaoyi Chen <chaoyi.chen@rock-chips.com>, Matthias
 Schiffer <matthias.schiffer@ew.tq-group.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>,  Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 05 Jun 2025 17:06:43 +0800
In-Reply-To: <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
	 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
	 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
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

=E5=9C=A8 2025-06-04=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 14:23 +0200=EF=BC=
=8CAndrew Lunn=E5=86=99=E9=81=93=EF=BC=9A
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RX and TX delays are added by the M=
AC when required
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # RX and TX delays are provided by th=
e PCB. See below
> >=20
> > This really sounds like a breaking change that changes the meaning
> > of
> > the definition of this item instead of simply rewording.
> >=20
> > Everything written according to the original description is broken
> > by
> > this change.
>=20
> Please give some examples. What has broken, which was not already
> broken. There has been a lot of discussion about this over the last
> year, so please do some careful research about what has been said,
> and
> try not to repeat past discussion.

Yes, I saw many related discussions.

I have the same question with [1], what's the answer?

[1]
https://lore.kernel.org/netdev/271c15a45f41a110416f65d1f8a44b896aa01e33.cam=
el@ew.tq-group.com/

In addition, analyzing existing Ethernet drivers, I found two drivers
with contradition: stmicro/stmmac/dwmac-qcom-ethqos.c and
ti/icssg/icssg_prueth.c .

The QCOM ETHQOS driver enables the MAC's TX delay if the phy_mode is
rgmii or rgmii-rxid, and the PRU ETH driver, which works on some MAC
with hardcoded TX delay, rejects rgmii and rgmii-rxid, and patches
rgmii-id or rgmii-txid to remove the txid part.

The logic of QCOM ETHQOS clearly follows the original DT binding, which
describes "rgmii-id" as `RGMII with internal RX and TX delays provided
by the PHY, the MAC should not add the RX or TX delays in this case`
(the driver skips the delay for rgmii-id). The logic of PRU ETH follows
the logic of the new DT binding. This shows that the DT binding patch
is not a simple clarification, but a change of meanings.

>=20
> The whole point of this change is this is often wrongly interpreted,
> and there are a lot of broken .dts files. By including a lot of text,
> explaining both the pure OS agnostic DT meaning, and how Linux
> systems
> should implement it, i hope i have made it less ambiguous.
>=20
> > Although these PHYs are able to implement (or not to implement) the
> > delay, it's not promised that this could be overriden by the kernel
> > instead of being set up as strap pins.
>=20
> If you want the kernel to not touch the PHY, use
>=20
> phy-mode =3D 'internal'

This sounds weird, and may introduce side effect on the MAC side.

Well we might need to allow PHY to have phy-mode property in addition
to MAC, in this case MAC phy-mode=3D'rgmii*' and PHY phy-mode=3D'internal'
might work?

>=20
> > In addition, the Linux kernel contains a "Generic PHY" driver for
> > any
> > 802.1 c22 PHYs to work, without setting any delays.
>=20
> genphy is best effort, cross your fingers, it might work if you are
> luckily. Given the increasing complexity of PHYs, it is becoming less
> and less likely to work. From a Maintainers perspective, i only care
> if the system works with the proper PHY driver for the
> hardware. Anything else is unmaintainable.

Well this sounds unfortunate but reasonable.

>=20
> > > +#
> > > +# There are a small number of cases where the MAC has hard coded
> > > +# delays which cannot be disabled. The 'phy-mode' only describes
> > > the
> > > +# PCB.=C2=A0 The inability to disable the delays in the MAC does not
> > > change
> > > +# the meaning of 'phy-mode'. It does however mean that a 'phy-
> > > mode'
> > > of
> > > +# 'rgmii' is now invalid, it cannot be supported, since both the
> > > PCB
> > > +# and the MAC and PHY adding delays cannot result in a
> > > functional
> > > +# link. Thus the MAC should report a fatal error for any modes
> > > which
> >=20
> > Considering compatibilty, should this be just a warning (which
> > usually
> > means a wrong phy-mode setup) instead of a fatal error?
>=20
> As i said, there are a large number of broken DT blobs. In order to
> fix them, but not break backwards compatibility, some MAC and PHY
> drivers are going to have to check the strapping/bootloader
> configuration and issue a warning if phy-mode seems wrong, telling
> the
> user to update there DT blob. So, yes it is just a warning for
> systems
> that are currently broken, but i would consider it an error for
> correctly implemented systems.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Andrew


