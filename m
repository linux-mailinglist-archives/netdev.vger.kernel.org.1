Return-Path: <netdev+bounces-117219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDCD94D24B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305A21C21782
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1070C19754A;
	Fri,  9 Aug 2024 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="W1E5OcW3"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1913FFC;
	Fri,  9 Aug 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214269; cv=pass; b=MyOG5a5mANZOGP2jbDM2c+InRlMZawY17ElXRm/UEunKWuL4Vx4vSVZi+6RZ2OFtOmYwja23tW4boE91cxmVLDCZKM73T7nphuJd4mWyev7IlOlNtUzYkj4cCP5BGIEZlQKkqbcFf2a1xZy+MVImsC02JzLUL98y+9maFfpAEdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214269; c=relaxed/simple;
	bh=K1LJiFAisyhDOCRP5TxNAC56apWym8nG4c3U9g0UrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgcNxHv4g2TAH9RdmGraEi7LA2M7OcpGs94MmhzBhDydopPNqrb/Ls2UhY4E5zuVK9Ol93D9REn3hVPlcBWSe72jFNpRx40ALE2pH9+1HCREOnhzVUbMsUPf6+ZYXRbTXRIls6G7tIEUY60PE7NahJUTXBomjtpEGIlfmfCoUe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=W1E5OcW3; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723214225; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NsxGtx2fA0C4A9OVyVNqjCQKGk3HW9p44+uDrI71/cVlCLpdoBfB4DMUWAqwqpZNGhRaxNSp/H5ltNl1z4QzANgEYRmcEQO7hhCWXTfGu1lCiC1if3thrni+z/ttaWPWDbcuSCXmNczhAzH8ybolJdpDwAYbE2PvZ2Ce9JZev7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723214225; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5WYVhNuU88SniE2jCodWNyDFApk5Mbdr54y77hRyghI=; 
	b=oAoHkXeCcX7nviLec5sUp7engJc5J13+w1b5iXuExiv5/VRRS0zhYxyqvsW4+tRnpCFvBedF4jQz6BsqA8tX5jCW9VGUlwHiGybjoLPe3jlTFPA0y/lOD0VDjoVQfsW5PP2gEamq3H3VL9NU0MIoy4F53gK6+UvNvWgL5sW/l1k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723214225;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=5WYVhNuU88SniE2jCodWNyDFApk5Mbdr54y77hRyghI=;
	b=W1E5OcW3K+ddqoH06ti0Zsc5hYb/I4WCMfRRJzAptQzpSWLw1L8YjUczP5juZWnN
	FbaB/Nfg8OZWirTeygvyeEjhK/dVygb/iqyCMc7eK15zjZD/SGyazaxTw+yozETswje
	ycZHcWojplbfXV5BYXOEAihbjxe/7cQtq68nd4fc=
Received: by mx.zohomail.com with SMTPS id 1723214224288259.9191665746731;
	Fri, 9 Aug 2024 07:37:04 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org,
 Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 David Wu <david.wu@rock-chips.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 kernel@collabora.com
Subject:
 Re: [PATCH v2 2/2] ethernet: stmmac: dwmac-rk: Add GMAC support for RK3576
Date: Fri, 09 Aug 2024 10:38:23 -0400
Message-ID: <3304458.aeNJFYEL58@trenzalore>
In-Reply-To: <3724132.9z1YWOviru@diego>
References:
 <20240808170113.82775-1-detlev.casanova@collabora.com>
 <20240808170113.82775-3-detlev.casanova@collabora.com>
 <3724132.9z1YWOviru@diego>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Friday, 9 August 2024 09:16:44 EDT Heiko St=C3=BCbner wrote:
> Hi Detlev,
>=20
> Am Donnerstag, 8. August 2024, 19:00:18 CEST schrieb Detlev Casanova:
> > From: David Wu <david.wu@rock-chips.com>
> >=20
> > Add constants and callback functions for the dwmac on RK3576 soc.
> >=20
> > Signed-off-by: David Wu <david.wu@rock-chips.com>
> > [rebase, extracted bindings]
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> >=20
> >  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 156 ++++++++++++++++++
> >  1 file changed, 156 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c index
> > 7ae04d8d291c8..e1fa8fc9f4012 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > @@ -1116,6 +1116,161 @@ static const struct rk_gmac_ops rk3568_ops =3D {
> >=20
> >  	},
> > =20
> >  };
> >=20

[...]

> > +/* SDGMAC_GRF */
> > +#define RK3576_GRF_GMAC_CON0			0X0020
> > +#define RK3576_GRF_GMAC_CON1			0X0024
> > +
> > +#define RK3576_GMAC_RMII_MODE			GRF_BIT(3)
> > +#define RK3576_GMAC_RGMII_MODE			GRF_CLR_BIT(3)
> > +
> > +#define RK3576_GMAC_CLK_SELET_IO		GRF_BIT(7)
> > +#define RK3576_GMAC_CLK_SELET_CRU		GRF_CLR_BIT(7)
>=20
> nit: typos _CLK_SELECT_ ... missing the C in select

Ack

> > +
> > +#define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
> > +#define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
>=20
> I think those are backwards
> The TRM says bit[5]=3D0: 25MHz (DIV2) and bit[5]=3D1: 2.5MHz (DIV20)
>=20
> I guess nobody also on Rockchip's side tested a RMII phy on those control=
lrs

Can't be sure about that. An error in the TRM is not impossible either, as =
for=20
rk3588, it is also bit[5]=3D0: DIV20 and bit[5]=3D1: DIV2. I can switch the=
m to=20
match the TRM though, we may never now.

> > +
> > +#define RK3576_GMAC_CLK_RGMII_DIV1		\
> > +			(GRF_CLR_BIT(6) | GRF_CLR_BIT(5))
> > +#define RK3576_GMAC_CLK_RGMII_DIV5		\
> > +			(GRF_BIT(6) | GRF_BIT(5))
> > +#define RK3576_GMAC_CLK_RGMII_DIV50		\
> > +			(GRF_BIT(6) | GRF_CLR_BIT(5))
> > +
>=20
> in contrast, these are correct and match the TRM
>=20
> > +#define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
> > +#define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
> > +
> > +static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
> > +				int tx_delay, int rx_delay)
> > +{
> > +	struct device *dev =3D &bsp_priv->pdev->dev;
> > +	unsigned int offset_con;
> > +
> > +	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
> > +		dev_err(dev, "Missing rockchip,grf or rockchip,php_grf=20
property\n");
> > +		return;
> > +	}
> > +
> > +	offset_con =3D bsp_priv->id =3D=3D 1 ? RK3576_GRF_GMAC_CON1 :
> > +					 RK3576_GRF_GMAC_CON0;
> > +
> > +	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RGMII_MODE);
> > +
> > +	offset_con =3D bsp_priv->id =3D=3D 1 ? RK3576_VCCIO0_1_3_IOC_CON4 :
> > +					=20
RK3576_VCCIO0_1_3_IOC_CON2;
> > +
> > +	/* m0 && m1 delay enabled */
> > +	regmap_write(bsp_priv->php_grf, offset_con,
> > +		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
> > +	regmap_write(bsp_priv->php_grf, offset_con + 0x4,
> > +		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
> > +
> > +	/* m0 && m1 delay value */
> > +	regmap_write(bsp_priv->php_grf, offset_con,
> > +		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
> > +		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
> > +	regmap_write(bsp_priv->php_grf, offset_con + 0x4,
> > +		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
> > +		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
> > +}
> > +
> > +static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
> > +{
> > +	struct device *dev =3D &bsp_priv->pdev->dev;
> > +	unsigned int offset_con;
> > +
> > +	if (IS_ERR(bsp_priv->php_grf)) {
> > +		dev_err(dev, "%s: Missing rockchip,php_grf property\n",=20
__func__);
> > +		return;
> > +	}
> > +
> > +	offset_con =3D bsp_priv->id =3D=3D 1 ? RK3576_GRF_GMAC_CON1 :
> > +					 RK3576_GRF_GMAC_CON0;
> > +
> > +	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RMII_MODE);
> > +}
> > +
> > +static void rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv, int
> > speed) +{
> > +	struct device *dev =3D &bsp_priv->pdev->dev;
> > +	unsigned int val =3D 0, offset_con;
> > +
> > +	switch (speed) {
> > +	case 10:
> > +		if (bsp_priv->phy_iface =3D=3D PHY_INTERFACE_MODE_RMII)
> > +			val =3D RK3576_GMAC_CLK_RMII_DIV20;
> > +		else
> > +			val =3D RK3576_GMAC_CLK_RGMII_DIV50;
>=20
> 		val =3D bsp_priv->phy_iface =3D=3D PHY_INTERFACE_MODE_RMII ?
> 				RK3576_GMAC_CLK_RMII_DIV20 :
> 				RK3576_GMAC_CLK_RGMII_DIV50;
> perhaps?

This way matches how it is written in rk3588_set_gmac_speed(). I find that=
=20
having similar code for similar functions helps reading and understanding i=
t=20
better (although I agree that your suggestion looks better).

I'd rather keep it like it is for now if that's ok.

> > +		break;
> > +	case 100:
> > +		if (bsp_priv->phy_iface =3D=3D PHY_INTERFACE_MODE_RMII)
> > +			val =3D RK3576_GMAC_CLK_RMII_DIV2;
> > +		else
> > +			val =3D RK3576_GMAC_CLK_RGMII_DIV5;
>=20
> same as above?
>=20
> > +		break;
> > +	case 1000:
> > +		if (bsp_priv->phy_iface !=3D PHY_INTERFACE_MODE_RMII)
> > +			val =3D RK3576_GMAC_CLK_RGMII_DIV1;
> > +		else
> > +			goto err;
>=20
> 		if (bsp_priv->phy_iface =3D=3D PHY_INTERFACE_MODE_RMII)
> 			goto err;
>=20
> 		val =3D RK3576_GMAC_CLK_RGMII_DIV1;
>=20
> > +		break;
> > +	default:
> > +		goto err;
> > +	}
> > +
> > +	offset_con =3D bsp_priv->id =3D=3D 1 ? RK3576_GRF_GMAC_CON1 :
> > +					 RK3576_GRF_GMAC_CON0;
> > +
> > +	regmap_write(bsp_priv->grf, offset_con, val);
> > +
> > +	return;
> > +err:
> > +	dev_err(dev, "unknown speed value for GMAC speed=3D%d", speed);
> > +}
> > +
> > +static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv,
> > bool input, +				       bool enable)
> > +{
> > +	unsigned int val =3D input ? RK3576_GMAC_CLK_SELET_IO :
> > +				   RK3576_GMAC_CLK_SELET_CRU;
> > +	unsigned int offset_con;
> > +
> > +	val |=3D enable ? RK3576_GMAC_CLK_RMII_NOGATE :
> > +			RK3576_GMAC_CLK_RMII_GATE;
> > +
> > +	offset_con =3D bsp_priv->id =3D=3D 1 ? RK3576_GRF_GMAC_CON1 :
> > +					 RK3576_GRF_GMAC_CON0;
>=20
> nit: alignment of both looks like it could be nicer

That's strange, the alignments looks good in vim and git diff. It also look=
s=20
nice on the archive: https://lore.kernel.org/linux-rockchip/
20240808170113.82775-3-detlev.casanova@collabora.com/
=20

Regards,
Detlev



