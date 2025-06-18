Return-Path: <netdev+bounces-199102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84176ADEF3A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227DC1886FEF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156FD2EBB8D;
	Wed, 18 Jun 2025 14:24:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392842E8DED;
	Wed, 18 Jun 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256650; cv=none; b=N/8tA9F9nIBeuC/ICR5H1jIP7wky6wDNf7V19zv34f17mvShi+3sXxlfdL12P6Sieya8lBWoP3ChotJwJQzBK1UFsOM8MbBaGT3nYyNjYaPdwUd9M+jU88rQXrQvD9D+8KjkKKOKXAebyZ/9EXEND84v2HDquooa9lwUMQop2wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256650; c=relaxed/simple;
	bh=bi81rDOTqtPi0s6oEwF6JDygTavaOvX9oS5mne9wc4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIQaBvDKNKErke52aei5lsov9V4SQjfZ+0BVIKo4iJ8aSY1CeKAV5nBFN0x4XM7MYWM+HuJj0zxYpy8ulbD9cOP8DDXetdZxXKPj3Xx0YdL/OB2dSKtFZVgp4zW45C+mlGpgw505ztoos98ie5Su7ggdN3URObAMFNzdrOnubEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uRtZL-000000003nZ-3dHt;
	Wed, 18 Jun 2025 14:23:57 +0000
Date: Wed, 18 Jun 2025 16:23:49 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Simon Horman <horms@kernel.org>,
	arinc.unal@arinc9.com
Subject: Re: [net-next v5 2/3] net: ethernet: mtk_eth_soc: add consts for irq
 index
Message-ID: <aFLL9Uhu6zmovd2O@pidgin.makrotopia.org>
References: <20250618130717.75839-1-linux@fw-web.de>
 <20250618130717.75839-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618130717.75839-3-linux@fw-web.de>

On Wed, Jun 18, 2025 at 03:07:13PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Use consts instead of fixed integers for accessing IRQ array.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
> v5:
> - rename consts to be compatible with upcoming RSS/LRO changes
>   MTK_ETH_IRQ_SHARED => MTK_FE_IRQ_SHARED
>   MTK_ETH_IRQ_TX => MTK_FE_IRQ_TX
>   MTK_ETH_IRQ_RX => MTK_FE_IRQ_RX
>   MTK_ETH_IRQ_MAX => MTK_FE_IRQ_NUM
> v4:
> - calculate max from last (rx) irq index and use it for array size too
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 22 ++++++++++-----------
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h |  7 ++++++-
>  2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 39b673ed7495..875e477a987b 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3342,9 +3342,9 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
>  	int i;
>  
>  	/* future SoCs beginning with MT7988 should use named IRQs in dts */
> -	eth->irq[1] = platform_get_irq_byname(pdev, "tx");
> -	eth->irq[2] = platform_get_irq_byname(pdev, "rx");
> -	if (eth->irq[1] >= 0 && eth->irq[2] >= 0)
> +	eth->irq[MTK_FE_IRQ_TX] = platform_get_irq_byname(pdev, "tx");
> +	eth->irq[MTK_FE_IRQ_RX] = platform_get_irq_byname(pdev, "rx");
> +	if (eth->irq[MTK_FE_IRQ_TX] >= 0 && eth->irq[MTK_FE_IRQ_RX] >= 0)
>  		return 0;
>  
>  	/* legacy way:
> @@ -3353,9 +3353,9 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
>  	 * On SoCs with non-shared IRQs the first entry is not used,
>  	 * the second is for TX, and the third is for RX.
>  	 */
> -	for (i = 0; i < 3; i++) {
> +	for (i = 0; i < MTK_FE_IRQ_NUM; i++) {
>  		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> -			eth->irq[i] = eth->irq[0];
> +			eth->irq[i] = eth->irq[MTK_FE_IRQ_SHARED];
>  		else
>  			eth->irq[i] = platform_get_irq(pdev, i);
>  
> @@ -3421,7 +3421,7 @@ static void mtk_poll_controller(struct net_device *dev)
>  
>  	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
>  	mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
> -	mtk_handle_irq_rx(eth->irq[2], dev);
> +	mtk_handle_irq_rx(eth->irq[MTK_FE_IRQ_RX], dev);
>  	mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
>  	mtk_rx_irq_enable(eth, eth->soc->rx.irq_done_mask);
>  }
> @@ -4907,7 +4907,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
>  	eth->netdev[id]->features |= eth->soc->hw_features;
>  	eth->netdev[id]->ethtool_ops = &mtk_ethtool_ops;
>  
> -	eth->netdev[id]->irq = eth->irq[0];
> +	eth->netdev[id]->irq = eth->irq[MTK_FE_IRQ_SHARED];
>  	eth->netdev[id]->dev.of_node = np;
>  
>  	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
> @@ -5184,17 +5184,17 @@ static int mtk_probe(struct platform_device *pdev)
>  	}
>  
>  	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
> -		err = devm_request_irq(eth->dev, eth->irq[0],
> +		err = devm_request_irq(eth->dev, eth->irq[MTK_FE_IRQ_SHARED],
>  				       mtk_handle_irq, 0,
>  				       dev_name(eth->dev), eth);
>  	} else {
> -		err = devm_request_irq(eth->dev, eth->irq[1],
> +		err = devm_request_irq(eth->dev, eth->irq[MTK_FE_IRQ_TX],
>  				       mtk_handle_irq_tx, 0,
>  				       dev_name(eth->dev), eth);
>  		if (err)
>  			goto err_free_dev;
>  
> -		err = devm_request_irq(eth->dev, eth->irq[2],
> +		err = devm_request_irq(eth->dev, eth->irq[MTK_FE_IRQ_RX],
>  				       mtk_handle_irq_rx, 0,
>  				       dev_name(eth->dev), eth);
>  	}
> @@ -5240,7 +5240,7 @@ static int mtk_probe(struct platform_device *pdev)
>  		} else
>  			netif_info(eth, probe, eth->netdev[i],
>  				   "mediatek frame engine at 0x%08lx, irq %d\n",
> -				   eth->netdev[i]->base_addr, eth->irq[0]);
> +				   eth->netdev[i]->base_addr, eth->irq[MTK_FE_IRQ_SHARED]);
>  	}
>  
>  	/* we run 2 devices on the same DMA ring so we need a dummy device
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> index 6f72a8c8ae1e..8cdf1317dff5 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> @@ -642,6 +642,11 @@
>  
>  #define MTK_MAC_FSM(x)		(0x1010C + ((x) * 0x100))
>  
> +#define MTK_FE_IRQ_SHARED	0
> +#define MTK_FE_IRQ_TX		1
> +#define MTK_FE_IRQ_RX		2
> +#define MTK_FE_IRQ_NUM		(MTK_FE_IRQ_RX + 1)
> +
>  struct mtk_rx_dma {
>  	unsigned int rxd1;
>  	unsigned int rxd2;
> @@ -1292,7 +1297,7 @@ struct mtk_eth {
>  	struct net_device		*dummy_dev;
>  	struct net_device		*netdev[MTK_MAX_DEVS];
>  	struct mtk_mac			*mac[MTK_MAX_DEVS];
> -	int				irq[3];
> +	int				irq[MTK_FE_IRQ_NUM];
>  	u32				msg_enable;
>  	unsigned long			sysclk;
>  	struct regmap			*ethsys;
> -- 
> 2.43.0
> 

