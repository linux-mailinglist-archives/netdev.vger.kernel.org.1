Return-Path: <netdev+bounces-210745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E20B14A5E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28F61AA079E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA3285CBB;
	Tue, 29 Jul 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfc/wren"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0E1B0413;
	Tue, 29 Jul 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778829; cv=none; b=SOmE5WyA5abNplgcouBxfXJGaiOaRvutrbX6ZhJhKAAtXmfzwOyEy0/P1W6MUy72mR0cECSBM+e8o/jQ2FWjsQUempNjCJwk1khU9MUdYUXHKhYgTvKrSUVuGrmjbTR8Ix0Fvz2/L7x9hEEZOMF8cRlsuVD15BUujwyl6KLrtBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778829; c=relaxed/simple;
	bh=j5Nxp3sqxUzkjfdDiLe3WF5WObVWb43UAxAKH67Wjco=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=BF7dTUakuyHsggCyU5eAi7D+Wcpemb6OVGpxmLwNpkF113UUFGcZjr4jYdrscdib62j0Pd5PEaeowwL9my6pRnhGiVxYiK6JmCFdsH691vsHXDK2bJRShVeFNtYotNwXpsg2V07lI3jbta8cNkXc3+ZRO9oT5ww/sQ4XrX599yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfc/wren; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C66EC4CEF5;
	Tue, 29 Jul 2025 08:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753778828;
	bh=j5Nxp3sqxUzkjfdDiLe3WF5WObVWb43UAxAKH67Wjco=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=Jfc/wren1LJbaQtPGrfXlPuphqQNuJpRnfOQv1nnLazN+3tTSTJlF0b2eTDtdavR3
	 annnAuru0Yah2c2M/xwoBtko0DeRnaCb7cLHwzhfdMc5RfxIRizs5KLMqvNH/PDL7n
	 Ij6BiFlDmUbfiE1BEJRGkn0tGNkRyy592IvscC71gaWvyx4o+Va2AFxzkaUYjnoU7D
	 tWKVhmZv5YpI68wZiGHGaICzY+ZOCeZTVu3zDDZW/r7qcor32qbHvC/WBl+hnyee88
	 En7g/rQUrF3GK+fHCiVHKiZi6k6yL4X/K+XfXkE/yibdVX3B3Lk+TIgn5ZyfOZhQTL
	 3/8Z1Co5COJlQ==
Content-Type: multipart/signed;
 boundary=2e705e879b310d7c093d9c723eda778d834dac574dec93290c67c2b07d74;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 29 Jul 2025 10:47:04 +0200
Message-Id: <DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Matthias Schiffer" <matthias.schiffer@ew.tq-group.com>, "Andrew Lunn"
 <andrew@lunn.ch>, "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>
Subject: Re: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup
 PHY mode for fixed RGMII TX delay"
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Roger
 Quadros" <rogerq@kernel.org>, "Simon Horman" <horms@kernel.org>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@ew.tq-group.com>
X-Mailer: aerc 0.16.0
References: <20250728064938.275304-1-mwalle@kernel.org>
 <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
 <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
 <d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
In-Reply-To: <d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

--2e705e879b310d7c093d9c723eda778d834dac574dec93290c67c2b07d74
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > The patch being reverted says:
> > >=20
> > >    All am65-cpsw controllers have a fixed TX delay
> > >=20
> > > So we have some degree of contradiction here.
> >=20
> > I've digged through the old thread and Matthias just references the
> > datasheet saying it is fixed. Matthias, could you actually try to
> > set/read this bit? I'm not sure it is really read-only.
>
> I just referred to the datasheets of various K3 SoCs, I did not try modif=
ying
> the reserved bits.

So can you try to modify them?

> > > > The u-boot driver (net/ti/am65-cpsw-nuss.c) will configure the dela=
y in
> > > > am65_cpsw_gmii_sel_k3(). If the u-boot device tree uses rgmii-id th=
is
> > > > patch will break the transmit path because it will disable the PHY =
delay
> > > > on the transmit path, but the bootloader has already disabled the M=
AC
> > > > delay, hence there will be no delay at all.
>
> I have a patch that removes this piece of U-Boot code and had intended to=
 submit
> that soon to align the U-Boot driver with Linux again. I'll hold off unti=
l we
> know how the solution in Linux is going to look.

That doesn't fix older bootloaders though. So in linux we still have
to work around that.

Although I don't get it why you want to remove that feature.

> > > We have maybe 8 weeks to fix this, before it makes it into a released
> > > kernel. So rather than revert, i would prefer to extend the patch to
> > > make it work with all variants of the SoC.
> > >=20
> > > Is CTRL_MMR0_CFG0_ENET1_CTRL in the Ethernet address space?
> >=20
> > No, that register is part of the global configuration space (search
> > for phy_gmii_sel in the k3-am62p-j722s-common-main.dtsi), but is
> > modeled after a PHY (not a network PHY). And actually, I've just
> > found out that the PHY driver for that will serve the rgmii_id bit
> > if .features has PHY_GMII_SEL_RGMII_ID_MODE set. So there is already
> > a whitelist (although it's wrong at the moment, because the J722S
> > SoC is not listed as having it). As a side note, the j722s also
> > doesn't have it's own SoC specific compatible it is reusing the
> > am654-phy-gmii-sel compatible. That might or might not bite us now..
> >=20
> > I digress..
> >=20
> > > Would it be possible for the MAC driver to read it, and know if the d=
elay has
> > > been disabled? The switch statement can then be made conditional?
> > >=20
> > > If this register actually exists on all SoC variants, can we just
> > > globally disable it, and remove the switch statement?
>
> If we just remove the switch statement, thus actually supporting all the
> different delay modes, we're back at the point where there is no way for =
the
> driver to determine whether rgmii-rxid is supposed to be interpreted corr=
ectly
> or not (currently all Device Trees using this driver require the old/inco=
rrect
> interpretation for Ethernet to work).

I can't follow you here. Are you assuming that the TX delay is
fixed? For me, that's still the culprit. Is that a fair assumption?
And only TI can tell us.

> > Given that all the handling is in the PHY subsystem I don't know.
> > You'd have to ask the PHY if it supports that, before patching the
> > phy-interface-mode - before attaching the network PHY I guess?
>
> The previous generation of the CPSW IP handles this in
> drivers/net/ethernet/ti/cpsw-phy-sel.c, which is just a custom platform d=
evice
> referenced by the MAC node. The code currently (partially) implements the
> old/incorrect interpretation for phy-mode, enabling the delay on the MAC =
side
> for PHY_INTERFACE_MODE_RGMII.
>
> >=20
> > If we want to just disable (and I assume with disable you mean
> > disable the MAC delay) it: the PHY is optional, not sure every SoC
> > will have one. And also, the reset default is exactly the opposite
> > and TI says it's fixed to the opposite and there has to be a reason
> > for that.
>
> My preference would be to unconditionally enable the MAC-side delay on Li=
nux to
> align with the reset default and what the datasheet claims is the only su=
pported
> mode, but let's hear what the TI folks think about this.

Which goes against Andrew's "lets to all the delays in the PHY". We
have rgmii-id in our AM67A based board and we've actually measured
the signals with and without the MAC delay.

Last week, I've also opened an e2e forum case, maybe we get some
more insights. Funny enough, TI seem to have a different register
description where this bit is described.
https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1=
544031/am67a-internal-rgmii-delay/

-michael

--2e705e879b310d7c093d9c723eda778d834dac574dec93290c67c2b07d74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaIiKiBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hl+wF+ITZLpIYegyZ3XuZ+Vfhowbdn6UY2SnLB
6Dpab1h4j0uWenCbmv+cOgrQ/C2B7KdnAYDUQ3PLU2QzJSdXWSCyORgpZufahSG8
w45jv335Buy8k6rrY09HazY/SOWpKFQahHQ=
=Pkql
-----END PGP SIGNATURE-----

--2e705e879b310d7c093d9c723eda778d834dac574dec93290c67c2b07d74--

