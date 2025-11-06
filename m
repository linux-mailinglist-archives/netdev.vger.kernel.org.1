Return-Path: <netdev+bounces-236254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A26CC3A4A4
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A4C6501EE5
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274B2D0602;
	Thu,  6 Nov 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uWWq+fR0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B12D5C8E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425017; cv=none; b=pd5PzLBLRdEkkbOR3nNLxsPxuNGq0xr1jj0HY+bOn8go8KvyKxckXT+GCbt5gfpR77+WzoYsNl8yxpK6dffhjyEGJrJZ66emRRjibVGLuYpdRlDsRiryVKsZcC0sP4wOPhzhjohtuR386guQY6CZj5tuvboCzDlrlyo6kjo/c/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425017; c=relaxed/simple;
	bh=2E42p1vJTIXXDQfjuVgCx4PLTkUYmNH+9/s61XiW29Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=futS7Qg8ux98/4roo3lgQK6ZoPi8Oa1oXxfCbkTNp5zOFR90A9xRU0tw4Yx8tJL6M21j5iOKjVmihzfLyhEe6V5hYzV9nluqaopV5HzGFZd4+vFNigQGMNlmSmEWFo2ABvUmhZme52D+foryA1XaOTm4cIbVNvAeRljgEUg6ujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uWWq+fR0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ADBDC4E41565;
	Thu,  6 Nov 2025 10:30:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 817516068C;
	Thu,  6 Nov 2025 10:30:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A36211850AFC;
	Thu,  6 Nov 2025 11:30:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762425011; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cHz0SE5KeAh/7vSWzG3tdPmFQ5OyevIIxyddxPOiKM4=;
	b=uWWq+fR0MPstUGwl/3vUxQTeBDXfOAak+9qHp87IXELB51kYoRhynbUS41wCrv6hmuSy4z
	t9yGxNdi9fTO8lzvJUn58Cu7EIIac7sgwVVHYGZN2++1xzmipHAbfiXXdz4gZrCEd1OKiI
	ROGNw6tA0C/BZw3Jdgd06ekD6s7toYBnFbRfsyRT4ZKVjpcAzbOhIaQ04KHdAH3IRHo5RW
	J7f6gg//hkrwq5jS8+ByYniXpD7xxSfu72BVBybHojL8V2z3OsvpO4HDBTYda/0gzix5g4
	KqNgLE7l17RRtkmi3JTWJFachP4Ii0H3TTrvpr7igeBj2oGswV8TDuKQQBdOOw==
Message-ID: <59a6705f-8e26-493b-84d5-424d373b68cf@bootlin.com>
Date: Thu, 6 Nov 2025 11:30:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 11/11] net: stmmac: ingenic: use
 ->set_phy_intf_sel()
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
 <E1vGvoo-0000000DWpK-47nP@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vGvoo-0000000DWpK-47nP@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 06/11/2025 09:58, Russell King (Oracle) wrote:
> Rather than placing the phy_intf_sel() setup in the ->init() method,
> move it to the new ->set_phy_intf_sel() method.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

This looks good to me, but I can't test however :(

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

BTW this series was very nice to review with all the incremental
changes, thanks !

Maxime


> ---
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 33 +++++++------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> index 41a2071262bc..957bc78d5a1e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> @@ -134,32 +134,21 @@ static int x2000_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
>  
> -static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
> +static int ingenic_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
>  {
>  	struct ingenic_mac *mac = bsp_priv;
> -	phy_interface_t interface;
> -	int phy_intf_sel, ret;
> -
> -	if (mac->soc_info->set_mode) {
> -		interface = mac->plat_dat->phy_interface;
> -
> -		phy_intf_sel = stmmac_get_phy_intf_sel(interface);
> -		if (phy_intf_sel < 0 || phy_intf_sel >= BITS_PER_BYTE ||
> -		    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel)) {
> -			dev_err(mac->dev, "unsupported interface %s\n",
> -				phy_modes(interface));
> -			return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
> -		}
>  
> -		dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
> -			phy_modes(interface));
> +	if (!mac->soc_info->set_mode)
> +		return 0;
>  
> -		ret = mac->soc_info->set_mode(mac, phy_intf_sel);
> -		if (ret)
> -			return ret;
> -	}
> +	if (phy_intf_sel >= BITS_PER_BYTE ||
> +	    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel))
> +		return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
> +
> +	dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
> +		phy_modes(mac->plat_dat->phy_interface));
>  
> -	return 0;
> +	return mac->soc_info->set_mode(mac, phy_intf_sel);
>  }
>  
>  static int ingenic_mac_probe(struct platform_device *pdev)
> @@ -221,7 +210,7 @@ static int ingenic_mac_probe(struct platform_device *pdev)
>  	mac->plat_dat = plat_dat;
>  
>  	plat_dat->bsp_priv = mac;
> -	plat_dat->init = ingenic_mac_init;
> +	plat_dat->set_phy_intf_sel = ingenic_set_phy_intf_sel;
>  
>  	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
>  }


