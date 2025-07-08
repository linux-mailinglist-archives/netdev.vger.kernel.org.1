Return-Path: <netdev+bounces-204927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42301AFC900
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2FC1BC5A47
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C42C3769;
	Tue,  8 Jul 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GTYnoGkA"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F672D9489
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972101; cv=none; b=jVufHaKCO8V/6pz4HT2YrlPFHYLe7hAU8syzXefMkyxza7LImXNio8dgucvbJzfJXqfrCQ2d6a2sOk4VjWDZP+QEdc5gzuaxNxoFpAmfyV204kxkR4xqLPKiJDPbqmmj/I1ixDMF89Z1tIkpsJQE0HIomeO45E+PazFRQS/0E4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972101; c=relaxed/simple;
	bh=ZGb9phm2p2Ug3/QvE/ChNooiYxJ50qajvBpPKwUFpCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ef6JdPQsQ2W5TzmnSwIG7oDMikm2lW+m607vbdAhGYc33tEA7+1aAkBVQNJVKjbz+TKSZwLAh0WADRcIwx0WguwWUriCO1V1yEalWnTWsHO9juv2JyJPFQCGwgPsP6nItr4toxknMN/lysR1ml7cdOT0yB4Lw/9/ESJa+jUgT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GTYnoGkA; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc6140db-08d9-4d05-bb68-410ddbb63c65@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751972095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgPqWiZNi8dr9K3gBo7yTlv5tjI2ZhTAurvPAGkTOEs=;
	b=GTYnoGkAV9VQ6v96UCackBaW1BmSpFzCfEuJuoWAczy+J8TAlq7erIEokzSsMbkJdD5tNl
	mLwVA2Dcr45Mil648QjcrYp/X5DiJKCTeqRJ92KvoSITuJgAFVz2QG/0pAm3PrszliQlo/
	YrcDZyqia3e2Yha53ba1NzErUXYWnbQ=
Date: Tue, 8 Jul 2025 11:54:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next] amd-xgbe: add hardware PTP timestamping support
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20250707175356.46246-1-Raju.Rangoju@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250707175356.46246-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/07/2025 18:53, Raju Rangoju wrote:
> Adds support for hardware-based PTP (IEEE 1588) timestamping to
> the AMD XGBE driver.
> 
> - Initialize and configure the MAC PTP registers based on link
>    speed and reference clock.
> - Support both 50MHz and 125MHz PTP reference clocks.
> - Update the driver interface and version data to support PTP
>    clock frequency selection.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-common.h |  10 ++
>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 145 ++++++++++++++++----
>   drivers/net/ethernet/amd/xgbe/xgbe-drv.c    |  15 +-
>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |   2 +
>   drivers/net/ethernet/amd/xgbe/xgbe-ptp.c    |  74 +++++-----
>   drivers/net/ethernet/amd/xgbe/xgbe.h        |  25 +++-
>   6 files changed, 187 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> index e54e3e36d3f9..009fbc9b11ce 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> @@ -223,6 +223,10 @@
>   #define MAC_TSSR			0x0d20
>   #define MAC_TXSNR			0x0d30
>   #define MAC_TXSSR			0x0d34
> +#define MAC_TICNR                       0x0d58
> +#define MAC_TICSNR                      0x0d5C
> +#define MAC_TECNR                       0x0d60
> +#define MAC_TECSNR                      0x0d64
>   
>   #define MAC_QTFCR_INC			4
>   #define MAC_MACA_INC			4
> @@ -428,6 +432,8 @@
>   #define MAC_TSCR_SNAPTYPSEL_WIDTH	2
>   #define MAC_TSCR_TSADDREG_INDEX		5
>   #define MAC_TSCR_TSADDREG_WIDTH		1
> +#define MAC_TSCR_TSUPDT_INDEX		3
> +#define MAC_TSCR_TSUPDT_WIDTH		1
>   #define MAC_TSCR_TSCFUPDT_INDEX		1
>   #define MAC_TSCR_TSCFUPDT_WIDTH		1
>   #define MAC_TSCR_TSCTRLSSR_INDEX	9
> @@ -456,6 +462,10 @@
>   #define MAC_TSSR_TXTSC_WIDTH		1
>   #define MAC_TXSNR_TXTSSTSMIS_INDEX	31
>   #define MAC_TXSNR_TXTSSTSMIS_WIDTH	1
> +#define MAC_TICSNR_TSICSNS_INDEX	8
> +#define MAC_TICSNR_TSICSNS_WIDTH	8
> +#define MAC_TECSNR_TSECSNS_INDEX	8
> +#define MAC_TECSNR_TSECSNS_WIDTH	8
>   #define MAC_VLANHTR_VLHT_INDEX		0
>   #define MAC_VLANHTR_VLHT_WIDTH		16
>   #define MAC_VLANIR_VLTI_INDEX		20
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index 9e4e79bfe624..559425fa1846 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -1558,6 +1558,29 @@ static void xgbe_rx_desc_init(struct xgbe_channel *channel)
>   	DBGPR("<--rx_desc_init\n");
>   }
>   
> +static void xgbe_update_tstamp_time(struct xgbe_prv_data *pdata,
> +				    unsigned int sec, unsigned int nsec)
> +{
> +	unsigned int count = 10000;
> +
> +	/* Set the time values and tell the device */
> +	XGMAC_IOWRITE(pdata, MAC_STSUR, sec);
> +	XGMAC_IOWRITE(pdata, MAC_STNUR, nsec);
> +
> +	/* issue command to update the system time value */
> +	XGMAC_IOWRITE(pdata, MAC_TSCR,
> +		      XGMAC_IOREAD(pdata, MAC_TSCR) |
> +		      (1 << MAC_TSCR_TSUPDT_INDEX));
> +
> +	/* Wait for the time till update complete */
> +	while (--count && XGMAC_IOREAD_BITS(pdata, MAC_TSCR, TSUPDT))
> +		udelay(5);
> +
> +	if (!count)
> +		netdev_err(pdata->netdev,
> +			   "timed out updating system timestamp\n");
> +}
> +
>   static void xgbe_update_tstamp_addend(struct xgbe_prv_data *pdata,
>   				      unsigned int addend)
>   {
> @@ -1636,8 +1659,8 @@ static void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
>   	if (XGMAC_GET_BITS_LE(rdesc->desc3, RX_CONTEXT_DESC3, TSA) &&
>   	    !XGMAC_GET_BITS_LE(rdesc->desc3, RX_CONTEXT_DESC3, TSD)) {
>   		nsec = le32_to_cpu(rdesc->desc1);
> -		nsec <<= 32;
> -		nsec |= le32_to_cpu(rdesc->desc0);
> +		nsec *= NSEC_PER_SEC;
> +		nsec += le32_to_cpu(rdesc->desc0);

This change is not explained in the commit message. Looks like the
HW timestamping has already been implemented, but in a wrong way?

>   		if (nsec != 0xffffffffffffffffULL) {
>   			packet->rx_tstamp = nsec;
>   			XGMAC_SET_BITS(packet->attributes, RX_PACKET_ATTRIBUTES,
> @@ -1646,39 +1669,18 @@ static void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
>   	}
>   }
>   
> -static int xgbe_config_tstamp(struct xgbe_prv_data *pdata,
> -			      unsigned int mac_tscr)
> +static void xgbe_config_tstamp(struct xgbe_prv_data *pdata,
> +			       unsigned int mac_tscr)
>   {
> -	/* Set one nano-second accuracy */
> -	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCTRLSSR, 1);
> -
> -	/* Set fine timestamp update */
> -	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCFUPDT, 1);
> -
> -	/* Overwrite earlier timestamps */
> -	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TXTSSTSM, 1);
> -
> -	XGMAC_IOWRITE(pdata, MAC_TSCR, mac_tscr);
> -
> -	/* Exit if timestamping is not enabled */
> -	if (!XGMAC_GET_BITS(mac_tscr, MAC_TSCR, TSENA))
> -		return 0;
> +	unsigned int value = 0;
>   
> -	/* Initialize time registers */
> -	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SSINC, XGBE_TSTAMP_SSINC);
> -	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SNSINC, XGBE_TSTAMP_SNSINC);
> -	xgbe_update_tstamp_addend(pdata, pdata->tstamp_addend);
> -	xgbe_set_tstamp_time(pdata, 0, 0);
> -
> -	/* Initialize the timecounter */
> -	timecounter_init(&pdata->tstamp_tc, &pdata->tstamp_cc,
> -			 ktime_to_ns(ktime_get_real()));
> -
> -	return 0;
> +	value = XGMAC_IOREAD(pdata, MAC_TSCR);
> +	value |= mac_tscr;
> +	XGMAC_IOWRITE(pdata, MAC_TSCR, value);
>   }
>   
>   static void xgbe_tx_start_xmit(struct xgbe_channel *channel,
> -			       struct xgbe_ring *ring)
> +		struct xgbe_ring *ring)

doesn't look like we need this change

>   {
>   	struct xgbe_prv_data *pdata = channel->pdata;
>   	struct xgbe_ring_data *rdata;
> @@ -3512,6 +3514,87 @@ static void xgbe_powerdown_rx(struct xgbe_prv_data *pdata)
>   	}
>   }
>   
> +static void xgbe_init_ptp(struct xgbe_prv_data *pdata)
> +{
> +	unsigned int mac_tscr = 0;
> +	struct timespec64 now;
> +	u64 dividend;
> +
> +	/* Register Settings to be done based on the link speed. */
> +	switch (pdata->phy.speed) {
> +	case SPEED_1000:
> +		XGMAC_IOWRITE(pdata, MAC_TICNR, MAC_TICNR_1G_INITVAL);
> +		XGMAC_IOWRITE(pdata, MAC_TECNR, MAC_TECNR_1G_INITVAL);
> +		break;
> +	case SPEED_2500:
> +	case SPEED_10000:
> +		XGMAC_IOWRITE_BITS(pdata, MAC_TICSNR, TSICSNS,
> +				   MAC_TICSNR_10G_INITVAL);
> +		XGMAC_IOWRITE(pdata, MAC_TECNR, MAC_TECNR_10G_INITVAL);
> +		XGMAC_IOWRITE_BITS(pdata, MAC_TECSNR, TSECSNS,
> +				   MAC_TECSNR_10G_INITVAL);
> +		break;
> +	case SPEED_UNKNOWN:
> +	default:
> +		break;
> +	}
> +
> +	/* Enable IEEE1588 PTP clock. */
> +	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
> +
> +	/* Overwrite earlier timestamps */
> +	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TXTSSTSM, 1);
> +
> +	/* Set one nano-second accuracy */
> +	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCTRLSSR, 1);
> +
> +	/* Set fine timestamp update */
> +	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCFUPDT, 1);
> +
> +	xgbe_config_tstamp(pdata, mac_tscr);
> +
> +	/* Exit if timestamping is not enabled */
> +	if (!XGMAC_GET_BITS(mac_tscr, MAC_TSCR, TSENA))
> +		return;
> +
> +	if (pdata->vdata->tstamp_ptp_clock_freq) {
> +		/* Initialize time registers based on
> +		 * 125MHz PTP Clock Frequency
> +		 */
> +		XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SSINC,
> +				   XGBE_V2_TSTAMP_SSINC);
> +		XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SNSINC,
> +				   XGBE_V2_TSTAMP_SNSINC);
> +	} else {
> +		/* Initialize time registers based on
> +		 * 50MHz PTP Clock Frequency
> +		 */
> +		XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SSINC, XGBE_TSTAMP_SSINC);
> +		XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SNSINC, XGBE_TSTAMP_SNSINC);
> +	}
> +
> +	/* Calculate the addend:
> +	 *   addend = 2^32 / (PTP ref clock / (PTP clock based on SSINC))
> +	 *          = (2^32 * (PTP clock based on SSINC)) / PTP ref clock
> +	 */
> +	if (pdata->vdata->tstamp_ptp_clock_freq)
> +		dividend = 100000000;           // PTP clock frequency is 125MHz
> +	else
> +		dividend = 50000000;            // PTP clock frequency is 50MHz
why do you use 100_000_000 value for 125MHz while 50_000_000 for 50MHz?
it doesn't look intuitive

also, please, be consistent with the style of comments.

> +
> +	dividend <<= 32;
> +	pdata->tstamp_addend = div_u64(dividend, pdata->ptpclk_rate);
> +
> +	xgbe_update_tstamp_addend(pdata, pdata->tstamp_addend);
> +
> +	dma_wmb();
> +	/* initialize system time */
> +	ktime_get_real_ts64(&now);
> +
> +	/* lower 32 bits of tv_sec are safe until y2106 */
> +	xgbe_set_tstamp_time(pdata, (u32)now.tv_sec, now.tv_nsec);
> +}
> +
>   static int xgbe_init(struct xgbe_prv_data *pdata)
>   {
>   	struct xgbe_desc_if *desc_if = &pdata->desc_if;
> @@ -3672,9 +3755,11 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
>   	hw_if->read_mmc_stats = xgbe_read_mmc_stats;
>   
>   	/* For PTP config */
> +	hw_if->init_ptp = xgbe_init_ptp;
>   	hw_if->config_tstamp = xgbe_config_tstamp;
>   	hw_if->update_tstamp_addend = xgbe_update_tstamp_addend;
>   	hw_if->set_tstamp_time = xgbe_set_tstamp_time;
> +	hw_if->update_tstamp_time = xgbe_update_tstamp_time;
>   	hw_if->get_tstamp_time = xgbe_get_tstamp_time;
>   	hw_if->get_tx_tstamp = xgbe_get_tx_tstamp;
>   
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index 65447f9a0a59..a6b9d0cda48c 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -1377,7 +1377,6 @@ static void xgbe_tx_tstamp(struct work_struct *work)
>   						   struct xgbe_prv_data,
>   						   tx_tstamp_work);
>   	struct skb_shared_hwtstamps hwtstamps;
> -	u64 nsec;
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&pdata->tstamp_lock, flags);
> @@ -1385,11 +1384,8 @@ static void xgbe_tx_tstamp(struct work_struct *work)
>   		goto unlock;
>   
>   	if (pdata->tx_tstamp) {
> -		nsec = timecounter_cyc2time(&pdata->tstamp_tc,
> -					    pdata->tx_tstamp);
> -
>   		memset(&hwtstamps, 0, sizeof(hwtstamps));
> -		hwtstamps.hwtstamp = ns_to_ktime(nsec);
> +		hwtstamps.hwtstamp = ns_to_ktime(pdata->tx_tstamp);
>   		skb_tstamp_tx(pdata->tx_tstamp_skb, &hwtstamps);
>   	}
>   
> @@ -1776,6 +1772,9 @@ static int xgbe_open(struct net_device *netdev)
>   	INIT_WORK(&pdata->stopdev_work, xgbe_stopdev);
>   	INIT_WORK(&pdata->tx_tstamp_work, xgbe_tx_tstamp);
>   
> +	/* Initialize PTP timestamping and clock. */
> +	pdata->hw_if.init_ptp(pdata);
> +
>   	ret = xgbe_alloc_memory(pdata);
>   	if (ret)
>   		goto err_ptpclk;
> @@ -2546,12 +2545,8 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
>   
>   		if (XGMAC_GET_BITS(packet->attributes,
>   				   RX_PACKET_ATTRIBUTES, RX_TSTAMP)) {
> -			u64 nsec;
> -
> -			nsec = timecounter_cyc2time(&pdata->tstamp_tc,
> -						    packet->rx_tstamp);
>   			hwtstamps = skb_hwtstamps(skb);
> -			hwtstamps->hwtstamp = ns_to_ktime(nsec);
> +			hwtstamps->hwtstamp = ns_to_ktime(packet->rx_tstamp);
>   		}
>   
>   		if (XGMAC_GET_BITS(packet->attributes,
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> index 097ec5e4f261..e3e1dca9856a 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> @@ -414,6 +414,7 @@ static struct xgbe_version_data xgbe_v2a = {
>   	.tx_max_fifo_size		= 229376,
>   	.rx_max_fifo_size		= 229376,
>   	.tx_tstamp_workaround		= 1,
> +	.tstamp_ptp_clock_freq		= 1,
>   	.ecc_support			= 1,
>   	.i2c_support			= 1,
>   	.irq_reissue_support		= 1,
> @@ -430,6 +431,7 @@ static struct xgbe_version_data xgbe_v2b = {
>   	.tx_max_fifo_size		= 65536,
>   	.rx_max_fifo_size		= 65536,
>   	.tx_tstamp_workaround		= 1,
> +	.tstamp_ptp_clock_freq		= 1,
>   	.ecc_support			= 1,
>   	.i2c_support			= 1,
>   	.irq_reissue_support		= 1,
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
> index 978c4dd01fa0..52764dcd9f4d 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
> @@ -13,18 +13,6 @@
>   #include "xgbe.h"
>   #include "xgbe-common.h"
>   
> -static u64 xgbe_cc_read(const struct cyclecounter *cc)
> -{
> -	struct xgbe_prv_data *pdata = container_of(cc,
> -						   struct xgbe_prv_data,
> -						   tstamp_cc);
> -	u64 nsec;
> -
> -	nsec = pdata->hw_if.get_tstamp_time(pdata);
> -
> -	return nsec;
> -}
> -
>   static int xgbe_adjfine(struct ptp_clock_info *info, long scaled_ppm)
>   {
>   	struct xgbe_prv_data *pdata = container_of(info,
> @@ -50,25 +38,55 @@ static int xgbe_adjtime(struct ptp_clock_info *info, s64 delta)
>   						   struct xgbe_prv_data,
>   						   ptp_clock_info);
>   	unsigned long flags;
> +	unsigned int sec, nsec;
> +	unsigned int neg_adjust = 0;
> +	u32 quotient, reminder;

please, use reverse x-mass tree ordering of variables

> +
> +	if (delta < 0) {
> +		neg_adjust = 1;
> +		delta = -delta;
> +	}
> +
> +	quotient = div_u64_rem(delta, 1000000000ULL, &reminder);
> +	sec = quotient;
> +	nsec = reminder;
> +
> +	/* Negative adjustment for Hw timer register. */
> +	if (neg_adjust) {
> +		sec = -sec;
> +		if (XGMAC_IOREAD_BITS(pdata, MAC_TSCR, TSCTRLSSR))
> +			nsec = (1000000000UL - nsec);
> +		else
> +			nsec = (0x80000000UL - nsec);
> +	}
> +	nsec = (neg_adjust << 31) | nsec;
>   
>   	spin_lock_irqsave(&pdata->tstamp_lock, flags);
> -	timecounter_adjtime(&pdata->tstamp_tc, delta);
> +	pdata->hw_if.update_tstamp_time(pdata, sec, nsec);
>   	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
>   
>   	return 0;
>   }
>   
> -static int xgbe_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
> +static int xgbe_gettimex(struct ptp_clock_info *info,
> +			 struct timespec64 *ts,
> +			 struct ptp_system_timestamp *sts)
>   {
>   	struct xgbe_prv_data *pdata = container_of(info,
>   						   struct xgbe_prv_data,
>   						   ptp_clock_info);
>   	unsigned long flags;
>   	u64 nsec;
> +	static int count = 3;
 > +> +	if (count > 0 && count--)
> +		dump_stack();

looks like debug leftover

>   
>   	spin_lock_irqsave(&pdata->tstamp_lock, flags);
>   
> -	nsec = timecounter_read(&pdata->tstamp_tc);
> +	ptp_read_system_prets(sts);
> +	nsec = pdata->hw_if.get_tstamp_time(pdata);
> +	ptp_read_system_postts(sts);
>   
>   	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
>   
> @@ -84,13 +102,10 @@ static int xgbe_settime(struct ptp_clock_info *info,
>   						   struct xgbe_prv_data,
>   						   ptp_clock_info);
>   	unsigned long flags;
> -	u64 nsec;
> -
> -	nsec = timespec64_to_ns(ts);
>   
>   	spin_lock_irqsave(&pdata->tstamp_lock, flags);
>   
> -	timecounter_init(&pdata->tstamp_tc, &pdata->tstamp_cc, nsec);
> +	pdata->hw_if.set_tstamp_time(pdata, ts->tv_sec, ts->tv_nsec);
>   
>   	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
>   
> @@ -107,8 +122,6 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
>   {
>   	struct ptp_clock_info *info = &pdata->ptp_clock_info;
>   	struct ptp_clock *clock;
> -	struct cyclecounter *cc = &pdata->tstamp_cc;
> -	u64 dividend;
>   
>   	snprintf(info->name, sizeof(info->name), "%s",
>   		 netdev_name(pdata->netdev));
> @@ -116,7 +129,7 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
>   	info->max_adj = pdata->ptpclk_rate;
>   	info->adjfine = xgbe_adjfine;
>   	info->adjtime = xgbe_adjtime;
> -	info->gettime64 = xgbe_gettime;
> +	info->gettimex64 = xgbe_gettimex;
>   	info->settime64 = xgbe_settime;
>   	info->enable = xgbe_enable;
>   
> @@ -128,23 +141,6 @@ void xgbe_ptp_register(struct xgbe_prv_data *pdata)
>   
>   	pdata->ptp_clock = clock;
>   
> -	/* Calculate the addend:
> -	 *   addend = 2^32 / (PTP ref clock / 50Mhz)
> -	 *          = (2^32 * 50Mhz) / PTP ref clock
> -	 */
> -	dividend = 50000000;
> -	dividend <<= 32;
> -	pdata->tstamp_addend = div_u64(dividend, pdata->ptpclk_rate);
> -
> -	/* Setup the timecounter */
> -	cc->read = xgbe_cc_read;
> -	cc->mask = CLOCKSOURCE_MASK(64);
> -	cc->mult = 1;
> -	cc->shift = 0;
> -
> -	timecounter_init(&pdata->tstamp_tc, &pdata->tstamp_cc,
> -			 ktime_to_ns(ktime_get_real()));
> -
>   	/* Disable all timestamping to start */
>   	XGMAC_IOWRITE(pdata, MAC_TSCR, 0);
>   	pdata->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index 70169ea23c7f..b5c5624eb827 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -119,6 +119,14 @@
>   #define XGBE_MSI_BASE_COUNT	4
>   #define XGBE_MSI_MIN_COUNT	(XGBE_MSI_BASE_COUNT + 1)
>   
> +/* Initial PTP register values based on Link Speed. */
> +#define MAC_TICNR_1G_INITVAL	0x10
> +#define MAC_TECNR_1G_INITVAL	0x28
> +
> +#define MAC_TICSNR_10G_INITVAL	0x33
> +#define MAC_TECNR_10G_INITVAL	0x14
> +#define MAC_TECSNR_10G_INITVAL	0xCC
> +
>   /* PCI clock frequencies */
>   #define XGBE_V2_DMA_CLOCK_FREQ	500000000	/* 500 MHz */
>   #define XGBE_V2_PTP_CLOCK_FREQ	125000000	/* 125 MHz */
> @@ -129,6 +137,8 @@
>   #define XGBE_TSTAMP_SSINC	20
>   #define XGBE_TSTAMP_SNSINC	0
>   
> +#define XGBE_V2_TSTAMP_SSINC	0xA
> +#define XGBE_V2_TSTAMP_SNSINC	0
>   /* Driver PMT macros */
>   #define XGMAC_DRIVER_CONTEXT	1
>   #define XGMAC_IOCTL_CONTEXT	2
> @@ -742,10 +752,16 @@ struct xgbe_hw_if {
>   	void (*read_mmc_stats)(struct xgbe_prv_data *);
>   
>   	/* For Timestamp config */
> -	int (*config_tstamp)(struct xgbe_prv_data *, unsigned int);
> -	void (*update_tstamp_addend)(struct xgbe_prv_data *, unsigned int);
> -	void (*set_tstamp_time)(struct xgbe_prv_data *, unsigned int sec,
> +	void (*init_ptp)(struct xgbe_prv_data *pdata);
> +	void (*config_tstamp)(struct xgbe_prv_data *pdata,
> +			      unsigned int mac_tscr);
> +	void (*update_tstamp_addend)(struct xgbe_prv_data *pdata,
> +				     unsigned int addend);
> +	void (*set_tstamp_time)(struct xgbe_prv_data *pdata, unsigned int sec,
>   				unsigned int nsec);
> +	void (*update_tstamp_time)(struct xgbe_prv_data *pdata,
> +				   unsigned int sec,
> +				   unsigned int nsec);
>   	u64 (*get_tstamp_time)(struct xgbe_prv_data *);
>   	u64 (*get_tx_tstamp)(struct xgbe_prv_data *);
>   
> @@ -946,6 +962,7 @@ struct xgbe_version_data {
>   	unsigned int tx_max_fifo_size;
>   	unsigned int rx_max_fifo_size;
>   	unsigned int tx_tstamp_workaround;
> +	unsigned int tstamp_ptp_clock_freq;
>   	unsigned int ecc_support;
>   	unsigned int i2c_support;
>   	unsigned int irq_reissue_support;
> @@ -1131,8 +1148,6 @@ struct xgbe_prv_data {
>   	struct ptp_clock_info ptp_clock_info;
>   	struct ptp_clock *ptp_clock;
>   	struct hwtstamp_config tstamp_config;
> -	struct cyclecounter tstamp_cc;
> -	struct timecounter tstamp_tc;
>   	unsigned int tstamp_addend;
>   	struct work_struct tx_tstamp_work;
>   	struct sk_buff *tx_tstamp_skb;


