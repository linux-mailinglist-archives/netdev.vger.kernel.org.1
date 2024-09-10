Return-Path: <netdev+bounces-127123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D24AB974346
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 21:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0244B1C2635E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C11A76DA;
	Tue, 10 Sep 2024 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKxWTSih"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B71A7072;
	Tue, 10 Sep 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995711; cv=none; b=Aw4IEgS3o2PZl/XWKASTjCT6m8LUCYRw2V9QONBcYxJRMnWgZI/vgg0bxqe6SCPxDCQkOsJngDiVgS74VKXvacdGhid2/1/ybnf9rhfAgrjxSKnXpNLCvYePYEd0Dyc252era+dUPLZkEwu+99+4XF3tuJVvolBVXvWZvBpFhwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995711; c=relaxed/simple;
	bh=x+/mJ0BvlD1a8ZLy2Y//uln5RWCagFIAwvRFw25XJDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUxpSLkMAzG1NIeq5sep2HZwtKja45V7mGEZxnMcxwR7xWs+OAMeLrrsDUa0ci+bObLAD6Dr64MDUnb+1Y5MbIGv4R/o6vb2I0ICR4VI1qYi2bI/4oVBxy298zjvSY9JiP6rAa0OLIw/mdFdEFEyIrbTLEcnREw9JRvpj4GUYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKxWTSih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D709C4CEC3;
	Tue, 10 Sep 2024 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725995710;
	bh=x+/mJ0BvlD1a8ZLy2Y//uln5RWCagFIAwvRFw25XJDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sKxWTSih5okge8V7EJfpXXdWz69rQ6nSG0zlrLR517+wIPh9x3UE632+seBMmNUHq
	 fH9/Nv32pkovI/R8USBIoVgVLpP6OMWSYLEiYa0KodEgLPNIV3K8H4oZiO+V8IEapw
	 8fxSBgwd5FvVGNMaUNV1aQhLWTpAuF/jASm5q5weUOuE6L8V+jFhOHYnRHRzMVLjv6
	 JTRGHZR3JIfTviC2P8hNZWqytEyqK336JWMML26qG8zU3eRUJpM63OPH8sBj9wP9XE
	 lfhMiF5alQnDqYTIoi8M5FI4SKf/f57Y9jBEQdeKTI0soe6a10zuhhW3Kg/Re4Qm24
	 rwpeHRK5g3fYQ==
Message-ID: <82d4d4b4-0db9-4fbf-972f-c7ee5ce9cec4@kernel.org>
Date: Tue, 10 Sep 2024 22:15:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/5] net: ti: icssg-prueth: Enable HSR Tx
 duplication, Tx Tag and Rx Tag offload
To: "Anwar, Md Danish" <a0501179@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, robh@kernel.org, jan.kiszka@siemens.com,
 dan.carpenter@linaro.org, saikrishnag@marvell.com, andrew@lunn.ch,
 javier.carrasco.cruz@gmail.com, jacob.e.keller@intel.com,
 diogo.ivo@siemens.com, horms@kernel.org, richardcochran@gmail.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240906111538.1259418-1-danishanwar@ti.com>
 <20240906111538.1259418-5-danishanwar@ti.com>
 <7df37a43-e2d6-4775-859d-1ca05f456e21@kernel.org>
 <e2379571-09ab-4061-8428-37707de32bc5@ti.com>
 <6ef4b928-a46c-4462-bfec-7d5d463d3bea@kernel.org>
 <166d37d1-1590-4b0a-8c20-3c635726a733@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <166d37d1-1590-4b0a-8c20-3c635726a733@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/09/2024 21:27, Anwar, Md Danish wrote:
> 
> 
> On 9/10/2024 11:36 PM, Roger Quadros wrote:
>>
>>
>> On 10/09/2024 20:52, Anwar, Md Danish wrote:
>>> Hi Roger,
>>>
>>> On 9/10/2024 11:08 PM, Roger Quadros wrote:
>>>>
>>>>
>>>> On 06/09/2024 14:15, MD Danish Anwar wrote:
>>>>> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>>>>
>>>>> The HSR stack allows to offload its Tx packet duplication functionality to
>>>>> the hardware. Enable this offloading feature for ICSSG driver. Add support
>>>>> to offload HSR Tx Tag Insertion and Rx Tag Removal and duplicate discard.
>>>>>
>>>>> Inorder to enable hsr-tag-ins-offload, hsr-dup-offload must also be enabled
>>>>
>>>> "In order"
>>>>
>>>>> as these are tightly coupled in the firmware implementation.
>>>>>
>>>>> Duplicate discard is done as part of RX tag removal and it is
>>>>> done by the firmware. When driver sends the r30 command
>>>>> ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE, firmware does RX tag removal as well as
>>>>> duplicate discard.
>>>>>
>>>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>>>>  drivers/net/ethernet/ti/icssg/icssg_common.c | 18 ++++++++++---
>>>>>  drivers/net/ethernet/ti/icssg/icssg_config.c |  4 ++-
>>>>>  drivers/net/ethernet/ti/icssg/icssg_config.h |  2 ++
>>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 28 +++++++++++++++++++-
>>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 +++
>>>>>  5 files changed, 50 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
>>>>> index b9d8a93d1680..fdebeb2f84e0 100644
>>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
>>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
>>>>> @@ -660,14 +660,15 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>>>>>  {
>>>>>  	struct cppi5_host_desc_t *first_desc, *next_desc, *cur_desc;
>>>>>  	struct prueth_emac *emac = netdev_priv(ndev);
>>>>> +	struct prueth *prueth = emac->prueth;
>>>>>  	struct netdev_queue *netif_txq;
>>>>>  	struct prueth_tx_chn *tx_chn;
>>>>>  	dma_addr_t desc_dma, buf_dma;
>>>>> +	u32 pkt_len, dst_tag_id;
>>>>>  	int i, ret = 0, q_idx;
>>>>>  	bool in_tx_ts = 0;
>>>>>  	int tx_ts_cookie;
>>>>>  	void **swdata;
>>>>> -	u32 pkt_len;
>>>>>  	u32 *epib;
>>>>>  
>>>>>  	pkt_len = skb_headlen(skb);
>>>>> @@ -712,9 +713,20 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>>>>>  
>>>>>  	/* set dst tag to indicate internal qid at the firmware which is at
>>>>>  	 * bit8..bit15. bit0..bit7 indicates port num for directed
>>>>> -	 * packets in case of switch mode operation
>>>>> +	 * packets in case of switch mode operation and port num 0
>>>>> +	 * for undirected packets in case of HSR offload mode
>>>>>  	 */
>>>>> -	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
>>>>> +	dst_tag_id = emac->port_id | (q_idx << 8);
>>>>> +
>>>>> +	if (prueth->is_hsr_offload_mode &&
>>>>> +	    (ndev->features & NETIF_F_HW_HSR_DUP))
>>>>> +		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
>>>>> +
>>>>> +	if (prueth->is_hsr_offload_mode &&
>>>>> +	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
>>>>> +		epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
>>>>> +
>>>>> +	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
>>>>>  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>>>>>  	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
>>>>>  	swdata = cppi5_hdesc_get_swdata(first_desc);
>>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>>>> index 7b2e6c192ff3..72ace151d8e9 100644
>>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>>>> @@ -531,7 +531,9 @@ static const struct icssg_r30_cmd emac_r32_bitmask[] = {
>>>>>  	{{EMAC_NONE,  0xffff4000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx ENABLE*/
>>>>>  	{{EMAC_NONE,  0xbfff0000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx DISABLE*/
>>>>>  	{{0xffff0010,  EMAC_NONE, 0xffff0010, EMAC_NONE}},	/* VLAN AWARE*/
>>>>> -	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}}	/* VLAN UNWARE*/
>>>>> +	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}},	/* VLAN UNWARE*/
>>>>> +	{{0xffff2000, EMAC_NONE, EMAC_NONE, EMAC_NONE}},	/* HSR_RX_OFFLOAD_ENABLE */
>>>>> +	{{0xdfff0000, EMAC_NONE, EMAC_NONE, EMAC_NONE}}		/* HSR_RX_OFFLOAD_DISABLE */
>>>>>  };
>>>>>  
>>>>>  int icssg_set_port_state(struct prueth_emac *emac,
>>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
>>>>> index 1ac60283923b..92c2deaa3068 100644
>>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
>>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
>>>>> @@ -80,6 +80,8 @@ enum icssg_port_state_cmd {
>>>>>  	ICSSG_EMAC_PORT_PREMPT_TX_DISABLE,
>>>>>  	ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE,
>>>>>  	ICSSG_EMAC_PORT_VLAN_AWARE_DISABLE,
>>>>> +	ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE,
>>>>> +	ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE,
>>>>>  	ICSSG_EMAC_PORT_MAX_COMMANDS
>>>>>  };
>>>>>  
>>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>>> index 676168d6fded..9af06454ba64 100644
>>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>>> @@ -41,7 +41,10 @@
>>>>>  #define DEFAULT_PORT_MASK	1
>>>>>  #define DEFAULT_UNTAG_MASK	1
>>>>>  
>>>>> -#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	NETIF_F_HW_HSR_FWD
>>>>> +#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	(NETIF_F_HW_HSR_FWD | \
>>>>> +						 NETIF_F_HW_HSR_DUP | \
>>>>> +						 NETIF_F_HW_HSR_TAG_INS | \
>>>>> +						 NETIF_F_HW_HSR_TAG_RM)
>>>>>  
>>>>>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>>>>>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>>>>> @@ -758,6 +761,21 @@ static void emac_change_hsr_feature(struct net_device *ndev,
>>>>>  	}
>>>>>  }
>>>>>  
>>>>> +static netdev_features_t emac_ndo_fix_features(struct net_device *ndev,
>>>>> +					       netdev_features_t features)
>>>>> +{
>>>>> +	/* In order to enable hsr tag insertion offload, hsr dup offload must
>>>>> +	 * also be enabled as these two are tightly coupled in firmware
>>>>> +	 * implementation.
>>>>> +	 */
>>>>> +	if (features & NETIF_F_HW_HSR_TAG_INS)
>>>>> +		features |= NETIF_F_HW_HSR_DUP;
>>>>
>>>> What if only NETIF_F_HW_HSR_DUP was set? Don't you have to set NETIF_F_HW_HSR_TAG_INS as well?
>>>>
>>>>> +	else
>>>>> +		features &= ~NETIF_F_HW_HSR_DUP;
>>>>
>>>> what if NETIF_F_HW_HSR_DUP was still set?
>>>>
>>>> I think you need to write a logic like follows.
>>>> 	if both are already cleared in ndev->features and any one is set in features you set both in features.
>>>> 	if both are already set in ndev->features and any one is cleared in features you clear both in features.
>>>>
>>>> is this reasonable?
>>>>
>>>
>>> Yes that does sound reasonable,
>>> How does below code look to you.
>>>
>>> 	if (!(ndev->features & NETIF_F_HW_HSR_DUP) &&
>>> 	    !(ndev->features & NETIF_F_HW_HSR_TAG_INS))
>>
>> While this is OK. it could also be
>> 	if (!(ndev->features & (NETIF_F_HW_HSR_DUP | NETIF_F_HW_HSR_TAG_INS)))
>> Your choice.
>>
>>> 		if ((features & NETIF_F_HW_HSR_DUP) ||
>>> 		    (features & NETIF_F_HW_HSR_TAG_INS)) {
>>> 			features |= NETIF_F_HW_HSR_DUP;
>>> 			features |= NETIF_F_HW_HSR_TAG_INS;
>> how about one line?
>> 			features |= NETIF_F_HW_HSR_DUP | NETIF_F_HW_HSR_TAG_INS;
>>> 		}
>>
>> then you can get rid of the braces.
>>
> 
> Yes I could do this but this make the line length go beyond 80
> characters. That's why I thought of putting this in two lines.

then you can split the line
e.g.
			features |= NETIF_F_HW_HSR_DUP |
				    NETIF_F_HW_HSR_TAG_INS;
> 
>>>
>>> 	if ((ndev->features & NETIF_F_HW_HSR_DUP) &&
>>> 	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
>>> 		if (!(features & NETIF_F_HW_HSR_DUP) ||
>>> 		    !(features & NETIF_F_HW_HSR_TAG_INS)) {
>>> 			features &= ~NETIF_F_HW_HSR_DUP;
>>> 			features &= ~NETIF_F_HW_HSR_TAG_INS;
>>
>> 			features &= ~(NETIF_F_HW_HSR_DUP | NETIF_F_HW_HSR_TAG_INS);
>>
>>> 		}
>>>
>>>>> +
>>>>> +	return features;
>>>>> +}
>>>>> +
>>>>>  static int emac_ndo_set_features(struct net_device *ndev,
>>>>>  				 netdev_features_t features)
>>>>>  {
>>>>> @@ -780,6 +798,7 @@ static const struct net_device_ops emac_netdev_ops = {
>>>>>  	.ndo_eth_ioctl = icssg_ndo_ioctl,
>>>>>  	.ndo_get_stats64 = icssg_ndo_get_stats64,
>>>>>  	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
>>>>> +	.ndo_fix_features = emac_ndo_fix_features,
>>>>>  	.ndo_set_features = emac_ndo_set_features,
>>>>>  };
>>>>>  
>>>>> @@ -1007,6 +1026,13 @@ static void icssg_change_mode(struct prueth *prueth)
>>>>>  
>>>>>  	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
>>>>>  		emac = prueth->emac[mac];
>>>>> +		if (prueth->is_hsr_offload_mode) {
>>>>> +			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
>>>>> +				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
>>>>> +			else
>>>>> +				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE);
>>>>> +		}
>>>>> +
>>>>>  		if (netif_running(emac->ndev)) {
>>>>>  			icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
>>>>>  					  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
>>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>>> index a4b025fae797..bba6da2e6bd8 100644
>>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>>> @@ -59,6 +59,9 @@
>>>>>  
>>>>>  #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
>>>>>  
>>>>> +#define PRUETH_UNDIRECTED_PKT_DST_TAG	0
>>>>> +#define PRUETH_UNDIRECTED_PKT_TAG_INS	BIT(30)
>>>>> +
>>>>>  /* Firmware status codes */
>>>>>  #define ICSS_HS_FW_READY 0x55555555
>>>>>  #define ICSS_HS_FW_DEAD 0xDEAD0000	/* lower 16 bits contain error code */
>>>>
>>>
>>
> 

-- 
cheers,
-roger

