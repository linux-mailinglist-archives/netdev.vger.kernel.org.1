Return-Path: <netdev+bounces-213214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA67B2422E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B4E724C6F
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8FF2BE64F;
	Wed, 13 Aug 2025 07:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50B1B4257
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068864; cv=none; b=OQb+IqxBzTBRJd50GfJHsixsRgEXTI40gwrScWGSCYRWvc89tZtg4IVU7g54UduYG3LMWA3G4bxyaGfUocI6/ogFq53qMPfP1Fhomg4+zNZA2BO11ieIHT6GR29IUb2sQN0kL+C4fhz9ZxCXxqeZfA5u49ipI/IqESwI0QxOhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068864; c=relaxed/simple;
	bh=ZxOsu80dPXP4RVHcQKDLMmEkqIlc7JubAlytaedrZf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkEBhbdzAYSOaZT09gG5CFpsDrKvJXoSghcSfad4zWPa+OiXyLFmy0znivc7u+JsFeOb6clNe6wyTSwlvZNbtm3IAIxqnsbu1rj7z3gj5gsfDP0b75Cu0wlwaZkpU1mJvCaLbHkWZ9kK72rzIf8bjI9327QoEEIOPVPiknPWi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz21t1755068854tcf55b7c1
X-QQ-Originating-IP: gnaOuli4b2G/5CPyc2oyLv+iGndJ646NoS1ke4YiZho=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 15:07:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1358432892365096457
Date: Wed, 13 Aug 2025 15:07:32 +0800
From: Yibo Dong <dong100@mucse.com>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <9CCA89AC57AB18AC+20250813070732.GD944516@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-3-dong100@mucse.com>
 <d77189ec-b1ee-4718-9212-c7208da40814@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d77189ec-b1ee-4718-9212-c7208da40814@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MTGYztYhR5ETiX0PhubvQKeRIctxmuYfakhQ/saxxtKlDjM9hy1ODQr8
	by2iwXqrHrdt3QUSJifH9gjQFPygwndAzBXZmy0N9hwGHhox8MkG3QEZKU4WnvqlHJLySmD
	y8tgvi4IGlWC5C5fCQd0hhbHLtJHHqq4fUxB1Ker/bA6jHuH+8kTt3lysu72DqeB/XRcnnW
	bD2g4Zqh3mxUU8Dlm15L9eAK49vQ/yJ8aVps2I1OEZ0t5h7N3apFeWDslaM5AAZqtttbtdx
	3SJYLsbhmWcwAfg1FXeofd292qfWU4ixrj6NIHcgrnNZLAiGzfYzGL4d6+PH4tgNsvIyXUJ
	GzFsuVKh5iTfxL0fGcBXUUrMTN4C83/d2l5lusvU9FFUExQ+O2TPpdoQVGwKzeVMSYJbEqc
	KyOX9hebr2nQ+ecaPLiZNytkQ1Pk2QCofMo8/zD5OzzPX4UceVsOhDeWX07Yllt5P3C4Sgi
	HuCciiiI5bAOqDMJpBAnUpo4J3OZDVd0Vau6qP4qETuCI/57TJR14yMJVHp8Ypf35f7m1ut
	L3OaELUcTRufeSLlZcGNnn+mVR5+4MZT3oPYB2CcWSjScMN7qvBbLwubuwdmpSWKV5LZXcE
	5niqn9dAJmqq/2G2oVps09daYOXVS3xHSXTr2uiDJanLE5tq6gm6eOg6H0Cp5p3st9lQbSe
	Io+ri80JY+2yuPuNWfOPECJG20aJXgCO28kBkGUIv55511+dOS2W4KYUGvSsq3e50Ogzdwx
	fbBb4bBqZjCg9otf9r8Fi4/o6/pfGXxMm/ELoZm81NcTKxOmBvT838kAJWVRNAmqPrGpflQ
	YUlPMzno5S+ZxwrT/aqNpAejU0QYI3dtOrWmwVeIbyFr0vTybaq8qrzpLYXHm36lED19zdH
	tJUeTXiW/1Z3j6DCdANsZScI00iH+sfqddBWtH6ZB1rI8/LMd2lflQAgpBGsIYm3VJ8agcR
	d2/ql4WMWFk2RMIMUyPVsyIhPFPnrnKF9F1E+TwdgK2xPBGEYNStN9TsOS8D1EXfNVD+Ers
	F4vg32VrEOPwnhXfU4
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 09:55:11PM +0530, Anwar, Md Danish wrote:
> On 8/12/2025 3:09 PM, Dong Yibo wrote:
> > Initialize n500/n210 chip bar resource map and
> > dma, eth, mbx ... info for future use.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  60 +++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  88 ++++++++++++++
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  12 ++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 115 ++++++++++++++++++
> >  5 files changed, 277 insertions(+), 1 deletion(-)
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
> > index 23c84454e7c7..0dd3d3cb2a4d 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -4,18 +4,78 @@
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
> > +	rnpgbe_hw_unknow
> > +};
> 
> 
> The enum value name should be "rnpgbe_hw_unknown" not "rnpgbe_hw_unknow"
> (missing 'n').
> 

Got it, I will fix this.

> > +
> > +struct mucse_dma_info {
> > +	void __iomem *dma_base_addr;
> > +	void __iomem *dma_ring_addr;
> > +	void *back;
> > +	u32 dma_version;
> > +};
> > +
> > +struct mucse_eth_info {
> > +	void __iomem *eth_base_addr;
> > +	void *back;
> > +};
> > +
> > +struct mucse_mac_info {
> > +	void __iomem *mac_addr;
> > +	void *back;
> > +};
> > +
> > +struct mucse_mbx_info {
> > +	/* fw <--> pf mbx */
> > +	u32 fw_pf_shm_base;
> > +	u32 pf2fw_mbox_ctrl;
> > +	u32 pf2fw_mbox_mask;
> > +	u32 fw_pf_mbox_mask;
> > +	u32 fw2pf_mbox_vec;
> > +};
> > +
> > +struct mucse_hw {
> > +	void *back;
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
> >  	u16 bd_number;
> >  };
> >  
> > +struct rnpgbe_info {
> > +	int total_queue_pair_cnts;
> > +	enum rnpgbe_hw_type hw_type;
> > +	void (*init)(struct mucse_hw *hw);
> > +};
> > +
> >  /* Device IDs */
> >  #define PCI_VENDOR_ID_MUCSE 0x8848
> >  #define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > new file mode 100644
> > index 000000000000..20ec67c9391e
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -0,0 +1,88 @@
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
> > +	dma->back = hw;
> > +
> > +	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
> > +	eth->back = hw;
> > +
> > +	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
> > +	mac->back = hw;
> > +}
> > +
> > +/**
> > + * rnpgbe_init_n500 - Setup n500 hw info
> > + * @hw: hw information structure
> > + *
> > + * rnpgbe_init_n500 initializes all private
> > + * structure, such as dma, eth, mac and mbx base on
> > + * hw->addr for n500
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
> > +
> > +/**
> > + * rnpgbe_init_n210 - Setup n210 hw info
> > + * @hw: hw information structure
> > + *
> > + * rnpgbe_init_n210 initializes all private
> > + * structure, such as dma, eth, mac and mbx base on
> > + * hw->addr for n210
> > + **/
> > +static void rnpgbe_init_n210(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	rnpgbe_init_common(hw);
> > +
> > +	mbx->fw2pf_mbox_vec = 0x29400;
> > +	mbx->fw_pf_shm_base = 0x2d900;
> > +	mbx->pf2fw_mbox_ctrl = 0x2e900;
> > +	mbx->fw_pf_mbox_mask = 0x2eb00;
> > +	hw->ring_msix_base = hw->hw_addr + 0x29000;
> > +	hw->usecstocount = 62;
> > +}
> 
> I don't see pf2fw_mbox_mask getting initialized anywhere. Is that not
> needed?
> 

You are right, pf2fw_mbox_mask is not needed. I will delete it.

> > +
> > +const struct rnpgbe_info rnpgbe_n500_info = {
> 
> 
> -- 
> Thanks and Regards,
> Md Danish Anwar
> 
> 

Thanks for your feedback.


