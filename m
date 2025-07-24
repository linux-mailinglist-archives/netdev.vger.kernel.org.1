Return-Path: <netdev+bounces-209726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68262B109B6
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988775A450D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCAC2BE641;
	Thu, 24 Jul 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbPBNnPM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595A2BE63B;
	Thu, 24 Jul 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358247; cv=none; b=Pwnrxi5AqBptENBSWTVwZc4Gk0bu9QK050nxQ5tYYbtbMblx2uK1oTCWGYl+VM1Px9JWhLDsgG+miiaI1mGwLDh+nB30mGyu8LF6bb9Q7qb5aquL4chxZLK7uym2jcrHQOpr6SnEsG6k5tjip5pPww8gBreG7E6/lgk/UrgqT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358247; c=relaxed/simple;
	bh=OOUZVsJeWP+Qw+0ZqMy9T6QfTUzFRI5SsUl6yJPkwuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3jeFqb2o1H+HQy3+shPaqI5F0aVwltgkBYkBAz6IuKHDzWp4whlE2q5aoaHZzNllBlo9dSrSwxW7p/yXoWUMKIgswUPF/l8w6SsqDfF9j5YDmEQiirhJUP5xODwjAe52kBFugM/vFeCx/MMcDYmfxTLdymFc13vsbuk0K7a44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbPBNnPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2427C4CEED;
	Thu, 24 Jul 2025 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753358247;
	bh=OOUZVsJeWP+Qw+0ZqMy9T6QfTUzFRI5SsUl6yJPkwuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbPBNnPMd9CQJbFD+wF/XwPOMSvfEa13xkfQdg7FNh3mXe34+lpmGsbTuXR6/2kdC
	 /CRz1b/eE0Zx1tGfbJv/uhg3M2d6h8K5lS+U7FIvSpIX8nTfZyyWubusBiFUuoXr3G
	 MxXEXBfxWk1li2FULl3Iy91tkt01vyGLsvXeEgz73NrW6d6dZg7wXWfkMncpjo9Bpj
	 /P3frzjpd0uTN5gACMNcVn0saMH0ZftNPvPq1Cc3lhdbiVf2tznKehXIqmuTpFkqkG
	 xfCy/lSfHVUQm0obWPTrXjjtWCgcJxPEPWml9WvT/6N1meNdHMfIC+P1Rg4MzMuL0X
	 wOptQB6dqGqgw==
Date: Thu, 24 Jul 2025 12:57:22 +0100
From: Simon Horman <horms@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, willemb@google.com, pkaligineedi@google.com,
	joshwash@google.com, linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Ziwei Xiao <ziweixiao@google.com>
Subject: Re: [PATCH net-next] gve: support unreadable netmem
Message-ID: <20250724115722.GK1150792@horms.kernel.org>
References: <20250723222829.3528565-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723222829.3528565-1-hramamurthy@google.com>

On Wed, Jul 23, 2025 at 10:28:29PM +0000, Harshitha Ramamurthy wrote:

...

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c

...

> @@ -793,13 +811,19 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
>  		rx->rx_hsplit_unsplit_pkt += unsplit;
>  		rx->rx_hsplit_bytes += hdr_len;
>  		u64_stats_update_end(&rx->statss);
> +	} else if (!rx->ctx.skb_head && rx->dqo.page_pool &&
> +		   netmem_is_net_iov(buf_state->page_info.netmem)) {
> +		/* when header split is disabled, the header went to the packet
> +		 * buffer. If the packet buffer is a net_iov, those can't be
> +		 * easily mapped into the kernel space to access the header
> +		 * required to process the packet.
> +		 */
> +		gve_free_buffer(rx, buf_state);
> +		return -EFAULT;

nit: I think it would be nice to consistently handle error paths
     in this function using goto error.

>  	}
>  
>  	/* Sync the portion of dma buffer for CPU to read. */
> -	dma_sync_single_range_for_cpu(&priv->pdev->dev, buf_state->addr,
> -				      buf_state->page_info.page_offset +
> -				      buf_state->page_info.pad,
> -				      buf_len, DMA_FROM_DEVICE);
> +	gve_dma_sync(priv, rx, buf_state, buf_len);
>  
>  	/* Append to current skb if one exists. */
>  	if (rx->ctx.skb_head) {

