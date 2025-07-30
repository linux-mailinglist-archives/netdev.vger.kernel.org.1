Return-Path: <netdev+bounces-210999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B2B161B6
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B8F3BAEC0
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A062D7807;
	Wed, 30 Jul 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lpBt/uFu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DhzlhYOG"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68662D6634;
	Wed, 30 Jul 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883111; cv=none; b=nIKQ0SvpspWTjOHX/6EYTEgOv9w3NDu98fIXnZRODRUklLVGZoV7N4+YEMqxIJ5Doe5BePIowy5WsW3zMNcG14dcDOQdjouWEYO/+aHB7b3Q7TkizxMqyu1hugowJISdlWyqfyhs9yKP1H1fCPiF+EMCOWqNmFXxCUFOd9ACufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883111; c=relaxed/simple;
	bh=OQzgIsa7aSUBtWJImovG8CfnyC21YUm4Y5An40++jks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rIn5Nq79+fNH+YfQncvH6/7HKewTAHm1R8EHgTioK4qYCCRUj19440PNmwngd6PNOg6ysw94FvwtLEZ0pJlsh4EPmJsUA4SNXkWgYNNdwGpn3XakHWW9SXa8EiFjcPoi1+df7tCaYxNIQghSsMMDbtWSItzaUfiTFjRKrqy6VHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lpBt/uFu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=DhzlhYOG reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753883107; x=1785419107;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TYctwlqE4c17e9JAFfs99tJv4ZG+mGML0p/1/myql10=;
  b=lpBt/uFuYA1fWAtYtDwQG81uUrvT2bzWiVJZKYXl1BaKF/BFV7/Op1Xl
   wNzZkp6Un/DKpYZFRobXbAxnR3k4gPpH36ic5ZR42e8nJ9TBMlyXJzZff
   e2One3Ht2vhDDsp1Df36pUwLzJMSRQyBk2DwmFVeeUqMl1yt/rMRxpQzs
   pJFhl4xXuw++OOPhWxd+UrjziYVT4OM2aDY5pgcCPXoD6RISVAYQy473i
   86KbQVzNVj2w/EPdGmuK6P/Jbx7HcYjVydv5OIBCPIX2oF5qxwh0m+Jbc
   X+pvyIOTaOb2tZIoXAIRQMcYyH8w0KUPBVRAfdWovaQGjg8vwViGe7rva
   w==;
X-CSE-ConnectionGUID: cuvZQCj9RaeSGYokLmhdcA==
X-CSE-MsgGUID: Nq2lMiOmThiZdc5tfst/PA==
X-IronPort-AV: E=Sophos;i="6.16,350,1744063200"; 
   d="scan'208";a="45499918"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 30 Jul 2025 15:44:57 +0200
X-CheckPoint: {688A21D9-C-943DFC15-D71A48EE}
X-MAIL-CPID: F9500D448A178A2672AEAC09F23508C1_5
X-Control-Analysis: str=0001.0A002106.688A21E1.0029,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21238169696;
	Wed, 30 Jul 2025 15:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753883092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYctwlqE4c17e9JAFfs99tJv4ZG+mGML0p/1/myql10=;
	b=DhzlhYOGZzTmkA4C4uEUJcLfwD12MisNpnKTDxmzqTbpFmOcfNxmnQ+cfZxWW0BgwNUe0d
	hQwAaFLu+eeZRfde4J4lovxbzbpNOxSqRsx/Mo8awhzMW5W/gU00y7unuwzXTSKpJX8MSV
	095Y9gZgOg3EOubhQks+AI5YcKeRhaM3zUnlNK7z2LcetZKYSGYqwrCmawqTYpB+Pa2zIG
	EHxIWr2Z3m9ZoJJJKa7Vk0bIMGzBS2zqVrtQCX7aWM/6+Zm4sAc46kxZCg3tWc+rhqZf3N
	KiPQXXjM7Dct5QRew0RJL9sFSurq6p1HzzMToYRAeCBjZXw/3+onugyvftYkGA==
Message-ID: <88972e3aa99d7b9f4dd1967fbb445892829a9b47.camel@ew.tq-group.com>
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
Date: Wed, 30 Jul 2025 15:44:49 +0200
In-Reply-To: <2269f445fb233a55e63460351ab983cf3a6a2ed6.camel@ew.tq-group.com>
References: <20250728064938.275304-1-mwalle@kernel.org>
	 <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
	 <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
	 <d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
	 <DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org>
	 <2269f445fb233a55e63460351ab983cf3a6a2ed6.camel@ew.tq-group.com>
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

On Tue, 2025-07-29 at 11:09 +0200, Matthias Schiffer wrote:
> On Tue, 2025-07-29 at 10:47 +0200, Michael Walle wrote:
> > Hi,
> >=20
> > > > > The patch being reverted says:
> > > > >=20
> > > > >    All am65-cpsw controllers have a fixed TX delay
> > > > >=20
> > > > > So we have some degree of contradiction here.
> > > >=20
> > > > I've digged through the old thread and Matthias just references the
> > > > datasheet saying it is fixed. Matthias, could you actually try to
> > > > set/read this bit? I'm not sure it is really read-only.
> > >=20
> > > I just referred to the datasheets of various K3 SoCs, I did not try m=
odifying
> > > the reserved bits.
> >=20
> > So can you try to modify them?
>=20
> I can try some time this week.

I can confirm that the undocumented/reserved bit switches the MAC-side TX d=
elay
on and off on the J722S/AM67A. I have not checked if there is anything wron=
g
with the undelayed mode that might explain why TI doesn't want to support i=
t,
but traffic appears to flow through the interface without issue if I disabl=
e the
MAC-side and enable the PHY-side delay.

>=20
> >=20
> > > > > > The u-boot driver (net/ti/am65-cpsw-nuss.c) will configure the =
delay in
> > > > > > am65_cpsw_gmii_sel_k3(). If the u-boot device tree uses rgmii-i=
d this
> > > > > > patch will break the transmit path because it will disable the =
PHY delay
> > > > > > on the transmit path, but the bootloader has already disabled t=
he MAC
> > > > > > delay, hence there will be no delay at all.
> > >=20
> > > I have a patch that removes this piece of U-Boot code and had intende=
d to submit
> > > that soon to align the U-Boot driver with Linux again. I'll hold off =
until we
> > > know how the solution in Linux is going to look.
> >=20
> > That doesn't fix older bootloaders though. So in linux we still have
> > to work around that.
>=20
> I don't consider this something to "work around" but a necessary fix - th=
ere is
> simply no way for Linux to do the right thing without knowing whether the=
 MAC
> adds delays (either by reading or writing the flag, if that actually does
> anything).
>=20
> >=20
> > Although I don't get it why you want to remove that feature.
>=20
> My patch was based on the assumption that these bits don't actually work,=
 as the
> datasheet states that there is always a delay... but if this assumption i=
s
> wrong, I need to reconsider my approach.
>=20
>=20
> >=20
> > > > > We have maybe 8 weeks to fix this, before it makes it into a rele=
ased
> > > > > kernel. So rather than revert, i would prefer to extend the patch=
 to
> > > > > make it work with all variants of the SoC.
> > > > >=20
> > > > > Is CTRL_MMR0_CFG0_ENET1_CTRL in the Ethernet address space?
> > > >=20
> > > > No, that register is part of the global configuration space (search
> > > > for phy_gmii_sel in the k3-am62p-j722s-common-main.dtsi), but is
> > > > modeled after a PHY (not a network PHY). And actually, I've just
> > > > found out that the PHY driver for that will serve the rgmii_id bit
> > > > if .features has PHY_GMII_SEL_RGMII_ID_MODE set. So there is alread=
y
> > > > a whitelist (although it's wrong at the moment, because the J722S
> > > > SoC is not listed as having it). As a side note, the j722s also
> > > > doesn't have it's own SoC specific compatible it is reusing the
> > > > am654-phy-gmii-sel compatible. That might or might not bite us now.=
.
> > > >=20
> > > > I digress..
> > > >=20
> > > > > Would it be possible for the MAC driver to read it, and know if t=
he delay has
> > > > > been disabled? The switch statement can then be made conditional?
> > > > >=20
> > > > > If this register actually exists on all SoC variants, can we just
> > > > > globally disable it, and remove the switch statement?
> > >=20
> > > If we just remove the switch statement, thus actually supporting all =
the
> > > different delay modes, we're back at the point where there is no way =
for the
> > > driver to determine whether rgmii-rxid is supposed to be interpreted =
correctly
> > > or not (currently all Device Trees using this driver require the old/=
incorrect
> > > interpretation for Ethernet to work).
> >=20
> > I can't follow you here. Are you assuming that the TX delay is
> > fixed? For me, that's still the culprit. Is that a fair assumption?
> > And only TI can tell us.
>=20
> Right. In particular if it's the same for all K3 SoCs - I can only test A=
M62,
> AM64 and AM67A/J772S here.
>=20
>=20
> >=20
> > > > Given that all the handling is in the PHY subsystem I don't know.
> > > > You'd have to ask the PHY if it supports that, before patching the
> > > > phy-interface-mode - before attaching the network PHY I guess?
> > >=20
> > > The previous generation of the CPSW IP handles this in
> > > drivers/net/ethernet/ti/cpsw-phy-sel.c, which is just a custom platfo=
rm device
> > > referenced by the MAC node. The code currently (partially) implements=
 the
> > > old/incorrect interpretation for phy-mode, enabling the delay on the =
MAC side
> > > for PHY_INTERFACE_MODE_RGMII.
> > >=20
> > > >=20
> > > > If we want to just disable (and I assume with disable you mean
> > > > disable the MAC delay) it: the PHY is optional, not sure every SoC
> > > > will have one. And also, the reset default is exactly the opposite
> > > > and TI says it's fixed to the opposite and there has to be a reason
> > > > for that.

I looked this again - every SoC DTSI with a ti,*-cpsw-nuss also has a ti,*-=
phy-
gmii-sel, which will be used to choose between RMII/RGMII/SGMII/... (depend=
ing
on the supported interfaces of each SoC). This is set in the same register =
as
the ID mode, so it should be trivial to enable or disable the MAC delay whe=
re
the flag is supported. We will however need to figure out

- if all SoCs behave the same (and why TI doesn't document the flag)
- how to preserve backwards compatibility with old Device Trees

Best,
Matthias

> > >=20
> > > My preference would be to unconditionally enable the MAC-side delay o=
n Linux to
> > > align with the reset default and what the datasheet claims is the onl=
y supported
> > > mode, but let's hear what the TI folks think about this.
> >=20
> > Which goes against Andrew's "lets to all the delays in the PHY". We
> > have rgmii-id in our AM67A based board and we've actually measured
> > the signals with and without the MAC delay.
> >=20
> > Last week, I've also opened an e2e forum case, maybe we get some
> > more insights. Funny enough, TI seem to have a different register
> > description where this bit is described.
> > https://e2e.ti.com/support/processors-group/processors/f/processors-for=
um/1544031/am67a-internal-rgmii-delay/
> >=20
> > -michael
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

