Return-Path: <netdev+bounces-103675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA9990904E
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2482815AF
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFA135280;
	Fri, 14 Jun 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G97+Wiom"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B901AB52F;
	Fri, 14 Jun 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382655; cv=none; b=Q6bdb/J6At1354OROgt0A8OnqSAAI0zfcO9RlMm5wPud8Tz5t8kcqFwZiuv98bdGAyriIQh3gosjIzzpzXAON6PqJe4wfm47u893Q5bNQvCg2AvccSHn4d6PNrdFpajR6YOj0guSlArhnyeA+DW/AkETswuuC6mSB5Vau6E93oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382655; c=relaxed/simple;
	bh=4uMCD3nfnmamh+k914AZ9iNaZiZ2iLQY8YW/o+RixDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5C52zVAxnSjtw0PQkxovg0AsF3Jg0x9KEz7INN9x4veFoOPKHrrEAzPXFM5Vb0ZQvHY/CduEiS/mH8RCacivftLbVmFCmb2ewJHaPZqe8EbnJHUQU01RP3KJJ+l3wtBRqWA7xZGqb9TcWzpDyPWA61ZXG5sIsj1toXfQ7MvboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G97+Wiom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE24C2BD10;
	Fri, 14 Jun 2024 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718382654;
	bh=4uMCD3nfnmamh+k914AZ9iNaZiZ2iLQY8YW/o+RixDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G97+WiomIY+D1ScJvy+hWtvGznEx91P7NiLKw1qcgJ99tAQHrmn62kfqKjwz4Huqw
	 zaXjNqnM0oar5JZ7AMC7V/J1HJUrYj7k1XtSqxMtS10HyfX75UoUSU8Sx/Ikv000nE
	 MlJ6HJG/MCsjPIbCra2j5XPn6Boxj+1YQHyWsoEVTjgPX8t0JH42QF1DjbXySDIz2Z
	 YzkOil7NFjfE8zjaqOoWuhUYqNFp6ayy36oq0G3/WAQ4HDQ9fjwrIsMfqZQpBGtAoC
	 bas4pGTLt4b9shevSwSOMi1ixt4IUQS11CBozeMN9sOKI9bRwP5/OQDu8mAPTIaw/i
	 Chgx66MC+MT1Q==
Date: Fri, 14 Jun 2024 17:30:50 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/3] net: xilinx: axienet: Add statistics support
Message-ID: <20240614163050.GV8447@kernel.org>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610231022.2460953-4-sean.anderson@linux.dev>

On Mon, Jun 10, 2024 at 07:10:22PM -0400, Sean Anderson wrote:
> Add support for reading the statistics counters, if they are enabled.
> The counters may be 64-bit, but we can't detect this as there's no
> ability bit for it and the counters are read-only. Therefore, we assume
> the counters are 32-bits. To ensure we don't miss an overflow, we need
> to read all counters at regular intervals, configurable with
> stats-block-usecs. This should be often enough to ensure the bytes
> counters don't wrap at 2.5 Gbit/s.
> 
> Another complication is that the counters may be reset when the device
> is reset (depending on configuration). To ensure the counters persist
> across link up/down (including suspend/resume), we maintain our own
> 64-bit versions along with the last counter value we saw. Because we
> might wait up to 100 ms for the reset to complete, we use a mutex to
> protect writing hw_stats. We can't sleep in ndo_get_stats64, so we use a
> u64_stats_sync to protect readers.
> 
> We can't use the byte counters for either get_stats64 or
> get_eth_mac_stats. This is because the byte counters include everything
> in the frame (destination address to FCS, inclusive). But
> rtnl_link_stats64 wants bytes excluding the FCS, and
> ethtool_eth_mac_stats wants to exclude the L2 overhead (addresses and
> length/type).
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  81 ++++++
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 267 +++++++++++++++++-
>  2 files changed, 345 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h

...

> @@ -434,6 +502,11 @@ struct skbuf_dma_descriptor {
>   * @tx_packets: TX packet count for statistics
>   * @tx_bytes:	TX byte count for statistics
>   * @tx_stat_sync: Synchronization object for TX stats
> + * @hw_last_counter: Last-seen value of each statistic
> + * @hw_stats: Interface statistics periodically updated from hardware counters
> + * @hw_stats_sync: Synchronization object for @hw_stats

nit: s/hw_stats_sync/hw_stat_sync/

     Flagged by kernel-doc -none

> + * @stats_lock: Lock for writing @hw_stats and @hw_last_counter
> + * @stats_work: Work for reading the hardware statistics counters
>   * @dma_err_task: Work structure to process Axi DMA errors
>   * @tx_irq:	Axidma TX IRQ number
>   * @rx_irq:	Axidma RX IRQ number
> @@ -452,6 +525,7 @@ struct skbuf_dma_descriptor {
>   * @coalesce_usec_rx:	IRQ coalesce delay for RX
>   * @coalesce_count_tx:	Store the irq coalesce on TX side.
>   * @coalesce_usec_tx:	IRQ coalesce delay for TX
> + * @coalesce_usec_stats: Delay between hardware statistics refreshes
>   * @use_dmaengine: flag to check dmaengine framework usage.
>   * @tx_chan:	TX DMA channel.
>   * @rx_chan:	RX DMA channel.
> @@ -505,6 +579,12 @@ struct axienet_local {
>  	u64_stats_t tx_bytes;
>  	struct u64_stats_sync tx_stat_sync;
>  
> +	u32 hw_last_counter[STAT_COUNT];
> +	u64_stats_t hw_stats[STAT_COUNT];
> +	struct u64_stats_sync hw_stat_sync;
> +	struct mutex stats_lock;
> +	struct delayed_work stats_work;
> +
>  	struct work_struct dma_err_task;
>  
>  	int tx_irq;

...

