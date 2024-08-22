Return-Path: <netdev+bounces-120936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5240495B3CD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DA81F2060E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8AB1C93D7;
	Thu, 22 Aug 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gju4OxEe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD31C93CC;
	Thu, 22 Aug 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326132; cv=none; b=EMYm4RRQRiYzi/iqrjSpuoHqEZAZrxGJGZ5djsDrDZy6kseDtQpV/oPvubURswEVTYOSZfVKrMynh3Bbwa+XFYKRmblgRzFTK6M5yLT7Ni+xWWK+h51f4+8KejsrSlEmfCnhI8CTwJosRIiDvXhKe/Iz6HpjvLaVkUoIs2TON7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326132; c=relaxed/simple;
	bh=wL0sZHwUaMwMnoPuWj1ZqLeGrzV6EUKnxxoXzzW482g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2ZftRahoaawaWRp6ehOEKHwZitOkjMZgggYBHGgOTmvAi4nL/azAQBaokk1D2YZ6uwNlqWZlsUVPnAtXKu8aKPU2jN6NoUYfxgLpyntXwqIbPWhc7E8cNPjQVWtt1Kt/48k8q2Uw1y9loro5cDl7zemwKLanJR8Jx6qJCnm/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gju4OxEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2968DC4AF0C;
	Thu, 22 Aug 2024 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724326132;
	bh=wL0sZHwUaMwMnoPuWj1ZqLeGrzV6EUKnxxoXzzW482g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gju4OxEetGlRuIZh0v8CUKsLk01CYEVSFe2UT3EQ8AWnToiL5WqxrbhDVoaXKBFtt
	 0THqbZYBSO7NWFUnJyIs22HlmPYYjQz7JYhFI89nz0AuH56eua+44TRjLdb+naEWF8
	 5XsA2LV697p7YzsJZY0Ld1msrgOg9ZRbGzA/NJkV8TyG8nYjrESXM15cYlCw7gAsok
	 FiHG80nJD7Xl4uUY0yZpeUt1joxQ/ZwelbpULo4JwN6EQ5ZqlN+9dSBm3YHwevgKqG
	 MYc3gQfi7tqzB7PusBVeiMCXzm1SUgSHOJqputxflQg000JLxbWs078yOaf6WEayKF
	 rpGenqwM+5GTQ==
Message-ID: <e89b3b8d-98db-4bf7-b90b-4df1fd1105e3@kernel.org>
Date: Thu, 22 Aug 2024 14:28:45 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/7] net: ti: icssg-prueth: Enable HSR Tx Tag
 and Rx Tag offload
To: MD Danish Anwar <danishanwar@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Jan Kiszka <jan.kiszka@siemens.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-8-danishanwar@ti.com>
 <9f8beb62-42db-47d9-bba6-f942a655217d@kernel.org>
 <cfb025a4-41a4-448f-a7a8-7ce14f8532f5@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <cfb025a4-41a4-448f-a7a8-7ce14f8532f5@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/08/2024 11:03, MD Danish Anwar wrote:
> 
> 
> On 21/08/24 5:45 pm, Roger Quadros wrote:
>>
>>
>> On 13/08/2024 10:42, MD Danish Anwar wrote:
>>> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>>
>>> Add support to offload HSR Tx Tag Insertion and Rx Tag Removal
>>> and duplicate discard.
>>
>> I can see code for Tx Tag insertion and RX tag removal.
>> Where are you doing duplicate discard in this patch?
>>
> 
> Roger, duplicate discard is done as part of RX tag removal and it is
> done by firmware.
> When driver sends the command ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE, firmware
> does RX tag removal as well as duplicate discard.
> 
> Maybe I can modify the commit message to stated that duplicate discard
> is done as part of rx tag removal?

Yes please, that will help. Thanks!

> 
>>>
>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>> ---
>>>  drivers/net/ethernet/ti/icssg/icssg_common.c |  3 +++
>>>  drivers/net/ethernet/ti/icssg/icssg_config.c |  4 +++-
>>>  drivers/net/ethernet/ti/icssg/icssg_config.h |  2 ++
>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 11 ++++++++++-
>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
>>>  5 files changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
>>> index 2d6d8648f5a9..4eae4f9250c0 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
>>> @@ -721,6 +721,9 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>>>  	if (prueth->is_hsr_offload_mode && (ndev->features & NETIF_F_HW_HSR_DUP))
>>>  		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
>>>  
>>> +	if (prueth->is_hsr_offload_mode && (ndev->features & NETIF_F_HW_HSR_TAG_INS))
>>> +		epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
>>> +
>>>  	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
>>>  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>>>  	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> index 2f485318c940..f061fa97a377 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> @@ -531,7 +531,9 @@ static const struct icssg_r30_cmd emac_r32_bitmask[] = {
>>>  	{{EMAC_NONE,  0xffff4000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx ENABLE*/
>>>  	{{EMAC_NONE,  0xbfff0000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx DISABLE*/
>>>  	{{0xffff0010,  EMAC_NONE, 0xffff0010, EMAC_NONE}},	/* VLAN AWARE*/
>>> -	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}}	/* VLAN UNWARE*/
>>> +	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}},	/* VLAN UNWARE*/
>>> +	{{0xffff2000, EMAC_NONE, EMAC_NONE, EMAC_NONE}},	/* HSR_RX_OFFLOAD_ENABLE */
>>> +	{{0xdfff0000, EMAC_NONE, EMAC_NONE, EMAC_NONE}}		/* HSR_RX_OFFLOAD_DISABLE */
>>>  };
>>>  
>>>  int icssg_set_port_state(struct prueth_emac *emac,
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
>>> index 1ac60283923b..92c2deaa3068 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
>>> @@ -80,6 +80,8 @@ enum icssg_port_state_cmd {
>>>  	ICSSG_EMAC_PORT_PREMPT_TX_DISABLE,
>>>  	ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE,
>>>  	ICSSG_EMAC_PORT_VLAN_AWARE_DISABLE,
>>> +	ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE,
>>> +	ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE,
>>>  	ICSSG_EMAC_PORT_MAX_COMMANDS
>>>  };
>>>  
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> index 521e9f914459..582e72dd8f3f 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> @@ -42,7 +42,9 @@
>>>  #define DEFAULT_UNTAG_MASK	1
>>>  
>>>  #define NETIF_PRUETH_HSR_OFFLOAD	(NETIF_F_HW_HSR_FWD | \
>>> -					 NETIF_F_HW_HSR_DUP)
>>> +					 NETIF_F_HW_HSR_DUP | \
>>> +					 NETIF_F_HW_HSR_TAG_INS | \
>>> +					 NETIF_F_HW_HSR_TAG_RM)
>>>  
>>>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>>>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>>> @@ -1032,6 +1034,13 @@ static void icssg_change_mode(struct prueth *prueth)
>>>  
>>>  	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
>>>  		emac = prueth->emac[mac];
>>> +		if (prueth->is_hsr_offload_mode) {
>>> +			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
>>> +				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
> 
> Duplicate discard is done here ^^^^

Got it.

> 
>>> +			else
>>> +				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE);
>>> +		}
>>> +
>>>  		if (netif_running(emac->ndev)) {
>>>  			icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
>>>  					  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> index 6cb1dce8b309..246f1e41c13a 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> @@ -58,6 +58,7 @@
>>>  #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
>>>  
>>>  #define PRUETH_UNDIRECTED_PKT_DST_TAG	0
>>> +#define PRUETH_UNDIRECTED_PKT_TAG_INS	BIT(30)
>>>  
>>>  /* Firmware status codes */
>>>  #define ICSS_HS_FW_READY 0x55555555
>>
> 

-- 
cheers,
-roger

