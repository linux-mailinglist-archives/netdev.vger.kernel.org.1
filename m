Return-Path: <netdev+bounces-120858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9479C95B0E3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76FE1C22729
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C445175D51;
	Thu, 22 Aug 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGqKWZfm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E223170853;
	Thu, 22 Aug 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316427; cv=none; b=j/hASQx8irnV9VlLfqfYvzleVvz8eT4zkdn2u32JhzlUi2nQrAcvdx7XvVOAkoOLzA7BPW79xT9d5HMbKpadiTv7YIO+3HaTCB5OvYX6mo95snWr0/PyQ6p+t7Ga8Ew7t5AzBNV1mQ/NsyujQbmdawGm27Wib75/12hc0j/YO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316427; c=relaxed/simple;
	bh=3bWwL4T8vaWlqowHbIFp0xSD2EoKy+6F8vUXq842G/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFAVMqaZUl7PvFTBQnbMkQVMIr5ulmDO3OpuoxU6nh5AgmikCqgkKZy13WLa7UeYltq9hDHgCiwpjFtr3NRbRhaBdE4pdIUIUNvYLes4IxTPZnpwgFEUuv2hQ8gjjXNicFzbstdmrhpczWgPdtt+fLdInp9sN7u10W6AmuB4P0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGqKWZfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39D8C4AF0B;
	Thu, 22 Aug 2024 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724316426;
	bh=3bWwL4T8vaWlqowHbIFp0xSD2EoKy+6F8vUXq842G/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGqKWZfmrWv5MCpqshWHHwVdsGQHbO/KwP4dCJymAzE4ZUAEnioLZeZde+7fmqAEb
	 BCMuxe/SFy3Y4SD7xa3o/i49gX8NuGxnZSCfKvpKFzRPuHdla4yZPrtblRIecwSIsj
	 bb6rQ16gwbQ/IMxzHBWcvX6T0npNKIXTiZlBtm/GUz/2JTreMvNqOgAkI2MNftzuqG
	 ET5a2Q1TYpPhcgCD0cGh819bBuRrhON5OoSFLsFUNYHpB5NvDia1pOIIwjiLLlRCMK
	 KYophYe+kHbvLL0d91qku1c8hopFDwTN686uELsxv7ggpSjuBVaOduvVnb7YB1x740
	 J4dSn6XIB7gdw==
Date: Thu, 22 Aug 2024 09:47:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace
 "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
Message-ID: <20240822-headed-sworn-877211c3931f@spud>
References: <20240822013721.203161-1-wei.fang@nxp.com>
 <20240822013721.203161-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7Iw/ddfuE8M/V2WC"
Content-Disposition: inline
In-Reply-To: <20240822013721.203161-3-wei.fang@nxp.com>


--7Iw/ddfuE8M/V2WC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 09:37:20AM +0800, Wei Fang wrote:
> As the new property "nxp,phy-output-refclk" is added to instead of
> the "nxp,rmii-refclk-in" property, so replace the "nxp,rmii-refclk-in"
> property used in the driver with the "nxp,reverse-mode" property and
> make slight modifications.

Can you explain what makes this backwards compatible please?

>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> V2 changes:
> 1. Changed the property name.
> ---
>  drivers/net/phy/nxp-tja11xx.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
> index 2c263ae44b4f..7aa0599c38c3 100644
> --- a/drivers/net/phy/nxp-tja11xx.c
> +++ b/drivers/net/phy/nxp-tja11xx.c
> @@ -78,8 +78,7 @@
>  #define MII_COMMCFG			27
>  #define MII_COMMCFG_AUTO_OP		BIT(15)
> =20
> -/* Configure REF_CLK as input in RMII mode */
> -#define TJA110X_RMII_MODE_REFCLK_IN       BIT(0)
> +#define TJA11XX_REVERSE_MODE		BIT(0)
> =20
>  struct tja11xx_priv {
>  	char		*hwmon_name;
> @@ -274,10 +273,10 @@ static int tja11xx_get_interface_mode(struct phy_de=
vice *phydev)
>  		mii_mode =3D MII_CFG1_REVMII_MODE;
>  		break;
>  	case PHY_INTERFACE_MODE_RMII:
> -		if (priv->flags & TJA110X_RMII_MODE_REFCLK_IN)
> -			mii_mode =3D MII_CFG1_RMII_MODE_REFCLK_IN;
> -		else
> +		if (priv->flags & TJA11XX_REVERSE_MODE)
>  			mii_mode =3D MII_CFG1_RMII_MODE_REFCLK_OUT;
> +		else
> +			mii_mode =3D MII_CFG1_RMII_MODE_REFCLK_IN;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -517,8 +516,8 @@ static int tja11xx_parse_dt(struct phy_device *phydev)
>  	if (!IS_ENABLED(CONFIG_OF_MDIO))
>  		return 0;
> =20
> -	if (of_property_read_bool(node, "nxp,rmii-refclk-in"))
> -		priv->flags |=3D TJA110X_RMII_MODE_REFCLK_IN;
> +	if (of_property_read_bool(node, "nxp,phy-output-refclk"))
> +		priv->flags |=3D TJA11XX_REVERSE_MODE;
> =20
>  	return 0;
>  }
> --=20
> 2.34.1
>=20

--7Iw/ddfuE8M/V2WC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsb7BQAKCRB4tDGHoIJi
0k/DAQCFn021AFv8ijQoyazYsqV/JdrjdyG3BnG8U2HSTy/K9QEAxWHlTnKsNl0y
HE+P6/H6FIKNyfSn1mnYOhwRzWwQLA4=
=hJz4
-----END PGP SIGNATURE-----

--7Iw/ddfuE8M/V2WC--

