Return-Path: <netdev+bounces-239556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6808AC69B55
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 79BA62BAA9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE523563DE;
	Tue, 18 Nov 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MiBKtNPN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D129B783
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473745; cv=none; b=AcD0THco7A26VZmuMMowXtHtg4IkRAToowOTj9+oNAq7Gq+Z7MHCv+ysfZpuF38PhuPJkVtlxRyxWkxKmnag9ZGVFfVh7i1NDZ7XZ7G9g9iaMQe36bI93CdnMZiuqowtry8GpT5DFO/0m2GFrRuYepojiKeLQPexjhYurAYG/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473745; c=relaxed/simple;
	bh=FrPOOsZVyi/511d2OKLIe+2mKiI7Kq97FOMzoLiW24M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKw8vWWHEf0gzhdYHjOc+BEyKGAP6Tfsu0v9Kj9fUVPYp5Hr6+uQoSeF/L2vzzqCK0KG91rWOQ4Zx5O3nHT75yPfwL9NzXXstq6v09v+6+tv33Byjls5HIqvFmjJZ+Lq8T7K5cXNCVtW9AFTSGhP2e5j/ojQqcgsewxKGmkrX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MiBKtNPN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 35E871A1B86;
	Tue, 18 Nov 2025 13:48:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EED54606FE;
	Tue, 18 Nov 2025 13:48:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9846810371D09;
	Tue, 18 Nov 2025 14:48:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763473734; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=GlBhdagIv79JVcL9in1O72ju+fMc1vc59Oegn0NObR8=;
	b=MiBKtNPN5r33In7hMNTY3A/YcFYzQQpH/KpcDU5sLR3FBaW4H00KnunhPUHpW4ANBNQfUI
	f3rzckotNXn+7FsPmMGoz+TU7uYakDV5l8MsZMe6yad58UecyXZnsjtCUNNcLUhxesg7P7
	iaYjoTdDlDK8TFLO73hdKhVzpxV0ajGcC57emAvuhZPgFf8yA7NrlthI2hcBeEk3UaMc10
	1j6094cRbYuzUzewCLngiy9EgVPtKXfkgxyZf+4h/pJYXMCXHf7h5AQvl6GUx46J3l/Kbp
	SRo3/bOR3pJH1rI5l0tGlDRhWGpv5MXdkkd+mXod+t1HI0dTUa0YvUkzr0MHEg==
Message-ID: <7f81c9f1-a061-4269-96cd-ecdaa6137c72@bootlin.com>
Date: Tue, 18 Nov 2025 14:48:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos-eth: simplify switch() in
 dwc_eth_dwmac_config_dt()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <E1vLJij-0000000ExKZ-3C9s@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vLJij-0000000ExKZ-3C9s@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 18/11/2025 12:18, Russell King (Oracle) wrote:
> Simplify the the switch() statement in dwc_eth_dwmac_config_dt().
> Although this is not speed-critical, simplifying it can make it more
> readable. This also drastically improves the code emitted by the
> compiler.
> 
> On aarch64, with the original code, the compiler loads registers with
> every possible value, and then has a tree of test-and-branch statements
> to work out which register to store. With the simplified code, the
> compiler can load a register with '4' and shift it appropriately.
> 
> This shrinks the text size on aarch64 from 4289 bytes to 4153 bytes,
> a reduction of 3%.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 26 +++----------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> index c7cd6497d42d..e6d5893c5905 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> @@ -84,29 +84,9 @@ static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
>  	device_property_read_u32(dev, "snps,burst-map", &burst_map);
>  
>  	/* converts burst-map bitmask to burst array */
> -	for (bit_index = 0; bit_index < 7; bit_index++) {
> -		if (burst_map & (1 << bit_index)) {
> -			switch (bit_index) {
> -			case 0:
> -			plat_dat->axi->axi_blen[a_index] = 4; break;
> -			case 1:
> -			plat_dat->axi->axi_blen[a_index] = 8; break;
> -			case 2:
> -			plat_dat->axi->axi_blen[a_index] = 16; break;
> -			case 3:
> -			plat_dat->axi->axi_blen[a_index] = 32; break;
> -			case 4:
> -			plat_dat->axi->axi_blen[a_index] = 64; break;
> -			case 5:
> -			plat_dat->axi->axi_blen[a_index] = 128; break;
> -			case 6:
> -			plat_dat->axi->axi_blen[a_index] = 256; break;
> -			default:
> -			break;
> -			}
> -			a_index++;
> -		}
> -	}
> +	for (bit_index = 0; bit_index < 7; bit_index++)
> +		if (burst_map & (1 << bit_index))
> +			plat_dat->axi->axi_blen[a_index++] = 4 << bit_index;
>  
>  	/* dwc-qos needs GMAC4, AAL, TSO and PMT */
>  	plat_dat->core_type = DWMAC_CORE_GMAC4;


