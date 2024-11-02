Return-Path: <netdev+bounces-141212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811829BA0F8
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0CD1F216F9
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D1A18732C;
	Sat,  2 Nov 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="mnGoza7Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328678C9C;
	Sat,  2 Nov 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730559861; cv=none; b=Z73fTX5RBk1lbx/fONCjOFvAqVQO7+A5jCFyyk6tNaVwpaBA0Pt+VmU7Zo1gyQiTDb9zBkg1dP6CnZDPd9xjbkjFPnoRz1hIVjaxafzIx1dBIWGeVDz9BxR1EPCfSRLIV+wuqU0S9i9U33PFfopMNyvZa0oqCjQuZEdTC+76f5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730559861; c=relaxed/simple;
	bh=EsGsjnqrfynpSrhR2eT/7AHQ5QoQ/0kxHFpvQqKy2kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mc7FsPb65+znGORm5ldAMpdvnGMFGcChfYKZ9kn2kGxNwm8gINoYz8tOuQMxK+GHxjWD4XDycdd6Wlwr55kj9jhxaGId26hAVYk12OSJfg9Jpp9gyJRXhmCNIhhBX0sGGsZ56ApwaNoZQQFPvk3vv5HsTtIyJdSL/eMM0SGv++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=mnGoza7Y; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=KfcuEkTFDbnsEB2eizo+OjJRdsfLQdG03Z+BJy1Mb3Q=; b=mnGoza7YqL81lege
	clQ5v6luCe3L9zgsXQilreOKnPBBPjANs4Evmsx7SY+nK3X+fZiB+m2Qxiczu5Ug70k0xgf3k9oak
	+3oqGRNYKEqWcWpI8zMP8lpLsDy9W8FcyRCZAdqWGcsQ36vWqh9f+BG+2lZ+XWufGhONYFT44bTHb
	npcmt7gvIT5ylmv/TIUO+ADykD4HFiebnu/EyH3mK5BQz7uYgc0zcDd3gc4meV+oYuhb+BJKU0r1g
	bVPxQROp7787KGHdvj4hBXKeRqCfP7m8y9WqtcFnWzevjRMIA2VEfmpw2Il8Om5AwseUqY19WBJgy
	UNxzibbLbnz75VGgrw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t7Ffe-00F6OU-3A;
	Sat, 02 Nov 2024 15:04:10 +0000
Date: Sat, 2 Nov 2024 15:04:10 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sfc: Remove deadcode
Message-ID: <ZyY_avQn4yuj6WC3@gallifrey>
References: <20241102143317.24745-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241102143317.24745-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:03:46 up 178 days,  2:17,  1 user,  load average: 0.00, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> ef4_farch_dimension_resources(), ef4_nic_fix_nodesc_drop_stat(),
> ef4_ticks_to_usecs() and ef4_tx_get_copy_buffer_limited() were
> copied over from efx_ equivalents in 2016 but never used by
> commit 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into new
> sfc-falcon driver")
> 
> EF4_MAX_FLUSH_TIME is also unused.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Actually, NAK this copy; I'll resend it in a minute
as part of a series with a whole load more.

Dave

> ---
>  drivers/net/ethernet/sfc/falcon/efx.c   |  8 --------
>  drivers/net/ethernet/sfc/falcon/efx.h   |  1 -
>  drivers/net/ethernet/sfc/falcon/farch.c | 22 ----------------------
>  drivers/net/ethernet/sfc/falcon/nic.c   | 11 -----------
>  drivers/net/ethernet/sfc/falcon/nic.h   |  5 -----
>  drivers/net/ethernet/sfc/falcon/tx.c    |  8 --------
>  drivers/net/ethernet/sfc/falcon/tx.h    |  3 ---
>  7 files changed, 58 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
> index 8925745f1c17..b07f7e4e2877 100644
> --- a/drivers/net/ethernet/sfc/falcon/efx.c
> +++ b/drivers/net/ethernet/sfc/falcon/efx.c
> @@ -1886,14 +1886,6 @@ unsigned int ef4_usecs_to_ticks(struct ef4_nic *efx, unsigned int usecs)
>  	return usecs * 1000 / efx->timer_quantum_ns;
>  }
>  
> -unsigned int ef4_ticks_to_usecs(struct ef4_nic *efx, unsigned int ticks)
> -{
> -	/* We must round up when converting ticks to microseconds
> -	 * because we round down when converting the other way.
> -	 */
> -	return DIV_ROUND_UP(ticks * efx->timer_quantum_ns, 1000);
> -}
> -
>  /* Set interrupt moderation parameters */
>  int ef4_init_irq_moderation(struct ef4_nic *efx, unsigned int tx_usecs,
>  			    unsigned int rx_usecs, bool rx_adaptive,
> diff --git a/drivers/net/ethernet/sfc/falcon/efx.h b/drivers/net/ethernet/sfc/falcon/efx.h
> index d3b4646545fa..52508f2c8cb2 100644
> --- a/drivers/net/ethernet/sfc/falcon/efx.h
> +++ b/drivers/net/ethernet/sfc/falcon/efx.h
> @@ -198,7 +198,6 @@ int ef4_try_recovery(struct ef4_nic *efx);
>  /* Global */
>  void ef4_schedule_reset(struct ef4_nic *efx, enum reset_type type);
>  unsigned int ef4_usecs_to_ticks(struct ef4_nic *efx, unsigned int usecs);
> -unsigned int ef4_ticks_to_usecs(struct ef4_nic *efx, unsigned int ticks);
>  int ef4_init_irq_moderation(struct ef4_nic *efx, unsigned int tx_usecs,
>  			    unsigned int rx_usecs, bool rx_adaptive,
>  			    bool rx_may_override_tx);
> diff --git a/drivers/net/ethernet/sfc/falcon/farch.c b/drivers/net/ethernet/sfc/falcon/farch.c
> index c64623c2e80c..01017c41338e 100644
> --- a/drivers/net/ethernet/sfc/falcon/farch.c
> +++ b/drivers/net/ethernet/sfc/falcon/farch.c
> @@ -1631,28 +1631,6 @@ void ef4_farch_rx_push_indir_table(struct ef4_nic *efx)
>  	}
>  }
>  
> -/* Looks at available SRAM resources and works out how many queues we
> - * can support, and where things like descriptor caches should live.
> - *
> - * SRAM is split up as follows:
> - * 0                          buftbl entries for channels
> - * efx->vf_buftbl_base        buftbl entries for SR-IOV
> - * efx->rx_dc_base            RX descriptor caches
> - * efx->tx_dc_base            TX descriptor caches
> - */
> -void ef4_farch_dimension_resources(struct ef4_nic *efx, unsigned sram_lim_qw)
> -{
> -	unsigned vi_count;
> -
> -	/* Account for the buffer table entries backing the datapath channels
> -	 * and the descriptor caches for those channels.
> -	 */
> -	vi_count = max(efx->n_channels, efx->n_tx_channels * EF4_TXQ_TYPES);
> -
> -	efx->tx_dc_base = sram_lim_qw - vi_count * TX_DC_ENTRIES;
> -	efx->rx_dc_base = efx->tx_dc_base - vi_count * RX_DC_ENTRIES;
> -}
> -
>  u32 ef4_farch_fpga_ver(struct ef4_nic *efx)
>  {
>  	ef4_oword_t altera_build;
> diff --git a/drivers/net/ethernet/sfc/falcon/nic.c b/drivers/net/ethernet/sfc/falcon/nic.c
> index 78c851b5a56f..1b91992e3698 100644
> --- a/drivers/net/ethernet/sfc/falcon/nic.c
> +++ b/drivers/net/ethernet/sfc/falcon/nic.c
> @@ -511,14 +511,3 @@ void ef4_nic_update_stats(const struct ef4_hw_stat_desc *desc, size_t count,
>  		}
>  	}
>  }
> -
> -void ef4_nic_fix_nodesc_drop_stat(struct ef4_nic *efx, u64 *rx_nodesc_drops)
> -{
> -	/* if down, or this is the first update after coming up */
> -	if (!(efx->net_dev->flags & IFF_UP) || !efx->rx_nodesc_drops_prev_state)
> -		efx->rx_nodesc_drops_while_down +=
> -			*rx_nodesc_drops - efx->rx_nodesc_drops_total;
> -	efx->rx_nodesc_drops_total = *rx_nodesc_drops;
> -	efx->rx_nodesc_drops_prev_state = !!(efx->net_dev->flags & IFF_UP);
> -	*rx_nodesc_drops -= efx->rx_nodesc_drops_while_down;
> -}
> diff --git a/drivers/net/ethernet/sfc/falcon/nic.h b/drivers/net/ethernet/sfc/falcon/nic.h
> index ada6e036fd97..ac10c12967df 100644
> --- a/drivers/net/ethernet/sfc/falcon/nic.h
> +++ b/drivers/net/ethernet/sfc/falcon/nic.h
> @@ -477,7 +477,6 @@ void ef4_farch_finish_flr(struct ef4_nic *efx);
>  void falcon_start_nic_stats(struct ef4_nic *efx);
>  void falcon_stop_nic_stats(struct ef4_nic *efx);
>  int falcon_reset_xaui(struct ef4_nic *efx);
> -void ef4_farch_dimension_resources(struct ef4_nic *efx, unsigned sram_lim_qw);
>  void ef4_farch_init_common(struct ef4_nic *efx);
>  void ef4_farch_rx_push_indir_table(struct ef4_nic *efx);
>  
> @@ -502,10 +501,6 @@ size_t ef4_nic_describe_stats(const struct ef4_hw_stat_desc *desc, size_t count,
>  void ef4_nic_update_stats(const struct ef4_hw_stat_desc *desc, size_t count,
>  			  const unsigned long *mask, u64 *stats,
>  			  const void *dma_buf, bool accumulate);
> -void ef4_nic_fix_nodesc_drop_stat(struct ef4_nic *efx, u64 *stat);
> -
> -#define EF4_MAX_FLUSH_TIME 5000
> -
>  void ef4_farch_generate_event(struct ef4_nic *efx, unsigned int evq,
>  			      ef4_qword_t *event);
>  
> diff --git a/drivers/net/ethernet/sfc/falcon/tx.c b/drivers/net/ethernet/sfc/falcon/tx.c
> index b9369483758c..e6e80b039ca2 100644
> --- a/drivers/net/ethernet/sfc/falcon/tx.c
> +++ b/drivers/net/ethernet/sfc/falcon/tx.c
> @@ -40,14 +40,6 @@ static inline u8 *ef4_tx_get_copy_buffer(struct ef4_tx_queue *tx_queue,
>  	return (u8 *)page_buf->addr + offset;
>  }
>  
> -u8 *ef4_tx_get_copy_buffer_limited(struct ef4_tx_queue *tx_queue,
> -				   struct ef4_tx_buffer *buffer, size_t len)
> -{
> -	if (len > EF4_TX_CB_SIZE)
> -		return NULL;
> -	return ef4_tx_get_copy_buffer(tx_queue, buffer);
> -}
> -
>  static void ef4_dequeue_buffer(struct ef4_tx_queue *tx_queue,
>  			       struct ef4_tx_buffer *buffer,
>  			       unsigned int *pkts_compl,
> diff --git a/drivers/net/ethernet/sfc/falcon/tx.h b/drivers/net/ethernet/sfc/falcon/tx.h
> index 2a88c59cbbbe..868ed8a861ab 100644
> --- a/drivers/net/ethernet/sfc/falcon/tx.h
> +++ b/drivers/net/ethernet/sfc/falcon/tx.h
> @@ -15,9 +15,6 @@
>  unsigned int ef4_tx_limit_len(struct ef4_tx_queue *tx_queue,
>  			      dma_addr_t dma_addr, unsigned int len);
>  
> -u8 *ef4_tx_get_copy_buffer_limited(struct ef4_tx_queue *tx_queue,
> -				   struct ef4_tx_buffer *buffer, size_t len);
> -
>  int ef4_enqueue_skb_tso(struct ef4_tx_queue *tx_queue, struct sk_buff *skb,
>  			bool *data_mapped);
>  
> -- 
> 2.47.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

