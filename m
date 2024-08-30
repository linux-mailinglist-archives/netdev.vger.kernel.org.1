Return-Path: <netdev+bounces-123693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F539662EE
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB861F243DF
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06CC199FA4;
	Fri, 30 Aug 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFfPRsdc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D76170A0B;
	Fri, 30 Aug 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024616; cv=none; b=aoAf7v9tEXNsJ1vUAdYh+laFVc2rpujwRFMARzCePKBj7LX/PWZUowk+De2mkk3O205R3VwEDJSzoZ8DW/chVmuV7fc8oWSJOzyWAoI88FN6gh2d4HNVnEoFR0tTJ3zA+br3xMzL5vA7LB3yTApTNkGjd0su1DgUo1Sb3wDW8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024616; c=relaxed/simple;
	bh=cGi2qH53DXoJQTJqY9tTH9RtUBOepKdH8v4H9qRqxJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLovPlc/UBZAnIW0fdSnhwhwRG07zZaA26PO8P/gTg8HeF++sDTS97NITLmkLAq8zd0Yg7duTf34nXwsS995NPlVhzyjDr6+RyFtsshShQLgv9XWn9vrnHhr9ilutUA69StQSR9W2oYbx0EP3NerUpcub2QSLKXMyFaSDIuHZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFfPRsdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8705BC4CEC2;
	Fri, 30 Aug 2024 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024616;
	bh=cGi2qH53DXoJQTJqY9tTH9RtUBOepKdH8v4H9qRqxJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gFfPRsdcZgx3AY7KzIMQtTCihpJ0y7f6xKWkKlKo1kQNEYyAybeZof+h1eEGxWWyA
	 8WiMb5SykooGr8zt1hJOODFcg099uE/udKjyK8nuaNBmnr6sbe34hnqSBRrVpuNJzM
	 pRDaysus8DD/iZu1G/A9yTJqd07laRf+RipXWx08eM9L9bv0H6YXYpp3CsCnfYCJAk
	 8iZ6UFf1/HWb2POecQbZu3k7LJp+aDDcHdzNC4MpBlp/MXTpOKLgEMaBukZbzb5g2s
	 /oSmVf1ywrehLuqG3U4tcpqa4U088QId2EsUgPUaajC+sQ3B40BH+MarnnjUQzR9f+
	 FbMmiWnIv1eCA==
Message-ID: <7ebd7657-8e79-44e4-9680-832946fab523@kernel.org>
Date: Fri, 30 Aug 2024 16:30:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/6] net: ti: icssg-prueth: Enable HSR Tx
 Packet duplication offload
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-5-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240828091901.3120935-5-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/08/2024 12:18, MD Danish Anwar wrote:
> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> The HSR stack allows to offload its Tx packet duplication functionality to
> the hardware. Enable this offloading feature for ICSSG driver
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_common.c | 13 ++++++++++---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |  5 +++--
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 ++
>  3 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index b9d8a93d1680..2d6d8648f5a9 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -660,14 +660,15 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>  {
>  	struct cppi5_host_desc_t *first_desc, *next_desc, *cur_desc;
>  	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
>  	struct netdev_queue *netif_txq;
>  	struct prueth_tx_chn *tx_chn;
>  	dma_addr_t desc_dma, buf_dma;
> +	u32 pkt_len, dst_tag_id;
>  	int i, ret = 0, q_idx;
>  	bool in_tx_ts = 0;
>  	int tx_ts_cookie;
>  	void **swdata;
> -	u32 pkt_len;
>  	u32 *epib;
>  
>  	pkt_len = skb_headlen(skb);
> @@ -712,9 +713,15 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>  
>  	/* set dst tag to indicate internal qid at the firmware which is at
>  	 * bit8..bit15. bit0..bit7 indicates port num for directed
> -	 * packets in case of switch mode operation
> +	 * packets in case of switch mode operation and port num 0
> +	 * for undirected packets in case of HSR offload mode
>  	 */
> -	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
> +	dst_tag_id = emac->port_id | (q_idx << 8);
> +
> +	if (prueth->is_hsr_offload_mode && (ndev->features & NETIF_F_HW_HSR_DUP))
> +		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
> +
> +	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
>  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>  	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
>  	swdata = cppi5_hdesc_get_swdata(first_desc);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index f4fd346fe6f5..b60efe7bd7a7 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -41,7 +41,8 @@
>  #define DEFAULT_PORT_MASK	1
>  #define DEFAULT_UNTAG_MASK	1
>  
> -#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	NETIF_F_HW_HSR_FWD
> +#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	(NETIF_F_HW_HSR_FWD | \
> +						 NETIF_F_HW_HSR_DUP)

You mentioned that these 2 features can't be enabled individually.

So better to squash this with previous patch and use ndo_fix_features() to make sure both
are set or cleared together.

>  
>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
> @@ -897,7 +898,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	ndev->ethtool_ops = &icssg_ethtool_ops;
>  	ndev->hw_features = NETIF_F_SG;
>  	ndev->features = ndev->hw_features;
> -	ndev->hw_features |= NETIF_F_HW_HSR_FWD;
> +	ndev->hw_features |= NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
>  
>  	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
>  	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index a4b025fae797..e110a5f92684 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -59,6 +59,8 @@
>  
>  #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
>  
> +#define PRUETH_UNDIRECTED_PKT_DST_TAG	0
> +
>  /* Firmware status codes */
>  #define ICSS_HS_FW_READY 0x55555555
>  #define ICSS_HS_FW_DEAD 0xDEAD0000	/* lower 16 bits contain error code */

-- 
cheers,
-roger

