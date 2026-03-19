Return-Path: <netdev+bounces-269662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGCvOkJrvGnwyQIAu9opvQ
	(envelope-from <netdev+bounces-269662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:31:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ABE2D2B08
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF10C30186AC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224713AEF2E;
	Thu, 19 Mar 2026 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JKalKqIK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7493101B4
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955902; cv=none; b=NrisoU4KjSzJZSsFUvHQ1qRMuVyrV5rh01PfxEiP1qh1pFwN8zLUg1aN/JYg0YKLmDKCvzud9XM4AmoyTfjakyDzmhW2jLiVmovpgTN19YCBx1JW3CgCT8wTJZ5CnTUp/x5fBsN78pWqJ4P8x7utYHtx0Z4qlO1J4msjGYqv9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955902; c=relaxed/simple;
	bh=GtumRf9Hnr7mzKctDO7NBkPlSfbVhRO1qgZNUo3pCyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlKPExsbntpW42sHW0XXi+Mb8Y4omzaYYaLvuAkzXE2SDZRA80ppiInjrMNLFIHDaRy8+VOx5A4DyQ0/A+xPHBXUkxq1SAWKfgzJPxFRImRCoNM+/f4VkjHIHoEqk/aqbecrC0l6AFnwjFreiyz+0p9X74lBDhXJcUWmJgpib80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JKalKqIK; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-89a07f66f4eso12952806d6.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955899; x=1774560699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYR1hRHQabBPcbUT7i4RJJHIilqZNEUs6+JSY+yrheg=;
        b=oXFms37r+vTIvGalyIKhTdC+S08i5Q+cmrvEOYCClVhqRiA+EJuwdOs4deTQJ2B++S
         7S5uY+hJg0U4l7IvKmkjfedp4JmpHorkiwPHn6YUKkrx+4e4n02EAipDJv/Kqibv3R68
         YhnhQZyKumzu4fB6jaer6fjZvMlacGS+N9zHgMU8y2txPfoLEHDJjBriuX1S7qEbcCHN
         +dnJm4K3EMupCzpXFfzGHrqpkT7vMdrF3LzM+pOv8rpPdan5uPjDXtbu5SjIxGulrFMj
         prSukEp5cv3Jbvejy8ihvKvmrzWNBnGcFfFPHQ9cL+JpnRzkg9k0d74+wHMRlRTGAzUD
         I0TA==
X-Forwarded-Encrypted: i=1; AJvYcCUxuj7TMHbSq7CKscAxRbAwpeFC1H4yAbuozxBsJII/CFX6Fv1phb14PtEbJYURZBMzTB3lmw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+7v4Vg4vGCYbiGtpXknG7xZjoOw3i7am+mqhxoMYhtThNOtjT
	rj5udSjsm/bEoJgjp1vmyGpVwmh4eAYXhQ9OUNWyDHD1kthYp6026vK0Pt+x0Vs2rIOA97ZFlM+
	ywfvTWaU5blUu9Fx8sg6T4bjJ2NLw/Z4iKjcFngbYI3RJNX2+LmcpR5xKsysrVwm/LY3v2xQ5s0
	tp6+0uBrfVZJBeTGH1JDfJQKBDEebMCCkfWE9YX5C9qtBpQoMD06zQBUJaNJnSOzYj7vCGh/0aK
	apP9tTY4g==
X-Gm-Gg: ATEYQzzOw5BkwPeGw88o7Ww7Db2xrSwB/pCnQeJWj4rRPmF2B/PjUNOgYVuc2ZETQzD
	5UX051khSp5T+0D0dcx1ga9ZJE8xwenZKh6a0nrxSSuu0OJ8EXCfCtjs6Sv7ffUMYEa81mwOxBX
	Z9UqqxzzoFMB7inqogyTkdAlPUqmFStFd15nwct3GnD5mBjBl01JZLgh/+/sGue51wRkDpwAiSK
	wBtUJ09NqqWaW4hN+fcdzKWiUta7eSdYwEuzJP8FQcD9FNM7G2FK7I9pxui2i6GQrhEcDek7oTZ
	8g9Ul+uLs9spPnf+V/0l79u5ircETNSsZiAtUDT3MBjKXkr46ztGiXDxzJ1dPMr1CO8djr863qr
	3bKyQiSfj2QKG4onHZKnRVKi1xIGSKSsuxPuYDQC3dZtdBnMVd1g8MlY6FVrnzt0IqrjodMMHNz
	dMs6J9hpr7uywxVpwyinGsxCgn369oe6/7MVxxQRcJn3VDE8x9mYYirbM=
X-Received: by 2002:a05:6214:5712:b0:89c:610f:fba1 with SMTP id 6a1803df08f44-89c85a7e223mr11134626d6.46.1773955899081;
        Thu, 19 Mar 2026 14:31:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89c852dedadsm610956d6.14.2026.03.19.14.31.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:31:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7f6ac239so743542285a.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773955898; x=1774560698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYR1hRHQabBPcbUT7i4RJJHIilqZNEUs6+JSY+yrheg=;
        b=JKalKqIKvV4QM2szytjntPwUxoJDPr3lJDHBPn98joObie6JWuutNNioy3MgUR1afV
         fERakJovjs9yfAfMWus7qdBeG42p00oWknSRezafvPaAOvdgze4I172qUhshNYv+DASV
         OhwXCZHZhPCMEfeA4HoJ7w+l2uxYeaS3et+Bk=
X-Forwarded-Encrypted: i=1; AJvYcCUDZzzRbC+o0vCGr3C31QJ2JSwNblK+lww1saqGoOqfXkbJnN46KYkgvmsVFbUM9SVruwjb6UQ=@vger.kernel.org
X-Received: by 2002:a05:620a:25d3:b0:8cd:8785:eff4 with SMTP id af79cd13be357-8cfc7b65c11mr135869185a.15.1773955897970;
        Thu, 19 Mar 2026 14:31:37 -0700 (PDT)
X-Received: by 2002:a05:620a:25d3:b0:8cd:8785:eff4 with SMTP id af79cd13be357-8cfc7b65c11mr135862185a.15.1773955897225;
        Thu, 19 Mar 2026 14:31:37 -0700 (PDT)
Received: from [10.14.5.69] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f934a4sm23212285a.16.2026.03.19.14.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:31:36 -0700 (PDT)
Message-ID: <47c7a6d1-c8e3-45c8-a2e1-213f44671306@broadcom.com>
Date: Thu, 19 Mar 2026 14:31:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/6] net: bcmgenet: add XDP_TX support
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-5-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260319115402.353509-5-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269662-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid,tipi-net.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 94ABE2D2B08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/19/26 4:53 AM, Nicolai Buchwitz wrote:
> Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
> descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.
> 
> Ring 16 gets 32 BDs carved from ring 0's allocation. TX completion is
> piggybacked on RX NAPI poll since ring 16's INTRL2_1 bit collides with
> RX ring 0, similar to how bnxt, ice, and other XDP drivers handle TX
> completion within the RX poll path.
> 
> The GENET MAC has TBUF_64B_EN set globally, requiring every TX buffer
> to start with a 64-byte struct status_64 (TSB). For local XDP_TX, the
> TSB is prepended by backing xdp->data into the RSB area (unused after
> BPF execution) and zeroing it. For foreign frames (ndo_xdp_xmit), the
> TSB is written into the xdp_frame headroom.
> 
> The page_pool DMA direction is changed from DMA_FROM_DEVICE to
> DMA_BIDIRECTIONAL to allow TX reuse of the existing DMA mapping.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>   .../net/ethernet/broadcom/genet/bcmgenet.c    | 195 ++++++++++++++++--
>   .../net/ethernet/broadcom/genet/bcmgenet.h    |   4 +-
>   2 files changed, 181 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index e8f90d6b16a2..54df1694f1cd 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -48,8 +48,10 @@
>   
>   #define GENET_Q0_RX_BD_CNT	\
>   	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_q)
> +#define GENET_Q16_TX_BD_CNT	64
>   #define GENET_Q0_TX_BD_CNT	\
> -	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q)
> +	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q \
> +	 - GENET_Q16_TX_BD_CNT)
>   
>   #define RX_BUF_LENGTH		2048
>   #define SKB_ALIGNMENT		32
> @@ -1893,6 +1895,14 @@ static struct sk_buff *bcmgenet_free_tx_cb(struct device *dev,
>   		if (cb == GENET_CB(skb)->last_cb)
>   			return skb;
>   
> +	} else if (cb->xdpf) {
> +		if (cb->xdp_dma_map)
> +			dma_unmap_single(dev, dma_unmap_addr(cb, dma_addr),
> +					 dma_unmap_len(cb, dma_len),
> +					 DMA_TO_DEVICE);
> +		dma_unmap_addr_set(cb, dma_addr, 0);
> +		xdp_return_frame(cb->xdpf);
> +		cb->xdpf = NULL;
>   	} else if (dma_unmap_addr(cb, dma_addr)) {
>   		dma_unmap_page(dev,
>   			       dma_unmap_addr(cb, dma_addr),
> @@ -1927,8 +1937,13 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
>   	unsigned int c_index;
>   	struct sk_buff *skb;
>   
> -	/* Clear status before servicing to reduce spurious interrupts */
> -	bcmgenet_intrl2_1_writel(priv, (1 << ring->index), INTRL2_CPU_CLEAR);
> +	/* Clear status before servicing to reduce spurious interrupts.
> +	 * Ring DESC_INDEX (XDP TX) has no interrupt; skip the clear to
> +	 * avoid clobbering RX ring 0's bit at the same position.
> +	 */
> +	if (ring->index != DESC_INDEX)
> +		bcmgenet_intrl2_1_writel(priv, BIT(ring->index),
> +					 INTRL2_CPU_CLEAR);
>   
>   	/* Compute how many buffers are transmitted since last xmit call */
>   	c_index = bcmgenet_tdma_ring_readl(priv, ring->index, TDMA_CONS_INDEX)
> @@ -1964,8 +1979,11 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
>   	u64_stats_add(&stats->bytes, bytes_compl);
>   	u64_stats_update_end(&stats->syncp);
>   
> -	netdev_tx_completed_queue(netdev_get_tx_queue(dev, ring->index),
> -				  pkts_compl, bytes_compl);
> +	/* Ring DESC_INDEX (XDP TX) has no netdev TX queue; skip BQL */
> +	if (ring->index != DESC_INDEX)
> +		netdev_tx_completed_queue(netdev_get_tx_queue(dev,
> +							      ring->index),
> +					  pkts_compl, bytes_compl);
>   
>   	return txbds_processed;
>   }
> @@ -2042,6 +2060,9 @@ static void bcmgenet_tx_reclaim_all(struct net_device *dev)
>   	do {
>   		bcmgenet_tx_reclaim(dev, &priv->tx_rings[i++], true);
>   	} while (i <= priv->hw_params->tx_queues && netif_is_multiqueue(dev));
> +
> +	/* Also reclaim XDP TX ring */
> +	bcmgenet_tx_reclaim(dev, &priv->tx_rings[DESC_INDEX], true);
>   }
>   
>   /* Reallocate the SKB to put enough headroom in front of it and insert
> @@ -2299,10 +2320,96 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
>   	return skb;
>   }
>   
> +static bool

Same as last patch. Perfer to remove newline here.

> +bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
> +			struct xdp_frame *xdpf, bool dma_map)
> +{
> +	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
> +	struct device *kdev = &priv->pdev->dev;
> +	struct enet_cb *tx_cb_ptr;
> +	dma_addr_t mapping;
> +	unsigned int dma_len;
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
> +	if (dma_map) {
> +		void *tsb_start;
> +
> +		/* The GENET MAC has TBUF_64B_EN set globally, so hardware
> +		 * expects a 64-byte TSB prefix on every TX buffer.  For
> +		 * redirected frames (ndo_xdp_xmit) we prepend a zeroed TSB
> +		 * using the frame's headroom.
> +		 */
> +		if (unlikely(xdpf->headroom < sizeof(struct status_64))) {
> +			bcmgenet_put_txcb(priv, ring);
> +			spin_unlock(&ring->lock);
> +			return false;
> +		}
> +
> +		tsb_start = xdpf->data - sizeof(struct status_64);
> +		memset(tsb_start, 0, sizeof(struct status_64));
> +
> +		dma_len = xdpf->len + sizeof(struct status_64);
> +		mapping = dma_map_single(kdev, tsb_start, dma_len,
> +					 DMA_TO_DEVICE);
> +		if (dma_mapping_error(kdev, mapping)) {
> +			tx_cb_ptr->skb = NULL;
> +			tx_cb_ptr->xdpf = NULL;
> +			bcmgenet_put_txcb(priv, ring);
> +			spin_unlock(&ring->lock);
> +			return false;
> +		}
> +	} else {
> +		struct page *page = virt_to_page(xdpf->data);
> +
> +		/* For local XDP_TX the caller already prepended the TSB
> +		 * into xdpf->data/len, so dma_len == xdpf->len.
> +		 */
> +		dma_len = xdpf->len;
> +		mapping = page_pool_get_dma_addr(page) +
> +			  sizeof(*xdpf) + xdpf->headroom;
> +		dma_sync_single_for_device(kdev, mapping, dma_len,
> +					   DMA_BIDIRECTIONAL);
> +	}
> +
> +	dma_unmap_addr_set(tx_cb_ptr, dma_addr, mapping);
> +	dma_unmap_len_set(tx_cb_ptr, dma_len, dma_len);
> +	tx_cb_ptr->skb = NULL;
> +	tx_cb_ptr->xdpf = xdpf;
> +	tx_cb_ptr->xdp_dma_map = dma_map;
> +
> +	len_stat = (dma_len << DMA_BUFLENGTH_SHIFT) |
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
>   static unsigned int
>   bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
>   		 struct xdp_buff *xdp, struct page *rx_page)
>   {
> +	struct bcmgenet_priv *priv = ring->priv;
> +	struct xdp_frame *xdpf;
>   	unsigned int act;
>   
>   	act = bpf_prog_run_xdp(prog, xdp);
> @@ -2310,14 +2417,33 @@ bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
>   	switch (act) {
>   	case XDP_PASS:
>   		return XDP_PASS;
> +	case XDP_TX:
> +		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
> +		 * MAC has TBUF_64B_EN set globally, so hardware expects every
> +		 * TX buffer to begin with a 64-byte struct status_64.  Back
> +		 * up xdp->data into the RSB area (which is no longer needed
> +		 * after the BPF program ran) and zero it.
> +		 */
> +		xdp->data -= sizeof(struct status_64);
> +		xdp->data_meta -= sizeof(struct status_64);
> +		memset(xdp->data, 0, sizeof(struct status_64));
> +
> +		xdpf = xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf) ||
> +		    unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf, false))) {
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}
> +		return XDP_TX;
>   	case XDP_DROP:
>   		page_pool_put_full_page(ring->page_pool, rx_page, true);
>   		return XDP_DROP;
>   	default:
> -		bpf_warn_invalid_xdp_action(ring->priv->dev, prog, act);
> +		bpf_warn_invalid_xdp_action(priv->dev, prog, act);
>   		fallthrough;
>   	case XDP_ABORTED:
> -		trace_xdp_exception(ring->priv->dev, prog, act);
> +		trace_xdp_exception(priv->dev, prog, act);
>   		page_pool_put_full_page(ring->page_pool, rx_page, true);
>   		return XDP_ABORTED;
>   	}
> @@ -2555,9 +2681,15 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
>   {
>   	struct bcmgenet_rx_ring *ring = container_of(napi,
>   			struct bcmgenet_rx_ring, napi);
> +	struct bcmgenet_priv *priv = ring->priv;
>   	struct dim_sample dim_sample = {};
>   	unsigned int work_done;
>   
> +	/* Reclaim completed XDP TX frames (ring 16 has no interrupt) */
> +	if (priv->xdp_prog)
> +		bcmgenet_tx_reclaim(priv->dev,
> +				    &priv->tx_rings[DESC_INDEX], false);
> +
>   	work_done = bcmgenet_desc_rx(ring, budget);
>   
>   	if (work_done < budget && napi_complete_done(napi, work_done))
> @@ -2832,8 +2964,11 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
>   	bcmgenet_tdma_ring_writel(priv, index, end_ptr * words_per_bd - 1,
>   				  DMA_END_ADDR);
>   
> -	/* Initialize Tx NAPI */
> -	netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
> +	/* Initialize Tx NAPI for priority queues only; ring DESC_INDEX
> +	 * (XDP TX) has its completions handled inline in RX NAPI.
> +	 */
> +	if (index != DESC_INDEX)
> +		netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
>   }
>   
>   static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
> @@ -2845,7 +2980,7 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
>   		.pool_size = ring->size,
>   		.nid = NUMA_NO_NODE,
>   		.dev = &priv->pdev->dev,
> -		.dma_dir = DMA_FROM_DEVICE,
> +		.dma_dir = DMA_BIDIRECTIONAL,
>   		.offset = GENET_XDP_HEADROOM,
>   		.max_len = RX_BUF_LENGTH,
>   	};
> @@ -2977,6 +3112,7 @@ static int bcmgenet_tdma_disable(struct bcmgenet_priv *priv)
>   
>   	reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
>   	mask = (1 << (priv->hw_params->tx_queues + 1)) - 1;
> +	mask |= BIT(DESC_INDEX);
>   	mask = (mask << DMA_RING_BUF_EN_SHIFT) | DMA_EN;
>   	reg &= ~mask;
>   	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
> @@ -3022,14 +3158,18 @@ static int bcmgenet_rdma_disable(struct bcmgenet_priv *priv)
>    * with queue 1 being the highest priority queue.
>    *
>    * Queue 0 is the default Tx queue with
> - * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 = 128 descriptors.
> + * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 - 32 = 96 descriptors.
> + *
> + * Ring 16 (DESC_INDEX) is used for XDP TX with
> + * GENET_Q16_TX_BD_CNT = 32 descriptors.
>    *
>    * The transmit control block pool is then partitioned as follows:
> - * - Tx queue 0 uses tx_cbs[0..127]
> - * - Tx queue 1 uses tx_cbs[128..159]
> - * - Tx queue 2 uses tx_cbs[160..191]
> - * - Tx queue 3 uses tx_cbs[192..223]
> - * - Tx queue 4 uses tx_cbs[224..255]
> + * - Tx queue 0 uses tx_cbs[0..95]
> + * - Tx queue 1 uses tx_cbs[96..127]
> + * - Tx queue 2 uses tx_cbs[128..159]
> + * - Tx queue 3 uses tx_cbs[160..191]
> + * - Tx queue 4 uses tx_cbs[192..223]
> + * - Tx ring 16 uses tx_cbs[224..255]

Can keep the term tx queue? Unless we are trying to highlight something 
different here.

>    */
>   static void bcmgenet_init_tx_queues(struct net_device *dev)
>   {
> @@ -3050,13 +3190,18 @@ static void bcmgenet_init_tx_queues(struct net_device *dev)
>   			<< DMA_PRIO_REG_SHIFT(i);
>   	}
>   
> +	/* Initialize ring 16 (descriptor ring) for XDP TX */
> +	bcmgenet_init_tx_ring(priv, DESC_INDEX, GENET_Q16_TX_BD_CNT,
> +			      TOTAL_DESC - GENET_Q16_TX_BD_CNT, TOTAL_DESC);
> +
>   	/* Set Tx queue priorities */
>   	bcmgenet_tdma_writel(priv, dma_priority[0], DMA_PRIORITY_0);
>   	bcmgenet_tdma_writel(priv, dma_priority[1], DMA_PRIORITY_1);
>   	bcmgenet_tdma_writel(priv, dma_priority[2], DMA_PRIORITY_2);
>   
> -	/* Configure Tx queues as descriptor rings */
> +	/* Configure Tx queues as descriptor rings, including ring 16 */
>   	ring_mask = (1 << (priv->hw_params->tx_queues + 1)) - 1;
> +	ring_mask |= BIT(DESC_INDEX);
>   	bcmgenet_tdma_writel(priv, ring_mask, DMA_RING_CFG);
>   
>   	/* Enable Tx rings */
> @@ -3770,6 +3915,21 @@ static void bcmgenet_get_stats64(struct net_device *dev,
>   		stats->tx_dropped += tx_dropped;
>   	}
>   
> +	/* Include XDP TX ring (DESC_INDEX) stats */
> +	tx_stats = &priv->tx_rings[DESC_INDEX].stats64;
> +	do {
> +		start = u64_stats_fetch_begin(&tx_stats->syncp);
> +		tx_bytes = u64_stats_read(&tx_stats->bytes);
> +		tx_packets = u64_stats_read(&tx_stats->packets);
> +		tx_errors = u64_stats_read(&tx_stats->errors);
> +		tx_dropped = u64_stats_read(&tx_stats->dropped);
> +	} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
> +
> +	stats->tx_bytes += tx_bytes;
> +	stats->tx_packets += tx_packets;
> +	stats->tx_errors += tx_errors;
> +	stats->tx_dropped += tx_dropped;
> +
>   	for (q = 0; q <= priv->hw_params->rx_queues; q++) {
>   		rx_stats = &priv->rx_rings[q].stats64;
>   		do {
> @@ -4273,6 +4433,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
>   		u64_stats_init(&priv->rx_rings[i].stats64.syncp);
>   	for (i = 0; i <= priv->hw_params->tx_queues; i++)
>   		u64_stats_init(&priv->tx_rings[i].stats64.syncp);
> +	u64_stats_init(&priv->tx_rings[DESC_INDEX].stats64.syncp);
>   
>   	/* libphy will determine the link state */
>   	netif_carrier_off(dev);
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index 1459473ac1b0..fce598c29a96 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -472,6 +472,8 @@ struct bcmgenet_rx_stats64 {
>   
>   struct enet_cb {
>   	struct sk_buff      *skb;
> +	struct xdp_frame    *xdpf;
> +	bool                xdp_dma_map;
>   	struct page         *rx_page;
>   	unsigned int        rx_page_offset;
>   	void __iomem *bd_addr;
> @@ -610,7 +612,7 @@ struct bcmgenet_priv {
>   	struct enet_cb *tx_cbs;
>   	unsigned int num_tx_bds;
>   
> -	struct bcmgenet_tx_ring tx_rings[GENET_MAX_MQ_CNT + 1];
> +	struct bcmgenet_tx_ring tx_rings[DESC_INDEX + 1];

This creates a bunch of tx_rings that aren't used. I don't see why we 
need them in the same array. The logic above loops through the queue 
rings, then hits the DESC_INDEX ring last. So not too much value of 
keeping them in the same array.

Thanks,
Justin

>   
>   	/* receive variables */
>   	void __iomem *rx_bds;


