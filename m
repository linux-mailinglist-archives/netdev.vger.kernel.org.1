Return-Path: <netdev+bounces-240027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6496FC6F692
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 49C9E2413D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B56A369226;
	Wed, 19 Nov 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0Rl0sp1w"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE232FA0B
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563502; cv=none; b=j4m3bQ6kcloCm/RbJZ45zOCvHeJtit3QQTTUdWNvVyqYCnFj+D86Nlb+RmXlMbaKqVDEBRSX+qzOj7gnj06b0+ueTvGHAVvWOEEv2HXieMIqXx/ZFo5vOMD8+t73AQU6DXMAfvSYYBqkfKlRdDO3/wzJU7Mt9J3bvkPMqopLtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563502; c=relaxed/simple;
	bh=4Z5a11EyYCieIyPiW/n4D512METjXrEvfjMOaNbvIrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUiYq5999AbqtwcMSMyYIVBaXDPGUc9gRsSaXddh/J8LbUTDStPhoY1VNBGAuBpgqXFfuScak5lGIREOLATL/GqjH67VWbNvvdKMnz44SumPIXyD/fBhGOPk49f74BWLJ0O6mDgisBmBMzvjaGP7OeTI05TDrKId0TpstdwhY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0Rl0sp1w; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D749E4E417A3;
	Wed, 19 Nov 2025 14:44:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 97E8860699;
	Wed, 19 Nov 2025 14:44:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6873910371A6A;
	Wed, 19 Nov 2025 15:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763563495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7iiJkyAiaoC4nTbLPRcA1iOunb9oVr36vkZfSc57VsA=;
	b=0Rl0sp1wQb64Ay+ArkOFLsYq3M6SnWwGlpPikPGywEbaTi3z77+SAYX9/bHivJ2qoCNPYN
	sViCpqRDrKydyagjH2XgJNWvPtFaZb1A1iEOEtv+I3PDwh6eXJg3ISIhNQPlfuKphn19+B
	LRtaSs/o/VKQSKfnn6mUU4itsvg36WPDiXxrLFYjb9Z5u19zbl53KWy41FWRbQlqotce6u
	mkKFHojmi+gzW+wUC8/lzJI69mt5sLerjQ1WMxVh6zLSJmymTRzm1UdswJ/Ymk0T64nyBg
	ZkM9NSfMU8jcM6eB16wLE1KhOmxhihW3/NvhCPAHOssM6UrwrkGMf45xlXPzgA==
Date: Wed, 19 Nov 2025 15:44:48 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrei Botila
 <andrei.botila@oss.nxp.com>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/9] net: phy: micrel: add HW timestamp
 configuration reporting
Message-ID: <20251119154448.2ca40ac9@kmaincent-XPS-13-7390>
In-Reply-To: <20251119124725.3935509-6-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
	<20251119124725.3935509-6-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 19 Nov 2025 12:47:21 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores HW timestamping configuration and can technically
> report it. Add callback to do it.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/phy/micrel.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 05de68b9f719..b149d539aec3 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -3147,6 +3147,18 @@ static void lan8814_flush_fifo(struct phy_device
> *phydev, bool egress) lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
> PTP_TSU_INT_STS); }
> =20
> +static int lan8814_hwtstamp_get(struct mii_timestamper *mii_ts,
> +				struct kernel_hwtstamp_config *config)
> +{
> +	struct kszphy_ptp_priv *ptp_priv =3D
> +			  container_of(mii_ts, struct kszphy_ptp_priv,
> mii_ts); +
> +	config->tx_type =3D ptp_priv->hwts_tx_type;
> +	config->rx_filter =3D ptp_priv->rx_filter;
> +
> +	return 0;
> +}
> +
>  static int lan8814_hwtstamp_set(struct mii_timestamper *mii_ts,
>  				struct kernel_hwtstamp_config *config,
>  				struct netlink_ext_ack *extack)
> @@ -4390,6 +4402,7 @@ static void lan8814_ptp_init(struct phy_device *phy=
dev)
>  	ptp_priv->mii_ts.rxtstamp =3D lan8814_rxtstamp;
>  	ptp_priv->mii_ts.txtstamp =3D lan8814_txtstamp;
>  	ptp_priv->mii_ts.hwtstamp_set =3D lan8814_hwtstamp_set;
> +	ptp_priv->mii_ts.hwtstamp_get =3D lan8814_hwtstamp_get;
>  	ptp_priv->mii_ts.ts_info  =3D lan8814_ts_info;
> =20
>  	phydev->mii_ts =3D &ptp_priv->mii_ts;
> @@ -5042,6 +5055,19 @@ static void lan8841_ptp_enable_processing(struct
> kszphy_ptp_priv *ptp_priv, #define LAN8841_PTP_TX_TIMESTAMP_EN
> 443 #define LAN8841_PTP_TX_MOD			445
> =20
> +static int lan8841_hwtstamp_get(struct mii_timestamper *mii_ts,
> +				struct kernel_hwtstamp_config *config)
> +{
> +	struct kszphy_ptp_priv *ptp_priv;
> +
> +	ptp_priv =3D container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
> +
> +	config->tx_type =3D ptp_priv->hwts_tx_type;
> +	config->rx_filter =3D ptp_priv->rx_filter;

Something related to this patch, it seems there is an issue in the set
callback:
https://elixir.bootlin.com/linux/v6.18-rc6/source/drivers/net/phy/micrel.c#=
L3056

The priv->rx_filter and priv->hwts_tx_type are set before the switch condit=
ion.
The hwtstamp_get can then report something that is not supported.
Also HWTSTAMP_TX_ONESTEP_P2P is not managed by the driver but not returning
-ERANGE either so if we set this config the hwtstamp_get will report someth=
ing
wrong as not supported.
I think you will need to add a new patch here to fix the hwtstamp_set ops.

Maybe we should update net_hwtstamp_validate to check on the capabilities
reported by ts_info but that is a bigger change.

> +
> +	return 0;
> +}
> +
>  static int lan8841_hwtstamp_set(struct mii_timestamper *mii_ts,
>  				struct kernel_hwtstamp_config *config,
>  				struct netlink_ext_ack *extack)
> @@ -5925,6 +5951,7 @@ static int lan8841_probe(struct phy_device *phydev)
>  	ptp_priv->mii_ts.rxtstamp =3D lan8841_rxtstamp;
>  	ptp_priv->mii_ts.txtstamp =3D lan8814_txtstamp;
>  	ptp_priv->mii_ts.hwtstamp_set =3D lan8841_hwtstamp_set;
> +	ptp_priv->mii_ts.hwtstamp_get =3D lan8841_hwtstamp_get;
>  	ptp_priv->mii_ts.ts_info =3D lan8841_ts_info;
> =20
>  	phydev->mii_ts =3D &ptp_priv->mii_ts;



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

