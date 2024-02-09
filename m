Return-Path: <netdev+bounces-70465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9EE84F223
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95CB288EB6
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34AC664D0;
	Fri,  9 Feb 2024 09:17:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8B664CF
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470250; cv=none; b=uCCJvWg/4Q0T74yDV/XnzqN1ElSpLAaww7ex5f2T9JyonfcM8Pg0DubMLW6Hbh22+V8mkEc0zs1le6t4XH72snIleiHI021HYo71c9QYcSPqvS4Xwh5gg3j4MqFCVdKDGApW/aAys0Og+de5/IBKq4MRL6zOn6butH8J+QLDzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470250; c=relaxed/simple;
	bh=l2UjvVwyyCSopQ008FQ04ugHMSP3qSSh8dQt4MzZbYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1bJwyg1alxbMiqEtfhCkZigktWsY3ox4CBMLgg0pg6Cdgz4W9lcdjFwdry9BfF0IicQn7U3jJwagEvWg+q2aEipKAeObw554QVU7USaInE6Dknr1hLKhvXGNkei/5UAIxSbkdWo4AGIZD8FJe4PDyzNfOgPRSgrdGlzTw7jKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rYN0R-00055d-0u; Fri, 09 Feb 2024 10:17:11 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rYN0P-005Ns2-2t; Fri, 09 Feb 2024 10:17:09 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AFFE1289CD7;
	Fri,  9 Feb 2024 09:17:08 +0000 (UTC)
Date: Fri, 9 Feb 2024 10:17:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] net: fec: Refactor: #define magic constants
Message-ID: <20240209-genetics-bolster-08f69ccca8a9-mkl@pengutronix.de>
References: <20240209091100.5341-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zjylrjo4hcpenuy2"
Content-Disposition: inline
In-Reply-To: <20240209091100.5341-1-csokas.bence@prolan.hu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--zjylrjo4hcpenuy2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.02.2024 10:11:01, Cs=C3=B3k=C3=A1s Bence wrote:
> Add defines for bits of ECR, RCR control registers, TX watermark etc.
>=20
> Signed-off-by: Cs=C3=B3k=C3=A1s Bence <csokas.bence@prolan.hu>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 50 +++++++++++++++--------
>  1 file changed, 33 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethe=
rnet/freescale/fec_main.c
> index 63707e065141..a16220eff9b3 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -85,8 +85,6 @@ static int fec_enet_xdp_tx_xmit(struct fec_enet_private=
 *fep,
> =20
>  static const u16 fec_enet_vlan_pri_to_queue[8] =3D {0, 0, 1, 1, 1, 2, 2,=
 2};
> =20
> -/* Pause frame feild and FIFO threshold */
> -#define FEC_ENET_FCE	(1 << 5)
>  #define FEC_ENET_RSEM_V	0x84
>  #define FEC_ENET_RSFL_V	16
>  #define FEC_ENET_RAEM_V	0x8
> @@ -240,8 +238,8 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>  #define PKT_MINBUF_SIZE		64
> =20
>  /* FEC receive acceleration */
> -#define FEC_RACC_IPDIS		(1 << 1)
> -#define FEC_RACC_PRODIS		(1 << 2)
> +#define FEC_RACC_IPDIS		BIT(1)
> +#define FEC_RACC_PRODIS		BIT(2)
>  #define FEC_RACC_SHIFT16	BIT(7)
>  #define FEC_RACC_OPTIONS	(FEC_RACC_IPDIS | FEC_RACC_PRODIS)
> =20
> @@ -273,8 +271,23 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address"=
);
>  #define FEC_MMFR_TA		(2 << 16)
>  #define FEC_MMFR_DATA(v)	(v & 0xffff)
>  /* FEC ECR bits definition */
> -#define FEC_ECR_MAGICEN		(1 << 2)
> -#define FEC_ECR_SLEEP		(1 << 3)
> +#define FEC_ECR_RESET           BIT(0)
> +#define FEC_ECR_ETHEREN         BIT(1)
> +#define FEC_ECR_MAGICEN         BIT(2)
> +#define FEC_ECR_SLEEP           BIT(3)
> +#define FEC_ECR_EN1588          BIT(4)
> +#define FEC_ECR_BYTESWP         BIT(8)
> +/* FEC RCR bits definition */
> +#define FEC_RCR_LOOP            BIT(0)
> +#define FEC_RCR_HALFDPX         BIT(1)
> +#define FEC_RCR_MII             BIT(2)
> +#define FEC_RCR_PROMISC         BIT(3)
> +#define FEC_RCR_BC_REJ          BIT(4)
> +#define FEC_RCR_FLOWCTL         BIT(5)
> +#define FEC_RCR_RMII            BIT(8)
> +#define FEC_RCR_10BASET         BIT(9)
> +/* TX WMARK bits */
> +#define FEC_TXWMRK_STRFWD       BIT(8)
> =20
>  #define FEC_MII_TIMEOUT		30000 /* us */
> =20
> @@ -1137,18 +1150,18 @@ fec_restart(struct net_device *ndev)
>  		    fep->phy_interface =3D=3D PHY_INTERFACE_MODE_RGMII_TXID)
>  			rcntl |=3D (1 << 6);
>  		else if (fep->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII)
> -			rcntl |=3D (1 << 8);
> +			rcntl |=3D FEC_RCR_RMII;
>  		else
> -			rcntl &=3D ~(1 << 8);
> +			rcntl &=3D ~FEC_RCR_RMII;
> =20
>  		/* 1G, 100M or 10M */
>  		if (ndev->phydev) {
>  			if (ndev->phydev->speed =3D=3D SPEED_1000)
>  				ecntl |=3D (1 << 5);
>  			else if (ndev->phydev->speed =3D=3D SPEED_100)
> -				rcntl &=3D ~(1 << 9);
> +				rcntl &=3D ~FEC_RCR_10BASET;
>  			else
> -				rcntl |=3D (1 << 9);
> +				rcntl |=3D FEC_RCR_10BASET;
>  		}
>  	} else {
>  #ifdef FEC_MIIGSK_ENR
> @@ -1181,7 +1194,7 @@ fec_restart(struct net_device *ndev)
>  	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
>  	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
>  	     ndev->phydev && ndev->phydev->pause)) {
> -		rcntl |=3D FEC_ENET_FCE;
> +		rcntl |=3D FEC_RCR_FLOWCTL;
> =20
>  		/* set FIFO threshold parameter to reduce overrun */
>  		writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
> @@ -1192,7 +1205,7 @@ fec_restart(struct net_device *ndev)
>  		/* OPD */
>  		writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
>  	} else {
> -		rcntl &=3D ~FEC_ENET_FCE;
> +		rcntl &=3D ~FEC_RCR_FLOWCTL;
>  	}
>  #endif /* !defined(CONFIG_M5272) */
> =20
> @@ -1207,13 +1220,13 @@ fec_restart(struct net_device *ndev)
> =20
>  	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
>  		/* enable ENET endian swap */
> -		ecntl |=3D (1 << 8);
> +		ecntl |=3D FEC_ECR_BYTESWP;
>  		/* enable ENET store and forward mode */
> -		writel(1 << 8, fep->hwp + FEC_X_WMRK);
> +		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
>  	}
> =20
>  	if (fep->bufdesc_ex)
> -		ecntl |=3D (1 << 4);
> +		ecntl |=3D FEC_ECR_EN1588;
> =20
>  	if (fep->quirks & FEC_QUIRK_DELAYED_CLKS_SUPPORT &&
>  	    fep->rgmii_txc_dly)
> @@ -1312,7 +1325,8 @@ static void
>  fec_stop(struct net_device *ndev)
>  {
>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
> -	u32 rmii_mode =3D readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
> +	u32 rmii_mode =3D readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
> +	u32 ecntl =3D 0;

This is an unrelated change.

>  	u32 val;
> =20
>  	/* We cannot expect a graceful transmit stop without link !!! */
> @@ -1345,9 +1359,11 @@ fec_stop(struct net_device *ndev)
>  	/* We have to keep ENET enabled to have MII interrupt stay working */
>  	if (fep->quirks & FEC_QUIRK_ENET_MAC &&
>  		!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
> -		writel(2, fep->hwp + FEC_ECNTRL);
> +		ecntl |=3D FEC_ECR_ETHEREN;

This is an unrelated change.

>  		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
>  	}
> +
> +	writel(ecntl, fep->hwp + FEC_ECNTRL);

This is an unrelated change.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zjylrjo4hcpenuy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXF7ZEACgkQKDiiPnot
vG+7awgAn6bsQtbe73Lhbn/owy6mjeq4DADBWVtklRY/PkrhvHrsrVvdlwpOIht5
SG8+zumlkpeJ5i9b7sN9QFBV7gGUGARL7dEI9wOnRfubc4cs9MqSiLiwIaf7zgQI
jh4e/vzYZq9QWEidSPINasNKr5Umyh0c3Io9mK++0fiy2BMrON+wWDjC/7nqYAl6
Qj1uDE4sNSIHHNj6tM+0SpVGbicnRj5NN9OnIgydb7/z4oKQ3N8OkC4LsqrvMhkL
jVIURipFq0DB9wZJ7DB0iBcHL7+ceO+p7vuVM+IvdSnegKtt75pII8e3wvSN6ZiA
Qxt1Jy1OpOv+9k0AFVq9CyKbvdsMvA==
=7GmH
-----END PGP SIGNATURE-----

--zjylrjo4hcpenuy2--

