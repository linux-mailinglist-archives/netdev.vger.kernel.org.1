Return-Path: <netdev+bounces-212985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432EAB22BC2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51C27A4601
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA43C27FB27;
	Tue, 12 Aug 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ay2Espyb"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89424BC01
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012745; cv=none; b=udXJEqKZgCtMGfZrVq1y2N/ycjLu9ueUVGJPRUx2yE5JllesMSFdeBh9LyDvNF4NKNAM69HbdbtGgiRiLJ1KDj0avmoBmWcXSli/T3RU7z9Gk2smvZm+FAqKfQDvxcaMxZMBsyr+IMUI52FUk5wMw30ZfTQgZc6tZAMeVy0l40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012745; c=relaxed/simple;
	bh=YKII58KLVZlNeMGlDWTCBENBCKJ301Q6Hhmg3UkqKOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxykGIYeJ+6lezzPcpk7PZLSpT6cFcEWH7fSZOMHr31gw61rsDToNuSoj5VEdaQhSUk6yraA7zBsYWGadguNYvDQStvFghaVGArXTjsZSkKCGxDjh09rcGeQhvBvDzGCZakkqaE2vRfVCir4QI26rTQBhWGYGv2by4PB7jctJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ay2Espyb; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e410918e-98aa-4a14-8fb4-5d9e73f7375e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755012730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZC0/xXbsFFrsw3+lBnblC7WzG/1PPpLErO3BZN33Ag=;
	b=ay2EspybD0xN5L24+1TEYUsaL7K4u8Tjtm9AcFGev9EV0DOhxhIEpZPTqFDeHCEV41BFKS
	YpbBYOqhuDGPUC1ojBnfeg6s4r1JpEBU8kwzeOJbkZ+Q0dXnU9K4dkb4Zgu23UG/rODOBN
	n7+cM0d4Ir2VE71db0MMTA5GC6IaqgE=
Date: Tue, 12 Aug 2025 16:32:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/5] net: rnpgbe: Add register_netdev
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-6-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250812093937.882045-6-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/08/2025 10:39, Dong Yibo wrote:
> Initialize get mac from hw, register the netdev.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 22 ++++++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 76 +++++++++++++++++++
>   4 files changed, 172 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 6cb14b79cbfe..644b8c85c29d 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -6,6 +6,7 @@
>   
>   #include <linux/types.h>
>   #include <linux/mutex.h>
> +#include <linux/netdevice.h>
>   
>   extern const struct rnpgbe_info rnpgbe_n500_info;
>   extern const struct rnpgbe_info rnpgbe_n210_info;
> @@ -86,6 +87,18 @@ struct mucse_mbx_info {
>   	u32 fw2pf_mbox_vec;
>   };
>   
> +struct mucse_hw_operations {
> +	int (*init_hw)(struct mucse_hw *hw);
> +	int (*reset_hw)(struct mucse_hw *hw);
> +	void (*start_hw)(struct mucse_hw *hw);
> +	void (*init_rx_addrs)(struct mucse_hw *hw);
> +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> +};
> +
> +enum {
> +	mucse_driver_insmod,
> +};
> +
>   struct mucse_hw {
>   	void *back;
>   	u8 pfvfnum;
> @@ -96,12 +109,18 @@ struct mucse_hw {
>   	u32 axi_mhz;
>   	u32 bd_uid;
>   	enum rnpgbe_hw_type hw_type;
> +	const struct mucse_hw_operations *ops;
>   	struct mucse_dma_info dma;
>   	struct mucse_eth_info eth;
>   	struct mucse_mac_info mac;
>   	struct mucse_mbx_info mbx;
> +	u32 flags;
> +#define M_FLAGS_INIT_MAC_ADDRESS BIT(0)
>   	u32 driver_version;
>   	u16 usecstocount;
> +	int lane;
> +	u8 addr[ETH_ALEN];
> +	u8 perm_addr[ETH_ALEN];

why do you need both addresses if you have this info already in netdev?

>   };
>   
>   struct mucse {
> @@ -123,4 +142,7 @@ struct rnpgbe_info {
>   #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
>   #define PCI_DEVICE_ID_N210 0x8208
>   #define PCI_DEVICE_ID_N210L 0x820a
> +
> +#define dma_wr32(dma, reg, val) writel((val), (dma)->dma_base_addr + (reg))
> +#define dma_rd32(dma, reg) readl((dma)->dma_base_addr + (reg))
>   #endif /* _RNPGBE_H */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index 16d0a76114b5..3eaa0257f3bb 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -2,10 +2,82 @@
>   /* Copyright(c) 2020 - 2025 Mucse Corporation. */
>   
>   #include <linux/string.h>
> +#include <linux/etherdevice.h>
>   
>   #include "rnpgbe.h"
>   #include "rnpgbe_hw.h"
>   #include "rnpgbe_mbx.h"
> +#include "rnpgbe_mbx_fw.h"
> +
> +/**
> + * rnpgbe_get_permanent_mac - Get permanent mac
> + * @hw: hw information structure
> + * @mac_addr: pointer to store mac
> + *
> + * rnpgbe_get_permanent_mac tries to get mac from hw.
> + * It use eth_random_addr if failed.
> + **/
> +static void rnpgbe_get_permanent_mac(struct mucse_hw *hw,
> +				     u8 *mac_addr)
> +{
> +	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->lane)) {
> +		eth_random_addr(mac_addr);
> +	} else {
> +		if (!is_valid_ether_addr(mac_addr))
> +			eth_random_addr(mac_addr);
> +	}

well, this can be done in one if() statement using logical "or"

> +
> +	hw->flags |= M_FLAGS_INIT_MAC_ADDRESS;
> +}
> +
> +/**
> + * rnpgbe_reset_hw_ops - Do a hardware reset
> + * @hw: hw information structure
> + *
> + * rnpgbe_reset_hw_ops calls fw to do a hardware
> + * reset, and cleans some regs to default.
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
> +{
> +	struct mucse_dma_info *dma = &hw->dma;
> +	int err;
> +
> +	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
> +	err = mucse_mbx_fw_reset_phy(hw);
> +	if (err)
> +		return err;
> +	/* Store the permanent mac address */
> +	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS)) {
> +		rnpgbe_get_permanent_mac(hw, hw->perm_addr);
> +		memcpy(hw->addr, hw->perm_addr, ETH_ALEN);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * rnpgbe_driver_status_hw_ops - Echo driver status to hw
> + * @hw: hw information structure
> + * @enable: true or false status
> + * @mode: status mode
> + **/
> +static void rnpgbe_driver_status_hw_ops(struct mucse_hw *hw,
> +					bool enable,
> +					int mode)
> +{
> +	switch (mode) {
> +	case mucse_driver_insmod:
> +		mucse_mbx_ifinsmod(hw, enable);
> +		break;
> +	}
> +}
> +
> +static const struct mucse_hw_operations rnpgbe_hw_ops = {
> +	.reset_hw = &rnpgbe_reset_hw_ops,
> +	.driver_status = &rnpgbe_driver_status_hw_ops,
> +};
>   
>   /**
>    * rnpgbe_init_common - Setup common attribute
> @@ -28,6 +100,7 @@ static void rnpgbe_init_common(struct mucse_hw *hw)
>   	mac->back = hw;
>   
>   	hw->mbx.ops = &mucse_mbx_ops_generic;
> +	hw->ops = &rnpgbe_hw_ops;
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> index aee037e3219d..4e07328ccf82 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> @@ -9,6 +9,7 @@
>   #define RNPGBE_ETH_BASE 0x10000
>   /**************** DMA Registers ****************************/
>   #define RNPGBE_DMA_DUMY 0x000c
> +#define RNPGBE_DMA_AXI_EN 0x0010
>   /**************** CHIP Resource ****************************/
>   #define RNPGBE_MAX_QUEUES 8
>   #endif /* _RNPGBE_HW_H */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index c151995309f8..e0a08fa5b297 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -8,6 +8,7 @@
>   #include <linux/etherdevice.h>
>   
>   #include "rnpgbe.h"
> +#include "rnpgbe_mbx_fw.h"
>   
>   static const char rnpgbe_driver_name[] = "rnpgbe";
>   static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
> @@ -34,6 +35,54 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
>   	{0, },
>   };
>   
> +/**
> + * rnpgbe_open - Called when a network interface is made active
> + * @netdev: network interface device structure
> + *
> + * The open entry point is called when a network interface is made
> + * active by the system (IFF_UP).
> + *
> + * @return: 0 on success, negative value on failure
> + **/
> +static int rnpgbe_open(struct net_device *netdev)
> +{
> +	return 0;
> +}
> +
> +/**
> + * rnpgbe_close - Disables a network interface
> + * @netdev: network interface device structure
> + *
> + * The close entry point is called when an interface is de-activated
> + * by the OS.
> + *
> + * @return: 0, this is not allowed to fail
> + **/
> +static int rnpgbe_close(struct net_device *netdev)
> +{
> +	return 0;
> +}
> +
> +/**
> + * rnpgbe_xmit_frame - Send a skb to driver
> + * @skb: skb structure to be sent
> + * @netdev: network interface device structure
> + *
> + * @return: NETDEV_TX_OK or NETDEV_TX_BUSY
> + **/
> +static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
> +				     struct net_device *netdev)
> +{
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +}
> +
> +static const struct net_device_ops rnpgbe_netdev_ops = {
> +	.ndo_open = rnpgbe_open,
> +	.ndo_stop = rnpgbe_close,
> +	.ndo_start_xmit = rnpgbe_xmit_frame,
> +};
> +
>   /**
>    * rnpgbe_add_adapter - Add netdev for this pci_dev
>    * @pdev: PCI device information structure
> @@ -106,6 +155,29 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
>   	hw->dma.dma_version = dma_version;
>   	hw->driver_version = 0x0002040f;
>   	info->init(hw);
> +	hw->mbx.ops->init_params(hw);
> +	/* echo fw driver insmod to control hw */
> +	hw->ops->driver_status(hw, true, mucse_driver_insmod);
> +	err = mucse_mbx_get_capability(hw);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"mucse_mbx_get_capability failed! %d\n",
> +			err);
> +		goto err_free_net;
> +	}
> +	netdev->netdev_ops = &rnpgbe_netdev_ops;
> +	netdev->watchdog_timeo = 5 * HZ;
> +	err = hw->ops->reset_hw(hw);
> +	if (err) {
> +		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
> +		goto err_free_net;
> +	}
> +	eth_hw_addr_set(netdev, hw->perm_addr);
> +	memcpy(netdev->perm_addr, hw->perm_addr, netdev->addr_len);

the comment from register_netdevice() says:

	/* If the device has permanent device address, driver should
	 * set dev_addr and also addr_assign_type should be set to
	 * NET_ADDR_PERM (default value).
	 */

dev_addr is set by eth_hw_addr_set, perm_addr will be set by
register_netdev(), no need to manually copy it.

> +	ether_addr_copy(hw->addr, hw->perm_addr);

your init() function has the same copy operation...

> +	err = register_netdev(netdev);
> +	if (err)
> +		goto err_free_net;
>   	return 0;
>   
>   err_free_net:
> @@ -170,12 +242,16 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   static void rnpgbe_rm_adapter(struct pci_dev *pdev)
>   {
>   	struct mucse *mucse = pci_get_drvdata(pdev);
> +	struct mucse_hw *hw = &mucse->hw;
>   	struct net_device *netdev;
>   
>   	if (!mucse)
>   		return;
>   	netdev = mucse->netdev;
> +	if (netdev->reg_state == NETREG_REGISTERED)
> +		unregister_netdev(netdev);
>   	mucse->netdev = NULL;
> +	hw->ops->driver_status(hw, false, mucse_driver_insmod);
>   	free_netdev(netdev);
>   }
>   


