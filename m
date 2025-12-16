Return-Path: <netdev+bounces-244933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161CCC3783
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 495193005016
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65F333D6C1;
	Tue, 16 Dec 2025 13:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFAF33A710;
	Tue, 16 Dec 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891226; cv=none; b=Fnl0XEyI0f7q++/UkVaceB/74E7A5nppvPbO56Fm6GEY1j71No3W94NCuOnydoduwoC/eGzCxYBn94QyGr4dqarqn+q2F8cCm0riJp8/GG94C48PTiDFTyEq6E5JGQ46DYJimkdVOaBSqW3EXkJ1AT2Tw87sQtbfqCerXsk/bDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891226; c=relaxed/simple;
	bh=tktqJBRtXPuG9WDFkoJtpLnP/Ec+YKFfOlPFd+JgCAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNOu+wa9gzrbAyqQwYhf5xoSlaJp7wBieBeZdoRRRZsW8Y10QGy+xra2GBSzDBZuF5q2ukHBZ3T7nQOhVo9TftZKQfIOLhExPpZvKjK5n1juYF2i67plC9I4P3WOrpUFsIIOmJgq8RIjpNq+SfjmhHMB1D+Or5wuvqccm7/4tOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vVUyQ-0000000033m-1atP;
	Tue, 16 Dec 2025 13:20:18 +0000
Date: Tue, 16 Dec 2025 13:20:13 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII
 slew rate configuration
Message-ID: <aUFcjVzd7GFKkq70@makrotopia.org>
References: <20251216121705.65156-1-alexander.sverdlin@siemens.com>
 <20251216121705.65156-3-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216121705.65156-3-alexander.sverdlin@siemens.com>

On Tue, Dec 16, 2025 at 01:17:01PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Support newly introduced maxlinear,mii-slew-rate-slow device tree property
> to configure R(G)MII interface pins slew rate into "slow" mode. It might be
> used to reduce the radiated emissions.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
> Changelog:
> v2:
> - do not hijack gsw1xx_phylink_mac_select_pcs() for configuring the port,
>   introduce struct gswip_hw_info::port_setup callback
> - actively configure "normal" slew rate (if the new DT property is missing)
> - properly use regmap_set_bits() (v1 had reg and value mixed up)
> 
>  drivers/net/dsa/lantiq/lantiq_gswip.h        |  1 +
>  drivers/net/dsa/lantiq/lantiq_gswip_common.c |  6 +++++
>  drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 26 ++++++++++++++++++++
>  drivers/net/dsa/lantiq/mxl-gsw1xx.h          |  2 ++
>  4 files changed, 35 insertions(+)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
> index 9c38e51a75e80..3dc6c232a2e7b 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
> @@ -263,6 +263,7 @@ struct gswip_hw_info {
>  				 struct phylink_config *config);
>  	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
>  					      phy_interface_t interface);
> +	int (*port_setup)(struct dsa_switch *ds, int port);
>  };
>  
>  struct gswip_gphy_fw {
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> index 9da39edf8f574..efa7526609a41 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> @@ -425,6 +425,12 @@ static int gswip_port_setup(struct dsa_switch *ds, int port)
>  	struct gswip_priv *priv = ds->priv;
>  	int err;
>  
> +	if (priv->hw_info->port_setup) {
> +		err = priv->hw_info->port_setup(ds, port);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (!dsa_is_cpu_port(ds, port)) {
>  		err = gswip_add_single_port_br(priv, port, true);
>  		if (err)
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index 0816c61a47f12..cf35d5a00b7c8 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -531,6 +531,29 @@ static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *
>  	}
>  }
>  
> +static int gsw1xx_port_setup(struct dsa_switch *ds, int port)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct gsw1xx_priv *gsw1xx_priv;
> +	struct gswip_priv *gswip_priv;
> +	int ret;
> +
> +	if (dp->index != GSW1XX_MII_PORT)
> +		return 0;
> +
> +	gswip_priv = ds->priv;
> +	gsw1xx_priv = container_of(gswip_priv, struct gsw1xx_priv, gswip);
> +
> +	if (of_property_read_bool(dp->dn, "maxlinear,mii-slew-rate-slow"))
> +		ret = regmap_set_bits(gsw1xx_priv->shell, GSW1XX_SHELL_RGMII_SLEW_CFG,
> +				      RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC);
> +	else
> +		ret = regmap_clear_bits(gsw1xx_priv->shell, GSW1XX_SHELL_RGMII_SLEW_CFG,
> +					RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC);
> +
> +	return ret;
> +}
> +
>  static struct regmap *gsw1xx_regmap_init(struct gsw1xx_priv *priv,
>  					 const char *name,
>  					 unsigned int reg_base,
> @@ -674,6 +697,7 @@ static const struct gswip_hw_info gsw12x_data = {
>  	.pce_microcode		= &gsw1xx_pce_microcode,
>  	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
>  	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
> +	.port_setup		= gsw1xx_port_setup,

Nit: I'd place this before .pce_microcode, but as neither the
struct definition nor the individual instances follow any sorted
order at this moment (which could clearly be improved, mea culpa)
it's also ok like this and not worth an other round of submitting
the series imho.

>  };
>  
>  static const struct gswip_hw_info gsw140_data = {
> @@ -687,6 +711,7 @@ static const struct gswip_hw_info gsw140_data = {
>  	.pce_microcode		= &gsw1xx_pce_microcode,
>  	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
>  	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
> +	.port_setup		= gsw1xx_port_setup,
>  };
>  
>  static const struct gswip_hw_info gsw141_data = {
> @@ -699,6 +724,7 @@ static const struct gswip_hw_info gsw141_data = {
>  	.pce_microcode		= &gsw1xx_pce_microcode,
>  	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
>  	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
> +	.port_setup		= gsw1xx_port_setup,
>  };
>  
>  /*
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> index 38e03c048a26c..8c0298b2b7663 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> @@ -110,6 +110,8 @@
>  #define   GSW1XX_RST_REQ_SGMII_SHELL		BIT(5)
>  /* RGMII PAD Slew Control Register */
>  #define  GSW1XX_SHELL_RGMII_SLEW_CFG		0x78
> +#define   RGMII_SLEW_CFG_DRV_TXC		BIT(2)
> +#define   RGMII_SLEW_CFG_DRV_TXD		BIT(3)
>  #define   RGMII_SLEW_CFG_RX_2_5_V		BIT(4)
>  #define   RGMII_SLEW_CFG_TX_2_5_V		BIT(5)
>  
> -- 
> 2.52.0
> 

