Return-Path: <netdev+bounces-229894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C9BE1E5F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBED483657
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACA3216E24;
	Thu, 16 Oct 2025 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vpGWNdRO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629D42E36FB
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599380; cv=none; b=kCBnbAkIR/BBjlhrkQy31DTTlm5dCMxBHshTHdnQ1xPKH381yI2xjtGqk8YvcKmXvcY8YkmTq946y+i9cwADzQPm5+l8tfII/GikZ8/tN60lPFROxME2niRUFMGWHfnXusaA+9LMTtJaQhD/lLbkD8GNujMVsEhtEl0woej1t6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599380; c=relaxed/simple;
	bh=s2bt3R2WATElEQ8XO27KLN9GMH7psIC8qm9QHtFPgcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4/8niOKeputzZJgkx17fbLfgZGRUJd/p9PlL0lDtY6NXh6NV8s8cef0cmklwZFexn7qSKHaguAf9io6zdaq/U58Izoz83Pw/plnWM61P+FHltepGv7XBM9zShdW0Xj1GiMrDz1DItIdtLOFs16qrsng5qonirq4fB/59+uSFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vpGWNdRO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 740D11A1410;
	Thu, 16 Oct 2025 07:22:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F1A56062C;
	Thu, 16 Oct 2025 07:22:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90A44102F22EB;
	Thu, 16 Oct 2025 09:22:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760599373; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7zOUzik5MyvROjRAqeUBJc8fQpkR6r5Z9zOCmYjzSrI=;
	b=vpGWNdROx4mJa+kYUKCWf/ZKPABe5NrTWaC34G6w96sxkDyFCDXq6sg5uKoVPB7Djx8+Bv
	eZgWrS6i7SEr26izkqJKdZEgm6kJ7yeGzl07WTlAlhYdB/GpuvNWdURxhefN2t2s8pEG/U
	vhSdK+mePRkg12GEg3pgX/Iywy1BQhOW1wF3atE8/Lr51xWIRTsnyWksUrRaUbNJufoP1x
	9ixcsKgT/u6qgRmcmAHAxNIrdDTdsWkW1usH+Od3ORZMb2lvl7nh68Jy3F1s/SAcjW999C
	bTO3HzVg9oK0na+KnHrtjsH9Zk4UOzRnGYAimcwJ+mR2esioHsRLRKgq5YAY+Q==
Message-ID: <c1b019e6-1463-400f-b421-91ae8fa63c3b@bootlin.com>
Date: Thu, 16 Oct 2025 09:22:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] net: stmmac: avoid PHY speed change when
 configuring MTU
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
 <E1v945T-0000000AmeV-2BvU@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1v945T-0000000AmeV-2BvU@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 15/10/2025 18:10, Russell King (Oracle) wrote:
> There is no need to do the speed-down, speed-up dance when changing
> the MTU as there is little power saving that can be gained from such
> a brief interval between these, and the autonegotiation they cause
> takes much longer.
> 
> Move the calls to phylink_speed_up() and phylink_speed_down() into
> stmmac_open() and stmmac_release() respectively, reducing the work
> done in the __-variants of these functions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3728afa701c6..500cfd19e6b5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3963,8 +3963,6 @@ static int __stmmac_open(struct net_device *dev,
>  	stmmac_init_coalesce(priv);
>  
>  	phylink_start(priv->phylink);
> -	/* We may have called phylink_speed_down before */
> -	phylink_speed_up(priv->phylink);
>  
>  	ret = stmmac_request_irq(dev);
>  	if (ret)
> @@ -4015,6 +4013,9 @@ static int stmmac_open(struct net_device *dev)
>  
>  	kfree(dma_conf);
>  
> +	/* We may have called phylink_speed_down before */
> +	phylink_speed_up(priv->phylink);
> +
>  	return ret;
>  
>  err_disconnect_phy:
> @@ -4032,13 +4033,6 @@ static void __stmmac_release(struct net_device *dev)
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	u32 chan;
>  
> -	/* If the PHY or MAC has WoL enabled, then the PHY will not be
> -	 * suspended when phylink_stop() is called below. Set the PHY
> -	 * to its slowest speed to save power.
> -	 */
> -	if (device_may_wakeup(priv->device))
> -		phylink_speed_down(priv->phylink, false);
> -
>  	/* Stop and disconnect the PHY */
>  	phylink_stop(priv->phylink);
>  
> @@ -4078,6 +4072,13 @@ static int stmmac_release(struct net_device *dev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> +	/* If the PHY or MAC has WoL enabled, then the PHY will not be
> +	 * suspended when phylink_stop() is called below. Set the PHY
> +	 * to its slowest speed to save power.
> +	 */
> +	if (device_may_wakeup(priv->device))
> +		phylink_speed_down(priv->phylink, false);
> +
>  	__stmmac_release(dev);
>  
>  	phylink_disconnect_phy(priv->phylink);


