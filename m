Return-Path: <netdev+bounces-158049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD303A10414
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E651889BC3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB36229631;
	Tue, 14 Jan 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VZjs97Mu"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE7229608
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850537; cv=none; b=RnHs8xQgAQ2V5U/7SJ2SrdCWq1LFlyng5A+2MZfZ4zMa5Iq8AT7oZ/JrCvZYj7kz+i0gQFUaNEfQz4qT+S0R9qqIoRTyXjXTvtmNJLtRIJPQn19ZUHfHi5is3k3+oLX429kQ/C6egL4S2KPRupG/Tp+N8o8sa5A+r1WEWA9phHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850537; c=relaxed/simple;
	bh=n2l7BWhqvtnFO/M/5tbRyURTjxjEc4vCUxCyj7fNTkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM7RKQPHeQKODvN2AH1e6rXwj2BFPktkeyLbkoe+vObwUOMHTPbMR15uw/TKZyLPefW/5WiyT6+s/aWm4Z1O0oqGhiXkAh4DraLd5vdvvbLR2zd+4gZHZPZnK+ZgZRX0ed/QscFDBoIgsK46LTNYbmtCwkMVgxUA6qmdhFz4b0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VZjs97Mu; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e0a045b1-3c13-4354-9948-56f304cc1e72@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736850527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xMvj8mj+i509qrtEojaQcoXNPZSXcusfRCFWfjC6vE=;
	b=VZjs97Mu9ZGzxwxaIC+dv1Cf64tcjhP+nhe9E1053nLejA2xFdxSCRQrUAvrus05uIqojR
	1lk1IokyDorDx25eh5+m3QMYkTRaIWal8HcqdchM5SHN/j/4XooAp3dKIJii3BCiWyRoHk
	ukUxbhKx/cmYpSNkvJtk5/BcKFtyVM4=
Date: Tue, 14 Jan 2025 10:28:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 1/4] net: wangxun: Add support for PTP clock
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com
References: <20250114084425.2203428-1-jiawenwu@trustnetic.com>
 <20250114084425.2203428-2-jiawenwu@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250114084425.2203428-2-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/01/2025 08:44, Jiawen Wu wrote:
> Implement support for PTP clock on Wangxun NICs.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>   drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
>   .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   3 +
>   drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  52 +-
>   drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 706 ++++++++++++++++++
>   drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  19 +
>   drivers/net/ethernet/wangxun/libwx/wx_type.h  |  69 ++
>   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   8 +
>   drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  10 +
>   .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  11 +
>   .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   9 +
>   10 files changed, 883 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> index 42ccd6e4052e..e9f0f1f2309b 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,4 +4,4 @@
>   
>   obj-$(CONFIG_LIBWX) += libwx.o
>   
> -libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o
> +libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index abe5921dde02..c4b3b00b0926 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -41,6 +41,9 @@ static const struct wx_stats wx_gstrings_stats[] = {
>   	WX_STAT("rx_csum_offload_good_count", hw_csum_rx_good),
>   	WX_STAT("rx_csum_offload_errors", hw_csum_rx_error),
>   	WX_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),
> +	WX_STAT("tx_hwtstamp_timeouts", tx_hwtstamp_timeouts),
> +	WX_STAT("tx_hwtstamp_skipped", tx_hwtstamp_skipped),
> +	WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
>   };
>   
>   static const struct wx_stats wx_gstrings_fdir_stats[] = {
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 2b3d6586f44a..62c837cd3fb7 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -13,6 +13,7 @@
>   
>   #include "wx_type.h"
>   #include "wx_lib.h"
> +#include "wx_ptp.h"
>   #include "wx_hw.h"
>   
>   /* Lookup table mapping the HW PTYPE to the bit field for decoding */
> @@ -597,8 +598,17 @@ static void wx_process_skb_fields(struct wx_ring *rx_ring,
>   				  union wx_rx_desc *rx_desc,
>   				  struct sk_buff *skb)
>   {
> +	struct wx *wx = netdev_priv(rx_ring->netdev);
> +
>   	wx_rx_hash(rx_ring, rx_desc, skb);
>   	wx_rx_checksum(rx_ring, rx_desc, skb);
> +
> +	if (unlikely(test_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags)) &&
> +	    unlikely(wx_test_staterr(rx_desc, WX_RXD_STAT_TS))) {
> +		wx_ptp_rx_hwtstamp(rx_ring->q_vector->wx, skb);
> +		rx_ring->last_rx_timestamp = jiffies;
> +	}
> +
>   	wx_rx_vlan(rx_ring, rx_desc, skb);
>   	skb_record_rx_queue(skb, rx_ring->queue_index);
>   	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
> @@ -705,6 +715,7 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
>   {
>   	unsigned int budget = q_vector->wx->tx_work_limit;
>   	unsigned int total_bytes = 0, total_packets = 0;
> +	struct wx *wx = netdev_priv(tx_ring->netdev);
>   	unsigned int i = tx_ring->next_to_clean;
>   	struct wx_tx_buffer *tx_buffer;
>   	union wx_tx_desc *tx_desc;
> @@ -737,6 +748,11 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
>   		total_bytes += tx_buffer->bytecount;
>   		total_packets += tx_buffer->gso_segs;
>   
> +		/* schedule check for Tx timestamp */
> +		if (unlikely(test_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state)) &&
> +		    skb_shinfo(tx_buffer->skb)->tx_flags & SKBTX_IN_PROGRESS)
> +			schedule_work(&wx->ptp_tx_work);
> +
>   		/* free the skb */
>   		napi_consume_skb(tx_buffer->skb, napi_budget);
>   
> @@ -932,9 +948,9 @@ static void wx_tx_olinfo_status(union wx_tx_desc *tx_desc,
>   	tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
>   }
>   
> -static void wx_tx_map(struct wx_ring *tx_ring,
> -		      struct wx_tx_buffer *first,
> -		      const u8 hdr_len)
> +static int wx_tx_map(struct wx_ring *tx_ring,
> +		     struct wx_tx_buffer *first,
> +		     const u8 hdr_len)
>   {
>   	struct sk_buff *skb = first->skb;
>   	struct wx_tx_buffer *tx_buffer;
> @@ -1013,6 +1029,8 @@ static void wx_tx_map(struct wx_ring *tx_ring,
>   
>   	netdev_tx_sent_queue(wx_txring_txq(tx_ring), first->bytecount);
>   
> +	/* set the timestamp */
> +	first->time_stamp = jiffies;
>   	skb_tx_timestamp(skb);
>   
>   	/* Force memory writes to complete before letting h/w know there
> @@ -1038,7 +1056,7 @@ static void wx_tx_map(struct wx_ring *tx_ring,
>   	if (netif_xmit_stopped(wx_txring_txq(tx_ring)) || !netdev_xmit_more())
>   		writel(i, tx_ring->tail);
>   
> -	return;
> +	return 0;
>   dma_error:
>   	dev_err(tx_ring->dev, "TX DMA map failed\n");
>   
> @@ -1062,6 +1080,8 @@ static void wx_tx_map(struct wx_ring *tx_ring,
>   	first->skb = NULL;
>   
>   	tx_ring->next_to_use = i;
> +
> +	return -ENOMEM;
>   }
>   
>   static void wx_tx_ctxtdesc(struct wx_ring *tx_ring, u32 vlan_macip_lens,
> @@ -1486,6 +1506,20 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>   		tx_flags |= WX_TX_FLAGS_HW_VLAN;
>   	}
>   
> +	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
> +	    wx->ptp_clock) {
> +		if (wx->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
> +		    !test_and_set_bit_lock(WX_STATE_PTP_TX_IN_PROGRESS,
> +					   wx->state)) {
> +			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +			tx_flags |= WX_TX_FLAGS_TSTAMP;
> +			wx->ptp_tx_skb = skb_get(skb);
> +			wx->ptp_tx_start = jiffies;
> +		} else {
> +			wx->tx_hwtstamp_skipped++;
> +		}
> +	}
> +
>   	/* record initial flags and protocol */
>   	first->tx_flags = tx_flags;
>   	first->protocol = vlan_get_protocol(skb);
> @@ -1501,12 +1535,20 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>   	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags) && tx_ring->atr_sample_rate)
>   		wx->atr(tx_ring, first, ptype);
>   
> -	wx_tx_map(tx_ring, first, hdr_len);
> +	if (wx_tx_map(tx_ring, first, hdr_len))
> +		goto cleanup_tx_tstamp;
>   
>   	return NETDEV_TX_OK;
>   out_drop:
>   	dev_kfree_skb_any(first->skb);
>   	first->skb = NULL;
> +cleanup_tx_tstamp:
> +	if (unlikely(tx_flags & WX_TX_FLAGS_TSTAMP)) {
> +		dev_kfree_skb_any(wx->ptp_tx_skb);
> +		wx->ptp_tx_skb = NULL;
> +		wx->tx_hwtstamp_errors++;
> +		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +	}
>   
>   	return NETDEV_TX_OK;
>   }
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> new file mode 100644
> index 000000000000..97d39e8f02da
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> @@ -0,0 +1,706 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
> +
> +#include <linux/ptp_classify.h>
> +#include <linux/clocksource.h>
> +#include <linux/pci.h>
> +
> +#include "wx_type.h"
> +#include "wx_ptp.h"
> +#include "wx_hw.h"
> +
> +#define WX_INCVAL_10GB        0xCCCCCC
> +#define WX_INCVAL_1GB         0x800000
> +#define WX_INCVAL_100         0xA00000
> +#define WX_INCVAL_10          0xC7F380
> +#define WX_INCVAL_EM          0x2000000
> +
> +#define WX_INCVAL_SHIFT_10GB  20
> +#define WX_INCVAL_SHIFT_1GB   18
> +#define WX_INCVAL_SHIFT_100   15
> +#define WX_INCVAL_SHIFT_10    12
> +#define WX_INCVAL_SHIFT_EM    22
> +
> +#define WX_OVERFLOW_PERIOD    (HZ * 30)
> +#define WX_PTP_TX_TIMEOUT     (HZ)
> +
> +#define WX_1588_PPS_WIDTH_EM  120
> +
> +#define WX_NS_PER_SEC         1000000000ULL
> +
> +/**
> + * wx_ptp_adjfine
> + * @ptp: the ptp clock structure
> + * @ppb: parts per billion adjustment from base
> + * Returns 0 on success
> + *
> + * Adjust the frequency of the ptp cycle counter by the
> + * indicated ppb from the base frequency.
> + */
> +static int wx_ptp_adjfine(struct ptp_clock_info *ptp, long ppb)
> +{
> +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> +	u64 incval, mask;
> +
> +	smp_mb(); /* Force any pending update before accessing. */
> +	incval = READ_ONCE(wx->base_incval);
> +	incval = adjust_by_scaled_ppm(incval, ppb);
> +
> +	mask = (wx->mac.type == wx_mac_em) ? 0x7FFFFFF : 0xFFFFFF;
> +	incval &= mask;
> +	if (wx->mac.type != wx_mac_em)
> +		incval |= 2 << 24;
> +
> +	wr32ptp(wx, WX_TSC_1588_INC, incval);
> +
> +	return 0;
> +}
> +
> +/**
> + * wx_ptp_adjtime
> + * @ptp: the ptp clock structure
> + * @delta: offset to adjust the cycle counter by ns
> + * Returns 0 on success
> + *
> + * Adjust the timer by resetting the timecounter structure.
> + */
> +static int wx_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> +	unsigned long flags;
> +
> +	write_seqlock_irqsave(&wx->hw_tc_lock, flags);
> +	timecounter_adjtime(&wx->hw_tc, delta);
> +	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
> +
> +	return 0;
> +}
> +
> +/**
> + * wx_ptp_gettimex64
> + * @ptp: the ptp clock structure
> + * @ts: timespec structure to hold the current time value
> + * @sts: structure to hold the system time before and after reading the PHC
> + * Returns 0 on success
> + *
> + * Read the timecounter and return the correct value on ns,
> + * after converting it into a struct timespec64.
> + */
> +static int wx_ptp_gettimex64(struct ptp_clock_info *ptp,
> +			     struct timespec64 *ts,
> +			     struct ptp_system_timestamp *sts)
> +{
> +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> +	unsigned long flags;
> +	u64 ns, stamp;
> +
> +	write_seqlock_irqsave(&wx->hw_tc_lock, flags);
> +
> +	ptp_read_system_prets(sts);
> +	stamp = (u64)rd32ptp(wx, WX_TSC_1588_SYSTIML);
> +	ptp_read_system_postts(sts);
> +	stamp |= (u64)rd32ptp(wx, WX_TSC_1588_SYSTIMH) << 32;
> +	ns = timecounter_cyc2time(&wx->hw_tc, stamp);

Another thing here - you don't check for the overflow. This is unusual
pattern. What will happen if WX_TSC_1588_SYSTIMH value will change
between these 2 calls?

Usual pattern for this is to read WX_TSC_1588_SYSTIMH, then read
WX_TSC_1588_SYSTIML, and then read WX_TSC_1588_SYSTIMH again. If 2 reads
of WX_TSC_1588_SYSTIMH are the same, then the value is correct,
otherwise re-read WX_TSC_1588_SYSTIML again. You can find examples of
this template in the other drivers, like mlx5.

> +
> +	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
> +
> +	*ts = ns_to_timespec64(ns);
> +
> +	return 0;
> +}

[...]

> +/**
> + * wx_ptp_convert_to_hwtstamp - convert register value to hw timestamp
> + * @wx: private board structure
> + * @hwtstamp: stack timestamp structure
> + * @timestamp: unsigned 64bit system time value
> + *
> + * We need to convert the adapter's RX/TXSTMP registers into a hwtstamp value
> + * which can be used by the stack's ptp functions.
> + *
> + * The lock is used to protect consistency of the cyclecounter and the SYSTIME
> + * registers. However, it does not need to protect against the Rx or Tx
> + * timestamp registers, as there can't be a new timestamp until the old one is
> + * unlatched by reading.
> + *
> + * In addition to the timestamp in hardware, some controllers need a software
> + * overflow cyclecounter, and this function takes this into account as well.
> + **/
> +static void wx_ptp_convert_to_hwtstamp(struct wx *wx,
> +				       struct skb_shared_hwtstamps *hwtstamp,
> +				       u64 timestamp)
> +{
> +	unsigned long flags;
> +	u64 ns;
> +
> +	memset(hwtstamp, 0, sizeof(*hwtstamp));

no need to zero out it, it will be completely overwritten later

> +
> +	write_seqlock_irqsave(&wx->hw_tc_lock, flags);
> +	ns = timecounter_cyc2time(&wx->hw_tc, timestamp);
> +	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
> +
> +	hwtstamp->hwtstamp = ns_to_ktime(ns);
> +}
> +

[...]

> +/**
> + * wx_ptp_read - read raw cycle counter (to be used by time counter)
> + * @hw_cc: the cyclecounter structure
> + *
> + * this function reads the cyclecounter registers and is called by the
> + * cyclecounter structure used to construct a ns counter from the
> + * arbitrary fixed point registers
> + */
> +static u64 wx_ptp_read(const struct cyclecounter *hw_cc)
> +{
> +	struct wx *wx = container_of(hw_cc, struct wx, hw_cc);
> +	u64 stamp = 0;
> +
> +	stamp |= (u64)rd32ptp(wx, WX_TSC_1588_SYSTIML);
> +	stamp |= (u64)rd32ptp(wx, WX_TSC_1588_SYSTIMH) << 32;

The same reading sequence should be here...

> +
> +	return stamp;
> +}
> +
> +static void wx_ptp_link_speed_adjust(struct wx *wx, u32 *shift, u32 *incval)
> +{
> +	if (wx->mac.type == wx_mac_em) {
> +		*shift = WX_INCVAL_SHIFT_EM;
> +		*incval = WX_INCVAL_EM;
> +		return;
> +	}
> +
> +	switch (wx->speed) {
> +	case SPEED_10:
> +		*shift = WX_INCVAL_SHIFT_10;
> +		*incval = WX_INCVAL_10;
> +		break;
> +	case SPEED_100:
> +		*shift = WX_INCVAL_SHIFT_100;
> +		*incval = WX_INCVAL_100;
> +		break;
> +	case SPEED_1000:
> +		*shift = WX_INCVAL_SHIFT_1GB;
> +		*incval = WX_INCVAL_1GB;
> +		break;
> +	case SPEED_10000:
> +	default:
> +		*shift = WX_INCVAL_SHIFT_10GB;
> +		*incval = WX_INCVAL_10GB;
> +		break;
> +	}
> +}
> +

[...]

