Return-Path: <netdev+bounces-229892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC8EBE1DD0
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D09D4EF876
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B32F7AAA;
	Thu, 16 Oct 2025 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SnN1ms9Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6A2F5A0F
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598393; cv=none; b=Jwm8BBrs5Wyoq9+nSxFdt/ObOTlyp5e+O7UIKv66BZQudysnbOsQWnKYKPg8IhCMTnw48GBeMKgtF9TZGi4GdDvsB4PHp5M8LZVcddASDyq1WwunA+4IJJczFR1e5O0rkB509tf/pIPyU7sVbQRSe9DVBvsL/OlzRVnxqKEPuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598393; c=relaxed/simple;
	bh=guF/joi80UwvkP8nWPVm/K4T9BS1X9P7hJTAOpIJhsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYqJ4NWqaYNXMHQCzCNr0Gjl8j6YGD9gtqyhzBQB4WJlybqIe+fOvHge6uIv60+dauF0qjcGtakJuGg7b7npm+rX4r9/WupyAWKX4LpaUY+CRdZKwTYMGRlOaQeTZr62myMCuvc5/CmsN/feaE3kfINmAe9AiHz0V8jcuQgWJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SnN1ms9Y; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CD0FBC03B71;
	Thu, 16 Oct 2025 07:06:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 010036062C;
	Thu, 16 Oct 2025 07:06:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3250102F229A;
	Thu, 16 Oct 2025 09:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760598388; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ON2SCtQiP5UISY9OlG9TMamQzrttCF5L3Gqd7rBZXq4=;
	b=SnN1ms9YDbQxlYIHv0+nQCh4k1vRIopL+ldN2EOvNg/qox1nb7+h8HSS1A/qQJGk9/ygQ7
	VIAM1M9BjOm2tYnGe82+HmTAOnsecvqmvkOFC5Fm0VNbUXMiyN4nWH6DDCi2FlqsKZIlIF
	4JCentfpIvDeohQY5cW0gn3jTanCLLpXXCtJfdwiFNecEdnkxv8bxHH86d6NymNsjSuGJN
	hXlrRr9j6NGkSTkJiB0ORYAYGE9jWqEjGbFRHd4WW9OTM45GDe9JdihKqo6GfEIHU4wJPC
	y+gyzNJVoABux5QGy8DNSTHGrJWsVwFact7d9h6WsDkIODhNEErsjM5Oigp+Vg==
Message-ID: <ae07b0b6-f5d2-416d-b861-412888fda229@bootlin.com>
Date: Thu, 16 Oct 2025 09:06:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: stmmac: place .mac_finish() method more
 appropriately
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
 <E1v945O-0000000AmeP-1k0t@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1v945O-0000000AmeP-1k0t@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 15/10/2025 18:10, Russell King (Oracle) wrote:
> Place the .mac_finish() initialiser and implementation after the
> .mac_config() initialiser and method which reflects the order that
> they appear in struct phylink_mac_ops, and the order in which they
> are called. This keeps logically similar code together.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 26 +++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 650d75b73e0b..3728afa701c6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -859,6 +859,18 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
>  	/* Nothing to do, xpcs_config() handles everything */
>  }
>  
> +static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct net_device *ndev = to_net_dev(config->dev);
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +
> +	if (priv->plat->mac_finish)
> +		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode, interface);
> +
> +	return 0;
> +}
> +
>  static void stmmac_mac_link_down(struct phylink_config *config,
>  				 unsigned int mode, phy_interface_t interface)
>  {
> @@ -1053,27 +1065,15 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
>  	return 0;
>  }
>  
> -static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
> -			     phy_interface_t interface)
> -{
> -	struct net_device *ndev = to_net_dev(config->dev);
> -	struct stmmac_priv *priv = netdev_priv(ndev);
> -
> -	if (priv->plat->mac_finish)
> -		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode, interface);
> -
> -	return 0;
> -}
> -
>  static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
>  	.mac_get_caps = stmmac_mac_get_caps,
>  	.mac_select_pcs = stmmac_mac_select_pcs,
>  	.mac_config = stmmac_mac_config,
> +	.mac_finish = stmmac_mac_finish,
>  	.mac_link_down = stmmac_mac_link_down,
>  	.mac_link_up = stmmac_mac_link_up,
>  	.mac_disable_tx_lpi = stmmac_mac_disable_tx_lpi,
>  	.mac_enable_tx_lpi = stmmac_mac_enable_tx_lpi,
> -	.mac_finish = stmmac_mac_finish,
>  };
>  
>  /**


