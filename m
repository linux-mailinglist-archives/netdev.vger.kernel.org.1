Return-Path: <netdev+bounces-160046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1ADA17F10
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5D43A244C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C3D1F2C3B;
	Tue, 21 Jan 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="htEFROgp"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488661F03EA
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737466976; cv=none; b=K9AV3unLWsGHqNQjGnmd+Cz1MK+F/2HdeGBnw4wfdudswvWdwibSOtIAAxQuJlljrte2O8EUxTazaKEf1aWfIWIdjxwA14maAId2HyNZgMHcLTErAaMdlJ7GC/QnULjbBahQotXBjyFX4QIszKr03xoy71PrV3It1gNifug21Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737466976; c=relaxed/simple;
	bh=VTAJbNnVhlrhpHc7hXfvvLJEz/sYd1BNf5Sd/b1wzTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLOYnyVEZW1Wwvg69IN/xokXx/QJ8y7HJ2HxvzlszClxTofj/nxP4vJxNveGFeZJ9m8TvI3xBi+uWD0bo+CpQ5bSx9zB5ELTeDfrkY7punxEh0HT8TAxkvwjlntScAFGGxof9Vce2ZWMRFli1yC4v9pfuT+bPFKajKa67WODjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=htEFROgp; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4787f868-a384-4753-8cfd-3027f5c88fd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737466957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riUwlOLV98LIWuaBGw9AYLP5twrEkbqsTzI6ivE/+oM=;
	b=htEFROgpRDTuwyLUcbA8L+AEPC0TWS6DsHAhCftehljl3B20RKP+a50aboJaspD7NlDJ1A
	D5sFvKnEdYpeljOCvdf85vkeRWbc6/BituX4itOFrXC6V6kr1GMao2bb6d0GO5292Xh003
	dRZAt5RY1NT0+3Tqo59h3hNQbBPSF1Q=
Date: Tue, 21 Jan 2025 21:41:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
To: Qunqin Zhao <zhaoqunqin@loongson.cn>, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Cc: chenhuacai@kernel.org, fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 1/21/25 16:25, Qunqin Zhao 写道:
> Loongson's GMAC device takes nearly two seconds to complete DMA reset,
> however, the default waiting time for reset is 200 milliseconds
Is only GMAC like this?
>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-loongson.c    | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index bfe6e2d631bd..35639d26256c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -516,6 +516,18 @@ static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
>   	return 0;
>   }
>   
How about putting a part of the commit message here as a comment?
> +static int loongson_fix_soc_reset(void *priv, void __iomem *ioaddr)


> +{
> +	u32 value = readl(ioaddr + DMA_BUS_MODE);
> +
> +	value |= DMA_BUS_MODE_SFT_RESET;
> +	writel(value, ioaddr + DMA_BUS_MODE);
> +
> +	return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
> +				  !(value & DMA_BUS_MODE_SFT_RESET),
> +				  10000, 2000000);
> +}
> +
>   static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct plat_stmmacenet_data *plat;
> @@ -566,6 +578,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>   
>   	plat->bsp_priv = ld;
>   	plat->setup = loongson_dwmac_setup;
> +	plat->fix_soc_reset = loongson_fix_soc_reset;

If only GMAC needs to be done this way, how about putting it inside the 
loongson_gmac_data()?

Thanks,

Yanteng


