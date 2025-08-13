Return-Path: <netdev+bounces-213274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8CDB244ED
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65ADC188BC8C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCE32DC326;
	Wed, 13 Aug 2025 09:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA022C3252
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075862; cv=none; b=UQMqKW8p1rmZJaCruFv/wDycu0ukY2xt4kHH22t1id+h7pxpAjr3X0ZOypkD4zmWyrlbR+OxNCg106fo/ch3vv+gNx5z/fzKscbTONdKGFxEEYrCT0y5EUUuTqIOz30kc2RYWzkKqHEYmZoDIwK3NFeZPBP1jKtaEdgYJpmhj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075862; c=relaxed/simple;
	bh=R73pDVK0+rTjwBNX8EeB3Fe4kOmp2X5fu9MZNOhzs3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNmSegWIw/sPXU1aRPgFM/JK8kQ8zKNkKJpe3o5/UUp7w43y1Tt/Whwfk3fKJPyRWJ6DPopGBsdzEjkmHtmfHMcdcTOEmmwA4gEQS+NmSqmOA0K2EjMS+wyWMVl/cxX2tE2sD82WJ2rnq3UD2FotA2NR/GxIbDJ2gKWd4ki14PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz10t1755075847t32894ac3
X-QQ-Originating-IP: bqQZWNQI/ONbgNOc8LQ+pUQ21YN60deVeWVf6xrUUHo=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 17:04:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4281347920772169751
Date: Wed, 13 Aug 2025 17:04:05 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] net: rnpgbe: Add register_netdev
Message-ID: <B41E833713021188+20250813090405.GC965498@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-6-dong100@mucse.com>
 <e410918e-98aa-4a14-8fb4-5d9e73f7375e@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e410918e-98aa-4a14-8fb4-5d9e73f7375e@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MABkn+BX1UZ4HpEVKpn/wOxvsFj57MMyrbr0EhCyKzeuvokCZCU3M5k+
	JLCG+vvhS6I6m0sulCYpNR+OMLYqNTrzISYYrqLRz+oMIrKSLzZIHj0egWIr69rLsBQV0Xx
	mKHRE1VX1LqJX62YZ2K/F55SboZqGw/hUmBNiBkVwNzgwgNOs4Pl/tP5e9piOIho70gQdE1
	tPdKAr+UzCoj4kBxLEWCHFrafhYo7H45EVhbYXlUYIRHEseJqRuWsDDtL/sa5zxxHmxxq09
	rKsX1GUro2xbNWphl/XcwNVsjLn75emNc5hMW3mT8RvcjPPbFev4AdmwNzpyV9JmQt8TUn6
	pj8ll7xE1xynMinOGMt8n5GZog83zsG88lJBC+gVq5AGM8nxzsTRs3ed9j3Zeo4K8OAn9l5
	kwB7Z9Q8wxYnai8begtfbnnVUKD/MWL/H6/k9gJTB/K7OK1not+lhH3RpgEl1It46vtAAzL
	dJMKc1jB1V9pVWDfNU1qNDIsrFV8CY0FyG7UQLQJ3cyaBV2OnrzeJHteIh2+RtXYOO15rXy
	HgitkxX2toUSqlfGd1xqG7srR3u1ywaanL4Kk/2vtbumOaoP2E3iSTHog7DrtZydKsB0Nmz
	Rx0LLrfvMZWI2t3bNrKHrGCT6QqqC5OoK2tax0Ypr057zhByb8dKZVKp+w2j1i/gDJEHuLC
	vP6jJvyxAJW87+iQYMwGtTskZgWVvcGL7RlfxlBnrIvH4JnOb90cDSRdXeeh6mF1UCyCLrt
	pAutAny6PCnvzyCSkQLougXynFrtuKuJ/iCUtvGtV2Jhytwo9j0WEFrwYebjpMppxpXFdmD
	aczxIgx3lF6E8k1V5n+97STeYjJXnoWGCtZPOxPCZl8rPOII/kkE+HlwS4HUSkroKfVPInz
	MDrw8r8yH9QE2RzcOI2raHBx28uqXx5KoEvcRDpzBJPZPaoImc/Qs5cPqNJi7Pa2biN0KEe
	2g/v+KrSyTPMuAqv7qTdv7QYPXfsfGR8ysQhOhP0h7TPK1L/VDbwdhpuZbZppM015RhIRkf
	I2mddZtuk3IaUczQsAQ1z3p3D7rdsSbb+TgedvRQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 04:32:00PM +0100, Vadim Fedorenko wrote:
> On 12/08/2025 10:39, Dong Yibo wrote:
> > Initialize get mac from hw, register the netdev.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 22 ++++++
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
> >   drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 76 +++++++++++++++++++
> >   4 files changed, 172 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 6cb14b79cbfe..644b8c85c29d 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -6,6 +6,7 @@
> >   #include <linux/types.h>
> >   #include <linux/mutex.h>
> > +#include <linux/netdevice.h>
> >   extern const struct rnpgbe_info rnpgbe_n500_info;
> >   extern const struct rnpgbe_info rnpgbe_n210_info;
> > @@ -86,6 +87,18 @@ struct mucse_mbx_info {
> >   	u32 fw2pf_mbox_vec;
> >   };
> > +struct mucse_hw_operations {
> > +	int (*init_hw)(struct mucse_hw *hw);
> > +	int (*reset_hw)(struct mucse_hw *hw);
> > +	void (*start_hw)(struct mucse_hw *hw);
> > +	void (*init_rx_addrs)(struct mucse_hw *hw);
> > +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> > +};
> > +
> > +enum {
> > +	mucse_driver_insmod,
> > +};
> > +
> >   struct mucse_hw {
> >   	void *back;
> >   	u8 pfvfnum;
> > @@ -96,12 +109,18 @@ struct mucse_hw {
> >   	u32 axi_mhz;
> >   	u32 bd_uid;
> >   	enum rnpgbe_hw_type hw_type;
> > +	const struct mucse_hw_operations *ops;
> >   	struct mucse_dma_info dma;
> >   	struct mucse_eth_info eth;
> >   	struct mucse_mac_info mac;
> >   	struct mucse_mbx_info mbx;
> > +	u32 flags;
> > +#define M_FLAGS_INIT_MAC_ADDRESS BIT(0)
> >   	u32 driver_version;
> >   	u16 usecstocount;
> > +	int lane;
> > +	u8 addr[ETH_ALEN];
> > +	u8 perm_addr[ETH_ALEN];
> 
> why do you need both addresses if you have this info already in netdev?
> 

'perm_addr' is address from firmware (fixed, can't be changed by user).
'addr' is the current netdev address (It is Initialized the same with
'perm_addr', but can be changed by user)
Maybe I should add 'addr' in the patch which support ndo_set_mac_address?

> >   };
> >   struct mucse {
> > @@ -123,4 +142,7 @@ struct rnpgbe_info {
> >   #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
> >   #define PCI_DEVICE_ID_N210 0x8208
> >   #define PCI_DEVICE_ID_N210L 0x820a
> > +
> > +#define dma_wr32(dma, reg, val) writel((val), (dma)->dma_base_addr + (reg))
> > +#define dma_rd32(dma, reg) readl((dma)->dma_base_addr + (reg))
> >   #endif /* _RNPGBE_H */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index 16d0a76114b5..3eaa0257f3bb 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -2,10 +2,82 @@
> >   /* Copyright(c) 2020 - 2025 Mucse Corporation. */
> >   #include <linux/string.h>
> > +#include <linux/etherdevice.h>
> >   #include "rnpgbe.h"
> >   #include "rnpgbe_hw.h"
> >   #include "rnpgbe_mbx.h"
> > +#include "rnpgbe_mbx_fw.h"
> > +
> > +/**
> > + * rnpgbe_get_permanent_mac - Get permanent mac
> > + * @hw: hw information structure
> > + * @mac_addr: pointer to store mac
> > + *
> > + * rnpgbe_get_permanent_mac tries to get mac from hw.
> > + * It use eth_random_addr if failed.
> > + **/
> > +static void rnpgbe_get_permanent_mac(struct mucse_hw *hw,
> > +				     u8 *mac_addr)
> > +{
> > +	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->lane)) {
> > +		eth_random_addr(mac_addr);
> > +	} else {
> > +		if (!is_valid_ether_addr(mac_addr))
> > +			eth_random_addr(mac_addr);
> > +	}
> 
> well, this can be done in one if() statement using logical "or"
> 

Got it, I will update it.

> > +
> > +	hw->flags |= M_FLAGS_INIT_MAC_ADDRESS;
> > +}
> > +
> > +/**
> > + * rnpgbe_reset_hw_ops - Do a hardware reset
> > + * @hw: hw information structure
> > + *
> > + * rnpgbe_reset_hw_ops calls fw to do a hardware
> > + * reset, and cleans some regs to default.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
> > +{
> > +	struct mucse_dma_info *dma = &hw->dma;
> > +	int err;
> > +
> > +	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
> > +	err = mucse_mbx_fw_reset_phy(hw);
> > +	if (err)
> > +		return err;
> > +	/* Store the permanent mac address */
> > +	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS)) {
> > +		rnpgbe_get_permanent_mac(hw, hw->perm_addr);
> > +		memcpy(hw->addr, hw->perm_addr, ETH_ALEN);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * rnpgbe_driver_status_hw_ops - Echo driver status to hw
> > + * @hw: hw information structure
> > + * @enable: true or false status
> > + * @mode: status mode
> > + **/
> > +static void rnpgbe_driver_status_hw_ops(struct mucse_hw *hw,
> > +					bool enable,
> > +					int mode)
> > +{
> > +	switch (mode) {
> > +	case mucse_driver_insmod:
> > +		mucse_mbx_ifinsmod(hw, enable);
> > +		break;
> > +	}
> > +}
> > +
> > +static const struct mucse_hw_operations rnpgbe_hw_ops = {
> > +	.reset_hw = &rnpgbe_reset_hw_ops,
> > +	.driver_status = &rnpgbe_driver_status_hw_ops,
> > +};
> >   /**
> >    * rnpgbe_init_common - Setup common attribute
> > @@ -28,6 +100,7 @@ static void rnpgbe_init_common(struct mucse_hw *hw)
> >   	mac->back = hw;
> >   	hw->mbx.ops = &mucse_mbx_ops_generic;
> > +	hw->ops = &rnpgbe_hw_ops;
> >   }
> >   /**
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > index aee037e3219d..4e07328ccf82 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > @@ -9,6 +9,7 @@
> >   #define RNPGBE_ETH_BASE 0x10000
> >   /**************** DMA Registers ****************************/
> >   #define RNPGBE_DMA_DUMY 0x000c
> > +#define RNPGBE_DMA_AXI_EN 0x0010
> >   /**************** CHIP Resource ****************************/
> >   #define RNPGBE_MAX_QUEUES 8
> >   #endif /* _RNPGBE_HW_H */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > index c151995309f8..e0a08fa5b297 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > @@ -8,6 +8,7 @@
> >   #include <linux/etherdevice.h>
> >   #include "rnpgbe.h"
> > +#include "rnpgbe_mbx_fw.h"
> >   static const char rnpgbe_driver_name[] = "rnpgbe";
> >   static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
> > @@ -34,6 +35,54 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
> >   	{0, },
> >   };
> > +/**
> > + * rnpgbe_open - Called when a network interface is made active
> > + * @netdev: network interface device structure
> > + *
> > + * The open entry point is called when a network interface is made
> > + * active by the system (IFF_UP).
> > + *
> > + * @return: 0 on success, negative value on failure
> > + **/
> > +static int rnpgbe_open(struct net_device *netdev)
> > +{
> > +	return 0;
> > +}
> > +
> > +/**
> > + * rnpgbe_close - Disables a network interface
> > + * @netdev: network interface device structure
> > + *
> > + * The close entry point is called when an interface is de-activated
> > + * by the OS.
> > + *
> > + * @return: 0, this is not allowed to fail
> > + **/
> > +static int rnpgbe_close(struct net_device *netdev)
> > +{
> > +	return 0;
> > +}
> > +
> > +/**
> > + * rnpgbe_xmit_frame - Send a skb to driver
> > + * @skb: skb structure to be sent
> > + * @netdev: network interface device structure
> > + *
> > + * @return: NETDEV_TX_OK or NETDEV_TX_BUSY
> > + **/
> > +static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
> > +				     struct net_device *netdev)
> > +{
> > +		dev_kfree_skb_any(skb);
> > +		return NETDEV_TX_OK;
> > +}
> > +
> > +static const struct net_device_ops rnpgbe_netdev_ops = {
> > +	.ndo_open = rnpgbe_open,
> > +	.ndo_stop = rnpgbe_close,
> > +	.ndo_start_xmit = rnpgbe_xmit_frame,
> > +};
> > +
> >   /**
> >    * rnpgbe_add_adapter - Add netdev for this pci_dev
> >    * @pdev: PCI device information structure
> > @@ -106,6 +155,29 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
> >   	hw->dma.dma_version = dma_version;
> >   	hw->driver_version = 0x0002040f;
> >   	info->init(hw);
> > +	hw->mbx.ops->init_params(hw);
> > +	/* echo fw driver insmod to control hw */
> > +	hw->ops->driver_status(hw, true, mucse_driver_insmod);
> > +	err = mucse_mbx_get_capability(hw);
> > +	if (err) {
> > +		dev_err(&pdev->dev,
> > +			"mucse_mbx_get_capability failed! %d\n",
> > +			err);
> > +		goto err_free_net;
> > +	}
> > +	netdev->netdev_ops = &rnpgbe_netdev_ops;
> > +	netdev->watchdog_timeo = 5 * HZ;
> > +	err = hw->ops->reset_hw(hw);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
> > +		goto err_free_net;
> > +	}
> > +	eth_hw_addr_set(netdev, hw->perm_addr);
> > +	memcpy(netdev->perm_addr, hw->perm_addr, netdev->addr_len);
> 
> the comment from register_netdevice() says:
> 
> 	/* If the device has permanent device address, driver should
> 	 * set dev_addr and also addr_assign_type should be set to
> 	 * NET_ADDR_PERM (default value).
> 	 */
> 
> dev_addr is set by eth_hw_addr_set, perm_addr will be set by
> register_netdev(), no need to manually copy it.
> 

Got it, I will remove memcpy here.

> > +	ether_addr_copy(hw->addr, hw->perm_addr);
> 
> your init() function has the same copy operation...
> 

I will remove it here.

> > +	err = register_netdev(netdev);
> > +	if (err)
> > +		goto err_free_net;
> >   	return 0;
> >   err_free_net:
> > @@ -170,12 +242,16 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >   static void rnpgbe_rm_adapter(struct pci_dev *pdev)
> >   {
> >   	struct mucse *mucse = pci_get_drvdata(pdev);
> > +	struct mucse_hw *hw = &mucse->hw;
> >   	struct net_device *netdev;
> >   	if (!mucse)
> >   		return;
> >   	netdev = mucse->netdev;
> > +	if (netdev->reg_state == NETREG_REGISTERED)
> > +		unregister_netdev(netdev);
> >   	mucse->netdev = NULL;
> > +	hw->ops->driver_status(hw, false, mucse_driver_insmod);
> >   	free_netdev(netdev);
> >   }
> 
> 

Thanks for your feedback.


