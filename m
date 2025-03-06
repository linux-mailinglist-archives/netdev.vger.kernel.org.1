Return-Path: <netdev+bounces-172621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF50A558D6
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBC01896910
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88152151990;
	Thu,  6 Mar 2025 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Es9lFAUD"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5791F63F0;
	Thu,  6 Mar 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296807; cv=none; b=prK32vUWzFJqvZl7+k3jnjngpCiH/oJzFAAHVfKtwM9F5vdme2PcRsSdhM/vc+OUzbZLQe9JuAe1jNfGuNrJIs+EzIpBA2l6AUBdipxpVKz7hzGwZ0l7eCjv6N5CHUWJvymPfYqnyie55CvgANfSPgM3e0q/heaIao8MUwnd0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296807; c=relaxed/simple;
	bh=3ycLhxnAWExrf5K7nxzsus1V/stGOlgWmH8ennaTIeY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PaaTIEZTnKC7Tpn3Okx9u4+JLCZn7tIgTZJ1jSK7uXIRvp0uaO3O4LRxu6//xP2zm0d2WjCWIpWZpornr5ZuQG8curfjWDerIWhV3P3G+Vfbea6dbQz4QxtWiY6pL4wWcUn2Ayw/443HPJ4lMRTOBGw7IvCmLeXqNlg4hIKZe7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Es9lFAUD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741296803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHwsh6TluptXdzXqvVPP4F+V7q9r/42AAgM1LmiztSc=;
	b=Es9lFAUDceJGTlL8uwJGkGhN6jng+5C9geSl/63qijoK8req07NEpWF2sjyhqA+CSA4yYb
	tKRSDYSkeqhLLNo89bQsXKhsbFuglD25mfvkKZREmCvLYhnSqnGQ7c7oSxdSlYvR+3CVn7
	vVbZxiegGV6EwG4RmqlNfixKp8yxuzMDb4J15DbwE0DI0v36iL57M3Deh8PSa74vmSD2m8
	8zpaRnjvCSZaMn6A6BjmJxi5v3p7f5v38VZd9KSbvAaP7sHjxcaav5LWMZ+Vug5alcjt5n
	XBZwvOj2sE5+SPtzfwD6BLRslXVIfKeicrSnPhP/ny2lVUQBpRxo+lAwemcGog==
Date: Thu, 06 Mar 2025 22:33:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, David Wu <david.wu@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for
 RK3588
In-Reply-To: <20250306203858.1677595-4-jonas@kwiboo.se>
References: <20250306203858.1677595-1-jonas@kwiboo.se>
 <20250306203858.1677595-4-jonas@kwiboo.se>
Message-ID: <8323ba9aba1155004bcd201b4fd7b2fa@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jonas,

On 2025-03-06 21:38, Jonas Karlman wrote:
> Support for Rockchip RK3588 GMAC was added without use of the
> DELAY_ENABLE macro to assist with enable/disable use of MAC rx/tx 
> delay.
> 
> Change to use a variant of the DELAY_ENABLE macro to help disable MAC
> delay when RGMII_ID/RXID/TXID is used.
> 
> Fixes: 2f2b60a0ec28 ("net: ethernet: stmmac: dwmac-rk: Add gmac
> support for rk3588")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 37eb86e4e325..79db81d68afd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -91,6 +91,10 @@ struct rk_priv_data {
>  	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) 
> | \
>  	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
> 
> +#define DELAY_ENABLE_BY_ID(soc, tx, rx, id) \
> +	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE(id) : 
> soc##_GMAC_TXCLK_DLY_DISABLE(id)) | \
> +	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE(id) : 
> soc##_GMAC_RXCLK_DLY_DISABLE(id)))
> +
>  #define PX30_GRF_GMAC_CON1		0x0904
> 
>  /* PX30_GRF_GMAC_CON1 */
> @@ -1322,8 +1326,7 @@ static void rk3588_set_to_rgmii(struct
> rk_priv_data *bsp_priv,
>  		     RK3588_GMAC_CLK_RGMII_MODE(id));
> 
>  	regmap_write(bsp_priv->grf, RK3588_GRF_GMAC_CON7,
> -		     RK3588_GMAC_RXCLK_DLY_ENABLE(id) |
> -		     RK3588_GMAC_TXCLK_DLY_ENABLE(id));
> +		     DELAY_ENABLE_BY_ID(RK3588, tx_delay, rx_delay, id));
> 
>  	regmap_write(bsp_priv->grf, offset_con,
>  		     RK3588_GMAC_CLK_RX_DL_CFG(rx_delay) |

Thanks for this patch...  It's looking good to me, and good job
spotting this issue!  Please, free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

