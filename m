Return-Path: <netdev+bounces-210732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB240B149A6
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E435817374A
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891DE26B766;
	Tue, 29 Jul 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Pn3zYbyK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="onpI5jSb"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3B20297C;
	Tue, 29 Jul 2025 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775970; cv=none; b=kdvpZsCWCATMlOu6BvaVRVjaZYA5/V8D3QR9qMaUgcLDGePBDGIL8mgJIGC0na8ZGNoIN9eRd2cVBSQ/l4TehAnqMdNxfCKdnPlPCWbN0DYd6V45VJMlJICoJ1QuRg5Jt3jZ5Gn+DsbynqREUkKw5eloNhkUZ9tE+Wmc7W95WdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775970; c=relaxed/simple;
	bh=FPqcjXKhkRLcOuDTA6vBXwKTB4o5Ha6/+tMcFv3nbxI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmT0eXvYD1KAgt5qHuvu5bSOZ6rR9N5XVcawaJr31DA2MC4LtcNQMVhGHHseQ4VK/aS9ltME2UUZhYN44NVCvNp6Zvei4koRiaXu5T1Ry/RRHW9gofoN/7iqNaQ27Nm/S9ZffAWaIAI+r+mD5DhfmW4Z2A7Rkh2tYx55bumEylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Pn3zYbyK; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=onpI5jSb reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753775966; x=1785311966;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yzGn+uckFKqRkji97cXCPttuxHVubErEE81HxmQmbO0=;
  b=Pn3zYbyK9ybKVSuCaJ1oA0RTWhGTMRJP4JAgr0Uja20iN10up3OUW8j9
   ZB68aZ0mBQiZEO45+IXUK67sRfe+w9aoD884MAqa7UAbRADdxscMn/w83
   R0A9fmjmZsD+CrP4tGS2/A92AmeTAA67RLr05aLvt5pY90+V99lXta5AG
   wH5RZom292lsF76tZf9v5t6BPVGrG8s1G/P1htozgrXJVI17ihng39ITs
   ggFurSvPO72cpCPIkBppt9Wjp2RRzwoYQlDLBjdUGDiLoukpU8LXRLCXX
   +92Q0+EW/lc0JNBnXG0HeEKXgmy6NzisOTeRORCswqvi/l3cK0byNINLf
   Q==;
X-CSE-ConnectionGUID: aqYp61tQQwe9N8/Lbw8Z/Q==
X-CSE-MsgGUID: 5imnZLuPTVeuSYXZuaDLdA==
X-IronPort-AV: E=Sophos;i="6.16,348,1744063200"; 
   d="scan'208";a="45466426"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 Jul 2025 09:59:22 +0200
X-CheckPoint: {68887F5A-3F-9BFD12F6-F51D5FD4}
X-MAIL-CPID: 8E19EDAB92A753E99AFFFF78DBEFA098_3
X-Control-Analysis: str=0001.0A00211A.68887F82.006D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FE3F163F99;
	Tue, 29 Jul 2025 09:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753775958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzGn+uckFKqRkji97cXCPttuxHVubErEE81HxmQmbO0=;
	b=onpI5jSbR4QCw98mgPPhvGAlgJ+HFSiBbFDMVgPmxLzCgbqQ9IuBXcJJJIm98VMC2r0vq8
	ruI++YRHfKjJX34tMJPZK83NrpvnEbEqO59zUFyI0vG2AwM3zXwna3LrJQpAti/9mxffai
	Vhit8pmkHuPjcLT5yc7vzgWL8jNbPU7g7ZB8Pg2SEEsBYptflLi48zpjU7bny993hvjx6j
	jUCCJNREl0pAeXMA3ITbR8AMC7RUhVSfovy+wQOot4TMWDRp1f7SYUaUCKCy22rkgZVxxF
	5UoBPpFifAvxeOSactAuW+ot+gHykL5wekEfbSvv/KyU6WFwLAMzWf6OGjTQ1w==
Message-ID: <d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
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
Date: Tue, 29 Jul 2025 09:59:15 +0200
In-Reply-To: <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
References: <20250728064938.275304-1-mwalle@kernel.org>
	 <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
	 <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
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

On Tue, 2025-07-29 at 09:33 +0200, Michael Walle wrote:
> On Mon Jul 28, 2025 at 4:41 PM CEST, Andrew Lunn wrote:
> > On Mon, Jul 28, 2025 at 08:49:38AM +0200, Michael Walle wrote:
> > > This reverts commit ca13b249f291f4920466638d1adbfb3f9c8db6e9.
> > >=20
> > > This patch breaks the transmit path on an AM67A/J722S. This SoC has a=
n
> > > (undocumented) configurable delay (CTRL_MMR0_CFG0_ENET1_CTRL, bit 4).
> >=20
> > Is this undocumented register only on the AM67A/J722S?
>=20
> I've looked at the AM65x TRM (search for MMR0 or RGMII_ID_MODE),
> which reads that bit 4 is r/w but only '0' is documented as
> 'internal transmit delay', value '1' is called "reserved".
>=20
> I couldn't find anything in the AM64x TRM. Didn't look further.
>=20
> There has to be a reason why TI states that TX delay is always on
> and don't document that bit. OTOH, they wrote code to serve that bit
> in u-boot. Sigh. Someone from TI have to chime in here to shed some
> light to this.

Adding TI K3 maintainers, as am65-cpsw doesn't have a MAINTAINERS entry of =
its
own.

>=20
> > The patch being reverted says:
> >=20
> >    All am65-cpsw controllers have a fixed TX delay
> >=20
> > So we have some degree of contradiction here.
>=20
> I've digged through the old thread and Matthias just references the
> datasheet saying it is fixed. Matthias, could you actually try to
> set/read this bit? I'm not sure it is really read-only.

I just referred to the datasheets of various K3 SoCs, I did not try modifyi=
ng
the reserved bits.

>=20
> > > The u-boot driver (net/ti/am65-cpsw-nuss.c) will configure the delay =
in
> > > am65_cpsw_gmii_sel_k3(). If the u-boot device tree uses rgmii-id this
> > > patch will break the transmit path because it will disable the PHY de=
lay
> > > on the transmit path, but the bootloader has already disabled the MAC
> > > delay, hence there will be no delay at all.

I have a patch that removes this piece of U-Boot code and had intended to s=
ubmit
that soon to align the U-Boot driver with Linux again. I'll hold off until =
we
know how the solution in Linux is going to look.

> >=20
> > We have maybe 8 weeks to fix this, before it makes it into a released
> > kernel. So rather than revert, i would prefer to extend the patch to
> > make it work with all variants of the SoC.
> >=20
> > Is CTRL_MMR0_CFG0_ENET1_CTRL in the Ethernet address space?
>=20
> No, that register is part of the global configuration space (search
> for phy_gmii_sel in the k3-am62p-j722s-common-main.dtsi), but is
> modeled after a PHY (not a network PHY). And actually, I've just
> found out that the PHY driver for that will serve the rgmii_id bit
> if .features has PHY_GMII_SEL_RGMII_ID_MODE set. So there is already
> a whitelist (although it's wrong at the moment, because the J722S
> SoC is not listed as having it). As a side note, the j722s also
> doesn't have it's own SoC specific compatible it is reusing the
> am654-phy-gmii-sel compatible. That might or might not bite us now..
>=20
> I digress..
>=20
> > Would it be possible for the MAC driver to read it, and know if the del=
ay has
> > been disabled? The switch statement can then be made conditional?
> >=20
> > If this register actually exists on all SoC variants, can we just
> > globally disable it, and remove the switch statement?

If we just remove the switch statement, thus actually supporting all the
different delay modes, we're back at the point where there is no way for th=
e
driver to determine whether rgmii-rxid is supposed to be interpreted correc=
tly
or not (currently all Device Trees using this driver require the old/incorr=
ect
interpretation for Ethernet to work).

>=20
> Given that all the handling is in the PHY subsystem I don't know.
> You'd have to ask the PHY if it supports that, before patching the
> phy-interface-mode - before attaching the network PHY I guess?

The previous generation of the CPSW IP handles this in
drivers/net/ethernet/ti/cpsw-phy-sel.c, which is just a custom platform dev=
ice
referenced by the MAC node. The code currently (partially) implements the
old/incorrect interpretation for phy-mode, enabling the delay on the MAC si=
de
for PHY_INTERFACE_MODE_RGMII.

>=20
> If we want to just disable (and I assume with disable you mean
> disable the MAC delay) it: the PHY is optional, not sure every SoC
> will have one. And also, the reset default is exactly the opposite
> and TI says it's fixed to the opposite and there has to be a reason
> for that.

My preference would be to unconditionally enable the MAC-side delay on Linu=
x to
align with the reset default and what the datasheet claims is the only supp=
orted
mode, but let's hear what the TI folks think about this.

Best,
Matthias


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

