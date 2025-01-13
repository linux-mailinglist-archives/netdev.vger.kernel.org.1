Return-Path: <netdev+bounces-157830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B5EA0BF02
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC013A78F9
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0F1B4135;
	Mon, 13 Jan 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHabkGtg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86641494A7;
	Mon, 13 Jan 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789955; cv=none; b=d3L2gXJh+1YH6dOfrs41iD+TNbWvfB53ifHBXvvKxeWnq7I0mIdEyrOMtcbgaAkuOffyVe0xNcx4ubnejhTSSCzagtRQNV6zqqhMnzss1Su3VxuN01sFTlyICp9DKei1Dj02+sWZPLjzs9X6SaJIbtQHVZ3LmzxpdSuU76nyPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789955; c=relaxed/simple;
	bh=gQO929TF1zG4isHV+Ba2Rq5IQvrjzSjfb92qIyMfByY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSTSfXDnYK0wKXXDpACbokjS6DDrDmbpY38QO5KLyDbhbf5otkTszMuY4KMbtEu17BkemsS4k8SoGzno3yXRaD313Up01shEJ9uTmNO2owI5j8EkMzp/rF/RC6UtH1VRNaosyro6UWyamueMFkTwiTD3Vn384ljD6nxQSp7DejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHabkGtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A83C4CED6;
	Mon, 13 Jan 2025 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736789955;
	bh=gQO929TF1zG4isHV+Ba2Rq5IQvrjzSjfb92qIyMfByY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHabkGtgN29J8ZSfisP47q69iaLm5PM59Nr1dEy0Tt2FyWPEYsA+0WgTlvfOLoX8Q
	 UA8vWvhrEo8Yh9CUtBKNB+o0Q38kpo7tOLFE4oOpFdyv5nW3mdovZUz80K6VbJb4wI
	 WH7kfTOn+XtWTjhSDr4TFmUHnr5Kbr7Ay+P6sd9Qg70kl7gOKPN2wGURNCpKg6xc7I
	 2waTjRoC4IsmlL0/svh79xMrRiocfGS04bbcBOZSHyid9J2yO3Yjw5Fk0lLKRHqEIx
	 gVpuhH438kbnJfEb++BgeqqvydV1ERyq09QSJN/a0YhhAgw/sd3T9a42qN4730o6YI
	 eIsnTkobrjYpA==
Date: Mon, 13 Jan 2025 17:39:10 +0000
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] net: xilinx: axienet: Get coalesce
 parameters from driver state
Message-ID: <20250113173910.GF5497@kernel.org>
References: <20250110192616.2075055-1-sean.anderson@linux.dev>
 <20250110192616.2075055-6-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110192616.2075055-6-sean.anderson@linux.dev>

On Fri, Jan 10, 2025 at 02:26:15PM -0500, Sean Anderson wrote:
> The cr variables now contain the same values as the control registers
> themselves. Extract/calculate the values from the variables instead of
> saving the user-specified values. This allows us to remove some
> bookeeping, and also lets the user know what the actual coalesce
> settings are.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Reviewed by: Shannon Nelson <shannon.nelson@amd.com>

Hi Sean,

Unfortunately this series does not appear to apply cleanly to net-next.
Which is our CI is currently unable to cope with :(

Please consider rebasing and reposting.

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - New
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  8 ---
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 70 +++++++++++++------
>  2 files changed, 47 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 6b8e550c2155..45d8d80dbb1a 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -533,10 +533,6 @@ struct skbuf_dma_descriptor {
>   *		  supported, the maximum frame size would be 9k. Else it is
>   *		  1522 bytes (assuming support for basic VLAN)
>   * @rxmem:	Stores rx memory size for jumbo frame handling.
> - * @coalesce_count_rx:	Store the irq coalesce on RX side.
> - * @coalesce_usec_rx:	IRQ coalesce delay for RX
> - * @coalesce_count_tx:	Store the irq coalesce on TX side.
> - * @coalesce_usec_tx:	IRQ coalesce delay for TX
>   * @use_dmaengine: flag to check dmaengine framework usage.
>   * @tx_chan:	TX DMA channel.
>   * @rx_chan:	RX DMA channel.
> @@ -615,10 +611,6 @@ struct axienet_local {
>  	u32 max_frm_size;
>  	u32 rxmem;
>  
> -	u32 coalesce_count_rx;
> -	u32 coalesce_usec_rx;
> -	u32 coalesce_count_tx;
> -	u32 coalesce_usec_tx;
>  	u8  use_dmaengine;
>  	struct dma_chan *tx_chan;
>  	struct dma_chan *rx_chan;

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c

...

> @@ -260,6 +264,23 @@ static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
>  	return cr;
>  }
>  
> +/**
> + * axienet_cr_params() - Extract coalesce parameters from the CR

nit: axienet_coalesce_params

> + * @lp: Device private data
> + * @cr: The control register to parse
> + * @count: Number of packets before an interrupt
> + * @usec: Idle time (in usec) before an interrupt
> + */
> +static void axienet_coalesce_params(struct axienet_local *lp, u32 cr,
> +				    u32 *count, u32 *usec)
> +{
> +	u64 clk_rate = axienet_dma_rate(lp);
> +	u64 timer = FIELD_GET(XAXIDMA_DELAY_MASK, cr);
> +
> +	*count = FIELD_GET(XAXIDMA_COALESCE_MASK, cr);
> +	*usec = DIV64_U64_ROUND_CLOSEST(timer * XAXIDMA_DELAY_SCALE, clk_rate);
> +}
> +
>  /**
>   * axienet_dma_start - Set up DMA registers and start DMA operation
>   * @lp:		Pointer to the axienet_local structure

