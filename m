Return-Path: <netdev+bounces-141548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D649BB4B9
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D592C1C21D1D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6108218C025;
	Mon,  4 Nov 2024 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JS/AI1PD"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61831E4A6
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723578; cv=none; b=lQPld+g02CM/Ou95Km4mQ0isgjCxAreEsvED/mM1A4s6neodcq3AzwkQG6CNLsfO8pVW/lQ4+SqvwpLZt9k/bLaCLUicR6I+9C2ttKj1bPPnLwJ44K2hU/l8FLxFj580tfvLbjZZBEe+Hi0la28iG3xtQ4JQz5jnUyfmMgcv5PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723578; c=relaxed/simple;
	bh=PZZWS7eN5mW9JGmZGVLxTJy4ZuK4lwHpQ3Sc50J3nmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KTMttDn5PZAD0oZKx4PkpMOpKztZZp+1wgwU79Env6zAijjvN7XK9s/0SdppbOQ+Pt19nBD8VRgCAhFMIz8F+woOiPWYBiEK/mARUPbrxp2mI7oc4w+I3PAxkAEk6+638U4D7Onxa1fP/9kBAfn0kervc5DQrop7ZJijqp6UC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JS/AI1PD; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f2162f3f-81f1-4142-bfc2-89cb3612d088@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730723572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/I/fBj69sncpBHFDOxBvE3Ew6WSNG9QAH7YtFGAat0=;
	b=JS/AI1PD0yfj7pPxDxC0wjSXgRacTFZop1T7fjh1ArWPq/XQ9gsUosovjI4WhteSAOnyzq
	PEhU2vP2Avy3My/IE3v8gMqDRG5F6XAcdCkbj5/GQCn5k6+JmUw2W9lVB77SKo0aXIDYZ/
	y+ib2U7B+gDBrf9Z2lB2HquuFz9m4Oo=
Date: Mon, 4 Nov 2024 12:32:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
 arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com
References: <20241104090750.12942-1-divya.koppera@microchip.com>
 <20241104090750.12942-3-divya.koppera@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241104090750.12942-3-divya.koppera@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/11/2024 09:07, Divya Koppera wrote:
> Add ptp library for Microchip phys
> 1-step and 2-step modes are supported, over Ethernet and UDP(ipv4, ipv6)
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
>   drivers/net/phy/microchip_ptp.c | 990 ++++++++++++++++++++++++++++++++
>   1 file changed, 990 insertions(+)
>   create mode 100644 drivers/net/phy/microchip_ptp.c
> 
> diff --git a/drivers/net/phy/microchip_ptp.c b/drivers/net/phy/microchip_ptp.c
> new file mode 100644
> index 000000000000..45000984858e
> --- /dev/null
> +++ b/drivers/net/phy/microchip_ptp.c
> @@ -0,0 +1,990 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Microchip Technology
> +
> +#include "microchip_ptp.h"
> +
> +static int mchp_ptp_flush_fifo(struct mchp_ptp_clock *ptp_clock,
> +			       enum ptp_fifo_dir dir)
> +{
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	int rc;
> +
> +	for (int i = 0; i < MCHP_PTP_FIFO_SIZE; ++i) {
> +		rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +				  dir == PTP_EGRESS_FIFO ?
> +				  MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock)) :
> +				  MCHP_PTP_RX_MSG_HEADER2(BASE_PORT(ptp_clock)));
> +		if (rc < 0)
> +			return rc;
> +	}
> +	return phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			    MCHP_PTP_INT_STS(BASE_PORT(ptp_clock)));
> +}
> +
> +static int mchp_ptp_config_intr(struct mchp_ptp_clock *ptp_clock,
> +				bool enable)
> +{
> +	struct phy_device *phydev = ptp_clock->phydev;
> +
> +	/* Enable  or disable ptp interrupts */
> +	return phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			     MCHP_PTP_INT_EN(BASE_PORT(ptp_clock)),
> +			     enable ? MCHP_PTP_INT_ALL_MSK : 0);
> +}
> +
> +static void mchp_ptp_txtstamp(struct mii_timestamper *mii_ts,
> +			      struct sk_buff *skb, int type)
> +{
> +	struct mchp_ptp_clock *ptp_clock = container_of(mii_ts,
> +						      struct mchp_ptp_clock,
> +						      mii_ts);
> +
> +	switch (ptp_clock->hwts_tx_type) {
> +	case HWTSTAMP_TX_ONESTEP_SYNC:
> +		if (ptp_msg_is_sync(skb, type)) {
> +			kfree_skb(skb);
> +			return;
> +		}
> +		fallthrough;
> +	case HWTSTAMP_TX_ON:
> +		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +		skb_queue_tail(&ptp_clock->tx_queue, skb);
> +		break;
> +	case HWTSTAMP_TX_OFF:
> +	default:
> +		kfree_skb(skb);
> +		break;
> +	}
> +}
> +
> +static bool mchp_ptp_get_sig_rx(struct sk_buff *skb, u16 *sig)
> +{
> +	struct ptp_header *ptp_header;
> +	int type;
> +
> +	skb_push(skb, ETH_HLEN);
> +	type = ptp_classify_raw(skb);
> +	if (type == PTP_CLASS_NONE)
> +		return false;
> +
> +	ptp_header = ptp_parse_header(skb, type);
> +	if (!ptp_header)
> +		return false;
> +
> +	skb_pull_inline(skb, ETH_HLEN);
> +
> +	*sig = ntohs(ptp_header->sequence_id);
> +
> +	return true;
> +}
> +
> +static bool mchp_ptp_match_skb(struct mchp_ptp_clock *ptp_clock,
> +			       struct mchp_ptp_rx_ts *rx_ts)
> +{
> +	struct skb_shared_hwtstamps *shhwtstamps;
> +	struct sk_buff *skb, *skb_tmp;
> +	unsigned long flags;
> +	bool rc = false;
> +	u16 skb_sig;
> +
> +	spin_lock_irqsave(&ptp_clock->rx_queue.lock, flags);
> +	skb_queue_walk_safe(&ptp_clock->rx_queue, skb, skb_tmp) {
> +		if (!mchp_ptp_get_sig_rx(skb, &skb_sig))
> +			continue;
> +
> +		if (memcmp(&skb_sig, &rx_ts->seq_id, sizeof(rx_ts->seq_id)))
> +			continue;

why do you use memcmp() instead of simple u16 comparison? It will be
optimized anyway, but still, why? The same question goes to other
comparisons futher in the file.

> +
> +		__skb_unlink(skb, &ptp_clock->rx_queue);
> +
> +		rc = true;
> +		break;
> +	}
> +	spin_unlock_irqrestore(&ptp_clock->rx_queue.lock, flags);
> +
> +	if (rc) {
> +		shhwtstamps = skb_hwtstamps(skb);
> +		memset(shhwtstamps, 0, sizeof(*shhwtstamps));

I don't think this memset is needed. hwtstamp is fully overwritten on
on the next line.

> +		shhwtstamps->hwtstamp = ktime_set(rx_ts->seconds, rx_ts->nsec);
> +		netif_rx(skb);
> +	}
> +
> +	return rc;
> +}
> +
> +static void mchp_ptp_match_rx_ts(struct mchp_ptp_clock *ptp_clock,
> +				 struct mchp_ptp_rx_ts *rx_ts)
> +{
> +	unsigned long flags;
> +
> +	/* If we failed to match the skb add it to the queue for when
> +	 * the frame will come
> +	 */
> +	if (!mchp_ptp_match_skb(ptp_clock, rx_ts)) {
> +		spin_lock_irqsave(&ptp_clock->rx_ts_lock, flags);
> +		list_add(&rx_ts->list, &ptp_clock->rx_ts_list);
> +		spin_unlock_irqrestore(&ptp_clock->rx_ts_lock, flags);
> +	} else {
> +		kfree(rx_ts);
> +	}
> +}
> +
> +static void mchp_ptp_match_rx_skb(struct mchp_ptp_clock *ptp_clock,
> +				  struct sk_buff *skb)
> +{
> +	struct skb_shared_hwtstamps *shhwtstamps;
> +	struct mchp_ptp_rx_ts *rx_ts, *tmp;
> +	unsigned long flags;
> +	bool match = false;
> +	u16 skb_sig;
> +
> +	if (!mchp_ptp_get_sig_rx(skb, &skb_sig))
> +		return;
> +
> +	/* Iterate over all RX timestamps and match it with the received skbs */
> +	spin_lock_irqsave(&ptp_clock->rx_ts_lock, flags);
> +	list_for_each_entry_safe(rx_ts, tmp, &ptp_clock->rx_ts_list, list) {
> +		/* Check if we found the signature we were looking for. */
> +		if (memcmp(&skb_sig, &rx_ts->seq_id, sizeof(rx_ts->seq_id)))
> +			continue;
> +
> +		shhwtstamps = skb_hwtstamps(skb);
> +		memset(shhwtstamps, 0, sizeof(*shhwtstamps));

and again - memset is useless here

> +		shhwtstamps->hwtstamp = ktime_set(rx_ts->seconds,
> +						  rx_ts->nsec);
> +		netif_rx(skb);
> +
> +		list_del(&rx_ts->list);
> +		kfree(rx_ts);

kfree can be done outside of spinlock as well as all other timestamp
manipulations to reduce spinlock scope.
> +
> +		match = true;
> +		break;
> +	}
> +	spin_unlock_irqrestore(&ptp_clock->rx_ts_lock, flags);

it's a good idea to think about RCU implementaton of the ts list as this
spinlock may become pretty hot on high packet rate.

> +
> +	if (!match)
> +		skb_queue_tail(&ptp_clock->rx_queue, skb);
> +}
> +
> +static bool mchp_ptp_rxtstamp(struct mii_timestamper *mii_ts,
> +			      struct sk_buff *skb, int type)
> +{
> +	struct mchp_ptp_clock *ptp_clock = container_of(mii_ts,
> +							struct mchp_ptp_clock,
> +							mii_ts);
> +
> +	if (ptp_clock->rx_filter == HWTSTAMP_FILTER_NONE ||
> +	    type == PTP_CLASS_NONE)
> +		return false;
> +
> +	if ((type & ptp_clock->version) == 0 || (type & ptp_clock->layer) == 0)
> +		return false;
> +
> +	/* Here if match occurs skb is sent to application, If not skb is added
> +	 * to queue and sending skb to application will get handled when
> +	 * interrupt occurs i.e., it get handles in interrupt handler. By
> +	 * any means skb will reach the application so we should not return
> +	 * false here if skb doesn't matches.
> +	 */
> +	mchp_ptp_match_rx_skb(ptp_clock, skb);
> +
> +	return true;
> +}
> +
> +static int mchp_ptp_hwtstamp(struct mii_timestamper *mii_ts,
> +			     struct kernel_hwtstamp_config *config,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct mchp_ptp_clock *ptp_clock =
> +				container_of(mii_ts, struct mchp_ptp_clock,
> +					     mii_ts);
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	struct mchp_ptp_rx_ts *rx_ts, *tmp;
> +	int txcfg = 0, rxcfg = 0;
> +	int rc;
> +
> +	ptp_clock->hwts_tx_type = config->tx_type;
> +	ptp_clock->rx_filter = config->rx_filter;
> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		ptp_clock->layer = 0;
> +		ptp_clock->version = 0;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +		ptp_clock->layer = PTP_CLASS_L4;
> +		ptp_clock->version = PTP_CLASS_V2;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> +		ptp_clock->layer = PTP_CLASS_L2;
> +		ptp_clock->version = PTP_CLASS_V2;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +		ptp_clock->layer = PTP_CLASS_L4 | PTP_CLASS_L2;
> +		ptp_clock->version = PTP_CLASS_V2;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	/* Setup parsing of the frames and enable the timestamping for ptp
> +	 * frames
> +	 */
> +	if (ptp_clock->layer & PTP_CLASS_L2) {
> +		rxcfg = MCHP_PTP_PARSE_CONFIG_LAYER2_EN;
> +		txcfg = MCHP_PTP_PARSE_CONFIG_LAYER2_EN;
> +	}
> +	if (ptp_clock->layer & PTP_CLASS_L4) {
> +		rxcfg |= MCHP_PTP_PARSE_CONFIG_IPV4_EN |
> +			 MCHP_PTP_PARSE_CONFIG_IPV6_EN;
> +		txcfg |= MCHP_PTP_PARSE_CONFIG_IPV4_EN |
> +			 MCHP_PTP_PARSE_CONFIG_IPV6_EN;
> +	}
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_RX_PARSE_CONFIG(BASE_PORT(ptp_clock)),
> +			   rxcfg);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_TX_PARSE_CONFIG(BASE_PORT(ptp_clock)),
> +			   txcfg);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_RX_TIMESTAMP_EN(BASE_PORT(ptp_clock)),
> +			   MCHP_PTP_TIMESTAMP_EN_ALL);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_TX_TIMESTAMP_EN(BASE_PORT(ptp_clock)),
> +			   MCHP_PTP_TIMESTAMP_EN_ALL);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (ptp_clock->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
> +		/* Enable / disable of the TX timestamp in the SYNC frames */
> +		rc = phy_modify_mmd(phydev, PTP_MMD(ptp_clock),
> +				    MCHP_PTP_TX_MOD(BASE_PORT(ptp_clock)),
> +				    MCHP_PTP_TX_MOD_PTP_SYNC_TS_INSERT,
> +				    MCHP_PTP_TX_MOD_PTP_SYNC_TS_INSERT);
> +	else
> +		rc = phy_modify_mmd(phydev, PTP_MMD(ptp_clock),
> +				    MCHP_PTP_TX_MOD(BASE_PORT(ptp_clock)),
> +				    MCHP_PTP_TX_MOD_PTP_SYNC_TS_INSERT,
> +				    (u16)~MCHP_PTP_TX_MOD_PTP_SYNC_TS_INSERT);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Now enable the timestamping interrupts */
> +	rc = mchp_ptp_config_intr(ptp_clock,
> +				  config->rx_filter != HWTSTAMP_FILTER_NONE);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* In case of multiple starts and stops, these needs to be cleared */
> +	list_for_each_entry_safe(rx_ts, tmp, &ptp_clock->rx_ts_list, list) {
> +		list_del(&rx_ts->list);
> +		kfree(rx_ts);
> +	}

I think this list clearing should be done under spinlock too.

> +	skb_queue_purge(&ptp_clock->rx_queue);
> +	skb_queue_purge(&ptp_clock->tx_queue);
> +
> +	rc = mchp_ptp_flush_fifo(ptp_clock, PTP_INGRESS_FIFO);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = mchp_ptp_flush_fifo(ptp_clock, PTP_EGRESS_FIFO);
> +
> +	return rc < 0 ? rc : 0;
> +}
> +
> +static int mchp_ptp_ts_info(struct mii_timestamper *mii_ts,
> +			    struct kernel_ethtool_ts_info *info)
> +{
> +	struct mchp_ptp_clock *ptp_clock = container_of(mii_ts,
> +							struct mchp_ptp_clock,
> +							mii_ts);
> +
> +	info->phc_index =
> +		ptp_clock->ptp_clock ? ptp_clock_index(ptp_clock->ptp_clock) : -1;
> +	if (info->phc_index == -1)
> +		return 0;
> +
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
> +				SOF_TIMESTAMPING_RX_HARDWARE |
> +				SOF_TIMESTAMPING_RAW_HARDWARE;
> +
> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON) |
> +			 BIT(HWTSTAMP_TX_ONESTEP_SYNC);
> +
> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT);
> +
> +	return 0;
> +}
> +
> +static int mchp_ptp_ltc_adjtime(struct ptp_clock_info *info, s64 delta)
> +{
> +	struct mchp_ptp_clock *ptp_clock = container_of(info,
> +							struct mchp_ptp_clock,
> +							caps);
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	struct timespec64 ts;
> +	bool add = true;
> +	int rc = 0;
> +	u32 nsec;
> +	s32 sec;
> +
> +	/* The HW allows up to 15 sec to adjust the time, but here we limit to
> +	 * 10 sec the adjustment. The reason is, in case the adjustment is 14
> +	 * sec and 999999999 nsec, then we add 8ns to compensate the actual
> +	 * increment so the value can be bigger than 15 sec. Therefore limit the
> +	 * possible adjustments so we will not have these corner cases
> +	 */
> +	if (delta > 10000000000LL || delta < -10000000000LL) {
> +		/* The timeadjustment is too big, so fall back using set time */
> +		u64 now;
> +
> +		info->gettime64(info, &ts);
> +
> +		now = ktime_to_ns(timespec64_to_ktime(ts));
> +		ts = ns_to_timespec64(now + delta);
> +
> +		info->settime64(info, &ts);
> +		return 0;
> +	}
> +	sec = div_u64_rem(abs(delta), NSEC_PER_SEC, &nsec);
> +	if (delta < 0 && nsec != 0) {
> +		/* It is not allowed to adjust low the nsec part, therefore
> +		 * subtract more from second part and add to nanosecond such
> +		 * that would roll over, so the second part will increase
> +		 */
> +		sec--;
> +		nsec = NSEC_PER_SEC - nsec;
> +	}
> +
> +	/* Calculate the adjustments and the direction */
> +	if (delta < 0)
> +		add = false;
> +
> +	if (nsec > 0) {
> +		/* add 8 ns to cover the likely normal increment */
> +		nsec += 8;
> +
> +		if (nsec >= NSEC_PER_SEC) {
> +			/* carry into seconds */
> +			sec++;
> +			nsec -= NSEC_PER_SEC;
> +		}
> +	}
> +
> +	mutex_lock(&ptp_clock->ptp_lock);
> +	if (sec) {
> +		sec = abs(sec);
> +
> +		rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +				   MCHP_PTP_LTC_STEP_ADJ_LO(BASE_CLK(ptp_clock)),
> +				   sec);
> +		if (rc < 0)
> +			goto out_unlock;
> +		rc = phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock),
> +				      MCHP_PTP_LTC_STEP_ADJ_HI(BASE_CLK(ptp_clock)),
> +				      ((add ? MCHP_PTP_LTC_STEP_ADJ_HI_DIR :
> +					0) | ((sec >> 16) & GENMASK(13, 0))));
> +		if (rc < 0)
> +			goto out_unlock;
> +		rc = phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock),
> +				      MCHP_PTP_CMD_CTL(BASE_CLK(ptp_clock)),
> +				      MCHP_PTP_CMD_CTL_LTC_STEP_SEC);
> +		if (rc < 0)
> +			goto out_unlock;
> +	}
> +
> +	if (nsec) {
> +		rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +				   MCHP_PTP_LTC_STEP_ADJ_LO(BASE_CLK(ptp_clock)),
> +				   nsec & GENMASK(15, 0));
> +		if (rc < 0)
> +			goto out_unlock;
> +		rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +				   MCHP_PTP_LTC_STEP_ADJ_HI(BASE_CLK(ptp_clock)),
> +				   (nsec >> 16) & GENMASK(13, 0));
> +		if (rc < 0)
> +			goto out_unlock;
> +		rc = phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock),
> +				      MCHP_PTP_CMD_CTL(BASE_CLK(ptp_clock)),
> +				      MCHP_PTP_CMD_CTL_LTC_STEP_NSEC);
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&ptp_clock->ptp_lock);
> +
> +	return rc;
> +}
> +
> +static int mchp_ptp_ltc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
> +{
> +	struct mchp_ptp_clock *ptp_clock = container_of(info,
> +							struct mchp_ptp_clock,
> +							caps);
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	u16 rate_lo, rate_hi;
> +	bool faster = true;
> +	u32 rate;
> +	int rc;
> +
> +	if (!scaled_ppm)
> +		return 0;
> +
> +	if (scaled_ppm < 0) {
> +		scaled_ppm = -scaled_ppm;
> +		faster = false;
> +	}
> +
> +	rate = MCHP_PTP_1PPM_FORMAT * (upper_16_bits(scaled_ppm));
> +	rate += (MCHP_PTP_1PPM_FORMAT * (lower_16_bits(scaled_ppm))) >> 16;
> +
> +	rate_lo = rate & GENMASK(15, 0);
> +	rate_hi = (rate >> 16) & GENMASK(13, 0);
> +
> +	if (faster)
> +		rate_hi |= MCHP_PTP_LTC_RATE_ADJ_HI_DIR;
> +
> +	mutex_lock(&ptp_clock->ptp_lock);
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_LTC_RATE_ADJ_HI(BASE_CLK(ptp_clock)),
> +			   rate_hi);
> +	if (rc < 0)
> +		goto error;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_LTC_RATE_ADJ_LO(BASE_CLK(ptp_clock)),
> +			   rate_lo);
> +	if (rc > 0)
> +		rc = 0;
> +error:
> +	mutex_unlock(&ptp_clock->ptp_lock);
> +
> +	return rc;
> +}
> +
> +static int mchp_ptp_ltc_gettime64(struct ptp_clock_info *info,
> +				  struct timespec64 *ts)
> +{
> +	struct mchp_ptp_clock *ptp_clock = container_of(info,
> +							struct mchp_ptp_clock,
> +							caps);
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	time64_t secs;
> +	int rc = 0;
> +	s64 nsecs;
> +
> +	mutex_lock(&ptp_clock->ptp_lock);
> +	/* Set read bit to 1 to save current values of 1588 local time counter
> +	 * into PTP LTC seconds and nanoseconds registers.
> +	 */
> +	rc = phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock),
> +			      MCHP_PTP_CMD_CTL(BASE_CLK(ptp_clock)),
> +			      MCHP_PTP_CMD_CTL_CLOCK_READ);
> +	if (rc < 0)
> +		goto out_unlock;
> +
> +	/* Get LTC clock values */
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_LTC_READ_SEC_HI(BASE_CLK(ptp_clock)));
> +	if (rc < 0)
> +		goto out_unlock;
> +	secs = rc << 16;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_LTC_READ_SEC_MID(BASE_CLK(ptp_clock)));
> +	if (rc < 0)
> +		goto out_unlock;
> +	secs |= rc;
> +	secs <<= 16;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_LTC_READ_SEC_LO(BASE_CLK(ptp_clock)));
> +	if (rc < 0)
> +		goto out_unlock;
> +	secs |= rc;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_LTC_READ_NS_HI(BASE_CLK(ptp_clock)));
> +	if (rc < 0)
> +		goto out_unlock;
> +	nsecs = (rc & GENMASK(13, 0));
> +	nsecs <<= 16;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_LTC_READ_NS_LO(BASE_CLK(ptp_clock)));
> +	if (rc < 0)
> +		goto out_unlock;
> +	nsecs |= rc;
> +
> +	set_normalized_timespec64(ts, secs, nsecs);
> +
> +	if (rc > 0)
> +		rc = 0;
> +out_unlock:
> +	mutex_unlock(&ptp_clock->ptp_lock);

That's interesting, but could the overwrapping happen to seconds counter
while reading nanoseconds? Usually high bits reading is wrapped into 
while() loop to advoid such cases.

> +
> +	return rc;
> +}
> +
> +static int mchp_ptp_ltc_settime64(struct ptp_clock_info *info,
> +				  const struct timespec64 *ts)
> +{
> +	struct mchp_ptp_clock *ptp_clock = container_of(info,
> +							struct mchp_ptp_clock,
> +							caps);
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	int rc;
> +
> +	mutex_lock(&ptp_clock->ptp_lock);
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_LTC_SEC_LO(BASE_CLK(ptp_clock)),
> +			   lower_16_bits(ts->tv_sec));
> +	if (rc < 0)
> +		goto out_unlock;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_LTC_SEC_MID(BASE_CLK(ptp_clock)),
> +			   upper_16_bits(ts->tv_sec));
> +	if (rc < 0)
> +		goto out_unlock;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_LTC_SEC_HI(BASE_CLK(ptp_clock)),
> +			   upper_32_bits(ts->tv_sec) & GENMASK(15, 0));
> +	if (rc < 0)
> +		goto out_unlock;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_LTC_NS_LO(BASE_CLK(ptp_clock)),
> +			   lower_16_bits(ts->tv_nsec));
> +	if (rc < 0)
> +		goto out_unlock;
> +
> +	rc = phy_write_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_LTC_NS_HI(BASE_CLK(ptp_clock)),
> +			   upper_16_bits(ts->tv_nsec) & GENMASK(13, 0));
> +	if (rc < 0)
> +		goto out_unlock;
> +
> +	/* Set load bit to 1 to write PTP LTC seconds and nanoseconds
> +	 * registers to 1588 local time counter.
> +	 */
> +	rc = phy_set_bits_mmd(phydev, PTP_MMD(ptp_clock),
> +			      MCHP_PTP_CMD_CTL(BASE_CLK(ptp_clock)),
> +			      MCHP_PTP_CMD_CTL_CLOCK_LOAD);
> +	if (rc > 0)
> +		rc = 0;
> +out_unlock:
> +	mutex_unlock(&ptp_clock->ptp_lock);
> +
> +	return rc;
> +}
> +
> +static bool mchp_ptp_get_sig_tx(struct sk_buff *skb, u16 *sig)
> +{
> +	struct ptp_header *ptp_header;
> +	int type;
> +
> +	type = ptp_classify_raw(skb);
> +	if (type == PTP_CLASS_NONE)
> +		return false;
> +
> +	ptp_header = ptp_parse_header(skb, type);
> +	if (!ptp_header)
> +		return false;
> +
> +	*sig = htons(ptp_header->sequence_id);
> +
> +	return true;
> +}
> +
> +static void mchp_ptp_match_tx_skb(struct mchp_ptp_clock *ptp_clock,
> +				  u32 seconds, u32 nsec, u16 seq_id)
> +{
> +	struct skb_shared_hwtstamps shhwtstamps;
> +	struct sk_buff *skb, *skb_tmp;
> +	unsigned long flags;
> +	bool rc = false;
> +	u16 skb_sig;
> +
> +	spin_lock_irqsave(&ptp_clock->tx_queue.lock, flags);
> +	skb_queue_walk_safe(&ptp_clock->tx_queue, skb, skb_tmp) {
> +		if (!mchp_ptp_get_sig_tx(skb, &skb_sig))
> +			continue;
> +
> +		if (memcmp(&skb_sig, &seq_id, sizeof(seq_id)))
> +			continue;
> +
> +		__skb_unlink(skb, &ptp_clock->tx_queue);
> +		rc = true;
> +		break;
> +	}
> +	spin_unlock_irqrestore(&ptp_clock->tx_queue.lock, flags);
> +
> +	if (rc) {
> +		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
> +		shhwtstamps.hwtstamp = ktime_set(seconds, nsec);
> +		skb_complete_tx_timestamp(skb, &shhwtstamps);
> +	}
> +}
> +
> +static struct mchp_ptp_rx_ts *mchp_ptp_get_rx_ts(struct mchp_ptp_clock *ptp_clock)
> +{
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	struct mchp_ptp_rx_ts *rx_ts = NULL;
> +	u32 sec, nsec;
> +	u16 seq;
> +	int rc;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_RX_INGRESS_NS_HI(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		goto error;
> +	if (!(rc & MCHP_PTP_RX_INGRESS_NS_HI_TS_VALID)) {
> +		phydev_err(phydev, "RX Timestamp is not valid!\n");
> +		goto error;
> +	}
> +	nsec = (rc & GENMASK(13, 0)) << 16;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_RX_INGRESS_NS_LO(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		goto error;
> +	nsec |= rc;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_RX_INGRESS_SEC_HI(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		goto error;
> +	sec = rc << 16;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_RX_INGRESS_SEC_LO(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		goto error;
> +	sec |= rc;
> +
> +	seq = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_RX_MSG_HEADER2(BASE_PORT(ptp_clock)));
> +	if (seq < 0)
> +		goto error;
> +
> +	rx_ts = kzalloc(sizeof(*rx_ts), GFP_KERNEL);

why zero out allocation? all fields of this structure are rewritten
unconditionally later (list_add happens in mchp_ptp_match_rx_ts) ...

> +	if (!rx_ts)
> +		return NULL;
> +
> +	rx_ts->seconds = sec;
> +	rx_ts->nsec = nsec;
> +	rx_ts->seq_id = seq;
> +
> +error:
> +	return rx_ts;
> +}
> +
> +static void mchp_ptp_process_rx_ts(struct mchp_ptp_clock *ptp_clock)
> +{
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	int caps;
> +
> +	do {
> +		struct mchp_ptp_rx_ts *rx_ts;
> +
> +		rx_ts = mchp_ptp_get_rx_ts(ptp_clock);
> +		if (rx_ts)
> +			mchp_ptp_match_rx_ts(ptp_clock, rx_ts);
> +
> +		caps = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +				    MCHP_PTP_CAP_INFO(BASE_PORT(ptp_clock)));
> +		if (caps < 0)
> +			return;
> +	} while (MCHP_PTP_RX_TS_CNT(caps) > 0);
> +}
> +

[ ... ]

