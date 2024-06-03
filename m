Return-Path: <netdev+bounces-100247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3448D850D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597A6B22702
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43FB136643;
	Mon,  3 Jun 2024 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="U5JsTJpK"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A9134406;
	Mon,  3 Jun 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425018; cv=none; b=IjQuYv9L9JPWHYQWATivkT6bDwE/s28rYiTOGUvLcx0thXLqmvt9Sc8p2keWCjEjhuilhrkAbarkb0HoVp0smMhDSokw+g+L9Jf/FE6/erqNdVrw4erWbjC0BUtTbymjjX3iv9Lqx8uu7hsE6kogw+DRgQlSMf0+C4TLHmLk5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425018; c=relaxed/simple;
	bh=ca3PFMqvf2PEgoAA0VG4VlDQamgfG44SJn7TGmIqUT8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qg96lQVlrSesoc1C4NHmM2wjeSJTPJ6no4ynXaHygDMwJ9EPTtAW/j3X0bxxlgb6zYnO5ZzAKx6aWFI7k7i3EKYquF6EQVirgzK0QIz89nS/rvbop4KFelVR5vXMFaH4i1XXu6IJg6Mlv2ov9j/PjDKzYpXDFpSZqD+9ndogOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=U5JsTJpK; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E7E2D88308;
	Mon,  3 Jun 2024 16:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717425015;
	bh=D1FOb8+LRm3aTJoqLkva7vJcqtsDNNOiof4KFRfCgww=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=U5JsTJpKB9XrS+tOJLOdQnsrjPnXzbEKxTliEtCsqgl9KiPEoZiH/ruyYK8A4xR6w
	 6BTejiu4wQw10P32WDrayv4apql6SINcNU1zBEL1UleFpWvNjsXYUWPagQhgFk1d7C
	 AOnA5FvELgXNYWpNKVmVbPMvFUvBhKE3FNFkFO46G1s3+Keqj69pNyCis9vnebE+Po
	 QgJ8ePGlpDpOea5a0C3f+LEQF70txG3PZy1lQ4PqAlIjg1X4ztyN/N1vGSXaUIVHNp
	 o1J7lMtU3Se4D24YoY8YTLAaEg06HeQdXRgkQrCEMt6L1j1I9L/B6n/KE25YxFMyM0
	 t+0qPGhF12zDQ==
Message-ID: <f1c30ac7-cec1-422f-9114-7b30321d3563@denx.de>
Date: Mon, 3 Jun 2024 16:27:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 02/11] net: stmmac: dwmac-stm32: Separate out external
 clock rate validation
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-3-christophe.roullier@foss.st.com>
Content-Language: en-US
In-Reply-To: <20240603092757.71902-3-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/3/24 11:27 AM, Christophe Roullier wrote:
> From: Marek Vasut <marex@denx.de>
> 
> Pull the external clock frequency validation into a separate function,
> to avoid conflating it with external clock DT property decoding and
> clock mux register configuration. This should make the code easier to
> read and understand.
> 
> This does change the code behavior slightly. The clock mux PMCR register
> setting now depends solely on the DT properties which configure the clock
> mux between external clock and internal RCC generated clock. The mux PMCR
> register settings no longer depend on the supplied clock frequency, that
> supplied clock frequency is now only validated, and if the clock frequency
> is invalid for a mode, it is rejected.
> 
> Previously, the code would switch the PMCR register clock mux to internal
> RCC generated clock if external clock couldn't provide suitable frequency,
> without checking whether the RCC generated clock frequency is correct. Such
> behavior is risky at best, user should have configured their clock correctly
> in the first place, so this behavior is removed here.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 54 +++++++++++++++----
>   1 file changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index c92dfc4ecf570..43340a5573c64 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -157,25 +157,57 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat, bool resume)
>   	return stm32_dwmac_clk_enable(dwmac, resume);
>   }
>   
> +static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
> +{
> +	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
> +	const u32 clk_rate = clk_get_rate(dwmac->clk_eth_ck);

 From Sai in
Re: [net-next,RFC,PATCH 1/5] net: stmmac: dwmac-stm32: Separate out 
external clock rate validation

Please check reverse x-mass tree is followed for these variables, if 
possible.

> +	switch (plat_dat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		if (clk_rate == ETH_CK_F_25M)
> +			return 0;
> +		break;
> +	case PHY_INTERFACE_MODE_GMII:
> +		if (clk_rate == ETH_CK_F_25M)
> +			return 0;
> +		break;

 From Sai in
Re: [net-next,RFC,PATCH 1/5] net: stmmac: dwmac-stm32: Separate out 
external clock rate validation

Please check, whether we can combine the two cases..

> +	case PHY_INTERFACE_MODE_RMII:
> +		if (clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M)
> +			return 0;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		if (clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M)
> +			return 0;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	dev_err(dwmac->dev, "Mode %s does not match eth-ck frequency %d Hz",
> +		phy_modes(plat_dat->mac_interface), clk_rate);
> +	return -EINVAL;
> +}

[...]

