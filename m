Return-Path: <netdev+bounces-65946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A175583C9A7
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C831F2A2BB
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C63137C49;
	Thu, 25 Jan 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N0U7gxV4"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2EC1C6A5
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202684; cv=none; b=Wz1KLMDKAi2ZyoHSwqhZf2SK+ygwUMMI+xqKlnKcFSpOqfYQCtk5zgYfWwifvtl4YSvs4mR8ASUiWLK4K5HcMaCoXl0UYQ3lkbXXGgtksNYonXXUMnRpu7XDCb/WMpJR118zT7dhKfQXbAZU38GN33Lkyh8E262sj047tDCL2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202684; c=relaxed/simple;
	bh=nEOsNt6FFR1h3VkdNsbanGLxwjGlJ3VKJhYvlacD+Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAQcNiGyesLpU4EHa/hJcvXo+p6vTVyFO4yNQAypoalEEVb3o/nQPke6gqZXYnMjpLjfcg8R7vknimliGiGBIighXRZsHLEEjbOgldIkcAF3LSzA5T/cpINOCBpHDqX+82kERUhh4rsaq7+rbEduw/LRaAews622vMn0XzttOCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N0U7gxV4; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <081af630-ab5d-4502-a29a-a8577d414809@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706202677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwiSZZSX/ApevLiEYXtfnRTxSGnWM9HwOp5AgT3owUs=;
	b=N0U7gxV4MpRvXxZcKiNEOu7DcT42hPeaN/Y2U6qOFPHSWeUEx4AgFNLBjp7qqagQPL5Oin
	vS/FcFfWwyVinSJlI1TWDI/1iwAtorxSkT5HS1mkvoDa4w5K36G+wEdbCJp+CO7+M+5p6Y
	yxIDgy4Ne25i2rLOl8VrcxMTq+AfUn4=
Date: Thu, 25 Jan 2024 17:11:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-imx: set TSO/TBS TX queues default
 settings
Content-Language: en-US
To: Esben Haabendal <esben@geanix.com>, netdev@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
References: <cover.1706184304.git.esben@geanix.com>
 <5606bb5f0b7566a20bb136b268dae89d22a48898.1706184304.git.esben@geanix.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <5606bb5f0b7566a20bb136b268dae89d22a48898.1706184304.git.esben@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/01/2024 12:34, Esben Haabendal wrote:
> TSO and TBS cannot coexist. For now we set i.MX Ethernet QOS controller to use
> TX queue with TSO and the rest for TBS.
> 
> TX queues with TBS can support etf qdisc hw offload.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> index 8f730ada71f9..c42e8f972833 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -353,6 +353,12 @@ static int imx_dwmac_probe(struct platform_device *pdev)
>   	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
>   		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
>   
> +        for (int i = 0; i < plat_dat->tx_queues_to_use; i++) {
> +                /* Default TX Q0 to use TSO and rest TXQ for TBS */
> +                if (i > 0)
> +                        plat_dat->tx_queues_cfg[i].tbs_en = 1;
> +        }
> +

Just wonder why don't you start with i = 1 and remove 'if' completely?
Keeping comment in place will make it understandable.

>   	plat_dat->host_dma_width = dwmac->ops->addr_width;
>   	plat_dat->init = imx_dwmac_init;
>   	plat_dat->exit = imx_dwmac_exit;


