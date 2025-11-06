Return-Path: <netdev+bounces-236252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B5C3A408
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6E43AF9FA
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF82C159C;
	Thu,  6 Nov 2025 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZQS17aoU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078326B08F
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424578; cv=none; b=UpF96t9odfOy/Vnv53pntJc+GiAX3lk0k+31JNrezXoiGg8Apb/TSY04vdeL2Fb9fwGRx0iYuGKJszGxlh+E7wlBpGRWfQzKepzowgiULyRZKhcX2XwtCsN0hY2xGLTox1RVT2dwOdFuEs9HOZzs2JaKjTGfTrxZA5ZtlsFNrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424578; c=relaxed/simple;
	bh=Mq/f8KUYq/PtXXnC8i8yXVFV382/oiOIyxWYTozAt5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpnKEarXNoLCMsL0p7ox4DyarQCoXzCvC2P7YvIwLF/HJzg5nBAEPiaOAlAfnZrOOK7q9oSfxqe5X3Ft+KmRbk2/VW6DSoLSIgAJJpPsHmWRaEw4XV0OIbzHFXAkt89ZzytU5brym8hbDaDoCo11c2lavNPv8pFJUyJ2FnYW5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZQS17aoU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 18353C0FA88;
	Thu,  6 Nov 2025 10:22:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 254486068C;
	Thu,  6 Nov 2025 10:22:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8707311850A2F;
	Thu,  6 Nov 2025 11:22:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762424574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=t5fJe9feAElneP/yta870eC//hgCpWA6xE5I2Oa5k7I=;
	b=ZQS17aoUlaouBr/Th7AG4xsr2oqMcu/GinPQqFkQmC3wjFGHIPu30a52ty9p2Q4qew1evE
	0uHxqGq5FRHTS2Gp6/WiT2uZXCPao8yiAmCEAFaWwqXbOD+H63m+VHZ9J12guey1poraFU
	W4SGyNZCJZzAmfuLAw4yUJCi3oSF0NcvWuYiBCjddbgoAT7P+ZLTv9ju4/PpqTApV8vppS
	OIspgVcfO0sFkL7CQlJRpohcS5djOzfo1lEhD1G+Y+UeSKJ9tI/V2bHUobpbe4fvTNKtMb
	l4NzZLq1bux1UE+pIbKvBrSpY6Z0aQs93ay8JMeyoX+CiJz5bRyW2JwP1ltIPQ==
Message-ID: <898f6533-2b6a-47d8-8102-1e89e1769c3e@bootlin.com>
Date: Thu, 6 Nov 2025 11:22:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/11] net: stmmac: ingenic: pass ingenic_mac
 struct rather than plat_dat
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
 <E1vGvoj-0000000DWpE-3b5C@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vGvoj-0000000DWpE-3b5C@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 06/11/2025 09:58, Russell King (Oracle) wrote:
> It no longer makes sense to pass a pointer to struct
> plat_stmmacenet_data when calling the set_mode() methods to only use it
> to get a pointer to the ingenic_mac structure that we already had in
> the caller. Simplify this by passing the struct ingenic_mac pointer.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 25 ++++++-------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> index eb5744e0b9ea..41a2071262bc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> @@ -64,15 +64,13 @@ struct ingenic_soc_info {
>  	enum ingenic_mac_version version;
>  	u32 mask;
>  
> -	int (*set_mode)(struct plat_stmmacenet_data *plat_dat, u8 phy_intf_sel);
> +	int (*set_mode)(struct ingenic_mac *mac, u8 phy_intf_sel);
>  
>  	u8 valid_phy_intf_sel;
>  };
>  
> -static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
> -			       u8 phy_intf_sel)
> +static int jz4775_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
>  {
> -	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
>  
>  	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel) |
> @@ -82,19 +80,14 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
>  
> -static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
> -			      u8 phy_intf_sel)
> +static int x1000_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
>  {
> -	struct ingenic_mac *mac = plat_dat->bsp_priv;
> -
>  	/* Update MAC PHY control register */
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, 0);
>  }
>  
> -static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
> -			      u8 phy_intf_sel)
> +static int x1600_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
>  {
> -	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
>  
>  	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
> @@ -103,10 +96,8 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
>  
> -static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
> -			      u8 phy_intf_sel)
> +static int x1830_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
>  {
> -	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
>  
>  	val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII) |
> @@ -116,10 +107,8 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
>  
> -static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
> -			      u8 phy_intf_sel)
> +static int x2000_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
>  {
> -	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
>  
>  	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
> @@ -165,7 +154,7 @@ static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
>  		dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
>  			phy_modes(interface));
>  
> -		ret = mac->soc_info->set_mode(mac->plat_dat, phy_intf_sel);
> +		ret = mac->soc_info->set_mode(mac, phy_intf_sel);
>  		if (ret)
>  			return ret;
>  	}


