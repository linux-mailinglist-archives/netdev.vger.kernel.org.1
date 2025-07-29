Return-Path: <netdev+bounces-210752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71144B14ACB
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CED3AF93C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB6A27A123;
	Tue, 29 Jul 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CB07qjmE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cccGYJjV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA37B15A8;
	Tue, 29 Jul 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780195; cv=none; b=lY3g4XME7LW+njw2cKJV5u6c+8Fy+5aWJ+9HHWZoAme2vulL7dYSxThrRYBVyEslm9ofQfEaEx+8HGFEsvQWlMqCA4vVqddi49anoLU8gnJm8ECqowMX7P8+1pUyGW7oVZj4i8dkwydKw6Ce5bjxdrNPIU+57MpJwdg4WGyJBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780195; c=relaxed/simple;
	bh=D/tOdqR0SfOGpqhv+w4E/qoFhLJZb57AQg4Q3hH+BGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqjyo2Yud8yXtIwCTeMES5iZn46kfxTtzL0zQBvTEeqrdSpY11+H3BKvLicKh1zCnoJo5XcpuBJtKuasioHG5e0YZ5GiHrN4Bsh4eP5bUPv8tbW+29IP0esCOSuuLQzweK0R1YX4MXg2jFw4mri841XwWbNQA4FY8mMza55y7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CB07qjmE; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cccGYJjV reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753780191; x=1785316191;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7nxrZ60AIQWic7u3GpZXKQS+4f6MYU2DIFzYEaCchXA=;
  b=CB07qjmE0wZYo/aLaQQreBF+BD/qlfVw9/iufJqCdTMr5o+bZmGaSTGI
   xQ9d+m7ZE7moucyxxt0joczN0UtqwR7ccgspgS+DYAvaMWJTCjLdY++eH
   zztwJRvlScHm9aiqnjltQ/leCJZ/sri7kiPNUig+7wxE+xDvZQwpZxHsm
   UigbMTqzE+2XI2qTCD9dvj8hj7vNdbzLhmM2TMHdnFqPW7Vxa+8/Q+NPD
   paxxZ29VA3mwtHq0MVsmjLGXgAaYwbhWL5Z/uuroRDz3XXcdY6MqolbEX
   zBqQwBXn32Amwi4GNZ0b8F9DRh+oD5ezTRlQro6O456SRft6L2bgA0Cdp
   A==;
X-CSE-ConnectionGUID: VF7S07ZPS2q4KCVLhS92Zw==
X-CSE-MsgGUID: myUVa8DhQ2eIfBZsfN/ZQw==
X-IronPort-AV: E=Sophos;i="6.16,348,1744063200"; 
   d="scan'208";a="45469678"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 Jul 2025 11:09:46 +0200
X-CheckPoint: {68888FDA-23-9BFD12F6-F51D5FD4}
X-MAIL-CPID: 2D85FC6484F8E6F0C0A0BB2DD72D21BA_3
X-Control-Analysis: str=0001.0A002104.68888FDC.0002,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5D871698FA;
	Tue, 29 Jul 2025 11:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753780182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nxrZ60AIQWic7u3GpZXKQS+4f6MYU2DIFzYEaCchXA=;
	b=cccGYJjVxS2rWXj2CwV2xOcVlL8FlhMveRRat6EJG3Yd3Itrqp5vh+X78j08PchJenS1LT
	Amv4i9rvuO5pOHlrMaVCc+3pyHUt0ift10I1SY7exa0QEjQ+2UQA8MQTH2e9sjhi5eWsA1
	T9N6qeuxqRvc5Xmmi7uIsbbxB4a33BFS+PLs8nB62OiC6wN7jTUhEeeuAyTOWjVP5e7kfL
	c6suHqIT2vzSp0shVxl+0THHXCwRspL88lGy8SMAy8sIJLgAtGtf1gxouqnN/khyMc/v9i
	7s5AqA8G+hVdsv4eKWawUi1HnBsGnarNx+zzdZ5ojnwJMtstwlLxgYEmgTh5Mg==
Message-ID: <2269f445fb233a55e63460351ab983cf3a6a2ed6.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup
 PHY mode for fixed RGMII TX delay"
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Nishanth Menon
	 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	 <kristo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roger Quadros
	 <rogerq@kernel.org>, Simon Horman <horms@kernel.org>, Siddharth Vadapalli
	 <s-vadapalli@ti.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Date: Tue, 29 Jul 2025 11:09:39 +0200
In-Reply-To: <DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org>
References: <20250728064938.275304-1-mwalle@kernel.org>
	 <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
	 <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
	 <d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
	 <DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 2025-07-29 at 10:47 +0200, Michael Walle wrote:
> Hi,
>=20
> > > > The patch being reverted says:
> > > >=20
> > > >    All am65-cpsw controllers have a fixed TX delay
> > > >=20
> > > > So we have some degree of contradiction here.
> > >=20
> > > I've digged through the old thread and Matthias just references the
> > > datasheet saying it is fixed. Matthias, could you actually try to
> > > set/read this bit? I'm not sure it is really read-only.
> >=20
> > I just referred to the datasheets of various K3 SoCs, I did not try mod=
ifying
> > the reserved bits.
>=20
> So can you try to modify them?

I can try some time this week.

>=20
> > > > > The u-boot driver (net/ti/am65-cpsw-nuss.c) will configure the de=
lay in
> > > > > am65_cpsw_gmii_sel_k3(). If the u-boot device tree uses rgmii-id =
this
> > > > > patch will break the transmit path because it will disable the PH=
Y delay
> > > > > on the transmit path, but the bootloader has already disabled the=
 MAC
> > > > > delay, hence there will be no delay at all.
> >=20
> > I have a patch that removes this piece of U-Boot code and had intended =
to submit
> > that soon to align the U-Boot driver with Linux again. I'll hold off un=
til we
> > know how the solution in Linux is going to look.
>=20
> That doesn't fix older bootloaders though. So in linux we still have
> to work around that.

I don't consider this something to "work around" but a necessary fix - ther=
e is
simply no way for Linux to do the right thing without knowing whether the M=
AC
adds delays (either by reading or writing the flag, if that actually does
anything).

>=20
> Although I don't get it why you want to remove that feature.

My patch was based on the assumption that these bits don't actually work, a=
s the
datasheet states that there is always a delay... but if this assumption is
wrong, I need to reconsider my approach.


>=20
> > > > We have maybe 8 weeks to fix this, before it makes it into a releas=
ed
> > > > kernel. So rather than revert, i would prefer to extend the patch t=
o
> > > > make it work with all variants of the SoC.
> > > >=20
> > > > Is CTRL_MMR0_CFG0_ENET1_CTRL in the Ethernet address space?
> > >=20
> > > No, that register is part of the global configuration space (search
> > > for phy_gmii_sel in the k3-am62p-j722s-common-main.dtsi), but is
> > > modeled after a PHY (not a network PHY). And actually, I've just
> > > found out that the PHY driver for that will serve the rgmii_id bit
> > > if .features has PHY_GMII_SEL_RGMII_ID_MODE set. So there is already
> > > a whitelist (although it's wrong at the moment, because the J722S
> > > SoC is not listed as having it). As a side note, the j722s also
> > > doesn't have it's own SoC specific compatible it is reusing the
> > > am654-phy-gmii-sel compatible. That might or might not bite us now..
> > >=20
> > > I digress..
> > >=20
> > > > Would it be possible for the MAC driver to read it, and know if the=
 delay has
> > > > been disabled? The switch statement can then be made conditional?
> > > >=20
> > > > If this register actually exists on all SoC variants, can we just
> > > > globally disable it, and remove the switch statement?
> >=20
> > If we just remove the switch statement, thus actually supporting all th=
e
> > different delay modes, we're back at the point where there is no way fo=
r the
> > driver to determine whether rgmii-rxid is supposed to be interpreted co=
rrectly
> > or not (currently all Device Trees using this driver require the old/in=
correct
> > interpretation for Ethernet to work).
>=20
> I can't follow you here. Are you assuming that the TX delay is
> fixed? For me, that's still the culprit. Is that a fair assumption?
> And only TI can tell us.

Right. In particular if it's the same for all K3 SoCs - I can only test AM6=
2,
AM64 and AM67A/J772S here.


>=20
> > > Given that all the handling is in the PHY subsystem I don't know.
> > > You'd have to ask the PHY if it supports that, before patching the
> > > phy-interface-mode - before attaching the network PHY I guess?
> >=20
> > The previous generation of the CPSW IP handles this in
> > drivers/net/ethernet/ti/cpsw-phy-sel.c, which is just a custom platform=
 device
> > referenced by the MAC node. The code currently (partially) implements t=
he
> > old/incorrect interpretation for phy-mode, enabling the delay on the MA=
C side
> > for PHY_INTERFACE_MODE_RGMII.
> >=20
> > >=20
> > > If we want to just disable (and I assume with disable you mean
> > > disable the MAC delay) it: the PHY is optional, not sure every SoC
> > > will have one. And also, the reset default is exactly the opposite
> > > and TI says it's fixed to the opposite and there has to be a reason
> > > for that.
> >=20
> > My preference would be to unconditionally enable the MAC-side delay on =
Linux to
> > align with the reset default and what the datasheet claims is the only =
supported
> > mode, but let's hear what the TI folks think about this.
>=20
> Which goes against Andrew's "lets to all the delays in the PHY". We
> have rgmii-id in our AM67A based board and we've actually measured
> the signals with and without the MAC delay.
>=20
> Last week, I've also opened an e2e forum case, maybe we get some
> more insights. Funny enough, TI seem to have a different register
> description where this bit is described.
> https://e2e.ti.com/support/processors-group/processors/f/processors-forum=
/1544031/am67a-internal-rgmii-delay/
>=20
> -michael

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

