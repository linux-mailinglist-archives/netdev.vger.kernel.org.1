Return-Path: <netdev+bounces-82323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF50788D440
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 03:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E77C1C2427C
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 02:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D281CD2B;
	Wed, 27 Mar 2024 02:04:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A40200C1
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505050; cv=none; b=uS7D8er4b9xhWEkCIJVCH4ktwWckbPGkiyLMUKGqEoWReERj09z6qnLUB9LoLKQvECOThG/MuazOAukuqzeRs1YOTYVQeargvaj4LS2NTHb22PCTdL09x5GJvfd2CGC8DhVHRK7XkWCS9olVmS5AM7aMuX7fEXswXNAHJYnK3Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505050; c=relaxed/simple;
	bh=lr7///j4Gaq6xpWYuUBN5N61RURq6o6XJy5WdItWIho=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kWLISL5bGWVmCPB3vYFjFtliJgVjEcW1i/Kc1gwQe99zJXZp/nfPW5SnhKIbT+edfOfsBEBhcfJSRGEcG6G9JQM03u86mLKhxFi34ivCsGhOK/sQEmhXlB/w32MY2Y5qjE98u0XtBCmnurlB4CnlvV6SexV5XVM7U1TsJ0YWQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V48zS32r9zwQN1;
	Wed, 27 Mar 2024 10:01:24 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AAA218005D;
	Wed, 27 Mar 2024 10:04:04 +0800 (CST)
Received: from [10.67.120.135] (10.67.120.135) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 10:04:03 +0800
Subject: Re: [PATCH iwl-next v2] igc: Add MQPRIO offload support
To: Kurt Kanzenbach <kurt@linutronix.de>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
References: <20240212-igc_mqprio-v2-1-587924e6b18c@linutronix.de>
From: "shenjian (K)" <shenjian15@huawei.com>
Message-ID: <41a56bb7-8845-f85b-c470-a3683bac8b69@huawei.com>
Date: Wed, 27 Mar 2024 10:04:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240212-igc_mqprio-v2-1-587924e6b18c@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



在 2024/3/26 21:34, Kurt Kanzenbach 写道:
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
> ---
> Changes in v2:
> - Improve changelog (Paul Menzel)
> - Link to v1: https://lore.kernel.org/r/20240212-igc_mqprio-v1-1-7aed95b736db@linutronix.de
> ---
>   drivers/net/ethernet/intel/igc/igc.h         | 10 +++-
>   drivers/net/ethernet/intel/igc/igc_defines.h |  9 ++++
>   drivers/net/ethernet/intel/igc/igc_main.c    | 69 +++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_regs.h    |  2 +
>   drivers/net/ethernet/intel/igc/igc_tsn.c     | 71 +++++++++++++++++++++++++++-
>   5 files changed, 157 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 90316dc58630..49ba753ce957 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -227,6 +227,10 @@ struct igc_adapter {
>   	 */
>   	spinlock_t qbv_tx_lock;
>   
> +	bool strict_priority_enable;
> +	u8 num_tc;
> +	u16 queue_per_tc[IGC_MAX_TX_QUEUES];
> +
>   	/* OS defined structs */
>   	struct pci_dev *pdev;
>   	/* lock for statistics */
> @@ -346,9 +350,11 @@ extern char igc_driver_name[];
>   #define IGC_FLAG_RX_LEGACY		BIT(16)
>   #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
>   #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
> +#define IGC_FLAG_TSN_LEGACY_ENABLED	BIT(19)
>   
> -#define IGC_FLAG_TSN_ANY_ENABLED \
> -	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED)
> +#define IGC_FLAG_TSN_ANY_ENABLED				\
> +	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
> +	 IGC_FLAG_TSN_LEGACY_ENABLED)
>   
>   #define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
>   #define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 5f92b3c7c3d4..73502a0b4df7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -547,6 +547,15 @@
>   
>   #define IGC_MAX_SR_QUEUES		2
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
>   /* Receive Checksum Control */
>   #define IGC_RXCSUM_CRCOFL	0x00000800   /* CRC32 offload enable */
>   #define IGC_RXCSUM_PCSD		0x00002000   /* packet checksum disabled */
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 2e1cfbd82f4f..b17764973d74 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6415,6 +6415,13 @@ static int igc_tc_query_caps(struct igc_adapter *adapter,
>   	struct igc_hw *hw = &adapter->hw;
>   
>   	switch (base->type) {
> +	case TC_SETUP_QDISC_MQPRIO: {
> +		struct tc_mqprio_caps *caps = base->caps;
> +
> +		caps->validate_queue_counts = true;
> +
> +		return 0;
> +	}
>   	case TC_SETUP_QDISC_TAPRIO: {
>   		struct tc_taprio_caps *caps = base->caps;
>   
> @@ -6432,6 +6439,65 @@ static int igc_tc_query_caps(struct igc_adapter *adapter,
>   	}
>   }
>   
> +static void igc_save_mqprio_params(struct igc_adapter *adapter, u8 num_tc,
> +				   u16 *offset)
> +{
> +	int i;
> +
> +	adapter->strict_priority_enable = true;
> +	adapter->num_tc = num_tc;
> +
> +	for (i = 0; i < num_tc; i++)
> +		adapter->queue_per_tc[i] = offset[i];
> +}
> +
> +static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
> +				 struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct igc_hw *hw = &adapter->hw;
> +	int i;
> +
> +	if (hw->mac.type != igc_i225)
> +		return -EOPNOTSUPP;
> +
> +	if (!mqprio->qopt.num_tc) {
> +		adapter->strict_priority_enable = false;
> +		goto apply;
> +	}
> +
> +	/* There are as many TCs as Tx queues. */
> +	if (mqprio->qopt.num_tc != adapter->num_tx_queues) {
> +		NL_SET_ERR_MSG_FMT_MOD(mqprio->extack,
> +				       "Only %d traffic classes supported",
> +				       adapter->num_tx_queues);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Only one queue per TC is supported. */
> +	for (i = 0; i < mqprio->qopt.num_tc; i++) {
> +		if (mqprio->qopt.count[i] != 1) {
> +			NL_SET_ERR_MSG_MOD(mqprio->extack,
> +					   "Only one queue per TC supported");
> +			return -EOPNOTSUPP;
> +		}
> +	}
When mqprio enabled for igc, only one queue per TC supported. Is 
set_channels by ethtool
allowed in this case ?  If not, it's better to add limitation in 
icg_ethtool_set_channels.

Thanks,

Jian

> +
> +	/* Preemption is not supported yet. */
> +	if (mqprio->preemptible_tcs) {
> +		NL_SET_ERR_MSG_MOD(mqprio->extack,
> +				   "Preemption is not supported yet");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	igc_save_mqprio_params(adapter, mqprio->qopt.num_tc,
> +			       mqprio->qopt.offset);
> +
> +	mqprio->qopt.hw = TC_MQPRIO_HW_OFFLOAD_TCS;
> +
> +apply:
> +	return igc_tsn_offload_apply(adapter);
> +}
> +
>   static int igc_setup_tc(struct net_device *dev, enum tc_setup_type type,
>   			void *type_data)
>   {
> @@ -6451,6 +6517,9 @@ static int igc_setup_tc(struct net_device *dev, enum tc_setup_type type,
>   	case TC_SETUP_QDISC_CBS:
>   		return igc_tsn_enable_cbs(adapter, type_data);
>   
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return igc_tsn_enable_mqprio(adapter, type_data);
> +
>   	default:
>   		return -EOPNOTSUPP;
>   	}
> diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
> index e5b893fc5b66..c83c723f7c7e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
> @@ -238,6 +238,8 @@
>   #define IGC_TQAVCC(_n)		(0x3004 + ((_n) * 0x40))
>   #define IGC_TQAVHC(_n)		(0x300C + ((_n) * 0x40))
>   
> +#define IGC_TXARB		0x3354 /* Tx Arbitration Control TxARB - RW */
> +
>   /* System Time Registers */
>   #define IGC_SYSTIML	0x0B600  /* System time register Low - RO */
>   #define IGC_SYSTIMH	0x0B604  /* System time register High - RO */
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 22cefb1eeedf..5e2e1c6076f3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -46,6 +46,9 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
>   	if (is_cbs_enabled(adapter))
>   		new_flags |= IGC_FLAG_TSN_QAV_ENABLED;
>   
> +	if (adapter->strict_priority_enable)
> +		new_flags |= IGC_FLAG_TSN_LEGACY_ENABLED;
> +
>   	return new_flags;
>   }
>   
> @@ -84,7 +87,7 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
>   static int igc_tsn_disable_offload(struct igc_adapter *adapter)
>   {
>   	struct igc_hw *hw = &adapter->hw;
> -	u32 tqavctrl;
> +	u32 tqavctrl, txarb;
>   	int i;
>   
>   	wr32(IGC_GTXOFFSET, 0);
> @@ -106,7 +109,26 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
>   	wr32(IGC_QBVCYCLET_S, 0);
>   	wr32(IGC_QBVCYCLET, NSEC_PER_SEC);
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
> +
>   	adapter->flags &= ~IGC_FLAG_TSN_QBV_ENABLED;
> +	adapter->flags &= ~IGC_FLAG_TSN_LEGACY_ENABLED;
>   
>   	return 0;
>   }
> @@ -123,6 +145,50 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>   	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
>   	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
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
>   	for (i = 0; i < adapter->num_tx_queues; i++) {
>   		struct igc_ring *ring = adapter->tx_ring[i];
>   		u32 txqctl = 0;
> @@ -339,7 +405,8 @@ int igc_tsn_offload_apply(struct igc_adapter *adapter)
>   	 * cannot be changed dynamically. Require reset the adapter.
>   	 */
>   	if (netif_running(adapter->netdev) &&
> -	    (igc_is_device_id_i225(hw) || !adapter->qbv_count)) {
> +	    (igc_is_device_id_i225(hw) || !adapter->qbv_count ||
> +	     !adapter->strict_priority_enable)) {
>   		schedule_work(&adapter->reset_task);
>   		return 0;
>   	}
>
> ---
> base-commit: 537c2e91d3549e5d6020bb0576cf9b54a845255f
> change-id: 20240212-igc_mqprio-039650006128
>
> Best regards,


