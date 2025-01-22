Return-Path: <netdev+bounces-160278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D6A191EC
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC487A119A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F132212FB0;
	Wed, 22 Jan 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV2wpxuX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21055212FA7;
	Wed, 22 Jan 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550680; cv=none; b=WntDFoQB9NIfn0upl1Vupbnf5worfiGhhlMLb9a2hg9tvooDT7Pc1IfsNi5DColj2R3DZWvoZ+SjnSA+yKmZWkoewHZcc9sOtUV5Ka7/XsMS8cPzxI33oOOichPpxQtLZ7Mdb+mMhCiyMrbQOAhrfGixxdXqiiD3lkcqKDkEO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550680; c=relaxed/simple;
	bh=Luqk0JrthNbCxrW6b5dpOym7Wx98y0qRW4AUnYMH5dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDFj57zjPpDkE+pSKTtUoibxynRm3mAEV2pLM0H3+JjFg2FTjjBorhaJYT9+l+lO3QfV0S0mN89Rkx8p0WG9n/4HO/rUlqs8q98r6P4Mf9eb8TyjU1wfBfhd2yRIJAqhaI7d9fDeyQk08aH3+F+M3vlK0UmmBHEcunZSHFO0yi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dV2wpxuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A74AC4CEE0;
	Wed, 22 Jan 2025 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737550679;
	bh=Luqk0JrthNbCxrW6b5dpOym7Wx98y0qRW4AUnYMH5dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dV2wpxuXzdjRdn+1hNlMvtSfw32x1/CGZwFmRYgMVY9xFrH1qIK+/omHiXGhCCTKC
	 Xtut0jFiCz3V338AvruDUwkRXvGFXM5AZtyDCCDxh0Up6FfkD1ZDcLQcisK9uzdjZX
	 6IgOHUK5rXHjsCUfD14SdMoacbJikZPxHqO6j64beQGdXdeHammN/HlsROrqAhaeQF
	 0wUzjSJN98+Uh+T6beKhS3bhsa37KNKsEy64z9yoU9HnRZyOmd4/QB2zIl1NVBwZ0f
	 7rCjVUkIaY1ANtYdcdcGqouXVEP0fXDNIhX73AqO+NNJ2scaUfUjvg4Aen6AwFkOp2
	 5H/uvzRjxhQvw==
Date: Wed, 22 Jan 2025 12:57:55 +0000
From: Simon Horman <horms@kernel.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fec: remove unnecessary DMA mapping of TSO
 header
Message-ID: <20250122125755.GD390877@kernel.org>
References: <20250122104307.138659-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122104307.138659-1-dheeraj.linuxdev@gmail.com>

On Wed, Jan 22, 2025 at 04:13:07PM +0530, Dheeraj Reddy Jonnalagadda wrote:
> The TSO header buffer is pre-allocated DMA memory, so there's no need to
> map it again with dma_map_single() in fec_enet_txq_put_hdr_tso(). Remove
> this redundant mapping operation.
> 
> Fixes: 79f339125ea3 ("net: fec: Add software TSO support")
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 68725506a095..039de4c5044e 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -805,15 +805,6 @@ fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q *txq,
>  
>  		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
>  			swap_buffer(bufaddr, hdr_len);
> -
> -		dmabuf = dma_map_single(&fep->pdev->dev, bufaddr,
> -					hdr_len, DMA_TO_DEVICE);
> -		if (dma_mapping_error(&fep->pdev->dev, dmabuf)) {
> -			dev_kfree_skb_any(skb);
> -			if (net_ratelimit())
> -				netdev_err(ndev, "Tx DMA memory map failed\n");
> -			return NETDEV_TX_OK;
> -		}
>  	}
>  
>  	bdp->cbd_bufaddr = cpu_to_fec32(dmabuf);

Hi Dheeraj,

It seems to me that at this point of execution, without your patch, dmabuf
can be one of two values:

	1. txq->tso_hdrs_dma + index * TSO_HEADER_SIZE
	   This is the default case.

	2. txq->tx_bounce[index]
	   This is the special case, which is handed in the conditional
	   block that your patch updates.

In case 1, I agree that tso_hdrs_dma is already mapped.
But this case is not affected by your patch as the
conditional block that includes dma_map_single() is not executed.

In case 2, I do not see where txq->tx_bounce[index] is already mapped.

Am I missing something?

