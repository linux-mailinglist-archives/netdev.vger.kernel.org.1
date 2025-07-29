Return-Path: <netdev+bounces-210727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB045B14934
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2244F4E5A2D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46D5263C8E;
	Tue, 29 Jul 2025 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acFtYNW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1C235041;
	Tue, 29 Jul 2025 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774442; cv=none; b=nMcJfVreUsjQL5EcVZ7cdJj3soZt5rtZ4UhU+3OMe+iQHV87RRGGI+0gakqX83O58lJt/VqrwPXeplVXYKtp7/Ut0VBhKTvsepAlYCsUrtWFJRqA0OZXVrFYx7DImDfkKC14wbA5EXHadr2JzNL+l4keQm4bjzlh/ZD7kqgO63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774442; c=relaxed/simple;
	bh=Zi8RMlPIjpydMUQf5WzmsY1yxjV/z/BZfcnMp+TLv8Q=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=KbOoKjbyrWB/VRyx9r55UmuRr0Jub6mAi+6UbnlOTeuPRfkjBf1lz+LScxElaS5Wrzi+tCntpSotXGNJmlSp/RVm/jRT48uk5eBP5rdRxHikqWDBZ2JGm7ZKfd1jnx1K3e1FZlhlUMVwhjfbqhozR+ugk/SRfwCEmoWI276LCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acFtYNW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3C9C4CEEF;
	Tue, 29 Jul 2025 07:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753774441;
	bh=Zi8RMlPIjpydMUQf5WzmsY1yxjV/z/BZfcnMp+TLv8Q=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=acFtYNW2SzxisLDN0t6OiGJuWBpoZiL6PUTYFnoHWgxA5eC4zLKD6g+6zjHjKCwjP
	 SSRXuZ4uIS5LQPFgV35NPkz/PgSz5Qg/1fO5jTwLAbvR3/Vnkf9LvENvN7DWLN8NMs
	 fG2IT/IOoS6nTHW2h1xjrmfa19w+zE6yRmbBA9939I8v78SbFGIP28KK6zIPXQoCRh
	 qKml/R7PZzUAy98AISaWQw4MhusL8F2p2/P/1JzJdj9pe1OrfUN4yNHIOK53XoP0g7
	 R7cAZgP6asZz+X1Lhd6kN0Pz3voYEW3su4j2Cd/A5LadpdqKjSexL5IYFMh+CtZ1k2
	 6Gxx7JnUj7rNg==
Content-Type: multipart/signed;
 boundary=0c63bfa51af3e9ed96fbe52ced56120bb19c51bb22ebc0cea3350f8f2e56;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 29 Jul 2025 09:33:57 +0200
Message-Id: <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Roger
 Quadros" <rogerq@kernel.org>, "Simon Horman" <horms@kernel.org>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, "Matthias Schiffer"
 <matthias.schiffer@ew.tq-group.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andrew Lunn" <andrew@lunn.ch>
Subject: Re: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup
 PHY mode for fixed RGMII TX delay"
X-Mailer: aerc 0.16.0
References: <20250728064938.275304-1-mwalle@kernel.org>
 <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
In-Reply-To: <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

--0c63bfa51af3e9ed96fbe52ced56120bb19c51bb22ebc0cea3350f8f2e56
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jul 28, 2025 at 4:41 PM CEST, Andrew Lunn wrote:
> On Mon, Jul 28, 2025 at 08:49:38AM +0200, Michael Walle wrote:
> > This reverts commit ca13b249f291f4920466638d1adbfb3f9c8db6e9.
> >=20
> > This patch breaks the transmit path on an AM67A/J722S. This SoC has an
> > (undocumented) configurable delay (CTRL_MMR0_CFG0_ENET1_CTRL, bit 4).
>
> Is this undocumented register only on the AM67A/J722S?

I've looked at the AM65x TRM (search for MMR0 or RGMII_ID_MODE),
which reads that bit 4 is r/w but only '0' is documented as
'internal transmit delay', value '1' is called "reserved".

I couldn't find anything in the AM64x TRM. Didn't look further.

There has to be a reason why TI states that TX delay is always on
and don't document that bit. OTOH, they wrote code to serve that bit
in u-boot. Sigh. Someone from TI have to chime in here to shed some
light to this.

> The patch being reverted says:
>
>    All am65-cpsw controllers have a fixed TX delay
>
> So we have some degree of contradiction here.

I've digged through the old thread and Matthias just references the
datasheet saying it is fixed. Matthias, could you actually try to
set/read this bit? I'm not sure it is really read-only.

> > The u-boot driver (net/ti/am65-cpsw-nuss.c) will configure the delay in
> > am65_cpsw_gmii_sel_k3(). If the u-boot device tree uses rgmii-id this
> > patch will break the transmit path because it will disable the PHY dela=
y
> > on the transmit path, but the bootloader has already disabled the MAC
> > delay, hence there will be no delay at all.
>
> We have maybe 8 weeks to fix this, before it makes it into a released
> kernel. So rather than revert, i would prefer to extend the patch to
> make it work with all variants of the SoC.
>
> Is CTRL_MMR0_CFG0_ENET1_CTRL in the Ethernet address space?

No, that register is part of the global configuration space (search
for phy_gmii_sel in the k3-am62p-j722s-common-main.dtsi), but is
modeled after a PHY (not a network PHY). And actually, I've just
found out that the PHY driver for that will serve the rgmii_id bit
if .features has PHY_GMII_SEL_RGMII_ID_MODE set. So there is already
a whitelist (although it's wrong at the moment, because the J722S
SoC is not listed as having it). As a side note, the j722s also
doesn't have it's own SoC specific compatible it is reusing the
am654-phy-gmii-sel compatible. That might or might not bite us now..

I digress..

> Would it be possible for the MAC driver to read it, and know if the delay=
 has
> been disabled? The switch statement can then be made conditional?
>
> If this register actually exists on all SoC variants, can we just
> globally disable it, and remove the switch statement?

Given that all the handling is in the PHY subsystem I don't know.
You'd have to ask the PHY if it supports that, before patching the
phy-interface-mode - before attaching the network PHY I guess?

If we want to just disable (and I assume with disable you mean
disable the MAC delay) it: the PHY is optional, not sure every SoC
will have one. And also, the reset default is exactly the opposite
and TI says it's fixed to the opposite and there has to be a reason
for that.

Sounds like a real mess to me.

-michael

--0c63bfa51af3e9ed96fbe52ced56120bb19c51bb22ebc0cea3350f8f2e56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaIh5ZhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/glVAGAqnGGUJg8LAwwhUnP0qdRvUf3OIZraRX4
/r5R7hwv+9Okx1ZR/EAqpQDWrT640xbEAX4zyv7EjYmxv5OEFcMnwmrsIuLC5qIi
9TS8uteU0IgdJRTcjcIin8GD9ge1LnH02yo=
=KtFg
-----END PGP SIGNATURE-----

--0c63bfa51af3e9ed96fbe52ced56120bb19c51bb22ebc0cea3350f8f2e56--

