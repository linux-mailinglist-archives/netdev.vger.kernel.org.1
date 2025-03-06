Return-Path: <netdev+bounces-172614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B1AA55887
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AA51722F8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32E5272923;
	Thu,  6 Mar 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WiSqWs27"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D820E315;
	Thu,  6 Mar 2025 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295729; cv=none; b=iK1KBUvw9w1kC8pbZUq2aH/Y+fke8kUVW1oYrb95DVAFGRX1V/5LltUjbhIYU5wDaXnwMDa/SKzlwy+HVymBlT0gwmyFzyYIBDAtI0ddDzhwPfl6N0rhd7jQRGdMQRG3IU430MhzfrNZ2riiNIKcFaEFAvLFvqyYgUogLY1Dkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295729; c=relaxed/simple;
	bh=uZeojrfvjOuNPdEaD2fjxFVsMYcR4nZzJgFj6J0yLmM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UMQkTMBl6zbXiKMpKa8RcaK13vLDVLKdz3wB4kNvpZIuIHTh+Ii98LH76M8E2CVwmz5fExx4JkdYy+AOsi8wJPEm5EMyCadvCYlmRvbboBELy4PoljAg68n+g8dirWFaLY91X03UCPJ8rGX9OWZ1fR17A7LNreWVleumKH+py/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WiSqWs27; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741295347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2c81lklMsWoewbTrDLPjzFIwtetRMhEGhB4+GnHcqo=;
	b=WiSqWs276XwmL6ya8O18OlaDotyFuFbRKOpfqddTDFGjegQF7yrFJ/fjZqymvfCuHegLIW
	HidnrhNz9DXyySlOqdgziypXpdovMd53ofUUCHADRAqZkUQUPdGWCoT5QwgqyhForVQcaS
	SLy+g0SDLLq6eKdiqA6beA27hQuYi3YHLH8XpvNpLeVyKuDz15NKBPDyQJ8NRaObqvesP5
	H9nB8siyzS1lzqkqpfAsqgBKH871WqOw+loSNYZ1Nd6isC6x9WdSxTufdr7kj4JfcLX5Sy
	0zdnbY4+vqADaC/N/SxFzkqHCoQHzOeX6cJc7+IpxSPj0pC/0zQrSGWPz25dUg==
Date: Thu, 06 Mar 2025 22:09:06 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Wadim Egorov <w.egorov@phytec.de>,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for
 RK3328
In-Reply-To: <20250306203858.1677595-2-jonas@kwiboo.se>
References: <20250306203858.1677595-1-jonas@kwiboo.se>
 <20250306203858.1677595-2-jonas@kwiboo.se>
Message-ID: <427cbfc8c6b71bf70804a0d535ff9d18@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jonas,

On 2025-03-06 21:38, Jonas Karlman wrote:
> Support for Rockchip RK3328 GMAC and addition of the DELAY_ENABLE macro
> was merged in the same merge window. This resulted in RK3328 not being
> converted to use the new DELAY_ENABLE macro.
> 
> Change to use the DELAY_ENABLE macro to help disable MAC delay when
> RGMII_ID/RXID/TXID is used.
> 
> Fixes: eaf70ad14cbb ("net: stmmac: dwmac-rk: Add handling for
> RGMII_ID/RXID/TXID")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 003fa5cf42c3..297fa93e4a39 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -593,8 +593,7 @@ static void rk3328_set_to_rgmii(struct
> rk_priv_data *bsp_priv,
>  	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
>  		     RK3328_GMAC_PHY_INTF_SEL_RGMII |
>  		     RK3328_GMAC_RMII_MODE_CLR |
> -		     RK3328_GMAC_RXCLK_DLY_ENABLE |
> -		     RK3328_GMAC_TXCLK_DLY_ENABLE);
> +		     DELAY_ENABLE(RK3328, tx_delay, rx_delay));
> 
>  	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON0,
>  		     RK3328_GMAC_CLK_RX_DL_CFG(rx_delay) |

Thanks for this patch...  It's looking good to me, and good job
spotting this issue!  Please, feel free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

