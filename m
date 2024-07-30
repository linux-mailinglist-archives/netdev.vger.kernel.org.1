Return-Path: <netdev+bounces-114144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 219989412EF
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7595AB23BE5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F809198E84;
	Tue, 30 Jul 2024 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcEqtZHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D2173;
	Tue, 30 Jul 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345547; cv=none; b=hV/5AWF0bvbNllVNwLuzRtPLH2lwrcdtNI7WdvcTiZZ4veDlviULa0lQelYJG9K1KaGVEE5nCXImRAfn1a/srfmw8xAEQpODa/UUcrylcvqKhQInGFMkfIyIJ8PLL9eSumIzvULB/w0qO+au7to11lzHstH9mI6TXxZbUzLqv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345547; c=relaxed/simple;
	bh=HCIf9XuFl6tB5WF+L+HkWFkyZ4ILFc6TLSqOnuWij7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5ZnlcjgQpoXqZNRKMHh1355pM1uKKfv2DDjtVNGxjTCxzcVdcBftNkpc9sH6vJKSkuL2viZeHLS4ECPtm9Vym8/RqC094oDrU0AWQVC5HB9DnvRYwpkkPEm9ob1dbzEgd9haioG89ehAgTfSlcsaVylKQ9xlq1OYnYuPsMAUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcEqtZHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FE1C4AF0C;
	Tue, 30 Jul 2024 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722345546;
	bh=HCIf9XuFl6tB5WF+L+HkWFkyZ4ILFc6TLSqOnuWij7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcEqtZHrrufXuHDldlSFBEOiyXTA3nntEMNRBLpku0ZhTOooUWmRRvDXpQID6DhiU
	 0qZ6XYjYCAj9alOOPUd2lOCEt9MmNC9Hit1PXfBr4I/SkjpIga4FKACR14hRTiZ+oH
	 DSkQQLdUrvWJarC9foHDAAKJAStNggeDswkXYr3MpBIS1Hhl2532PLkaVMwtchdIeX
	 RRdaYFLADRIpISqgm77Asbsx9JJSXVIR1zkrlIXTsTlZRXBYvznfgDs4GoVUlkfmok
	 g1aTuvCLhBW/ff9fcPty2Gv/iW14xSdZbtdDY66rwthxBjQW6V79aobIT3AxIWtt4A
	 nE8xcLwW7lC4Q==
Date: Tue, 30 Jul 2024 15:19:03 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
	sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: Add EN7581 support
Message-ID: <ZqjoR-c9b3fjWoRa@lore-desk>
References: <cover.1722325265.git.lorenzo@kernel.org>
 <04a0f38a37e2a38438cdcd8d23ee4d80048e39da.1722325265.git.lorenzo@kernel.org>
 <b4c98268-e436-46d5-8906-2fdaf6e89fed@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vWJ/6jE5VlARBZho"
Content-Disposition: inline
In-Reply-To: <b4c98268-e436-46d5-8906-2fdaf6e89fed@arinc9.com>


--vWJ/6jE5VlARBZho
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 30/07/2024 10:46, Lorenzo Bianconi wrote:
> > Introduce support for the DSA built-in switch available on the EN7581
> > development board. EN7581 support is similar to MT7988 one except
> > it requires to set MT7530_FORCE_MODE bit in MT753X_PMCR_P register
> > for on cpu port.
> >=20
> > Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/net/dsa/mt7530-mmio.c |  1 +
> >   drivers/net/dsa/mt7530.c      | 38 +++++++++++++++++++++++++++++++----
> >   drivers/net/dsa/mt7530.h      | 16 ++++++++++-----
> >   3 files changed, 46 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmi=
o.c
> > index b74a230a3f13..10dc49961f15 100644
> > --- a/drivers/net/dsa/mt7530-mmio.c
> > +++ b/drivers/net/dsa/mt7530-mmio.c
> > @@ -11,6 +11,7 @@
> >   #include "mt7530.h"
> >   static const struct of_device_id mt7988_of_match[] =3D {
> > +	{ .compatible =3D "airoha,en7581-switch", .data =3D &mt753x_table[ID_=
EN7581], },
> >   	{ .compatible =3D "mediatek,mt7988-switch", .data =3D &mt753x_table[=
ID_MT7988], },
> >   	{ /* sentinel */ },
> >   };
> > diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> > index ec18e68bf3a8..8adc4561c5b2 100644
> > --- a/drivers/net/dsa/mt7530.c
> > +++ b/drivers/net/dsa/mt7530.c
> > @@ -1152,7 +1152,8 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int=
 port)
> >   	 * the MT7988 SoC. Trapped frames will be forwarded to the CPU port =
that
> >   	 * is affine to the inbound user port.
> >   	 */
> > -	if (priv->id =3D=3D ID_MT7531 || priv->id =3D=3D ID_MT7988)
> > +	if (priv->id =3D=3D ID_MT7531 || priv->id =3D=3D ID_MT7988 ||
> > +	    priv->id =3D=3D ID_EN7581)
> >   		mt7530_set(priv, MT7531_CFC, MT7531_CPU_PMAP(BIT(port)));
> >   	/* CPU port gets connected to all user ports of
> > @@ -2207,7 +2208,7 @@ mt7530_setup_irq(struct mt7530_priv *priv)
> >   		return priv->irq ? : -EINVAL;
> >   	}
> > -	if (priv->id =3D=3D ID_MT7988)
> > +	if (priv->id =3D=3D ID_MT7988 || priv->id =3D=3D ID_EN7581)
> >   		priv->irq_domain =3D irq_domain_add_linear(np, MT7530_NUM_PHYS,
> >   							 &mt7988_irq_domain_ops,
> >   							 priv);
> > @@ -2766,7 +2767,7 @@ static void mt7988_mac_port_get_caps(struct dsa_s=
witch *ds, int port,
> >   {
> >   	switch (port) {
> >   	/* Ports which are connected to switch PHYs. There is no MII pinout.=
 */
> > -	case 0 ... 3:
> > +	case 0 ... 4:
>=20
> Please create a new function, such as en7581_mac_port_get_caps().

ack, I will do in v2.

>=20
> >   		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> >   			  config->supported_interfaces);
> > @@ -2850,6 +2851,23 @@ mt7531_mac_config(struct dsa_switch *ds, int por=
t, unsigned int mode,
> >   	}
> >   }
> > +static void
> > +en7581_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
> > +		  phy_interface_t interface)
> > +{
> > +	/* BIT(31-27): reserved
> > +	 * BIT(26): TX_CRC_EN: enable(0)/disable(1) CRC insertion
> > +	 * BIT(25): RX_CRC_EN: enable(0)/disable(1) CRC insertion
> > +	 * Since the bits above have a different meaning with respect to the
> > +	 * one described in mt7530.h, set default values.
> > +	 */
> > +	mt7530_clear(ds->priv, MT753X_PMCR_P(port), MT7531_FORCE_MODE_MASK);
> > +	if (dsa_is_cpu_port(ds, port)) {
> > +		/* enable MT7530_FORCE_MODE on cpu port */
> > +		mt7530_set(ds->priv, MT753X_PMCR_P(port), MT7530_FORCE_MODE);
> > +	}
> > +}
>=20
> This seems to undo "Clear link settings and enable force mode to force li=
nk
> down on all ports until they're enabled later." on mt7531_setup_common()
> and redo it only for the CPU port. It should be so that force mode is
> enabled on all ports. You could position the diff below as a patch before
> this patch. It introduces the MT753X_FORCE_MODE() macro to choose the
> correct constant for the switch model.
>=20
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index ec18e68bf3a8..4915264c460f 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2438,8 +2438,10 @@ mt7530_setup(struct dsa_switch *ds)
>  		/* Clear link settings and enable force mode to force link down
>  		 * on all ports until they're enabled later.
>  		 */
> -		mt7530_rmw(priv, MT753X_PMCR_P(i), PMCR_LINK_SETTINGS_MASK |
> -			   MT7530_FORCE_MODE, MT7530_FORCE_MODE);
> +		mt7530_rmw(priv, MT753X_PMCR_P(i),
> +			   PMCR_LINK_SETTINGS_MASK |
> +				   MT753X_FORCE_MODE(priv->id),
> +			   MT753X_FORCE_MODE(priv->id));
>  		/* Disable forwarding by default on all ports */
>  		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
> @@ -2550,8 +2552,10 @@ mt7531_setup_common(struct dsa_switch *ds)
>  		/* Clear link settings and enable force mode to force link down
>  		 * on all ports until they're enabled later.
>  		 */
> -		mt7530_rmw(priv, MT753X_PMCR_P(i), PMCR_LINK_SETTINGS_MASK |
> -			   MT7531_FORCE_MODE_MASK, MT7531_FORCE_MODE_MASK);
> +		mt7530_rmw(priv, MT753X_PMCR_P(i),
> +			   PMCR_LINK_SETTINGS_MASK |
> +				   MT753X_FORCE_MODE(priv->id),
> +			   MT753X_FORCE_MODE(priv->id));
>  		/* Disable forwarding by default on all ports */
>  		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 28592123070b..d47d1ce511ba 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -355,6 +355,10 @@ enum mt7530_vlan_port_acc_frm {
>  					 MT7531_FORCE_MODE_TX_FC | \
>  					 MT7531_FORCE_MODE_EEE100 | \
>  					 MT7531_FORCE_MODE_EEE1G)
> +#define  MT753X_FORCE_MODE(id)		((id =3D=3D ID_MT7531 || \
> +					  id =3D=3D ID_MT7988) ? \
> +					 MT7531_FORCE_MODE_MASK : \
> +					 MT7530_FORCE_MODE)
>  #define  PMCR_LINK_SETTINGS_MASK	(PMCR_MAC_TX_EN | PMCR_MAC_RX_EN | \
>  					 PMCR_FORCE_EEE1G | \
>  					 PMCR_FORCE_EEE100 | \

ack, fine. I will merge this change in v2.

>=20
> > +
> >   static struct phylink_pcs *
> >   mt753x_phylink_mac_select_pcs(struct phylink_config *config,
> >   			      phy_interface_t interface)
> > @@ -2880,7 +2898,8 @@ mt753x_phylink_mac_config(struct phylink_config *=
config, unsigned int mode,
> >   	priv =3D ds->priv;
> > -	if ((port =3D=3D 5 || port =3D=3D 6) && priv->info->mac_port_config)
> > +	if ((port =3D=3D 5 || port =3D=3D 6 || priv->id =3D=3D ID_EN7581) &&
> > +	    priv->info->mac_port_config)
> >   		priv->info->mac_port_config(ds, port, mode, state->interface);
> >   	/* Are we connected to external phy */
> > @@ -3220,6 +3239,17 @@ const struct mt753x_info mt753x_table[] =3D {
> >   		.phy_write_c45 =3D mt7531_ind_c45_phy_write,
> >   		.mac_port_get_caps =3D mt7988_mac_port_get_caps,
> >   	},
> > +	[ID_EN7581] =3D {
> > +		.id =3D ID_EN7581,
> > +		.pcs_ops =3D &mt7530_pcs_ops,
> > +		.sw_setup =3D mt7988_setup,
> > +		.phy_read_c22 =3D mt7531_ind_c22_phy_read,
> > +		.phy_write_c22 =3D mt7531_ind_c22_phy_write,
> > +		.phy_read_c45 =3D mt7531_ind_c45_phy_read,
> > +		.phy_write_c45 =3D mt7531_ind_c45_phy_write,
> > +		.mac_port_get_caps =3D mt7988_mac_port_get_caps,
> > +		.mac_port_config =3D en7581_mac_config,
> > +	},
>=20
> Let me lend a hand; you can apply this diff on top of this patch.

Thx :)

>=20
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index b18b98a53a7d..f5766d8ae360 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2768,6 +2768,28 @@ static void mt7531_mac_port_get_caps(struct dsa_sw=
itch *ds, int port,
>  static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
>  				     struct phylink_config *config)
> +{
> +	switch (port) {
> +	/* Ports which are connected to switch PHYs. There is no MII pinout. */
> +	case 0 ... 3:
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +
> +		config->mac_capabilities |=3D MAC_10 | MAC_100 | MAC_1000FD;
> +		break;
> +
> +	/* Port 6 is connected to SoC's XGMII MAC. There is no MII pinout. */
> +	case 6:
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +
> +		config->mac_capabilities |=3D MAC_10000FD;
> +		break;
> +	}
> +}
> +
> +static void en7581_mac_port_get_caps(struct dsa_switch *ds, int port,
> +				     struct phylink_config *config)
>  {
>  	switch (port) {
>  	/* Ports which are connected to switch PHYs. There is no MII pinout. */
> @@ -2855,23 +2877,6 @@ mt7531_mac_config(struct dsa_switch *ds, int port,=
 unsigned int mode,
>  	}
>  }
> -static void
> -en7581_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
> -		  phy_interface_t interface)
> -{
> -	/* BIT(31-27): reserved
> -	 * BIT(26): TX_CRC_EN: enable(0)/disable(1) CRC insertion
> -	 * BIT(25): RX_CRC_EN: enable(0)/disable(1) CRC insertion
> -	 * Since the bits above have a different meaning with respect to the
> -	 * one described in mt7530.h, set default values.
> -	 */
> -	mt7530_clear(ds->priv, MT753X_PMCR_P(port), MT7531_FORCE_MODE_MASK);
> -	if (dsa_is_cpu_port(ds, port)) {
> -		/* enable MT7530_FORCE_MODE on cpu port */
> -		mt7530_set(ds->priv, MT753X_PMCR_P(port), MT7530_FORCE_MODE);
> -	}
> -}
> -
>  static struct phylink_pcs *
>  mt753x_phylink_mac_select_pcs(struct phylink_config *config,
>  			      phy_interface_t interface)
> @@ -2902,8 +2907,7 @@ mt753x_phylink_mac_config(struct phylink_config *co=
nfig, unsigned int mode,
>  	priv =3D ds->priv;
> -	if ((port =3D=3D 5 || port =3D=3D 6 || priv->id =3D=3D ID_EN7581) &&
> -	    priv->info->mac_port_config)
> +	if ((port =3D=3D 5 || port =3D=3D 6) && priv->info->mac_port_config)
>  		priv->info->mac_port_config(ds, port, mode, state->interface);
>  	/* Are we connected to external phy */
> @@ -3251,8 +3255,7 @@ const struct mt753x_info mt753x_table[] =3D {
>  		.phy_write_c22 =3D mt7531_ind_c22_phy_write,
>  		.phy_read_c45 =3D mt7531_ind_c45_phy_read,
>  		.phy_write_c45 =3D mt7531_ind_c45_phy_write,
> -		.mac_port_get_caps =3D mt7988_mac_port_get_caps,
> -		.mac_port_config =3D en7581_mac_config,
> +		.mac_port_get_caps =3D en7581_mac_port_get_caps,
>  	},
>  };
>  EXPORT_SYMBOL_GPL(mt753x_table);
>=20
> I don't know this hardware so please make sure the comments on
> en7581_mac_port_get_caps() are correct. I didn't compile this so please
> make sure it works.

ack, I tested it and it works fine.

Regards,
Lorenzo

>=20
> By the way, is this supposed to be AN7581? There's EN7580 but no EN7581 on
> the Airoha website.
>=20
> https://www.airoha.com/products/y1cQz8EpjIKhbK61
>=20
> Ar=C4=B1n=C3=A7

--vWJ/6jE5VlARBZho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZqjoRwAKCRA6cBh0uS2t
rJA5AP93vRv2hPmAsLJ/N8F/CcGfGM48JOfCRp8G5Pc+9+ujawD9FiXAvbYsL/Pg
cJwCTgahOxHT1GDGrpo/ZMoTNr2EDAo=
=Na3G
-----END PGP SIGNATURE-----

--vWJ/6jE5VlARBZho--

