Return-Path: <netdev+bounces-82835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D388FE4E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B645D2951A5
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A967D06B;
	Thu, 28 Mar 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKDotHXu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A42E3FE
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626398; cv=none; b=uno6n7CjDUEjHGtlyD8wm/0HfwVXDqjwcFyr3u6oYG1JHOEXnH1Xv3ImBjvvXP5fNxlvj1qR0I2D8CbSe3Ssfr+Gw/J/t0ubIXFfk2kQUD8nFf50bDVha0YoTp0vYRXXGpC5nQrF5yKtehIpio8gh2TiCUYaB0JXeVVUJb015mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626398; c=relaxed/simple;
	bh=jd50ccBDmt6hfv7/MdhphQmNaMN9Yc1zWRCQCEWQGJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3moIG8WVFxUoiE+Or7ezdMzmGkXtOsTbxy3Anw4Sv3fls4o5QXtoI+hOIuDbZ760o4GnBd0zmEVx+5RzuVdR2iv/KkGDXTBRJ9AUA1BgWVYYeimtmE9dpB4eAGUwXnR8LmopGWocnc74rVoVt9BHhThvABB85seGnvAXr3kWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKDotHXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65381C433C7;
	Thu, 28 Mar 2024 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711626397;
	bh=jd50ccBDmt6hfv7/MdhphQmNaMN9Yc1zWRCQCEWQGJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKDotHXu+veeELVCiF/IpiHPTI5PlSRQeftHjWipIhucI2ennUtM1GnHG0SQtt0ra
	 1yGJ7aKCno5sRi6bl97djZmNTRLbLinniGPCHccPSlflyH+jCECO0C9XtPWlNSjVDT
	 y922mr6oxOzySDoUCeICJMJoMt3NG6DN5psR1g37N9glgvdFc2KQiMgrQhqMsMTyNS
	 ODc7QFvvJqIKo+cgEA1AA49okRvSNIelw4BSMsACF2e/iwQXyjr2IdD1FtuPmFW+cJ
	 36pEwnND5LKiQKFxkrfoUSDhrZbBqXJ23tPcLoHp1r4+Sc4Uun1Ix4SMtSN203f5g0
	 2lM8pnIKqmYjw==
Date: Thu, 28 Mar 2024 11:46:33 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igc: Add MQPRIO offload support
Message-ID: <20240328114633.GI403975@kernel.org>
References: <20240212-igc_mqprio-v2-1-587924e6b18c@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-igc_mqprio-v2-1-587924e6b18c@linutronix.de>

On Tue, Mar 26, 2024 at 02:34:54PM +0100, Kurt Kanzenbach wrote:
> Add support for offloading MQPRIO. The hardware has four priorities as well
> as four queues. Each queue must be a assigned with a unique priority.
> 
> However, the priorities are only considered in TSN Tx mode. There are two
> TSN Tx modes. In case of MQPRIO the Qbv capability is not required.
> Therefore, use the legacy TSN Tx mode, which performs strict priority
> arbitration.
> 
> Example for mqprio with hardware offload:
> 
> |tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 4 \
> |   map 0 0 0 0 0 1 2 3 0 0 0 0 0 0 0 0 \
> |   queues 1@0 1@1 1@2 1@3 \
> |   hw 1
> 
> The mqprio Qdisc also allows to configure the `preemptible_tcs'. However,
> frame preemption is not supported yet.
> 
> Tested on Intel i225 and implemented by following data sheet section 7.5.2,
> Transmit Scheduling.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

...

> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 5f92b3c7c3d4..73502a0b4df7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -547,6 +547,15 @@
>  
>  #define IGC_MAX_SR_QUEUES		2
>  
> +#define IGC_TXARB_TXQ_PRIO_0_SHIFT	0
> +#define IGC_TXARB_TXQ_PRIO_1_SHIFT	2
> +#define IGC_TXARB_TXQ_PRIO_2_SHIFT	4
> +#define IGC_TXARB_TXQ_PRIO_3_SHIFT	6
> +#define IGC_TXARB_TXQ_PRIO_0_MASK	GENMASK(1, 0)
> +#define IGC_TXARB_TXQ_PRIO_1_MASK	GENMASK(3, 2)
> +#define IGC_TXARB_TXQ_PRIO_2_MASK	GENMASK(5, 4)
> +#define IGC_TXARB_TXQ_PRIO_3_MASK	GENMASK(7, 6)
> +
>  /* Receive Checksum Control */
>  #define IGC_RXCSUM_CRCOFL	0x00000800   /* CRC32 offload enable */
>  #define IGC_RXCSUM_PCSD		0x00002000   /* packet checksum disabled */
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c

...

> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c

...

> @@ -106,7 +109,26 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
>  	wr32(IGC_QBVCYCLET_S, 0);
>  	wr32(IGC_QBVCYCLET, NSEC_PER_SEC);
>  
> +	/* Reset mqprio TC configuration. */
> +	netdev_reset_tc(adapter->netdev);
> +
> +	/* Restore the default Tx arbitration: Priority 0 has the highest
> +	 * priority and is assigned to queue 0 and so on and so forth.
> +	 */
> +	txarb = rd32(IGC_TXARB);
> +	txarb &= ~(IGC_TXARB_TXQ_PRIO_0_MASK |
> +		   IGC_TXARB_TXQ_PRIO_1_MASK |
> +		   IGC_TXARB_TXQ_PRIO_2_MASK |
> +		   IGC_TXARB_TXQ_PRIO_3_MASK);
> +
> +	txarb |= 0x00 << IGC_TXARB_TXQ_PRIO_0_SHIFT;
> +	txarb |= 0x01 << IGC_TXARB_TXQ_PRIO_1_SHIFT;
> +	txarb |= 0x02 << IGC_TXARB_TXQ_PRIO_2_SHIFT;
> +	txarb |= 0x03 << IGC_TXARB_TXQ_PRIO_3_SHIFT;
> +	wr32(IGC_TXARB, txarb);

Hi Kurt,

It looks like the above would be a good candidate for using FIELD_PREP,
in which case the _SHIFT #defines can likely be removed.

Also, the logic above seems to be replicated in igc_tsn_enable_offload.
Perhaps a helper is appropriate.

> +
>  	adapter->flags &= ~IGC_FLAG_TSN_QBV_ENABLED;
> +	adapter->flags &= ~IGC_FLAG_TSN_LEGACY_ENABLED;
>  
>  	return 0;
>  }
> @@ -123,6 +145,50 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>  	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
>  	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
>  
> +	if (adapter->strict_priority_enable) {
> +		u32 txarb;
> +		int err;
> +
> +		err = netdev_set_num_tc(adapter->netdev, adapter->num_tc);
> +		if (err)
> +			return err;
> +
> +		for (i = 0; i < adapter->num_tc; i++) {
> +			err = netdev_set_tc_queue(adapter->netdev, i, 1,
> +						  adapter->queue_per_tc[i]);
> +			if (err)
> +				return err;
> +		}
> +
> +		/* In case the card is configured with less than four queues. */
> +		for (; i < IGC_MAX_TX_QUEUES; i++)
> +			adapter->queue_per_tc[i] = i;
> +
> +		/* Configure queue priorities according to the user provided
> +		 * mapping.
> +		 */
> +		txarb = rd32(IGC_TXARB);
> +		txarb &= ~(IGC_TXARB_TXQ_PRIO_0_MASK |
> +			   IGC_TXARB_TXQ_PRIO_1_MASK |
> +			   IGC_TXARB_TXQ_PRIO_2_MASK |
> +			   IGC_TXARB_TXQ_PRIO_3_MASK);
> +		txarb |= adapter->queue_per_tc[3] << IGC_TXARB_TXQ_PRIO_0_SHIFT;
> +		txarb |= adapter->queue_per_tc[2] << IGC_TXARB_TXQ_PRIO_1_SHIFT;
> +		txarb |= adapter->queue_per_tc[1] << IGC_TXARB_TXQ_PRIO_2_SHIFT;
> +		txarb |= adapter->queue_per_tc[0] << IGC_TXARB_TXQ_PRIO_3_SHIFT;
> +		wr32(IGC_TXARB, txarb);
> +
> +		/* Enable legacy TSN mode which will do strict priority without
> +		 * any other TSN features.
> +		 */
> +		tqavctrl = rd32(IGC_TQAVCTRL);
> +		tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN;
> +		tqavctrl &= ~IGC_TQAVCTRL_ENHANCED_QAV;
> +		wr32(IGC_TQAVCTRL, tqavctrl);
> +
> +		return 0;
> +	}
> +
>  	for (i = 0; i < adapter->num_tx_queues; i++) {
>  		struct igc_ring *ring = adapter->tx_ring[i];
>  		u32 txqctl = 0;

...

