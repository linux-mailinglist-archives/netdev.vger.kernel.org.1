Return-Path: <netdev+bounces-230908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F20BF184C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E1514E51F7
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B1031197C;
	Mon, 20 Oct 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kURPZHQ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9962FB0BC;
	Mon, 20 Oct 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966577; cv=none; b=rxjmpN5Etxcnmd77JGE72tQ28pUlX815hxs1ZER8i8Qas24W8M3d/gaIqLpt9KFtzOQhzH6JL9RJDgJiNUhgVom5XH10eyk4h2qy6zGw9jwncbZXOWhF7o8jHT5BcTRHznXoR5oTjvLdSKANFXcGi9naKX0jo+u0xGCj+z5+eaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966577; c=relaxed/simple;
	bh=hsbZxcmTLXeWrt9EPqmD1Z/I9dp/kZGkQetNJtWhlkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orS1uooKywSgrIpITnKNvh3YIURYzABwdCiE6kKMXwL9f2hPi1dZ9esUDi3gajqfTe4sKKpEdEBWy3Vi4lfLYK8erJhmL+bD+qmo0Oe+wMExz+ILzmJsAw9fouHdnQcNk9HaFqM1NMdvfb7pB+KE8cVk+z+vCmp/i+ukfud3Nss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kURPZHQ9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 992691A153D;
	Mon, 20 Oct 2025 13:22:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 62087606D5;
	Mon, 20 Oct 2025 13:22:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17888102F23BB;
	Mon, 20 Oct 2025 15:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760966570; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=53IQCYEkOjawI/9aykHKl8NHjR5KhUhTNObqoTGWdjo=;
	b=kURPZHQ9zxexdRP+2N9x/eSHNw+NN5SDieVFQwq4KnkdAFxOUhLPmzspnz3NJvGyExFzdX
	nsyX7Pl/5gaujrUfcVnp7B99XWKmASJviWIhd8oA0v0BSu567Qokhci8O4Wgm0fA0q46AV
	Q2+3v3LH/A+cQzyc2uxddSN2nJaV08eu5QFZJkNjrDJnsDAWm1qC5boOCQa4FI6jladO2h
	z/iJ3rUesgPj/5gG/wIun1VXGZiM7a0ocSJ4cGpJy3/7guOtYQczzQPI1FbLUlMvFq6dLo
	tAryIl+JFxy4AB4tfjP9lWr8D+YZrZX82yZt4dYqhKxqN072Yx9bsY4f7Mqarw==
Message-ID: <38335d21-ca2e-407a-818e-75ef5d200a2a@bootlin.com>
Date: Mon, 20 Oct 2025 15:22:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/7] net: dsa: lantiq_gswip: convert accessors
 to use regmap
To: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Peter Christen <peter.christen@siemens.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu
 <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
 Juraj Povazanec <jpovazanec@maxlinear.com>,
 "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1760964550.git.daniel@makrotopia.org>
 <90ec656a06156ebb8f7ec96dcf12274552d49ba9.1760964550.git.daniel@makrotopia.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <90ec656a06156ebb8f7ec96dcf12274552d49ba9.1760964550.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Daniel,

On 20/10/2025 14:57, Daniel Golle wrote:
> Use regmap for register access in preparation for supporting the MaxLinear
> GSW1xx family of switches connected via MDIO or SPI.
> Rewrite the existing accessor read-poll-timeout functions to use calls to
> the regmap API for now.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: drop error handling, it wasn't there before and it would anyway be
>     removed again by a follow-up change
> 
>  drivers/net/dsa/lantiq/Kconfig        |   1 +
>  drivers/net/dsa/lantiq/lantiq_gswip.c | 107 +++++++++++++++-----------
>  drivers/net/dsa/lantiq/lantiq_gswip.h |   6 +-
>  3 files changed, 67 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/net/dsa/lantiq/Kconfig b/drivers/net/dsa/lantiq/Kconfig
> index 1cb053c823f7..3cfa16840cf5 100644
> --- a/drivers/net/dsa/lantiq/Kconfig
> +++ b/drivers/net/dsa/lantiq/Kconfig
> @@ -2,6 +2,7 @@ config NET_DSA_LANTIQ_GSWIP
>  	tristate "Lantiq / Intel GSWIP"
>  	depends on HAS_IOMEM
>  	select NET_DSA_TAG_GSWIP
> +	select REGMAP
>  	help
>  	  This enables support for the Lantiq / Intel GSWIP 2.1 found in
>  	  the xrx200 / VR9 SoC.
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
> index 86b410a40d32..046feba16a2f 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
> @@ -113,22 +113,22 @@ static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
>  
>  static u32 gswip_switch_r(struct gswip_priv *priv, u32 offset)
>  {
> -	return __raw_readl(priv->gswip + (offset * 4));
> +	u32 val;
> +
> +	regmap_read(priv->gswip, offset, &val);
> +
> +	return val;
>  }
>  
>  static void gswip_switch_w(struct gswip_priv *priv, u32 val, u32 offset)
>  {
> -	__raw_writel(val, priv->gswip + (offset * 4));
> +	regmap_write(priv->gswip, offset, val);
>  }
>  
>  static void gswip_switch_mask(struct gswip_priv *priv, u32 clear, u32 set,
>  			      u32 offset)
>  {
> -	u32 val = gswip_switch_r(priv, offset);
> -
> -	val &= ~(clear);
> -	val |= set;
> -	gswip_switch_w(priv, val, offset);
> +	regmap_write_bits(priv->gswip, offset, clear | set, set);
>  }
>  
>  static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
> @@ -136,48 +136,34 @@ static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
>  {
>  	u32 val;
>  
> -	return readx_poll_timeout(__raw_readl, priv->gswip + (offset * 4), val,
> -				  (val & cleared) == 0, 20, 50000);
> +	return regmap_read_poll_timeout(priv->gswip, offset, val,
> +					!(val & cleared), 20, 50000);
>  }
>  
>  static u32 gswip_mdio_r(struct gswip_priv *priv, u32 offset)
>  {
> -	return __raw_readl(priv->mdio + (offset * 4));
> +	u32 val;
> +
> +	regmap_read(priv->mdio, offset, &val);
> +
> +	return val;
>  }
>  
>  static void gswip_mdio_w(struct gswip_priv *priv, u32 val, u32 offset)
>  {
> -	__raw_writel(val, priv->mdio + (offset * 4));
> +	regmap_write(priv->mdio, offset, val);
>  }
>  
>  static void gswip_mdio_mask(struct gswip_priv *priv, u32 clear, u32 set,
>  			    u32 offset)
>  {
> -	u32 val = gswip_mdio_r(priv, offset);
> -
> -	val &= ~(clear);
> -	val |= set;
> -	gswip_mdio_w(priv, val, offset);
> -}
> -
> -static u32 gswip_mii_r(struct gswip_priv *priv, u32 offset)
> -{
> -	return __raw_readl(priv->mii + (offset * 4));
> -}
> -
> -static void gswip_mii_w(struct gswip_priv *priv, u32 val, u32 offset)
> -{
> -	__raw_writel(val, priv->mii + (offset * 4));
> +	regmap_write_bits(priv->mdio, offset, clear | set, set);
>  }
>  
>  static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
>  			   u32 offset)
>  {
> -	u32 val = gswip_mii_r(priv, offset);
> -
> -	val &= ~(clear);
> -	val |= set;
> -	gswip_mii_w(priv, val, offset);
> +	regmap_write_bits(priv->mii, offset, clear | set, set);
>  }
>  
>  static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
> @@ -220,17 +206,10 @@ static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
>  
>  static int gswip_mdio_poll(struct gswip_priv *priv)
>  {
> -	int cnt = 100;
> -
> -	while (likely(cnt--)) {
> -		u32 ctrl = gswip_mdio_r(priv, GSWIP_MDIO_CTRL);
> -
> -		if ((ctrl & GSWIP_MDIO_CTRL_BUSY) == 0)
> -			return 0;
> -		usleep_range(20, 40);
> -	}
> +	u32 ctrl;
>  
> -	return -ETIMEDOUT;
> +	return regmap_read_poll_timeout(priv->mdio, GSWIP_MDIO_CTRL, ctrl,
> +					!(ctrl & GSWIP_MDIO_CTRL_BUSY), 40, 4000);
>  }
>  
>  static int gswip_mdio_wr(struct mii_bus *bus, int addr, int reg, u16 val)
> @@ -1893,9 +1872,37 @@ static int gswip_validate_cpu_port(struct dsa_switch *ds)
>  	return 0;
>  }
>  
> +static const struct regmap_config sw_regmap_config = {
> +	.name = "switch",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_shift = -2,

I already commented that on V2, but looking back at my review I for some
reason signed my reply too early and made it unclear there were further
review items, I apologize for that.

To re-iterate, it would be better for clarity to use the dedicated macro
here :

  .reg_shift = REGMAP_UPSHIFT(2),

> +	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> +	.max_register = GSWIP_SDMA_PCTRLp(6),
> +};
> +
> +static const struct regmap_config mdio_regmap_config = {
> +	.name = "mdio",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_shift = -2,

here

> +	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> +	.max_register = GSWIP_MDIO_PHYp(0),
> +};
> +
> +static const struct regmap_config mii_regmap_config = {
> +	.name = "mii",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_shift = -2,

and here.

Maxime

