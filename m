Return-Path: <netdev+bounces-200109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AE9AE3371
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 03:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3F41891421
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 01:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19A415A858;
	Mon, 23 Jun 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pUsOTE+f"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDFA2AE6A
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750643814; cv=none; b=S6EWE7ln8lZuudd0lbrn7ZxSDk2erRCRbfk010ZNQiIrXaF+utZhjwO05FQzaqN7hUmq9L2icFrUOVNAUW3rhe9F3G/rM6OZPNUSwJs0Esx2z/FVW+J1P+EStrsV2sqZr4Y6BymAfTgUem/iXPjgYrbtGxh2zf82oCLS+eP8wXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750643814; c=relaxed/simple;
	bh=W3V1YyL35JkgMpbpisqK/696C4Nv70IqFd2iOXqHCss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQQEMWHSa1CEqzuF8iezyJEXnzaOiCbPpuYkcMWA4lqCuPBTrzLDdFHixnaVXRSovBIGg/NxnxTpUFdyxsLJP7VlrbF45HQ3UNUiim8RtncAm4KProtwaZQJoiQUWF2/aGYQHsgn21Po9nk6KFoUR4xoBjuaSyQadeIXlUyFPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pUsOTE+f; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5dc786e1-0e2e-468c-b2d5-b8e93e6d8265@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750643809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZeaYSvjn6JUg4GMyZmlR25k/eELyipTcGo/9lSTmGA=;
	b=pUsOTE+fGNzyYUdlj32n3mwL/6desRujdrVDvH0OPo3T5FiBJykop9UNruC7nGCrPCFG0n
	/8DcTeqKO8Pq7OuZXWNQ+qXHMYbOisFRZV1Nlk8JE0qwddwGbndo9PnJ752loZD72P0IRw
	BgdrdXjKSAOxdNM25QDDhwKZPlgzb1I=
Date: Mon, 23 Jun 2025 09:56:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: stmmac: lpc18xx: use
 plat_dat->phy_interface
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Zapolskiy <vz@mleia.com>
References: <E1uSBri-004fL5-FI@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <E1uSBri-004fL5-FI@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 6/19/25 5:47 PM, Russell King (Oracle) 写道:
> lpc18xx uses plat_dat->mac_interface, despite wanting to validate the
> PHY interface. Checking the DT files (arch/arm/boot/dts/nxp/lpc/), none
> of them specify mac-mode which means mac_interface and phy_interface
> will be identical.
> 
> mac_interface is only used when there is some kind of MII converter
> between the DesignWare MAC and PHY, and describes the interface mode
> that the DW MAC needs to use, whereas phy_interface describes the
> interface mode that the PHY uses.
> 
> Noting that lpc18xx only supports MII and RMII interface modes, switch
> this glue driver to use plat_dat->phy_interface, and to mark that the
> mac_interface is not used, explicitly set it to PHY_INTERFACE_MODE_NA.
> The latter is safe as the only user of mac_interface for this platform
> would be in stmmac_check_pcs_mode(), which only checks for RGMII or
> SGMII.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>

Thanks,
Yanteng
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
> index 22653ffd2a04..c0c44916f849 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
> @@ -41,6 +41,7 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
>   	if (IS_ERR(plat_dat))
>   		return PTR_ERR(plat_dat);
>   
> +	plat_dat->mac_interface = PHY_INTERFACE_MODE_NA;
>   	plat_dat->has_gmac = true;
>   
>   	reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
> @@ -49,9 +50,9 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
>   		return PTR_ERR(reg);
>   	}
>   
> -	if (plat_dat->mac_interface == PHY_INTERFACE_MODE_MII) {
> +	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_MII) {
>   		ethmode = LPC18XX_CREG_CREG6_ETHMODE_MII;
> -	} else if (plat_dat->mac_interface == PHY_INTERFACE_MODE_RMII) {
> +	} else if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII) {
>   		ethmode = LPC18XX_CREG_CREG6_ETHMODE_RMII;
>   	} else {
>   		dev_err(&pdev->dev, "Only MII and RMII mode supported\n");


