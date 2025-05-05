Return-Path: <netdev+bounces-187735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8273AAA9498
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 15:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B886E3AC236
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA1B1FF7D7;
	Mon,  5 May 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="reak0Vpm"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231C190678;
	Mon,  5 May 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452104; cv=none; b=li1ODdDlQ8x/YEIGZpQpXkYQGRqiIbklpB9KWnwRcO3eJm1pgMvgPg7d2lNlKQL6Xhgqnsjq0rwXkNkrO3mjP741ReAT9teF55mw6gbQa+6F84Sh9z1NvR7Reo+L7mMC14tMkbsNcjlgdlurESFN1ROR/BpZErFdMIC/PrXY9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452104; c=relaxed/simple;
	bh=s8p3e5VIszstYk+q3tgIcOH1NUGgIICzoprifWFhoRE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nM0I5NouhzkwLgyIqaHYVy0nAu9XIDBDYdKDKQOOsRl3PJrLX1Loh/8v/ZY9ZpFRf6nl0/qEtdWiUKGMAcsIR5I/57Uj9rc4cKeejAPiV78eKNgRK9ETCy1gXT4JfTWsyAvJ1oTn41c7OIeh40mNROXURBEH5upziMIlshjsbgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=reak0Vpm; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lKakNgp+cMBljiW9bGBJgwi5m8R7UDNEA5lNfD/vC+E=; b=reak0VpmibtkEtPWw7a2b0Xnrd
	j8P+PpUjy6BpPdk/IHzqwfcKQDBk83Da4NA3M1qq6ANdBvc2cfLY2dPZkcuOiw2+vGAe1cpByJhbd
	739twC14lU37p+i+VGppTY7cHtncnTQnTaXPb5zrQPRavTCFqiJxioHPntdT2uMLtyf8xZ52w4nZs
	Z9M47OgewB7voEY1M0zub/91+TUCQbOGnL55ACvzJ6Y5AmVQE7gLMovenP8Mp0Ap4pfCUsDYT6xx0
	5UbF2afKB8+Vy4ChGFSBDPV1GPWUfWGf/uDrZEqCoLTnN5h5CVFkJaDYp93t/tHcn5ujW7QpzqtsZ
	RvCDcc7Q==;
Received: from [122.175.9.182] (port=5358 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uBvy2-000000003nv-3GhN;
	Mon, 05 May 2025 19:04:47 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 17A5C1781C02;
	Mon,  5 May 2025 19:04:39 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id ECB431783FF8;
	Mon,  5 May 2025 19:04:38 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZROrIBlTU3UA; Mon,  5 May 2025 19:04:38 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 8FE7317821E7;
	Mon,  5 May 2025 19:04:38 +0530 (IST)
Date: Mon, 5 May 2025 19:04:38 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>, 
	parvathi <parvathi@couthit.com>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
	tony <tony@atomide.com>, richardcochran <richardcochran@gmail.com>, 
	glaroque <glaroque@baylibre.com>, schnelle <schnelle@linux.ibm.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	rdunlap <rdunlap@infradead.org>, diogo ivo <diogo.ivo@siemens.com>, 
	basharath <basharath@couthit.com>, horms <horms@kernel.org>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	m-malladi <m-malladi@ti.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	afd <afd@ti.com>, s-anna <s-anna@ti.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <596171543.1212368.1746452078442.JavaMail.zimbra@couthit.local>
In-Reply-To: <90a12a85-cf44-499d-bc1b-9413eea00954@oracle.com>
References: <20250423060707.145166-1-parvathi@couthit.com> <20250423072356.146726-8-parvathi@couthit.com> <90a12a85-cf44-499d-bc1b-9413eea00954@oracle.com>
Subject: Re: [PATCH net-next v6 07/11] net: ti: prueth: Adds support for
 network filters for traffic control supported by PRU-ICSS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds support for network filters for traffic control supported by PRU-ICSS
Thread-Index: +fyddl2CzkXGoiVxpswuiFN5y+v5FA==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

>> +	/* for LRE, it is a shared table. So lock the access */
>> +	spin_lock_irqsave(&emac->addr_lock, flags);
>> +
>> +	/* VLAN filter table is 512 bytes (4096 bit) bitmap.
>> +	 * Each bit controls enabling or disabling corresponding
>> +	 * VID. Therefore byte index that controls a given VID is
>> +	 * can calculated as vid / 8 and the bit within that byte
>> +	 * that controls VID is given by vid % 8. Allow untagged
>> +	 * frames to host by default.
>> +	 */
>> +	byte_index = vid / BITS_PER_BYTE;
>> +	bit_index = vid % BITS_PER_BYTE;
>> +	val = readb(ram + vlan_filter_tbl + byte_index);
>> +	if (add)
>> +		val |= BIT(bit_index);
>> +	else
>> +		val &= ~BIT(bit_index);
>> +	writeb(val, ram + vlan_filter_tbl + byte_index);
>> +
>> +	spin_unlock_irqrestore(&emac->addr_lock, flags);
>> +
>> +	netdev_dbg(emac->ndev, "%s VID bit at index %d and bit %d\n",
>> +		   add ? "Setting" : "Clearing", byte_index, bit_index);
> 
> VID bit at byte index
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int icssm_emac_ndo_vlan_rx_add_vid(struct net_device *dev,
>> +					  __be16 proto, u16 vid)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(dev);
>> +
>> +	return icssm_emac_add_del_vid(emac, true, proto, vid);
>> +}
>> +
>> +static int icssm_emac_ndo_vlan_rx_kill_vid(struct net_device *dev,
>> +					   __be16 proto, u16 vid)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(dev);
>> +
>> +	return icssm_emac_add_del_vid(emac, false, proto, vid);
>> +}
>> +
>> +static int icssm_emac_get_port_parent_id(struct net_device *dev,
>> +					 struct netdev_phys_item_id *ppid)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(dev);
>> +	struct prueth *prueth = emac->prueth;
>> +
>> +	ppid->id_len = sizeof(prueth->base_mac);
>> +	memcpy(&ppid->id, &prueth->base_mac, ppid->id_len);
>> +
>> +	return 0;
>> +}
>> +
>> +static int icssm_emac_ndo_get_phys_port_name(struct net_device *ndev,
>> +					     char *name, size_t len)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	int err;
>> +
>> +	err = snprintf(name, len, "p%d", emac->port_id);
>> +
>> +	if (err >= len)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct net_device_ops emac_netdev_ops = {
>>   	.ndo_open = icssm_emac_ndo_open,
>>   	.ndo_stop = icssm_emac_ndo_stop,
>>   	.ndo_start_xmit = icssm_emac_ndo_start_xmit,
>> +	.ndo_set_mac_address = eth_mac_addr,
>> +	.ndo_validate_addr = eth_validate_addr,
>>   	.ndo_tx_timeout = icssm_emac_ndo_tx_timeout,
>>   	.ndo_get_stats64 = icssm_emac_ndo_get_stats64,
>> +	.ndo_set_rx_mode = icssm_emac_ndo_set_rx_mode,
>>   	.ndo_eth_ioctl = icssm_emac_ndo_ioctl,
>> +	.ndo_vlan_rx_add_vid = icssm_emac_ndo_vlan_rx_add_vid,
>> +	.ndo_vlan_rx_kill_vid = icssm_emac_ndo_vlan_rx_kill_vid,
>> +	.ndo_setup_tc = icssm_emac_ndo_setup_tc,
>> +	.ndo_get_port_parent_id = icssm_emac_get_port_parent_id,
>> +	.ndo_get_phys_port_name = icssm_emac_ndo_get_phys_port_name,
>>   };
>>   
>>   /* get emac_port corresponding to eth_node name */
>> @@ -1567,6 +1865,7 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
>>   	emac->prueth = prueth;
>>   	emac->ndev = ndev;
>>   	emac->port_id = port;
>> +	memset(&emac->mc_filter_mask[0], 0xff, ETH_ALEN); /* default mask */
>>   
>>   	/* by default eth_type is EMAC */
>>   	switch (port) {
>> @@ -1608,7 +1907,9 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
>>   		dev_err(prueth->dev, "could not get ptp tx irq. Skipping PTP support\n");
>>   	}
>>   
>> +	spin_lock_init(&emac->lock);
>>   	spin_lock_init(&emac->ptp_skb_lock);
>> +	spin_lock_init(&emac->addr_lock);
>>   
>>   	/* get mac address from DT and set private and netdev addr */
>>   	ret = of_get_ethdev_address(eth_node, ndev);
>> @@ -1637,6 +1938,10 @@ static int icssm_prueth_netdev_init(struct prueth
>> *prueth,
>>   	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
>>   	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
>>   
>> +	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC;
>> +
>> +	ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>> +
>>   	ndev->netdev_ops = &emac_netdev_ops;
>>   	ndev->ethtool_ops = &emac_ethtool_ops;
>>   
>> @@ -1689,6 +1994,7 @@ static int icssm_prueth_probe(struct platform_device
>> *pdev)
>>   	platform_set_drvdata(pdev, prueth);
>>   	prueth->dev = dev;
>>   	prueth->fw_data = device_get_match_data(dev);
>> +	prueth->fw_offsets = &fw_offsets_v2_1;
>>   
>>   	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
>>   	if (!eth_ports_node)
>> @@ -1875,6 +2181,8 @@ static int icssm_prueth_probe(struct platform_device
>> *pdev)
>>   			prueth->emac[PRUETH_MAC1]->ndev;
>>   	}
>>   
>> +	eth_random_addr(prueth->base_mac);
>> +
>>   	dev_info(dev, "TI PRU ethernet driver initialized: %s EMAC mode\n",
>>   		 (!eth0_node || !eth1_node) ? "single" : "dual");
>>   
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
>> index 1709b3b6c2be..8a5f1647466a 100644
>> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
>> @@ -28,6 +28,9 @@
>>   #define EMAC_MAX_FRM_SUPPORT (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN + \
>>   			      ICSSM_LRE_TAG_SIZE)
>>   
>> +/* default timer for NSP and HSR/PRP */
>> +#define PRUETH_NSP_TIMER_MS	(100) /* Refresh NSP counters every 100ms */
>> +
>>   #define PRUETH_REG_DUMP_VER		1
>>   
>>   /* Encoding: 32-16: Reserved, 16-8: Reg dump version, 8-0: Ethertype  */
> 
> remove extra ' ' after Ethertype
> 
>> @@ -293,6 +296,29 @@ enum prueth_mem {
>>   	PRUETH_MEM_MAX,
>>   };
>>   
>> +/* Firmware offsets/size information */
>> +struct prueth_fw_offsets {
>> +	u32 index_array_offset;
>> +	u32 bin_array_offset;
>> +	u32 nt_array_offset;
>> +	u32 index_array_loc;
>> +	u32 bin_array_loc;
>> +	u32 nt_array_loc;
>> +	u32 index_array_max_entries;
>> +	u32 bin_array_max_entries;
>> +	u32 nt_array_max_entries;
>> +	u32 vlan_ctrl_byte;
>> +	u32 vlan_filter_tbl;
>> +	u32 mc_ctrl_byte;
>> +	u32 mc_filter_mask;
>> +	u32 mc_filter_tbl;
>> +	/* IEP wrap is used in the rx packet ordering logic and
>> +	 * is different for ICSSM v1.0 vs 2.1
>> +	 */
>> +	u32 iep_wrap;
>> +	u16 hash_mask;
>> +};
>> +
> [clip]
>> @@ -0,0 +1,120 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/* Copyright (C) 2015-2021 Texas Instruments Incorporated -
>> https://urldefense.com/v3/__https://www.ti.com__;!!ACWV5N9M2RV99hQ!Pnt8LQPwsRI73TtUPzBpwVw_Cn90DbuNXinXJ5m2isPHfFxjNTp4JBlr6UedPapFerELKSzV4SFNoiUfE1xa8g$
>> + *
>> + * This file contains VLAN/Multicast filtering feature memory map
>> + *
>> + */
>> +
>> +#ifndef ICSS_VLAN_MULTICAST_FILTER_MM_H
>> +#define ICSS_VLAN_MULTICAST_FILTER_MM_H
>> +
>> +/*  VLAN/Multicast filter defines & offsets,
>> + *  present on both PRU0 and PRU1 DRAM
> 
> remove extra ' '
> 
>> + */
>> +
>> +/* Feature enable/disable values for multicast filtering */
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_DISABLED		0x00
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_ENABLED		0x01
>> +
>> +/* Feature enable/disable values  for VLAN filtering */
> 
> remove extra ' ' after values
> 
>> +#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_DISABLED			0x00
>> +#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_ENABLED			0x01
>> +
>> +/* Add/remove multicast mac id for filtering bin */
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_HOST_RCV_ALLOWED		0x01
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_HOST_RCV_NOT_ALLOWED	0x00
>> +
>> +/* Default HASH value for the multicast filtering Mask */
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_INIT_VAL			0xFF
>> +
>> +/* Size requirements for Multicast filtering feature */
>> +#define ICSS_EMAC_FW_MULTICAST_TABLE_SIZE_BYTES			       256
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_SIZE_BYTES			 6
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_SIZE_BYTES			 1
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_STATUS_SIZE_BYTES	 1
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_SIZE_BYTES		 4
>> +
>> +/* Size requirements for VLAN filtering feature : 4096 bits = 512 bytes */
>> +#define ICSS_EMAC_FW_VLAN_FILTER_TABLE_SIZE_BYTES		       512
>> +#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_SIZE_BYTES			 1
>> +#define ICSS_EMAC_FW_VLAN_FILTER_DROP_CNT_SIZE_BYTES			 4
>> +
>> +/* Mask override set status */
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_SET			 1
>> +/* Mask override not set status */
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_NOT_SET		 0
>> +/* 6 bytes HASH Mask for the MAC */
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET	  0xF4
>> +/* 0 -> multicast filtering disabled | 1 -> multicast filtering enabled */
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET	\
>> +	(ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET +	\
>> +	 ICSS_EMAC_FW_MULTICAST_FILTER_MASK_SIZE_BYTES)
>> +/* Status indicating if the HASH override is done or not: 0: no, 1: yes */
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_OVERRIDE_STATUS	\
>> +	(ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET +	\
>> +	 ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_SIZE_BYTES)
>> +/* Multicast drop statistics */
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_OFFSET	\
>> +	(ICSS_EMAC_FW_MULTICAST_FILTER_OVERRIDE_STATUS +\
>> +	 ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_STATUS_SIZE_BYTES)
>> +/* Multicast table */
>> +#define ICSS_EMAC_FW_MULTICAST_FILTER_TABLE		\
>> +	(ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_OFFSET +\
>> +	 ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_SIZE_BYTES)
>> +
>> +/* Multicast filter defines & offsets for LRE
>> + */
>> +#define ICSS_LRE_FW_MULTICAST_TABLE_SEARCH_OP_CONTROL_BIT	0xE0
>> +/* one byte field :
>> + * 0 -> multicast filtering disabled
>> + * 1 -> multicast filtering enabled
>> + */
>> +#define ICSS_LRE_FW_MULTICAST_FILTER_MASK			 0xE4
>> +#define ICSS_LRE_FW_MULTICAST_FILTER_TABLE			 0x100
>> +
>> +/* VLAN table Offsets */
>> +#define ICSS_EMAC_FW_VLAN_FLTR_TBL_BASE_ADDR		 0x200
>> +#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_BITMAP_OFFSET	 0xEF
>> +#define ICSS_EMAC_FW_VLAN_FILTER_DROP_CNT_OFFSET	\
>> +	(ICSS_EMAC_FW_VLAN_FILTER_CTRL_BITMAP_OFFSET +	\
>> +	 ICSS_EMAC_FW_VLAN_FILTER_CTRL_SIZE_BYTES)
>> +
>> +/* VLAN filter Control Bit maps */
>> +/* one bit field, bit 0: | 0 : VLAN filter disabled (default),
>> + * 1: VLAN filter enabled
>> + */
>> +#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_ENABLE_BIT		       0
>> +/* one bit field, bit 1: | 0 : untagged host rcv allowed (default),
>> + * 1: untagged host rcv not allowed
>> + */
>> +#define ICSS_EMAC_FW_VLAN_FILTER_UNTAG_HOST_RCV_ALLOW_CTRL_BIT	       1
>> +/* one bit field, bit 1: | 0 : priotag host rcv allowed (default),
>> + * 1: priotag host rcv not allowed
>> + */
>> +#define ICSS_EMAC_FW_VLAN_FILTER_PRIOTAG_HOST_RCV_ALLOW_CTRL_BIT       2
>> +/* one bit field, bit 1: | 0 : skip sv vlan flow
>> + * :1 : take sv vlan flow  (not applicable for dual emac )
>> + */
>> +#define ICSS_EMAC_FW_VLAN_FILTER_SV_VLAN_FLOW_HOST_RCV_ALLOW_CTRL_BIT  3
>> +
>> +/* VLAN IDs */
>> +#define ICSS_EMAC_FW_VLAN_FILTER_PRIOTAG_VID			       0
>> +#define ICSS_EMAC_FW_VLAN_FILTER_VID_MIN			       0x0000
>> +#define ICSS_EMAC_FW_VLAN_FILTER_VID_MAX			       0x0FFF
>> +
>> +/* VLAN Filtering Commands */
>> +#define ICSS_EMAC_FW_VLAN_FILTER_ADD_VLAN_VID_CMD		       0x00
>> +#define ICSS_EMAC_FW_VLAN_FILTER_REMOVE_VLAN_VID_CMD		       0x01
>> +
>> +/* Switch defines for VLAN/MC filtering */
>> +/* SRAM
>> + * VLAN filter defines & offsets
>> + */
>> +#define ICSS_LRE_FW_VLAN_FLTR_CTRL_BYTE				 0x1FE
> 
> lowercase hex please, all place.
> 

Thank you for the feedback.

We have addressed all the comments provided, except for the one regarding
hexadecimal format, where we need some clarity.

Is there any specific style guide or convention that mandates lowercase
hexadecimal formatting? We've observed that other drivers in the code base
consistently use uppercase hex values, and we've followed the same convention
throughout in our implementation.


Thanks and Regards,
Parvathi.

