Return-Path: <netdev+bounces-201979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE68AEBCD2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CA6164CB3
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A72E92CA;
	Fri, 27 Jun 2025 16:09:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707B19A288;
	Fri, 27 Jun 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040556; cv=none; b=ZezYd6EY5sUqlQ5t1kNs06kIWNv/ZeRoFoMjtpw+rPQE6bzSxHuAz9axtBOCxIcg0wJn/ypvvPmebdErcW2uN7sgfkAj8ndpVJX/NnN54ZtLCitVWDYExpDVO3p2LoEW5hLbBf+vk3y7tA69U8a8au2XSacMg+hBsil8M69mtyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040556; c=relaxed/simple;
	bh=uV6O5HmIwzaalO/a2iRBmdUQS9q71BBclJdamW0QU60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1NVvTIyz9RgucrXi1v+8R4+N6SXggMUEKlDhSK5eQXk6YqjvTT9mL0q6FiUtK5rzmqhJbnZ6AZudllBamTFqa3Il58PLXDIC7YIocVwAnkUdYl8/WVBW+kGna/d//NR2VE7YXK3+tQ6kbyJWL7Yz43hQiA3CbKCtA1agHut5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id B78451F00056;
	Fri, 27 Jun 2025 16:08:55 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 424B7AC87BE; Fri, 27 Jun 2025 16:08:54 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 11857AC87B0;
	Fri, 27 Jun 2025 16:08:48 +0000 (UTC)
Date: Fri, 27 Jun 2025 18:08:46 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Yixun Lan <dlan@gentoo.org>, Maxime Ripard <mripard@kernel.org>,
	netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: stmmac: sun8i: drop unneeded default
 syscon value
Message-ID: <aF7CDjRCYEa0CpqH@collins>
References: <20250423095222.1517507-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YU83H7T/fcLTVoMZ"
Content-Disposition: inline
In-Reply-To: <20250423095222.1517507-1-andre.przywara@arm.com>


--YU83H7T/fcLTVoMZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

Le Wed 23 Apr 25, 10:52, Andre Przywara a =C3=A9crit :
> For some odd reason we are very picky about the value of the EMAC clock
> register from the syscon block, insisting on a certain reset value and
> only doing read-modify-write operations on that register, even though we
> pretty much know the register layout.
> This already led to a basically redundant variant entry for the H6, which
> only differs by that value. We will have the same situation with the new
> A523 SoC, which again is compatible to the A64, but has a different syscon
> reset value.
>=20
> Drop any assumptions about that value, and set or clear the bits that we
> want to program, from scratch (starting with a value of 0). For the
> remove() implementation, we just turn on the POWERDOWN bit, and deselect
> the internal PHY, which mimics the existing code.

I was confused about why this existed as well and think this change makes a=
 lot
of sense!

I just tested it on my V3s Lichee Pi Zero dock, which uses the internal EPHY
(configured via this register) and it all looks good to me.

Tested-by: Paul Kocialkowski <paulk@sys-base.io>
Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

Note that my previous patch fixing the PHY address retrieval conflicts with
this, so you might want to spin up a new version, or it might be adapted wh=
en
this patch is picked-up. It's very straightforward to resolve.

Thanks for this cleanup!

Paul

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
>=20
> if anyone can shed some light on why we had this value and its handling
> in the first place, I would be grateful. I don't really get its purpose,
> and especially the warning message about the reset value seems odd.
> I briefly tested this on A523, H3, H6, but would be glad to see more
> testing on this.
>=20
> Cheers,
> Andre
>=20
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 47 ++-----------------
>  1 file changed, 4 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/=
net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 85723a78793ab..0f8d29763a909 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -31,10 +31,6 @@
>   */
> =20
>  /* struct emac_variant - Describe dwmac-sun8i hardware variant
> - * @default_syscon_value:	The default value of the EMAC register in sysc=
on
> - *				This value is used for disabling properly EMAC
> - *				and used as a good starting value in case of the
> - *				boot process(uboot) leave some stuff.
>   * @syscon_field		reg_field for the syscon's gmac register
>   * @soc_has_internal_phy:	Does the MAC embed an internal PHY
>   * @support_mii:		Does the MAC handle MII
> @@ -48,7 +44,6 @@
>   *				value of zero indicates this is not supported.
>   */
>  struct emac_variant {
> -	u32 default_syscon_value;
>  	const struct reg_field *syscon_field;
>  	bool soc_has_internal_phy;
>  	bool support_mii;
> @@ -94,7 +89,6 @@ static const struct reg_field sun8i_ccu_reg_field =3D {
>  };
> =20
>  static const struct emac_variant emac_variant_h3 =3D {
> -	.default_syscon_value =3D 0x58000,
>  	.syscon_field =3D &sun8i_syscon_reg_field,
>  	.soc_has_internal_phy =3D true,
>  	.support_mii =3D true,
> @@ -105,14 +99,12 @@ static const struct emac_variant emac_variant_h3 =3D=
 {
>  };
> =20
>  static const struct emac_variant emac_variant_v3s =3D {
> -	.default_syscon_value =3D 0x38000,
>  	.syscon_field =3D &sun8i_syscon_reg_field,
>  	.soc_has_internal_phy =3D true,
>  	.support_mii =3D true
>  };
> =20
>  static const struct emac_variant emac_variant_a83t =3D {
> -	.default_syscon_value =3D 0,
>  	.syscon_field =3D &sun8i_syscon_reg_field,
>  	.soc_has_internal_phy =3D false,
>  	.support_mii =3D true,
> @@ -122,7 +114,6 @@ static const struct emac_variant emac_variant_a83t =
=3D {
>  };
> =20
>  static const struct emac_variant emac_variant_r40 =3D {
> -	.default_syscon_value =3D 0,
>  	.syscon_field =3D &sun8i_ccu_reg_field,
>  	.support_mii =3D true,
>  	.support_rgmii =3D true,
> @@ -130,7 +121,6 @@ static const struct emac_variant emac_variant_r40 =3D=
 {
>  };
> =20
>  static const struct emac_variant emac_variant_a64 =3D {
> -	.default_syscon_value =3D 0,
>  	.syscon_field =3D &sun8i_syscon_reg_field,
>  	.soc_has_internal_phy =3D false,
>  	.support_mii =3D true,
> @@ -141,7 +131,6 @@ static const struct emac_variant emac_variant_a64 =3D=
 {
>  };
> =20
>  static const struct emac_variant emac_variant_h6 =3D {
> -	.default_syscon_value =3D 0x50000,
>  	.syscon_field =3D &sun8i_syscon_reg_field,
>  	/* The "Internal PHY" of H6 is not on the die. It's on the
>  	 * co-packaged AC200 chip instead.
> @@ -933,25 +922,11 @@ static int sun8i_dwmac_set_syscon(struct device *de=
v,
>  	struct sunxi_priv_data *gmac =3D plat->bsp_priv;
>  	struct device_node *node =3D dev->of_node;
>  	int ret;
> -	u32 reg, val;
> -
> -	ret =3D regmap_field_read(gmac->regmap_field, &val);
> -	if (ret) {
> -		dev_err(dev, "Fail to read from regmap field.\n");
> -		return ret;
> -	}
> -
> -	reg =3D gmac->variant->default_syscon_value;
> -	if (reg !=3D val)
> -		dev_warn(dev,
> -			 "Current syscon value is not the default %x (expect %x)\n",
> -			 val, reg);
> +	u32 reg =3D 0, val;
> =20
>  	if (gmac->variant->soc_has_internal_phy) {
>  		if (of_property_read_bool(node, "allwinner,leds-active-low"))
>  			reg |=3D H3_EPHY_LED_POL;
> -		else
> -			reg &=3D ~H3_EPHY_LED_POL;
> =20
>  		/* Force EPHY xtal frequency to 24MHz. */
>  		reg |=3D H3_EPHY_CLK_SEL;
> @@ -965,11 +940,6 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
>  		 * address. No need to mask it again.
>  		 */
>  		reg |=3D 1 << H3_EPHY_ADDR_SHIFT;
> -	} else {
> -		/* For SoCs without internal PHY the PHY selection bit should be
> -		 * set to 0 (external PHY).
> -		 */
> -		reg &=3D ~H3_EPHY_SELECT;
>  	}
> =20
>  	if (!of_property_read_u32(node, "allwinner,tx-delay-ps", &val)) {
> @@ -980,8 +950,6 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
>  		val /=3D 100;
>  		dev_dbg(dev, "set tx-delay to %x\n", val);
>  		if (val <=3D gmac->variant->tx_delay_max) {
> -			reg &=3D ~(gmac->variant->tx_delay_max <<
> -				 SYSCON_ETXDC_SHIFT);
>  			reg |=3D (val << SYSCON_ETXDC_SHIFT);
>  		} else {
>  			dev_err(dev, "Invalid TX clock delay: %d\n",
> @@ -998,8 +966,6 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
>  		val /=3D 100;
>  		dev_dbg(dev, "set rx-delay to %x\n", val);
>  		if (val <=3D gmac->variant->rx_delay_max) {
> -			reg &=3D ~(gmac->variant->rx_delay_max <<
> -				 SYSCON_ERXDC_SHIFT);
>  			reg |=3D (val << SYSCON_ERXDC_SHIFT);
>  		} else {
>  			dev_err(dev, "Invalid RX clock delay: %d\n",
> @@ -1008,11 +974,6 @@ static int sun8i_dwmac_set_syscon(struct device *de=
v,
>  		}
>  	}
> =20
> -	/* Clear interface mode bits */
> -	reg &=3D ~(SYSCON_ETCS_MASK | SYSCON_EPIT);
> -	if (gmac->variant->support_rmii)
> -		reg &=3D ~SYSCON_RMII_EN;
> -
>  	switch (plat->mac_interface) {
>  	case PHY_INTERFACE_MODE_MII:
>  		/* default */
> @@ -1039,9 +1000,9 @@ static int sun8i_dwmac_set_syscon(struct device *de=
v,
> =20
>  static void sun8i_dwmac_unset_syscon(struct sunxi_priv_data *gmac)
>  {
> -	u32 reg =3D gmac->variant->default_syscon_value;
> -
> -	regmap_field_write(gmac->regmap_field, reg);
> +	if (gmac->variant->soc_has_internal_phy)
> +		regmap_field_write(gmac->regmap_field,
> +				   (H3_EPHY_SHUTDOWN | H3_EPHY_SELECT));
>  }
> =20
>  static void sun8i_dwmac_exit(struct platform_device *pdev, void *priv)
> --=20
> 2.25.1
>=20
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--YU83H7T/fcLTVoMZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmhewg4ACgkQhP3B6o/u
lQyMOQ//RS+2/2CofBmwqDF0tdPx5od/nOTVjjlmfMbBiz0EMN1VutnRtQRnMj/X
5k3xE0LZdi91+01xyGDS3JaGc/4Q5Dhmybwu5RC2a1vZ18mj2gdQBDGXzANpXUML
m+mmq1o8bqWKecA/eYnSKjCdyYOUgWAhCCCwjNWsBrzbOpsHOmu1nYaB+lvMSFWZ
y83uFmzkUqjWFcXlfRvRQxrYctCgMXUrSzn0nd32yIbOwTe+dk/uKSRgiU/mtTFa
ORaxRV6Ohx6V+EZ8Sv962pqvp8xRRaBOW84OnD6wbOmgyxzgXogeaQdsEaKitc8K
ZXl+5koviMPyQUmQzWuySSLIT2nsHBaCTH9tck6DeIqi2gcGRkHzss22OcpAtNa7
KZ6Vfo+22CMNepDugBravEzuKfktOxz0udMBB7MYTMNiL4PHT2YXidcV7bV/WThl
d64ghZbvLWq2kAKFIjIeUv4vg4zIICVhcheieEKdApc6KqyJV1myZ8/uTcSaJPLw
RYWQMiyChxIkpo02HggzWO2gyhCQgkDNLZ4wzLEKJxyfan81T1leuPRZQT6XXW0P
w+xSBrPTI8qwHxHDZLknr0mzMUSG/X86vQeDrxj+5HvL1HInIOdBhOGvvDOUHGdY
jGbMv0cw+NfG3MUm2Jc+n1gu+QyGQYyvpIMyjwk9gzdsb6R8aM0=
=y+k3
-----END PGP SIGNATURE-----

--YU83H7T/fcLTVoMZ--

