Return-Path: <netdev+bounces-75059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D97867FEF
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0025C28F071
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 18:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DFF12B141;
	Mon, 26 Feb 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+1o7Aq1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7D1DFF4
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972866; cv=none; b=Smcr6TbibGDfq1ieyLw7BD806eD1lTq4YDcNtUiy2G/r35qYuYcmSqHr/JohPzii3ImRMIgqazhL4AWfS08ovze5s20pK5z28jDIAW50HvjHhTF0YhITs07n6ivujrzrMIcvHsw7F9Yu1QPXxjzuGsSybc42n5ElygQUrgd6Jng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972866; c=relaxed/simple;
	bh=A+tT3Up2nOHXFrnZGVZ8mxZHRFa1SQK9ovR/IFAJ5WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqRSj+qbL8TEm9tmt/TvqiHCNnBJoosOaCRokMO/fHnrdLXKNkj8bxTseAkMsHKcY+qg6ISNRQQb05bYV6/rnKMcDUQUNyp38/4JICW3mIjVfi4W8TBpK168RgMR/tHjFzttJLX1mH/93Y/Ru/n2BgFrUFHw/qFe612qh8YmIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+1o7Aq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80733C433F1;
	Mon, 26 Feb 2024 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708972866;
	bh=A+tT3Up2nOHXFrnZGVZ8mxZHRFa1SQK9ovR/IFAJ5WE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K+1o7Aq1aMcH8/VANLzwz/xBHquZhvFpnCr8vaJJkPwQ7IxHMADv6hlT7Wgi3pa7D
	 LCjAqBwA+UOlYP9/9l+kszAI1EuZsy85My6CejL2roRx5xmNMLOzB8xsmmd30ckwTd
	 QoO969wxB+wcO0fdXXVc9ddM8njj62XQoqpNe2MO1tI5UpeiKrVL1LcQjUuoHD5ftq
	 NWwVB0I+rInhZx5i2xc7TsNxWD1KELzxckVFuU8bwZH/kvddbZ8zPW04naipmCn2Vz
	 1NsxJkVZOcQ1a5uLwRLpmPCbHlXD8gO2YMhzwpIV0JFUgxV5bkEvWZinIwjTLXUvV3
	 e3EbUMDCPKtEQ==
Message-ID: <1963b69d-2656-40d1-9794-8d0a9a168eed@kernel.org>
Date: Mon, 26 Feb 2024 20:41:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/10] net: ti: icssg-prueth: Add functions to
 configure SR1.0 packet classifier
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, dan.carpenter@linaro.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-9-diogo.ivo@siemens.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240221152421.112324-9-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/02/2024 17:24, Diogo Ivo wrote:
> Add the functions to configure the SR1.0 packet classifier.
> 
> Based on the work of Roger Quadros in TI's 5.10 SDK [1].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
> Changes in v3:
>  - Replace local variables in icssg_class_add_mcast_sr1()
>    with eth_reserved_addr_base and eth_ipv4_mcast_addr_base
> 
>  .../net/ethernet/ti/icssg/icssg_classifier.c  | 113 ++++++++++++++++--
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   2 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +-
>  3 files changed, 110 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> index 6df53ab17fbc..71b2f89ccd8e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> @@ -274,6 +274,16 @@ static void rx_class_set_or(struct regmap *miig_rt, int slice, int n,
>  	regmap_write(miig_rt, offset, data);
>  }
>  
> +static u32 rx_class_get_or(struct regmap *miig_rt, int slice, int n)
> +{
> +	u32 offset, val;
> +
> +	offset = RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN);
> +	regmap_read(miig_rt, offset, &val);
> +
> +	return val;
> +}
> +
>  void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac)
>  {
>  	regmap_write(miig_rt, MAC_INTERFACE_0, (u32)(mac[0] | mac[1] << 8 |
> @@ -288,6 +298,26 @@ void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
>  	regmap_write(miig_rt, offs[slice].mac1, (u32)(mac[4] | mac[5] << 8));
>  }
>  
> +static void icssg_class_ft1_add_mcast(struct regmap *miig_rt, int slice,
> +				      int slot, const u8 *addr, const u8 *mask)
> +{
> +	int i;
> +	u32 val;
> +
> +	WARN(slot >= FT1_NUM_SLOTS, "invalid slot: %d\n", slot);
> +
> +	rx_class_ft1_set_da(miig_rt, slice, slot, addr);
> +	rx_class_ft1_set_da_mask(miig_rt, slice, slot, mask);
> +	rx_class_ft1_cfg_set_type(miig_rt, slice, slot, FT1_CFG_TYPE_EQ);
> +
> +	/* Enable the FT1 slot in OR enable for all classifiers */
> +	for (i = 0; i < ICSSG_NUM_CLASSIFIERS_IN_USE; i++) {
> +		val = rx_class_get_or(miig_rt, slice, i);
> +		val |= RX_CLASS_FT_FT1_MATCH(slot);
> +		rx_class_set_or(miig_rt, slice, i, val);
> +	}
> +}
> +
>  /* disable all RX traffic */
>  void icssg_class_disable(struct regmap *miig_rt, int slice)
>  {
> @@ -331,30 +361,95 @@ void icssg_class_disable(struct regmap *miig_rt, int slice)
>  	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);
>  }
>  
> -void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti)
> +void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti,
> +			 bool is_sr1)
>  {
> +	int num_classifiers = is_sr1 ? ICSSG_NUM_CLASSIFIERS_IN_USE : 1;
>  	u32 data;
> +	int n;
>  
>  	/* defaults */
>  	icssg_class_disable(miig_rt, slice);
>  
>  	/* Setup Classifier */
> -	/* match on Broadcast or MAC_PRU address */
> -	data = RX_CLASS_FT_BC | RX_CLASS_FT_DA_P;
> +	for (n = 0; n < num_classifiers; n++) {
> +		/* match on Broadcast or MAC_PRU address */
> +		data = RX_CLASS_FT_BC | RX_CLASS_FT_DA_P;
>  
> -	/* multicast */
> -	if (allmulti)
> -		data |= RX_CLASS_FT_MC;
> +		/* multicast */
> +		if (allmulti)
> +			data |= RX_CLASS_FT_MC;
>  
> -	rx_class_set_or(miig_rt, slice, 0, data);
> +		rx_class_set_or(miig_rt, slice, n, data);
>  
> -	/* set CFG1 for OR_OR_AND for classifier */
> -	rx_class_sel_set_type(miig_rt, slice, 0, RX_CLASS_SEL_TYPE_OR_OR_AND);
> +		/* set CFG1 for OR_OR_AND for classifier */
> +		rx_class_sel_set_type(miig_rt, slice, n,
> +				      RX_CLASS_SEL_TYPE_OR_OR_AND);
> +	}
>  
>  	/* clear CFG2 */
>  	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);
>  }
>  
> +void icssg_class_promiscuous_sr1(struct regmap *miig_rt, int slice)
> +{
> +	u32 data, offset;
> +	int n;
> +
> +	/* defaults */
> +	icssg_class_disable(miig_rt, slice);
> +
> +	/* Setup Classifier */
> +	for (n = 0; n < ICSSG_NUM_CLASSIFIERS_IN_USE; n++) {
> +		/* set RAW_MASK to bypass filters */
> +		offset = RX_CLASS_GATES_N_REG(slice, n);
> +		regmap_read(miig_rt, offset, &data);
> +		data |= RX_CLASS_GATES_RAW_MASK;
> +		regmap_write(miig_rt, offset, data);
> +	}
> +}
> +
> +void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
> +			       struct net_device *ndev)
> +{
> +	u8 mask_addr[6] = { 0, 0, 0, 0, 0, 0xff };
> +	struct netdev_hw_addr *ha;
> +	int slot = 2;
> +
> +	rx_class_ft1_set_start_len(miig_rt, slice, 0, 6);
> +	/* reserve first 2 slots for
> +	 *	1) 01-80-C2-00-00-XX Known Service Ethernet Multicast addresses
> +	 *	2) 01-00-5e-00-00-XX Local Network Control Block
> +	 *			      (224.0.0.0 - 224.0.0.255  (224.0.0/24))
> +	 */
> +	icssg_class_ft1_add_mcast(miig_rt, slice, 0,
> +				  eth_reserved_addr_base, mask_addr);
> +	icssg_class_ft1_add_mcast(miig_rt, slice, 1,
> +				  eth_ipv4_mcast_addr_base, mask_addr);

Build fails with

drivers/net/ethernet/ti/icssg/icssg_classifier.c:428:7: error: ‘eth_ipv4_mcast_addr_base’ undeclared (first use in this function)
  428 |       eth_ipv4_mcast_addr_base, mask_addr);
      |       ^~~~~~~~~~~~~~~~~~~~~~~~

Is there a dependency patch?

> +	mask_addr[5] = 0;
> +	netdev_for_each_mc_addr(ha, ndev) {
> +		/* skip addresses matching reserved slots */
> +		if (!memcmp(eth_reserved_addr_base, ha->addr, 5) ||
> +		    !memcmp(eth_ipv4_mcast_addr_base, ha->addr, 5)) {
> +			netdev_dbg(ndev, "mcast skip %pM\n", ha->addr);
> +			continue;
> +		}
> +
> +		if (slot >= FT1_NUM_SLOTS) {
> +			netdev_dbg(ndev,
> +				   "can't add more than %d MC addresses, enabling allmulti\n",
> +				   FT1_NUM_SLOTS);
> +			icssg_class_default(miig_rt, slice, 1, true);
> +			break;
> +		}
> +
> +		netdev_dbg(ndev, "mcast add %pM\n", ha->addr);
> +		icssg_class_ft1_add_mcast(miig_rt, slice, slot,
> +					  ha->addr, mask_addr);
> +		slot++;
> +	}
> +}
> +
>  /* required for SAV check */
>  void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
>  {
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index e6eac01f9f99..7d9db9683e18 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -437,7 +437,7 @@ static int emac_ndo_open(struct net_device *ndev)
>  	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>  	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>  
> -	icssg_class_default(prueth->miig_rt, slice, 0);
> +	icssg_class_default(prueth->miig_rt, slice, 0, false);
>  
>  	/* Notify the stack of the actual queue counts. */
>  	ret = netif_set_real_num_tx_queues(ndev, num_data_chn);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index a8192e408941..faefd9351c39 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -283,7 +283,11 @@ extern const struct dev_pm_ops prueth_dev_pm_ops;
>  void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac);
>  void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac);
>  void icssg_class_disable(struct regmap *miig_rt, int slice);
> -void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti);
> +void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti,
> +			 bool is_sr1);
> +void icssg_class_promiscuous_sr1(struct regmap *miig_rt, int slice);
> +void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
> +			       struct net_device *ndev);
>  void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr);
>  
>  /* config helpers */

-- 
cheers,
-roger

