Return-Path: <netdev+bounces-189763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D32AB3958
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572573B70B6
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CF0293743;
	Mon, 12 May 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTxn49JH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2BB5674E;
	Mon, 12 May 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056827; cv=none; b=ZwAPQdwU1ylP7tciOF9lvaZ/0FDD1E/dCAdbl7FMnsvxVsYNXo3IEARkd21vOmLdhbUoa3eOwEuHnFfh6rfKMoRJjViiVInxznz0fdKf3Ki0eRXKtQgiMd7/Twi/uu+YIoLK1Hu4rwuKtmmaJ217vwrky7IW4UfuE/SZIkrSoTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056827; c=relaxed/simple;
	bh=OSuhz6e6dWLHgaJVphGkxlbYoGHl5jGwOBDIywZ3Y+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuIoI+BWhagOjZ6k53qDDtJFJJuvm9lsA77oBvohEYZ9cKM4eU+qEpGroJ93N+C2mDpTuubn3iHLBn6f9098BhWnieGkbW2jvRz6HeV65rcx50Pd2gTqJbrwmKtmchaA00cGJ0D05FiG63PEEpKk6hfLvOlsEKtOLf2VEc4gvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTxn49JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5B9C4CEE7;
	Mon, 12 May 2025 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747056827;
	bh=OSuhz6e6dWLHgaJVphGkxlbYoGHl5jGwOBDIywZ3Y+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTxn49JHIXPhIbCuuiv+9AmgFbzDFHaISnc8qvXkrAFUEKgumncOY6oMUsqAGbaYw
	 7cZtl41uGkvMgncv8oLMjGidAWp2Ldjkj2nsM9OHDxTdFhxjXzq6G8rrqE7+1iSa36
	 NFl23db7pTc/PBBGp+YylsBcHHiv7RC6TlsTm1m2HHz7goXJnD/MevXpx2nhQ4uFgb
	 bzQn+T+60WJYVEiawF4RFFKz9t7zA0sSelsQ3AZ1UMsnz/JH7EhZe+1iOGjjgo51Zn
	 Nu361r8xEoe52fIPJfRpkWjfCARz7khX954eeyHpkWrKFA5dB6rxnWf8KwPQQkHu4q
	 kgnWRv2Bt7Nrw==
Date: Mon, 12 May 2025 14:33:42 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: airoha: Add the capability to
 allocate hw buffers in SRAM
Message-ID: <20250512133342.GB3339421@horms.kernel.org>
References: <20250509-airopha-desc-sram-v2-0-9dc3d8076dfb@kernel.org>
 <20250509-airopha-desc-sram-v2-2-9dc3d8076dfb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-airopha-desc-sram-v2-2-9dc3d8076dfb@kernel.org>

On Fri, May 09, 2025 at 04:51:34PM +0200, Lorenzo Bianconi wrote:
> In order to improve packet processing and packet forwarding
> performances, EN7581 SoC supports allocating buffers for hw forwarding
> queues in SRAM instead of DRAM if available on the system.
> Rely on SRAM for buffers allocation if available on the system and use
> DRAM as fallback.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 57 +++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c

...

> @@ -1088,12 +1091,45 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
>  
>  	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
>  
> -	size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
> -	qdma->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
> -					   GFP_KERNEL);
> -	if (!qdma->hfwd.q)
> +	name = devm_kasprintf(eth->dev, GFP_KERNEL, "qdma%d-buf", id);
> +	if (!name)
>  		return -ENOMEM;
>  
> +	index = of_property_match_string(eth->dev->of_node,
> +					 "memory-region-names", name);
> +	if (index >= 0) { /* buffers in sram */
> +		struct reserved_mem *rmem;
> +		struct device_node *np;
> +		void *q;
> +
> +		np = of_parse_phandle(eth->dev->of_node, "memory-region",
> +				      index);
> +		if (!np)
> +			return -ENODEV;
> +
> +		rmem = of_reserved_mem_lookup(np);
> +		of_node_put(np);
> +
> +		/* SRAM is actual memory and supports transparent access just
> +		 * like DRAM. Hence we don't require __iomem being set and
> +		 * we don't need to use accessor routines to read from or write
> +		 * to SRAM.
> +		 */

Thanks for this comment. IMHO It is really useful.

> +		q = (void __force *)devm_ioremap(eth->dev, rmem->base,
> +						 rmem->size);
> +		if (!q)
> +			return -ENOMEM;
> +
> +		qdma->hfwd.q = q;
> +		dma_addr = rmem->base;
> +	} else {
> +		size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
> +		qdma->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
> +						   GFP_KERNEL);
> +		if (!qdma->hfwd.q)
> +			return -ENOMEM;
> +	}
> +
>  	airoha_qdma_wr(qdma, REG_FWD_BUF_BASE, dma_addr);
>  
>  	airoha_qdma_rmw(qdma, REG_HW_FWD_DSCP_CFG,

...

