Return-Path: <netdev+bounces-213753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15759B26849
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55859E1DDA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F143009FE;
	Thu, 14 Aug 2025 13:54:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9B26FD84;
	Thu, 14 Aug 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179648; cv=none; b=cMDcrct/A0p8Wq7v+1NeKU4QmeVMvnA+4hi2YPIlcmOzs6dQsUF4ss0QLM+RcjtaMaRf2o62MB+rhZBvyQG8WPR48HzsgwWRobSR19DdeqIHiwegaIvYE85lvZ5cE5S87hvVbia3IHcoUhnf/R8ngdt/IvZTXit416PLUI/Bo8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179648; c=relaxed/simple;
	bh=aCddeyp2wykbHL0o2ItlIM8ElLwpa+Qx3TvCvjfVTe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLWZ+PTkUyxEh9fuq0IQVpuutWyj0afjMPqEIF9EHJ+YWszKzVZEPXGJJ04xJ5BvAJhHY5wPs+gZ3PwLen6TqiFlzhY01qHI6pX2QOLy0A1bd6MNl5vxgxCvi8XOABzQJUvRX/3kxQ7C44SyK6K0o75cxPSMIxMAiVJrtfRX6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1755179525t0c4b564a
X-QQ-Originating-IP: K4YTPx/FzH/0WKWZMeWOv8TngE/p6vFSRGE6pNA3ri8=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 21:52:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3016173073873674600
Date: Thu, 14 Aug 2025 21:52:03 +0800
From: Yibo Dong <dong100@mucse.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <172956B3368FC20D+20250814135203.GA1094497@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
 <8a041e8e-b9a8-4bd9-ab1a-de66f943dea6@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a041e8e-b9a8-4bd9-ab1a-de66f943dea6@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MAMW4dxoxFyt4QS9Wrwt6BZVV0CYwV1rHq/klM1IMsQrgFTlksz2H0tK
	jYRjW5vZkvyxdHKR+DLRUVcA139KbWckQ/qnq4pIwCSEqegmfQYfonovqmXlRGVzeuaK7ab
	Vuja6xKSnd0WsZ9FBlEHU9L5xv/4a1IOuccQQHCf9HyzHopzwb5oRS3MT6S54r2rcQBtzcJ
	FblnUzQyJzuxfMDGGeCKrvgszeCSlSZOW485CbfD4uMysTiriUAMMOdpw98qdm/W6qiFqtt
	HsQfEf30HTThJYSgqZw3USleRwixCidSCUIyw1vwIyDQsEaDLkpZGcF+GPr5P0ycDC5JkNM
	Lw2/BkO5Xw5yhjB30ZVsAMKPEEGyHWvU6taIoTE3ll5oUGosF+N8sV9SEiwD5fjQy3vaMpL
	Ae/AwI4CoPtb4wJKi6cBZq4oRySjpmM/UJ/yBCcItptm0F3fKH4qwiti/O6jFHotae0W3Mf
	WVOJSV7ODa+/3Ng6UUEz37UbbrgkfM/jTQniDeI4aeYW1CSKAtc3XtiXH4jc8kilTOXpLAF
	w8yoB5JtV6eLjdOIwAlFMSj6/08I7GUmsS+ryTFo+O6CNSW3+IE6mf9q1Bduwzvak7ZV/15
	01llwwdm0meb+P0pXiGKChfhe4DnYHyMbn5CuBvA15WEszsbBySy2kptH3/FnxbPr2pDAKg
	6rVBitgakXriUn+5/b+r2X85MPmakFLZ/bS+HsVZU0dJdc98OzBntPE3g8QLF8r016pE3Yx
	MM6z0v6cghn2XUoVbl3zQTu6m2VrNXt3tXURM4BKXvNMzHShM4Cbi2VyHsYV+m7e6Dkpuu5
	QpmxkLkyONz41lRI2b5C4HyV+Eql4LfSOaHAO+M6YLjsHl4lm26cnhLmF530OqnQi5JgJcX
	v51puhGE3Mw6q2uAPGM/zMEKIP7n8oA8j9T4E/0Xp2ZYnPFoYJ7OqK5C2uVjp7Ayu3IEkmY
	BTaNqg3FblR9h++rCWAfDpzY+8wi96avSZTUR93J1FzirtoR5L6+qr60wav3YTXMAX6ZlkG
	7sNky+CsXj0EEFG7Yp
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Thu, Aug 14, 2025 at 05:37:21PM +0530, MD Danish Anwar wrote:
> On 14/08/25 1:08 pm, Dong Yibo wrote:
> > Initialize n500/n210 chip bar resource map and
> > dma, eth, mbx ... info for future use.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  55 +++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  85 +++++++++++++
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  12 ++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 112 ++++++++++++++++++
> >  5 files changed, 266 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > index 9df536f0d04c..42c359f459d9 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > @@ -5,4 +5,5 @@
> >  #
> >  
> >  obj-$(CONFIG_MGBE) += rnpgbe.o
> > -rnpgbe-objs := rnpgbe_main.o
> > +rnpgbe-objs := rnpgbe_main.o\
> > +	       rnpgbe_chip.o
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 64b2c093bc6e..08faac3a67af 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -4,15 +4,70 @@
> >  #ifndef _RNPGBE_H
> >  #define _RNPGBE_H
> >  
> > +#include <linux/types.h>
> > +
> > +extern const struct rnpgbe_info rnpgbe_n500_info;
> > +extern const struct rnpgbe_info rnpgbe_n210_info;
> > +extern const struct rnpgbe_info rnpgbe_n210L_info;
> > +
> >  enum rnpgbe_boards {
> >  	board_n500,
> >  	board_n210,
> >  	board_n210L,
> >  };
> >  
> > +enum rnpgbe_hw_type {
> > +	rnpgbe_hw_n500 = 0,
> > +	rnpgbe_hw_n210,
> > +	rnpgbe_hw_n210L,
> > +	rnpgbe_hw_unknown
> > +};
> > +
> > +struct mucse_dma_info {
> > +	void __iomem *dma_base_addr;
> > +	void __iomem *dma_ring_addr;
> > +	u32 dma_version;
> > +};
> > +
> > +struct mucse_eth_info {
> > +	void __iomem *eth_base_addr;
> > +};
> > +
> > +struct mucse_mac_info {
> > +	void __iomem *mac_addr;
> > +};
> > +
> > +struct mucse_mbx_info {
> > +	/* fw <--> pf mbx */
> > +	u32 fw_pf_shm_base;
> > +	u32 pf2fw_mbox_ctrl;
> > +	u32 fw_pf_mbox_mask;
> > +	u32 fw2pf_mbox_vec;
> > +};
> > +
> > +struct mucse_hw {
> > +	void __iomem *hw_addr;
> > +	void __iomem *ring_msix_base;
> > +	struct pci_dev *pdev;
> > +	enum rnpgbe_hw_type hw_type;
> > +	struct mucse_dma_info dma;
> > +	struct mucse_eth_info eth;
> > +	struct mucse_mac_info mac;
> > +	struct mucse_mbx_info mbx;
> > +	u32 driver_version;
> > +	u16 usecstocount;
> > +};
> > +
> >  struct mucse {
> >  	struct net_device *netdev;
> >  	struct pci_dev *pdev;
> > +	struct mucse_hw hw;
> > +};
> > +
> > +struct rnpgbe_info {
> > +	int total_queue_pair_cnts;
> > +	enum rnpgbe_hw_type hw_type;
> > +	void (*init)(struct mucse_hw *hw);
> >  };
> >  
> >  /* Device IDs */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > new file mode 100644
> > index 000000000000..79aefd7e335d
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -0,0 +1,85 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +
> > +#include "rnpgbe.h"
> > +#include "rnpgbe_hw.h"
> > +
> > +/**
> > + * rnpgbe_init_common - Setup common attribute
> > + * @hw: hw information structure
> > + **/
> > +static void rnpgbe_init_common(struct mucse_hw *hw)
> > +{
> > +	struct mucse_dma_info *dma = &hw->dma;
> > +	struct mucse_eth_info *eth = &hw->eth;
> > +	struct mucse_mac_info *mac = &hw->mac;
> > +
> > +	dma->dma_base_addr = hw->hw_addr;
> > +	dma->dma_ring_addr = hw->hw_addr + RNPGBE_RING_BASE;
> > +
> > +	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
> > +
> > +	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
> > +}
> > +
> > +/**
> > + * rnpgbe_init_n500 - Setup n500 hw info
> > + * @hw: hw information structure
> > + *
> > + * rnpgbe_init_n500 initializes all private
> > + * structure, such as dma, eth, mac and mbx base on
> > + * hw->hw_addr for n500
> > + **/
> > +static void rnpgbe_init_n500(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	rnpgbe_init_common(hw);
> > +
> > +	mbx->fw2pf_mbox_vec = 0x28b00;
> > +	mbx->fw_pf_shm_base = 0x2d000;
> > +	mbx->pf2fw_mbox_ctrl = 0x2e000;
> > +	mbx->fw_pf_mbox_mask = 0x2e200;
> > +	hw->ring_msix_base = hw->hw_addr + 0x28700;
> > +	hw->usecstocount = 125;
> > +}
> 
> These hardcoded values should be defined in rnpgbe_hw.h as macros rather
> than using magic numbers.
> 

Got it, I will update this.

> > +
> > +/**
> > + * rnpgbe_init_n210 - Setup n210 hw info
> 
> > +static int rnpgbe_add_adapter(struct pci_dev *pdev,
> > +			      const struct rnpgbe_info *info)
> > +{
> > +	struct net_device *netdev;
> > +	void __iomem *hw_addr;
> > +	struct mucse *mucse;
> > +	struct mucse_hw *hw;
> > +	u32 dma_version = 0;
> > +	u32 queues;
> > +	int err;
> > +
> > +	queues = info->total_queue_pair_cnts;
> > +	netdev = alloc_etherdev_mq(sizeof(struct mucse), queues);
> > +	if (!netdev)
> > +		return -ENOMEM;
> > +
> > +	SET_NETDEV_DEV(netdev, &pdev->dev);
> > +	mucse = netdev_priv(netdev);
> > +	mucse->netdev = netdev;
> > +	mucse->pdev = pdev;
> > +	pci_set_drvdata(pdev, mucse);
> > +
> > +	hw = &mucse->hw;
> > +	hw->hw_type = info->hw_type;
> > +	hw->pdev = pdev;
> > +
> > +	switch (hw->hw_type) {
> > +	case rnpgbe_hw_n500:
> > +		hw_addr = devm_ioremap(&pdev->dev,
> > +				       pci_resource_start(pdev, 2),
> > +				       pci_resource_len(pdev, 2));
> > +		if (!hw_addr) {
> > +			err = -EIO;
> > +			goto err_free_net;
> > +		}
> > +
> > +		dma_version = readl(hw_addr);
> > +		break;
> > +	case rnpgbe_hw_n210:
> > +	case rnpgbe_hw_n210L:
> > +		hw_addr = devm_ioremap(&pdev->dev,
> > +				       pci_resource_start(pdev, 2),
> > +				       pci_resource_len(pdev, 2));
> > +		if (!hw_addr) {
> > +			err = -EIO;
> > +			goto err_free_net;
> > +		}
> > +
> > +		dma_version = readl(hw_addr);
> > +		break;
> 
> The code in both case branches is identical. Remove the switch statement
> and use the common code instead.
> 

Got it, I will fix this.

> > +	default:
> > +		err = -EIO;
> > +		goto err_free_net;
> > +	}
> > +	hw->hw_addr = hw_addr;
> > +	hw->dma.dma_version = dma_version;
> > +	hw->driver_version = 0x0002040f;
> > +	info->init(hw);
> > +	return 0;
> > +
> > +err_free_net:
> > +	free_netdev(netdev);
> > +	return err;
> > +}
> > +
> 
> 
> -- 
> Thanks and Regards,
> Danish
> 
> 

