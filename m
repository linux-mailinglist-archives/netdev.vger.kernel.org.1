Return-Path: <netdev+bounces-182259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB6BA88545
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF32D7A4095
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7127A933;
	Mon, 14 Apr 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ilqHsJsn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LUVeU7UL"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5D291148;
	Mon, 14 Apr 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640409; cv=none; b=DNT7LiCmKpAx9Ygv5GNUCJhpp63FqViip+FfgWz4iNbg8SIc0l7ZBr5uxb5AbtDjlUQ8cWG8uTk5gkbNHAp+ramObS2b52i3pSQaUqGHADniYWgVpY9nNBYbXqRjqx+9HlFBQEVC0nnC5+7GXoYr3F+UTK+6L3to+uYG4x4eeR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640409; c=relaxed/simple;
	bh=jXVyZDItmaL5AzoSHs1iPAA9ILTmI1rTDbn9+iURJQs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a7wNkuty9rrx5DuHN7PaLQ6hrquGhh3O8zz3UiMlRDyQqnq70+kRasSxvL8ygXlhznYoxLIBJE5lCRVGUB7SK++H+E884YHFuO3PmqK4Nq7j7A4SlrKHD+eDxEE9HATxCa+n4B7SwICY7UZS2OHS/yDzc8L2Tj61Tk0QRbeN6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ilqHsJsn; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LUVeU7UL reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744640405; x=1776176405;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=EXQyd0r4TZiqZpKsUTx2M/IYp8XzCZHA1OaGt/pVy74=;
  b=ilqHsJsnFXHDYpGrTv4URmBwY5GNP9inrD58caZldCx6AiTe6r4mHeDt
   2tPOSDurP1Ww+rR1EC3/J8CnED1Ns12892170PN+Z/g4ukV6UlQAXIYlS
   H+Evx0bg0y5I/P8Jic60UbMJoTmC6kjShlfoRIKZEtwOIRCf5LHIW94WQ
   6YlQqhguahAQEw5GgqHtFBCmQXJE0ZMI2jYUyYtQvJOCCcJO9ImWdRS58
   nsEWqvbJk+1lUkp/ecMcmp3olkTSY8oD1DU94bd4gm2Sa8aZ5+iK9hi7t
   PbYyfhTug3qiPZhhyaWUPEOhO+IyfLVjM/Jj4axAo66UdU9ws61oQ6RqY
   A==;
X-CSE-ConnectionGUID: oSsEAGTcRwy12Ys1dk3Cbw==
X-CSE-MsgGUID: cLZBKCDnRzOCOQfG1eH8sg==
X-IronPort-AV: E=Sophos;i="6.15,212,1739833200"; 
   d="scan'208";a="43517552"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Apr 2025 16:20:02 +0200
X-CheckPoint: {67FD1992-1B-DC4DC9A0-F4F29281}
X-MAIL-CPID: 6C967A4B7A7BB545A05DFDBA4709EEEB_0
X-Control-Analysis: str=0001.0A006399.67FD1993.008A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4496F16B658;
	Mon, 14 Apr 2025 16:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744640398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXQyd0r4TZiqZpKsUTx2M/IYp8XzCZHA1OaGt/pVy74=;
	b=LUVeU7UL04FhGhMDoOsHSPSzV+Bax3bDk2Uz56ZDySKjvuo3p/zjaiKs3W4EjeC/O7l4gk
	sl27UY7h8G13OJ1iNv0MKMNInjukXelfOXhXZEYSsri7+yRFFyg+kGJSuGcCwY+9MPsNwE
	9Eg1YUhHsG90RD2I+nbLsVjZ241sPVcAIyJbhkTOkr7PGQA3yqK2vYg2vifiNIkCCzP/r0
	Ol9OBqwt5LGyT+1CbmRS4eyKAC/bmn/e2QXTITzrvxxnEtxgwbG31ee75kzqTjuw7FzxxE
	54tcc6dI1L1E2M9fU6C3LBFEX4Bd/eU9CCNXP/aBLQTZ0qu+FqGQyBfZQzi8sg==
Message-ID: <c0c9cbcaf8bb8fd46d2ca618302bed8caa7bc812.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 1/2] net: phy: dp83867: remove check of delay
 strap configuration
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com
Date: Mon, 14 Apr 2025 16:19:56 +0200
In-Reply-To: <8013ae5966dd22bcb698c0c09d2fc0912ae7ac25.1744639988.git.matthias.schiffer@ew.tq-group.com>
References: 
	<8013ae5966dd22bcb698c0c09d2fc0912ae7ac25.1744639988.git.matthias.schiffer@ew.tq-group.com>
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

On Mon, 2025-04-14 at 16:13 +0200, Matthias Schiffer wrote:
> The check that intended to handle "rgmii" PHY mode differently from the
> other RGMII modes never worked as intended:
>=20
> - added in commit 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy"):
>   logic error caused the condition to always evaluate to true
> - changed in commit a46fa260f6f5 ("net: phy: dp83867: Fix warning check
>   for setting the internal delay"): now the condition always evaluates
>   to false
> - removed in commit 2b892649254f ("net: phy: dp83867: Set up RGMII TX
>   delay")
>=20
> Around the time of the removal, commit c11669a2757e ("net: phy: dp83867:
> Rework delay rgmii delay handling") started clearing the delay enable
> flags in RGMIICTL (or it would have, if the condition ever evaluated to
> true at that time). The change attempted to preserve the historical
> behavior of not disabling internal delays with "rgmii" PHY mode and also
> documented this in a comment, but due to a conflict between "Set up
> RGMII TX delay" and "Rework delay rgmii delay handling", the behavior
> dp83867_verify_rgmii_cfg() warned about (and that was also described in
> a commit in dp83867_config_init()) disappeared in the following merge

Ugh, of course I find a mistake in the commit message right after submittin=
g the
patch - this should read "a comment in ...". I'm going to wait for review a=
nd
then fix this in v2.


> of net into net-next in commit b4b12b0d2f02
> ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
>=20
> While is doesn't appear that this breaking change was intentional, it
> has been like this since 2019, and the new behavior to disable the delays
> with "rgmii" PHY mode is generally desirable - in particular with MAC
> drivers that have to fix up the delay mode, resulting in the PHY driver
> not even seeing the same mode that was specified in the Device Tree.
>=20
> Remove the obsolete check and comment.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/net/phy/dp83867.c | 32 +-------------------------------
>  1 file changed, 1 insertion(+), 31 deletions(-)
>=20
> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index 063266cafe9c7..e5b0c1b7be13f 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -92,11 +92,6 @@
>  #define DP83867_STRAP_STS1_RESERVED		BIT(11)
> =20
>  /* STRAP_STS2 bits */
> -#define DP83867_STRAP_STS2_CLK_SKEW_TX_MASK	GENMASK(6, 4)
> -#define DP83867_STRAP_STS2_CLK_SKEW_TX_SHIFT	4
> -#define DP83867_STRAP_STS2_CLK_SKEW_RX_MASK	GENMASK(2, 0)
> -#define DP83867_STRAP_STS2_CLK_SKEW_RX_SHIFT	0
> -#define DP83867_STRAP_STS2_CLK_SKEW_NONE	BIT(2)
>  #define DP83867_STRAP_STS2_STRAP_FLD		BIT(10)
> =20
>  /* PHY CTRL bits */
> @@ -510,25 +505,6 @@ static int dp83867_verify_rgmii_cfg(struct phy_devic=
e *phydev)
>  {
>  	struct dp83867_private *dp83867 =3D phydev->priv;
> =20
> -	/* Existing behavior was to use default pin strapping delay in rgmii
> -	 * mode, but rgmii should have meant no delay.  Warn existing users.
> -	 */
> -	if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII) {
> -		const u16 val =3D phy_read_mmd(phydev, DP83867_DEVADDR,
> -					     DP83867_STRAP_STS2);
> -		const u16 txskew =3D (val & DP83867_STRAP_STS2_CLK_SKEW_TX_MASK) >>
> -				   DP83867_STRAP_STS2_CLK_SKEW_TX_SHIFT;
> -		const u16 rxskew =3D (val & DP83867_STRAP_STS2_CLK_SKEW_RX_MASK) >>
> -				   DP83867_STRAP_STS2_CLK_SKEW_RX_SHIFT;
> -
> -		if (txskew !=3D DP83867_STRAP_STS2_CLK_SKEW_NONE ||
> -		    rxskew !=3D DP83867_STRAP_STS2_CLK_SKEW_NONE)
> -			phydev_warn(phydev,
> -				    "PHY has delays via pin strapping, but phy-mode =3D 'rgmii'\n"
> -				    "Should be 'rgmii-id' to use internal delays txskew:%x rxskew:%x=
\n",
> -				    txskew, rxskew);
> -	}
> -
>  	/* RX delay *must* be specified if internal delay of RX is used. */
>  	if ((phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_ID ||
>  	     phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_RXID) &&
> @@ -836,13 +812,7 @@ static int dp83867_config_init(struct phy_device *ph=
ydev)
>  		if (ret)
>  			return ret;
> =20
> -		/* If rgmii mode with no internal delay is selected, we do NOT use
> -		 * aligned mode as one might expect.  Instead we use the PHY's default
> -		 * based on pin strapping.  And the "mode 0" default is to *use*
> -		 * internal delay with a value of 7 (2.00 ns).
> -		 *
> -		 * Set up RGMII delays
> -		 */
> +		/* Set up RGMII delays */
>  		val =3D phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIICTL);
> =20
>  		val &=3D ~(DP83867_RGMII_TX_CLK_DELAY_EN | DP83867_RGMII_RX_CLK_DELAY_=
EN);

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

