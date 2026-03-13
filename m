Return-Path: <netdev+bounces-267423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BEAJyf3s2nYdgAAu9opvQ
	(envelope-from <netdev+bounces-267423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:38:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4CE28250A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 135B43024189
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28E35E930;
	Fri, 13 Mar 2026 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="C7lsj7v6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89F2F83A0;
	Fri, 13 Mar 2026 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401893; cv=none; b=NmcYsyxIKR2GgwO62nG4g3qSz1CX+A3J0Glje4pxe55PBfW8J+Nvs5YPX4px3nmxtnO4XqhavkWeuw0Iul/GAXdCEB1QdGCvmPnUmZjtJbZsv3SuQKVJObZdH9GPvfCm4lPR5ZZpJSUCTkB9IvIMez64z4NcjHMmw9szJiJm+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401893; c=relaxed/simple;
	bh=/k/9FS974n+DKyLTVMVI5E16Wa5IxxQNZTyNtvpztug=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+OnoF/IZ5pNZOzMk867XfAtC+MGQFO5mwIWv3Ka6aWwMvUuqMSB6wGVnJb6utTMu+SSwQFcxYHrMeNNK4tilM15iuDevfTpTp9sFJG9VHT5gugAzgEM1RSTDJJT8MvYmCzol1swX4zZtDw6C3hAlRJPeKS44kDV2Sq1ylggVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=C7lsj7v6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D36FSh1377189;
	Fri, 13 Mar 2026 04:37:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ynY30oRSIFo8M7mp17yjPMrqw
	2/qScu4SUxC5B5v7cA=; b=C7lsj7v6BQl71gnlVBpCjDxGgqUV9ooRySaq1386b
	Ky6LtvbVfV89e0q5SH+kRAMV0XefvkqNsRXQE/cb5bnGGWFu3+jJglv5U2mI+Rt0
	CZqBB/VEfj0zQ4t/EwUH5rvp/JS6W9v1zv0INR8p3lrmCvk9zxAS87gtmBuDUEkT
	TQbwQmqubQNW27l6BlBmNcVgor94n6MwXT24uXDFRsW7b5GLLi1QE4hN/pKTdMiH
	3DE7rGjC4KQmzNJKVJrBHNaOVHIUg4x2QKHRabtlMuerA6fkO1129qcqYwVqnuOf
	qpuPEF5TqYboyrbiLPCuyQqKkDbKarkvcBcFARxpfAcyw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cuh7f4ggb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 04:37:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Mar 2026 04:37:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 13 Mar 2026 04:37:43 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id C2B4A3F7071;
	Fri, 13 Mar 2026 04:37:38 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:07:37 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Doug Berger
	<opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Bhargava Marreddy
	<bhargava.marreddy@broadcom.com>,
        Rajashekar Hudumula
	<rajashekar.hudumula@broadcom.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Markus =?iso-8859-1?Q?Bl=F6chl?=
	<mbloch@rooftopnetworks.de>,
        Arnd Bergmann <arnd@arndb.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/6] net: bcmgenet: add XDP_TX support
Message-ID: <20260313113737.GA209052@kernel-ep2>
References: <20260313092101.1344954-1-nb@tipi-net.de>
 <20260313092101.1344954-5-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260313092101.1344954-5-nb@tipi-net.de>
X-Proofpoint-ORIG-GUID: 8JsapWJZe8ceQ8KRdyRwCh58DppsqHZR
X-Proofpoint-GUID: 8JsapWJZe8ceQ8KRdyRwCh58DppsqHZR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5MCBTYWx0ZWRfXxgjGlLfwF6PR
 nKghp9x4NM13CeBMwc7+400aB39CwW0fhKoYdhTYMfIoNb6hXJ9AsgpzO3qUwMMiR4pziwWOHGv
 AY1jtlVlfbjNJL1tl9Lq/l10vQZGszrt/NR7fb0vNFj1BUPA8ibYCO4/i159gGzyVRPQBI2k/EB
 Cd5CqKK5yLAac8/qoMkGxUZWdJ1VY6+5r3YcyPYnKwNW7El6DQsxAtmO1i9kWEAF/f6IvgyPRVL
 aUVDankp+QgTcrfpwGTrQW7EumUQP+kP1qzxsvU39SohPLu3YzTBekB9vLeQD/MUlS641WK3MO2
 G8vtwsqQE2KvNvvfwKrs1jzeEzj3I9GI0xLdCtPKz5d/+k77BzePw2A5jqBOt+eJRfWXMABuMPq
 G9vMCmfbUG28rTtgH+LBfBQ0a4g5NKWjTCm2XuyBAduUD5+9cBMNZMJhcAgBafcrfNoy1yNtNty
 8HwWHoUILQbyZzAybZg==
X-Authority-Analysis: v=2.4 cv=GdMaXAXL c=1 sm=1 tr=0 ts=69b3f709 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=GmAonr037yk7Tq6c59oA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267423-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,rooftopnetworks.de,arndb.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1B4CE28250A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 2026-03-13 at 14:50:59, Nicolai Buchwitz (nb@tipi-net.de) wrote:
> Implement XDP_TX by submitting XDP frames through the default TX ring
> (DESC_INDEX). The frame is DMA-mapped and placed into a single TX
> descriptor with SOP|EOP|APPEND_CRC flags.
> 
> The xdp_frame pointer is stored in the TX control block so that
> bcmgenet_free_tx_cb() can call xdp_return_frame() on TX completion,
> returning the page to the originating page_pool.
> 
> The page_pool DMA direction is changed from DMA_FROM_DEVICE to
> DMA_BIDIRECTIONAL to support the TX DMA mapping of received pages.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  .../net/ethernet/broadcom/genet/bcmgenet.c    | 73 ++++++++++++++++++-
>  .../net/ethernet/broadcom/genet/bcmgenet.h    |  1 +
>  2 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index d43729fc2b1b..373ba5878ca1 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -1893,6 +1893,12 @@ static struct sk_buff *bcmgenet_free_tx_cb(struct device *dev,
>  		if (cb == GENET_CB(skb)->last_cb)
>  			return skb;
>  
> +	} else if (cb->xdpf) {
> +		dma_unmap_single(dev, dma_unmap_addr(cb, dma_addr),
> +				 dma_unmap_len(cb, dma_len), DMA_TO_DEVICE);
> +		dma_unmap_addr_set(cb, dma_addr, 0);
> +		xdp_return_frame(cb->xdpf);
> +		cb->xdpf = NULL;
>  	} else if (dma_unmap_addr(cb, dma_addr)) {
>  		dma_unmap_page(dev,
>  			       dma_unmap_addr(cb, dma_addr),
> @@ -2299,10 +2305,62 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
>  	return skb;
>  }
>  
> +static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
> +				     struct xdp_frame *xdpf)
> +{
> +	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
> +	struct device *kdev = &priv->pdev->dev;
> +	struct enet_cb *tx_cb_ptr;
> +	dma_addr_t mapping;
> +	u32 len_stat;
> +
> +	spin_lock(&ring->lock);
> +
> +	if (ring->free_bds < 1) {
> +		spin_unlock(&ring->lock);
> +		return false;
> +	}
> +
> +	tx_cb_ptr = bcmgenet_get_txcb(priv, ring);
> +
> +	mapping = dma_map_single(kdev, xdpf->data, xdpf->len, DMA_TO_DEVICE);

AFAIU you are transmitting the frame received on a RQ which is from the page pool
and already dma mapped. Do you have to do dma_map again?

Thanks,
Sundeep

> +	if (dma_mapping_error(kdev, mapping)) {
> +		tx_cb_ptr->skb = NULL;
> +		tx_cb_ptr->xdpf = NULL;
> +		bcmgenet_put_txcb(priv, ring);
> +		spin_unlock(&ring->lock);
> +		return false;
> +	}
> +
> +	dma_unmap_addr_set(tx_cb_ptr, dma_addr, mapping);
> +	dma_unmap_len_set(tx_cb_ptr, dma_len, xdpf->len);
> +	tx_cb_ptr->skb = NULL;
> +	tx_cb_ptr->xdpf = xdpf;
> +
> +	len_stat = (xdpf->len << DMA_BUFLENGTH_SHIFT) |
> +		   (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT) |
> +		   DMA_TX_APPEND_CRC | DMA_SOP | DMA_EOP;
> +
> +	dmadesc_set(priv, tx_cb_ptr->bd_addr, mapping, len_stat);
> +
> +	ring->free_bds--;
> +	ring->prod_index++;
> +	ring->prod_index &= DMA_P_INDEX_MASK;
> +
> +	bcmgenet_tdma_ring_writel(priv, ring->index, ring->prod_index,
> +				  TDMA_PROD_INDEX);
> +
> +	spin_unlock(&ring->lock);
> +
> +	return true;
> +}
> +
>  static unsigned int
>  bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
>  		 struct xdp_buff *xdp, struct page *rx_page)
>  {
> +	struct bcmgenet_priv *priv = ring->priv;
> +	struct xdp_frame *xdpf;
>  	unsigned int act;
>  
>  	act = bpf_prog_run_xdp(prog, xdp);
> @@ -2310,14 +2368,23 @@ bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
>  	switch (act) {
>  	case XDP_PASS:
>  		return XDP_PASS;
> +	case XDP_TX:
> +		xdpf = xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf) ||
> +		    unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf))) {
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}
> +		return XDP_TX;
>  	case XDP_DROP:
>  		page_pool_put_full_page(ring->page_pool, rx_page, true);
>  		return XDP_DROP;
>  	default:
> -		bpf_warn_invalid_xdp_action(ring->priv->dev, prog, act);
> +		bpf_warn_invalid_xdp_action(priv->dev, prog, act);
>  		fallthrough;
>  	case XDP_ABORTED:
> -		trace_xdp_exception(ring->priv->dev, prog, act);
> +		trace_xdp_exception(priv->dev, prog, act);
>  		page_pool_put_full_page(ring->page_pool, rx_page, true);
>  		return XDP_ABORTED;
>  	}
> @@ -2846,7 +2913,7 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
>  		.pool_size = ring->size,
>  		.nid = NUMA_NO_NODE,
>  		.dev = &priv->pdev->dev,
> -		.dma_dir = DMA_FROM_DEVICE,
> +		.dma_dir = DMA_BIDIRECTIONAL,
>  		.offset = GENET_XDP_HEADROOM,
>  		.max_len = RX_BUF_LENGTH,
>  	};
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index 1459473ac1b0..192db0defbfc 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -472,6 +472,7 @@ struct bcmgenet_rx_stats64 {
>  
>  struct enet_cb {
>  	struct sk_buff      *skb;
> +	struct xdp_frame    *xdpf;
>  	struct page         *rx_page;
>  	unsigned int        rx_page_offset;
>  	void __iomem *bd_addr;
> -- 
> 2.51.0
> 

