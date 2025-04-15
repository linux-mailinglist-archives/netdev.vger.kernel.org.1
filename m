Return-Path: <netdev+bounces-182631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05730A896D4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D59189DCB4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE51EA7E1;
	Tue, 15 Apr 2025 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="GUr3rBan";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QqK2E6iT"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28531DE8B0;
	Tue, 15 Apr 2025 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706128; cv=none; b=KGVglo2i55+zgNLdLkg6YbShr6n9qs8yScr1LHByRPZ+2nVdnmgeJ0aMOqSiTCOaKIqREhU4AvFYgdJxPxUW30J11OdDCW0TysDyaX/uPkN83EBugMP8RfSbH/kFxB0xaXL0nHg0Rc21jyhnq2rl+SdsLepRnp6g6frPl/SYj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706128; c=relaxed/simple;
	bh=i+509ryJKJQmkn9+J/lCIfTtFXalbSn8FjHJ7x/dckQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BuBc789Cr4BpKV/R9SQYo39RzWBuzPW5MBMZ64O/DOz3K1RrIV0EDjvmqPs7UlzdE6mg8zQplFtH3S52PWEH+ycgVGUz0rhG0XpF0hzr+KuEQA6bZX1qNLUN/eElyAS3+rQoFyvGMEaqG9aXXDZdmNYdzlLIgAbF+LAw4ON4XXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=GUr3rBan; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=QqK2E6iT reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744706124; x=1776242124;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=t7sX4ntKbLpFGtsynu9D4uCV1+s7lyl50jhGsnyH5EU=;
  b=GUr3rBanGQ+z6Y/EYW1sBGzENbD/GhICIpy9VwwKjJNRC9XJiR13O6cO
   VQoVvgdb18DQRDAwq8/vNvai7CHODuiHZfhh7q+TDEIWo8f4HSqw/Ybv9
   0Kz9MYZ3KjBjq5nSbLfYCp8RMZ0Mur3rygT2HRZ/7kCb+IoOTjVUI/Sbj
   n/qAO7eMsH6lW+nuH5zLQwMIUyh3ZFkHfSHVXt+Y9nzUFnZ+srO11Ld8G
   ogRGf4yxPLWTAw1GPCySeDoVw3YDO//YiUvhszmKz+IY2EnJcbE5fwrKu
   aS6pyMewvVDOudeIawgkRsalQIEd6qVeQaO96YAtJyjWiZNno9kTKkuC3
   w==;
X-CSE-ConnectionGUID: RY2ljpalTvewaM8Ah5s4qw==
X-CSE-MsgGUID: OjugpQMXTQyYGi26XPOMJg==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="43533980"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2025 10:35:21 +0200
X-CheckPoint: {67FE1A48-36-F35B2447-E1635CDE}
X-MAIL-CPID: 3DD5DC0CAE778B2C95C854D9D45F62CB_1
X-Control-Analysis: str=0001.0A006368.67FE1A54.0074,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7523160F46;
	Tue, 15 Apr 2025 10:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744706116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7sX4ntKbLpFGtsynu9D4uCV1+s7lyl50jhGsnyH5EU=;
	b=QqK2E6iTMSKnfvdua8fvymCLNx14HqN89/DczRZPLmUxlur+6O495MVNwztJS63dbbGHBb
	rylLV7/Tx88zwe3bseo8u14iYtkwpuPBjCS1gG11vHjb7gWWhQcs4RMPeo7deqlVJ+04bA
	EI1Shl4XJHH3hWQ5xNzxiUpSzr5ibqMlOV2qkOPfngt3EJBBhGSsUxxlP1C+u3Mn4hqVWF
	N7kPwRkBEkToycS25O2zrzL1VByIZewhTLYe1RC5VQHlsBAFd8Ls8fQ5RZiMJ/r6k0Ypki
	fT8AzgFD3sM9qh2orc+yBRR42bmVlU6ekmQ617lLSKwm/T87ou4+EFUaQ1hBWQ==
Message-ID: <f28d39095f3ed99b6235a6f300d31111f2486f06.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 1/2] net: phy: dp83867: remove check of delay
 strap configuration
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com
Date: Tue, 15 Apr 2025 10:35:14 +0200
In-Reply-To: <c0c9cbcaf8bb8fd46d2ca618302bed8caa7bc812.camel@ew.tq-group.com>
References: 
	<8013ae5966dd22bcb698c0c09d2fc0912ae7ac25.1744639988.git.matthias.schiffer@ew.tq-group.com>
	 <c0c9cbcaf8bb8fd46d2ca618302bed8caa7bc812.camel@ew.tq-group.com>
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

On Mon, 2025-04-14 at 16:19 +0200, Matthias Schiffer wrote:
> On Mon, 2025-04-14 at 16:13 +0200, Matthias Schiffer wrote:
> > The check that intended to handle "rgmii" PHY mode differently from the
> > other RGMII modes never worked as intended:
> >=20
> > - added in commit 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy"=
):
> >   logic error caused the condition to always evaluate to true
> > - changed in commit a46fa260f6f5 ("net: phy: dp83867: Fix warning check
> >   for setting the internal delay"): now the condition always evaluates
> >   to false

Ah, I just realized that this is not entirely accurate. The condition did n=
ot
always evaluate to false, it just incorrectly evaluated to false for rgmii-=
txid.
Another thing to fix in v2.


> > - removed in commit 2b892649254f ("net: phy: dp83867: Set up RGMII TX
> >   delay")
> >=20
> > Around the time of the removal, commit c11669a2757e ("net: phy: dp83867=
:
> > Rework delay rgmii delay handling") started clearing the delay enable
> > flags in RGMIICTL (or it would have, if the condition ever evaluated to
> > true at that time). The change attempted to preserve the historical
> > behavior of not disabling internal delays with "rgmii" PHY mode and als=
o
> > documented this in a comment, but due to a conflict between "Set up
> > RGMII TX delay" and "Rework delay rgmii delay handling", the behavior
> > dp83867_verify_rgmii_cfg() warned about (and that was also described in
> > a commit in dp83867_config_init()) disappeared in the following merge
>=20
> Ugh, of course I find a mistake in the commit message right after submitt=
ing the
> patch - this should read "a comment in ...". I'm going to wait for review=
 and
> then fix this in v2.
>=20
>=20
> > of net into net-next in commit b4b12b0d2f02
> > ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
> >=20
> > While is doesn't appear that this breaking change was intentional, it
> > has been like this since 2019, and the new behavior to disable the dela=
ys
> > with "rgmii" PHY mode is generally desirable - in particular with MAC
> > drivers that have to fix up the delay mode, resulting in the PHY driver
> > not even seeing the same mode that was specified in the Device Tree.
> >=20
> > Remove the obsolete check and comment.
> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/net/phy/dp83867.c | 32 +-------------------------------
> >  1 file changed, 1 insertion(+), 31 deletions(-)
> >=20
> > diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> > index 063266cafe9c7..e5b0c1b7be13f 100644
> > --- a/drivers/net/phy/dp83867.c
> > +++ b/drivers/net/phy/dp83867.c
> > @@ -92,11 +92,6 @@
> >  #define DP83867_STRAP_STS1_RESERVED		BIT(11)
> > =20
> >  /* STRAP_STS2 bits */
> > -#define DP83867_STRAP_STS2_CLK_SKEW_TX_MASK	GENMASK(6, 4)
> > -#define DP83867_STRAP_STS2_CLK_SKEW_TX_SHIFT	4
> > -#define DP83867_STRAP_STS2_CLK_SKEW_RX_MASK	GENMASK(2, 0)
> > -#define DP83867_STRAP_STS2_CLK_SKEW_RX_SHIFT	0
> > -#define DP83867_STRAP_STS2_CLK_SKEW_NONE	BIT(2)
> >  #define DP83867_STRAP_STS2_STRAP_FLD		BIT(10)
> > =20
> >  /* PHY CTRL bits */
> > @@ -510,25 +505,6 @@ static int dp83867_verify_rgmii_cfg(struct phy_dev=
ice *phydev)
> >  {
> >  	struct dp83867_private *dp83867 =3D phydev->priv;
> > =20
> > -	/* Existing behavior was to use default pin strapping delay in rgmii
> > -	 * mode, but rgmii should have meant no delay.  Warn existing users.
> > -	 */
> > -	if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII) {
> > -		const u16 val =3D phy_read_mmd(phydev, DP83867_DEVADDR,
> > -					     DP83867_STRAP_STS2);
> > -		const u16 txskew =3D (val & DP83867_STRAP_STS2_CLK_SKEW_TX_MASK) >>
> > -				   DP83867_STRAP_STS2_CLK_SKEW_TX_SHIFT;
> > -		const u16 rxskew =3D (val & DP83867_STRAP_STS2_CLK_SKEW_RX_MASK) >>
> > -				   DP83867_STRAP_STS2_CLK_SKEW_RX_SHIFT;
> > -
> > -		if (txskew !=3D DP83867_STRAP_STS2_CLK_SKEW_NONE ||
> > -		    rxskew !=3D DP83867_STRAP_STS2_CLK_SKEW_NONE)
> > -			phydev_warn(phydev,
> > -				    "PHY has delays via pin strapping, but phy-mode =3D 'rgmii'\n"
> > -				    "Should be 'rgmii-id' to use internal delays txskew:%x rxskew:=
%x\n",
> > -				    txskew, rxskew);
> > -	}
> > -
> >  	/* RX delay *must* be specified if internal delay of RX is used. */
> >  	if ((phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_ID ||
> >  	     phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_RXID) &&
> > @@ -836,13 +812,7 @@ static int dp83867_config_init(struct phy_device *=
phydev)
> >  		if (ret)
> >  			return ret;
> > =20
> > -		/* If rgmii mode with no internal delay is selected, we do NOT use
> > -		 * aligned mode as one might expect.  Instead we use the PHY's defau=
lt
> > -		 * based on pin strapping.  And the "mode 0" default is to *use*
> > -		 * internal delay with a value of 7 (2.00 ns).
> > -		 *
> > -		 * Set up RGMII delays
> > -		 */
> > +		/* Set up RGMII delays */
> >  		val =3D phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIICTL);
> > =20
> >  		val &=3D ~(DP83867_RGMII_TX_CLK_DELAY_EN | DP83867_RGMII_RX_CLK_DELA=
Y_EN);
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

