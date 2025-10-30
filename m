Return-Path: <netdev+bounces-234351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB44C1F953
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CF0424F53
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DC12F8BEE;
	Thu, 30 Oct 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gx4Ls7sA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95134DB57
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820217; cv=none; b=UsKXB0+n3HvdMIBRmAjlhU7yd8xcqT1XGanFjIHcwbPWKAxB19d7N46zqIbJTf2eJH42TOiLgWVOvc/4gW8pFX6yGcwUEIgD58OG0Ta2kcGwJ+ICezWJrlCuTL0AQb2neqG/MgAwWlN9SS66ToBdHm8//R04kH9tpn0WZdJsR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820217; c=relaxed/simple;
	bh=IfIdHdQLq4yotsjQgOHDIuVVZRQ9KlW83RRMlTa7kM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBRhH39AROY6eX1yWBKiArrs4V2HyyvKnREemsooc9qMt46jc4APW7Shz22H2WkFwN7Yx/EWOft9yHMQF1QfL2Uo9USJ75RX8Olb811mMXw7YheXvqngHqn2KVkYJSM6JzvQ5IF/S5VSmvmGe4A9ZkHNdu2VXcuPcPZ18s23MCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gx4Ls7sA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6FEDF4E413EF
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:30:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43E6E6068C;
	Thu, 30 Oct 2025 10:30:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5EA5102F2500;
	Thu, 30 Oct 2025 11:30:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761820211; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6uY0D16mFNvYxpCJvbMOjToK3gBXmGfbF4RVLD8mqjc=;
	b=Gx4Ls7sA4dhXtcKi6yTByomyZpYKlGNs3uP8Xy3siVSj88xaTS4IXrtxLDIVKocQ2+ErEL
	AyA4kqh8fUZ3mb+JSbNtHNzWRtw7tmyz2mFyyMDArkLS//o7hwrR4ML4pHE0hEHAOqo9zb
	66lyLHBQ7e7qv9CQje9IWoC5yiQJWsxVx6hdVBMk5eDVak23GKNN3Nl0JSDNEIgbGnxoAY
	YiKDX6DpYxDoIMY8JluV8c/q5zCywNuwO40srVhN12goyd6tH5OCA+iBCOxv8TT29hArQZ
	qKxtmmrYnpmsvxh5Txrgmwl5hRY+Xqq2aKbkdxItxvmClEoU8RYaqgRtt/zeog==
Date: Thu, 30 Oct 2025 11:30:07 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next] ti: netcp: convert to ndo_hwtstamp callbacks
Message-ID: <20251030113007.1acc78b6@kmaincent-XPS-13-7390>
In-Reply-To: <20251029200922.590363-1-vadim.fedorenko@linux.dev>
References: <20251029200922.590363-1-vadim.fedorenko@linux.dev>
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

On Wed, 29 Oct 2025 20:09:22 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> Convert TI NetCP driver to use ndo_hwtstamp_get()/ndo_hwtstamp_set()
> callbacks. The logic is slightly changed, because I believe the original
> logic was not really correct. Config reading part is using the very
> first module to get the configuration instead of iterating over all of
> them and keep the last one as the configuration is supposed to be identic=
al
> for all modules. HW timestamp config set path is now trying to configure
> all modules, but in case of error from one module it adds extack
> message. This way the configuration will be as synchronized as possible.

On the case the hwtstamp_set return the extack error the hwtstamp_get will
return something that might not be true as not all module will have the same
config. Is it acceptable?
=20
> There are only 2 modules using netcp core infrastructure, and both use
> the very same function to configure HW timestamping, so no actual
> difference in behavior is expected.
>=20
> Compile test only.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> b/drivers/net/ethernet/ti/netcp_ethss.c index 55a1a96cd834..0ae44112812c
> 100644 --- a/drivers/net/ethernet/ti/netcp_ethss.c
> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
> @@ -2591,20 +2591,26 @@ static int gbe_rxtstamp(struct gbe_intf *gbe_intf,
> struct netcp_packet *p_info) return 0;
>  }
> =20
> -static int gbe_hwtstamp_get(struct gbe_intf *gbe_intf, struct ifreq *ifr)
> +static int gbe_hwtstamp_get(void *intf_priv, struct kernel_hwtstamp_conf=
ig
> *cfg) {
> -	struct gbe_priv *gbe_dev =3D gbe_intf->gbe_dev;
> -	struct cpts *cpts =3D gbe_dev->cpts;
> -	struct hwtstamp_config cfg;
> +	struct gbe_intf *gbe_intf =3D intf_priv;
> +	struct gbe_priv *gbe_dev;
> +	struct phy_device *phy;
> +
> +	gbe_dev =3D gbe_intf->gbe_dev;
> =20
> -	if (!cpts)
> +	if (!gbe_dev->cpts)
> +		return -EOPNOTSUPP;
> +
> +	phy =3D gbe_intf->slave->phy;
> +	if (phy_has_hwtstamp(phy))
>  		return -EOPNOTSUPP;

This condition should be removed.
The selection between PHY or MAC timestamping is now done in the net core:
https://elixir.bootlin.com/linux/v6.17.1/source/net/core/dev_ioctl.c#L244

> =20
> -	cfg.flags =3D 0;
> -	cfg.tx_type =3D gbe_dev->tx_ts_enabled ? HWTSTAMP_TX_ON :
> HWTSTAMP_TX_OFF;
> -	cfg.rx_filter =3D gbe_dev->rx_ts_enabled;
> +	cfg->flags =3D 0;
> +	cfg->tx_type =3D gbe_dev->tx_ts_enabled ? HWTSTAMP_TX_ON :
> HWTSTAMP_TX_OFF;
> +	cfg->rx_filter =3D gbe_dev->rx_ts_enabled;
> =20
> -	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
> +	return 0;
>  }
> =20
>  static void gbe_hwtstamp(struct gbe_intf *gbe_intf)
> @@ -2637,19 +2643,23 @@ static void gbe_hwtstamp(struct gbe_intf *gbe_int=
f)
>  	writel(ctl,    GBE_REG_ADDR(slave, port_regs, ts_ctl_ltype2));
>  }
> =20
> -static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
> +static int gbe_hwtstamp_set(void *intf_priv, struct kernel_hwtstamp_conf=
ig
> *cfg,
> +			    struct netlink_ext_ack *extack)
>  {
> -	struct gbe_priv *gbe_dev =3D gbe_intf->gbe_dev;
> -	struct cpts *cpts =3D gbe_dev->cpts;
> -	struct hwtstamp_config cfg;
> +	struct gbe_intf *gbe_intf =3D intf_priv;
> +	struct gbe_priv *gbe_dev;
> +	struct phy_device *phy;
> =20
> -	if (!cpts)
> +	gbe_dev =3D gbe_intf->gbe_dev;
> +
> +	if (!gbe_dev->cpts)
>  		return -EOPNOTSUPP;
> =20
> -	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
> -		return -EFAULT;
> +	phy =3D gbe_intf->slave->phy;
> +	if (phy_has_hwtstamp(phy))
> +		return phy->mii_ts->hwtstamp(phy->mii_ts, cfg, extack);

Same.

> =20
> -	switch (cfg.tx_type) {
> +	switch (cfg->tx_type) {
>  	case HWTSTAMP_TX_OFF:
>  		gbe_dev->tx_ts_enabled =3D 0;
>  		break;
> @@ -2660,7 +2670,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_in=
tf,
> struct ifreq *ifr) return -ERANGE;
>  	}
> =20
> -	switch (cfg.rx_filter) {
> +	switch (cfg->rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		gbe_dev->rx_ts_enabled =3D HWTSTAMP_FILTER_NONE;
>  		break;
> @@ -2668,7 +2678,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_in=
tf,
> struct ifreq *ifr) case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>  	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>  		gbe_dev->rx_ts_enabled =3D HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
> -		cfg.rx_filter =3D HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
> +		cfg->rx_filter =3D HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>  		break;
>  	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>  	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> @@ -2680,7 +2690,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_in=
tf,
> struct ifreq *ifr) case HWTSTAMP_FILTER_PTP_V2_SYNC:
>  	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>  		gbe_dev->rx_ts_enabled =3D HWTSTAMP_FILTER_PTP_V2_EVENT;
> -		cfg.rx_filter =3D HWTSTAMP_FILTER_PTP_V2_EVENT;
> +		cfg->rx_filter =3D HWTSTAMP_FILTER_PTP_V2_EVENT;
>  		break;
>  	default:
>  		return -ERANGE;
> @@ -2688,7 +2698,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_in=
tf,
> struct ifreq *ifr)=20
>  	gbe_hwtstamp(gbe_intf);
> =20
> -	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
> +	return 0;
>  }
> =20
>  static void gbe_register_cpts(struct gbe_priv *gbe_dev)
> @@ -2745,12 +2755,15 @@ static inline void gbe_unregister_cpts(struct
> gbe_priv *gbe_dev) {
>  }
> =20
> -static inline int gbe_hwtstamp_get(struct gbe_intf *gbe_intf, struct ifr=
eq
> *req) +static inline int gbe_hwtstamp_get(struct gbe_intf *gbe_intf,
> +				   struct kernel_hwtstamp_config *cfg)
>  {
>  	return -EOPNOTSUPP;
>  }
> =20
> -static inline int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifr=
eq
> *req) +static inline int gbe_hwtstamp_set(struct gbe_intf *gbe_intf,
> +				   struct kernel_hwtstamp_config *cfg,
> +				   struct netlink_ext_ack *extack)
>  {
>  	return -EOPNOTSUPP;
>  }
> @@ -2816,15 +2829,6 @@ static int gbe_ioctl(void *intf_priv, struct ifreq
> *req, int cmd) struct gbe_intf *gbe_intf =3D intf_priv;
>  	struct phy_device *phy =3D gbe_intf->slave->phy;
> =20
> -	if (!phy_has_hwtstamp(phy)) {
> -		switch (cmd) {
> -		case SIOCGHWTSTAMP:
> -			return gbe_hwtstamp_get(gbe_intf, req);
> -		case SIOCSHWTSTAMP:
> -			return gbe_hwtstamp_set(gbe_intf, req);
> -		}
> -	}
> -
>  	if (phy)
>  		return phy_mii_ioctl(phy, req, cmd);
> =20
> @@ -3824,6 +3828,8 @@ static struct netcp_module gbe_module =3D {
>  	.add_vid	=3D gbe_add_vid,
>  	.del_vid	=3D gbe_del_vid,
>  	.ioctl		=3D gbe_ioctl,
> +	.hwtstamp_get	=3D gbe_hwtstamp_get,
> +	.hwtstamp_set	=3D gbe_hwtstamp_set,
>  };
> =20
>  static struct netcp_module xgbe_module =3D {
> @@ -3841,6 +3847,8 @@ static struct netcp_module xgbe_module =3D {
>  	.add_vid	=3D gbe_add_vid,
>  	.del_vid	=3D gbe_del_vid,
>  	.ioctl		=3D gbe_ioctl,
> +	.hwtstamp_get	=3D gbe_hwtstamp_get,
> +	.hwtstamp_set	=3D gbe_hwtstamp_set,
>  };
> =20
>  static int __init keystone_gbe_init(void)



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

