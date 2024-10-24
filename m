Return-Path: <netdev+bounces-138434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 783929AD906
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 02:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AC61C218B2
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CC250F8;
	Thu, 24 Oct 2024 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4K/xXRx"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927331CAAC
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729731264; cv=none; b=cHMrZUM/GnwhUOzXoxGztdWONeG20l4aEWSdYAc2fAMb7SnWBErrq6PEphY2HyGtxMoE9vMlHJf5X0X0cWSzUra21ZV6rCcmHSB9/9eUJDmgDrgHKQ17hYybpeCwA3XQnBRUM+PGLQ9usUzY6THfg/AYdmOS+AYVOMLFxWXCo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729731264; c=relaxed/simple;
	bh=w2E3F9KPincj5xXYDy/XBpkry1Zk9hO+S2Or2DOjkGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i78O8sqkxGKo7KKdMbpZMYY3j80uKPCy5rb6qaF5cjg7jT7R6dJAhGDZjaf9CEjRyp0FVUybZ66uzDX1cdx/n5h86Oph+l4ADahmG0x7bWTSsL9Xh+G32LQfgXBLSNvSFmi0VbQGFUjrdU69XCqr5HgKTF7XyuyD1wAnvcTtGJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o4K/xXRx; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <24147551-b639-4f9f-be5e-def2570a863d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729731254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVgoIaDu3a4uA7dKxjkeP2UOxgCvLj7AFtqJcyyqZug=;
	b=o4K/xXRxT7AUFPwBCSjwf44lTQOHULpN9EbY4czS5zwWDveZVONFNXcb/9na/RgypdxIph
	M9TrJanBk1TnRVtHOnyIFZn475xpRdqBWaSEMV1XTB4oZ4DnH77RdDhs8KCfUTVXORbfeA
	3oEgq4Z96J+6r5TMClGOLTyFSz5LWp8=
Date: Thu, 24 Oct 2024 01:54:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 10/15] net: lan969x: add PTP handler function
To: Daniel Machon <daniel.machon@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, horatiu.vultur@microchip.com,
 jensemil.schulzostergaard@microchip.com,
 Parthiban.Veerasooran@microchip.com, Raju.Lakkaraju@microchip.com,
 UNGLinuxDriver@microchip.com, Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com,
 ast@fiberby.net, maxime.chevallier@bootlin.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
 <20241024-sparx5-lan969x-switch-driver-2-v2-10-a0b5fae88a0f@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-10-a0b5fae88a0f@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/10/2024 23:01, Daniel Machon wrote:
> Add PTP IRQ handler for lan969x. This is required, as the PTP registers
> are placed in two different targets on Sparx5 and lan969x. The
> implementation is otherwise the same as on Sparx5.
> 
> Also, expose sparx5_get_hwtimestamp() for use by lan969x.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>   drivers/net/ethernet/microchip/lan969x/lan969x.c   | 90 ++++++++++++++++++++++
>   .../net/ethernet/microchip/sparx5/sparx5_main.h    |  5 ++
>   drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |  9 +--
>   3 files changed, 99 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
> index 2c2b86f9144e..a3b40e09b947 100644
> --- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
> +++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
> @@ -201,6 +201,95 @@ static int lan969x_port_mux_set(struct sparx5 *sparx5, struct sparx5_port *port,
>   	return 0;
>   }
>   
> +static irqreturn_t lan969x_ptp_irq_handler(int irq, void *args)
> +{
> +	int budget = SPARX5_MAX_PTP_ID;
> +	struct sparx5 *sparx5 = args;
> +
> +	while (budget--) {
> +		struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
> +		struct skb_shared_hwtstamps shhwtstamps;
> +		struct sparx5_port *port;
> +		struct timespec64 ts;
> +		unsigned long flags;
> +		u32 val, id, txport;
> +		u32 delay;
> +
> +		val = spx5_rd(sparx5, PTP_TWOSTEP_CTRL);
> +
> +		/* Check if a timestamp can be retrieved */
> +		if (!(val & PTP_TWOSTEP_CTRL_PTP_VLD))
> +			break;
> +
> +		WARN_ON(val & PTP_TWOSTEP_CTRL_PTP_OVFL);
> +
> +		if (!(val & PTP_TWOSTEP_CTRL_STAMP_TX))
> +			continue;
> +
> +		/* Retrieve the ts Tx port */
> +		txport = PTP_TWOSTEP_CTRL_STAMP_PORT_GET(val);
> +
> +		/* Retrieve its associated skb */
> +		port = sparx5->ports[txport];
> +
> +		/* Retrieve the delay */
> +		delay = spx5_rd(sparx5, PTP_TWOSTEP_STAMP_NSEC);
> +		delay = PTP_TWOSTEP_STAMP_NSEC_NS_GET(delay);
> +
> +		/* Get next timestamp from fifo, which needs to be the
> +		 * rx timestamp which represents the id of the frame
> +		 */
> +		spx5_rmw(PTP_TWOSTEP_CTRL_PTP_NXT_SET(1),
> +			 PTP_TWOSTEP_CTRL_PTP_NXT,
> +			 sparx5, PTP_TWOSTEP_CTRL);
> +
> +		val = spx5_rd(sparx5, PTP_TWOSTEP_CTRL);
> +
> +		/* Check if a timestamp can be retrieved */
> +		if (!(val & PTP_TWOSTEP_CTRL_PTP_VLD))
> +			break;
> +
> +		/* Read RX timestamping to get the ID */
> +		id = spx5_rd(sparx5, PTP_TWOSTEP_STAMP_NSEC);
> +		id <<= 8;
> +		id |= spx5_rd(sparx5, PTP_TWOSTEP_STAMP_SUBNS);
> +
> +		spin_lock_irqsave(&port->tx_skbs.lock, flags);
> +		skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
> +			if (SPARX5_SKB_CB(skb)->ts_id != id)
> +				continue;
> +
> +			__skb_unlink(skb, &port->tx_skbs);
> +			skb_match = skb;
> +			break;
> +		}
> +		spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
> +
> +		/* Next ts */
> +		spx5_rmw(PTP_TWOSTEP_CTRL_PTP_NXT_SET(1),
> +			 PTP_TWOSTEP_CTRL_PTP_NXT,
> +			 sparx5, PTP_TWOSTEP_CTRL);
> +
> +		if (WARN_ON(!skb_match))
> +			continue;
> +
> +		spin_lock(&sparx5->ptp_ts_id_lock);
> +		sparx5->ptp_skbs--;
> +		spin_unlock(&sparx5->ptp_ts_id_lock);
> +
> +		/* Get the h/w timestamp */
> +		sparx5_get_hwtimestamp(sparx5, &ts, delay);
> +
> +		/* Set the timestamp in the skb */
> +		shhwtstamps.hwtstamp = ktime_set(ts.tv_sec, ts.tv_nsec);
> +		skb_tstamp_tx(skb_match, &shhwtstamps);
> +
> +		dev_kfree_skb_any(skb_match);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +

This handler looks like an absolute copy of sparx5_ptp_irq_handler()
with the difference in registers only. Did you consider keep one
function but substitute ptp register sets?

>   static const struct sparx5_regs lan969x_regs = {
>   	.tsize = lan969x_tsize,
>   	.gaddr = lan969x_gaddr,
> @@ -242,6 +331,7 @@ static const struct sparx5_ops lan969x_ops = {
>   	.get_hsch_max_group_rate = &lan969x_get_hsch_max_group_rate,
>   	.get_sdlb_group          = &lan969x_get_sdlb_group,
>   	.set_port_mux            = &lan969x_port_mux_set,
> +	.ptp_irq_handler         = &lan969x_ptp_irq_handler,
>   };
>   

