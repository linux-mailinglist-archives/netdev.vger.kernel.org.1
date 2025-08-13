Return-Path: <netdev+bounces-213235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9642B24306
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BB21B63217
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679992BF016;
	Wed, 13 Aug 2025 07:46:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD5274FDE
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071204; cv=none; b=WOYnerhxgzrUgk9aky8v87qkl3izmUEKp4C3b0LSdL33VcQWwPI4ULeiXVWx/CHoMkOChAiXwgRJuXD7UV8rHlED9eyTfOXyrVdVVO/3tSt5OPHcJr09nL1tNuFmHCxL2CKpwqI5uhnULqj4ItSJqhrz8VApay4teuiSpMkLJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071204; c=relaxed/simple;
	bh=5jeiwACZJC//91sUyzWvft1D13hiN2I8Ag/Y/4S2LY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiUixeNmh2JXHnrObpTX/IJ9Zg+EYhsae6TAvO7DFDKCHLE0c0m0Rb6+a7rUl4sG2PRGNikrhPOoFRYstmwPZz+RPY+CZ1QOBWD8u4G57FeUDAJKOVaA14VURMFwBHJRuYbCs3u/jGwgyFCVh1doP0ud7hPYAiMqTr6icMx3tlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz15t1755071184tbd45f04d
X-QQ-Originating-IP: D7wXgoZcnfh+Jsc+bkk1zhuO/ETlXGRMU4Iq6dxlGcI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 15:46:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10667824770877014471
Date: Wed, 13 Aug 2025 15:46:22 +0800
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
Subject: Re: [PATCH v3 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <C5DDDB438F5F4EF9+20250813074622.GE944516@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-4-dong100@mucse.com>
 <4f8d678a-8b72-449e-9809-bed912f26e59@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8d678a-8b72-449e-9809-bed912f26e59@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MEhpxtEHTNuOFMS3AVxhhGokPZiiyLY2tjkD7SR4omN9o/2Cyp/NLpzt
	PdpfkXEqowuK2oj0+dYKtiD5Jf4OOJaePQiILTUnAf1YGbK/gRZr5lPw12bHDhaIF76avhB
	e7LnetMm9Zn+B9Rh0CRnvsfn9f6kFROJP0p6RQ+bk3tSRt2nib3wva3JbRMB2843x+VhK/p
	dT/zycDGzBxavmYVnH0cbYe87GkV/PMrSeBQs1MAfuf9YFltuxpu9QlgEMdCVzBvIUgjYIn
	E26qJRVru30D3UHKXB89iROhdY+nZJX4ieVcCbSSdcAiwCK3j+qyq215Lanetobj+oyId6n
	DbptQt41PWWvU269TOpm7aYpO7sghb6C/30CLsKFD4BLdBcb7UdeQpcbdz75lQJJs9rqA1w
	kKHqIqr0RAL2AfvVNkgluA0F7V/j+aNCb40t0Gs8CaSeTnawKLzxmLQFFehQo+6N2PLhL4y
	uK1g06aH3qUmSunUt2931AH49Rtjnspjh6D7QMWLfo/+y/Jl4huqAN5QBZqfibPiXYUyErt
	1VVs7cBfaOQxhM3lPpp0K5RbJma+1X08CMZ64Oh5K8bFD8i2lDiO9epUFLuUaU7+FePFRD/
	uTrUGXbPrL5zx+h1NUtXSvxq+ez0eZuqQsPkz6hNabHuLdpaQJvCR5mSs+CROQL9E7DedCO
	pWoSUg+uva8Oxe87wqGpOrVmFcjfxH4GMsovcWbtIed8X3screEOEnvXR8fJkFlLdqb1kW4
	bwp5aETof7UdQNUTgKyrL2qXxp4LYnCvk9xfQaam0oAdfXA6pmjSskm+TcEGHu2rtkFytYL
	e1FTDo61puCixCvhm/mFlyeg8WfYG/hAP73N0M52GweLiLu5qTnWGbmMYwf9JTi/87uRkSb
	FMEgTDrIfJG2ho/edP49J6U1+3hddgpGWdZGQlOZcFNupUDEvUt63lr5ziqvZGAVIg40JaC
	0w/DDvrcTnHkSVZKkMevMc+lnUizVCyFX+7DiuVOQU9/MO5D9cufr03PEBRFjzyE4HpAUOB
	izkqZ/S3WXR0svNj3Tddgs1YwwE1T+8v4XiJ5UMgRI6tgwQ1lang8baE3OVeVaZJa1O5HHD
	cnc7dOIjVcdkC5qTn9YK3Kbqx/BViEfG8H3YemK1miG
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 10:00:57PM +0530, Anwar, Md Danish wrote:
> On 8/12/2025 3:09 PM, Dong Yibo wrote:
> > Initialize basic mbx function.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  37 ++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   5 +
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 443 ++++++++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  31 ++
> >  6 files changed, 520 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > index 42c359f459d9..5fc878ada4b1 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > @@ -6,4 +6,5 @@
> >  
> >  obj-$(CONFIG_MGBE) += rnpgbe.o
> >  rnpgbe-objs := rnpgbe_main.o\
> > -	       rnpgbe_chip.o
> > +	       rnpgbe_chip.o\
> > +	       rnpgbe_mbx.o
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 0dd3d3cb2a4d..05830bb73d3e 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -5,6 +5,7 @@
> >  #define _RNPGBE_H
> >  
> >  #include <linux/types.h>
> > +#include <linux/mutex.h>
> >  
> >  extern const struct rnpgbe_info rnpgbe_n500_info;
> >  extern const struct rnpgbe_info rnpgbe_n210_info;
> > @@ -40,7 +41,43 @@ struct mucse_mac_info {
> >  	void *back;
> >  };
> >  
> > +struct mucse_hw;
> > +
> > +struct mucse_mbx_operations {
> > +	void (*init_params)(struct mucse_hw *hw);
> > +	int (*read)(struct mucse_hw *hw, u32 *msg,
> > +		    u16 size);
> > +	int (*write)(struct mucse_hw *hw, u32 *msg,
> > +		     u16 size);
> > +	int (*read_posted)(struct mucse_hw *hw, u32 *msg,
> > +			   u16 size);
> > +	int (*write_posted)(struct mucse_hw *hw, u32 *msg,
> > +			    u16 size);
> > +	int (*check_for_msg)(struct mucse_hw *hw);
> > +	int (*check_for_ack)(struct mucse_hw *hw);
> > +	void (*configure)(struct mucse_hw *hw, int num_vec,
> > +			  bool enable);
> > +};
> > +
> > +struct mucse_mbx_stats {
> > +	u32 msgs_tx;
> > +	u32 msgs_rx;
> > +	u32 acks;
> > +	u32 reqs;
> > +	u32 rsts;
> > +};
> > +
> >  struct mucse_mbx_info {
> > +	const struct mucse_mbx_operations *ops;
> > +	struct mucse_mbx_stats stats;
> > +	u32 timeout;
> > +	u32 usec_delay;
> > +	u16 size;
> > +	u16 fw_req;
> > +	u16 fw_ack;
> > +	/* lock for only one use mbx */
> > +	struct mutex lock;
> > +	bool irq_enabled;
> >  	/* fw <--> pf mbx */
> >  	u32 fw_pf_shm_base;
> >  	u32 pf2fw_mbox_ctrl;
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index 20ec67c9391e..16d0a76114b5 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -1,8 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright(c) 2020 - 2025 Mucse Corporation. */
> >  
> > +#include <linux/string.h>
> > +
> >  #include "rnpgbe.h"
> >  #include "rnpgbe_hw.h"
> > +#include "rnpgbe_mbx.h"
> >  
> >  /**
> >   * rnpgbe_init_common - Setup common attribute
> > @@ -23,6 +26,8 @@ static void rnpgbe_init_common(struct mucse_hw *hw)
> >  
> >  	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
> >  	mac->back = hw;
> > +
> > +	hw->mbx.ops = &mucse_mbx_ops_generic;
> >  }
> >  
> >  /**
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > index fc57258537cf..aee037e3219d 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > @@ -7,6 +7,8 @@
> >  #define RNPGBE_RING_BASE 0x1000
> >  #define RNPGBE_MAC_BASE 0x20000
> >  #define RNPGBE_ETH_BASE 0x10000
> > +/**************** DMA Registers ****************************/
> > +#define RNPGBE_DMA_DUMY 0x000c
> >  /**************** CHIP Resource ****************************/
> >  #define RNPGBE_MAX_QUEUES 8
> >  #endif /* _RNPGBE_HW_H */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > new file mode 100644
> > index 000000000000..1195cf945ad1
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > @@ -0,0 +1,443 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2022 - 2025 Mucse Corporation. */
> > +
> > +#include <linux/pci.h>
> > +#include <linux/errno.h>
> > +#include <linux/delay.h>
> > +#include <linux/iopoll.h>
> > +
> > +#include "rnpgbe.h"
> > +#include "rnpgbe_mbx.h"
> > +#include "rnpgbe_hw.h"
> > +
> > +/**
> > + * mucse_read_mbx - Reads a message from the mailbox
> > + * @hw: pointer to the HW structure
> > + * @msg: the message buffer
> > + * @size: length of buffer
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	/* limit read size */
> > +	min(size, mbx->size);
> > +	return mbx->ops->read(hw, msg, size);
> > +}
> 
> What's the purpose of min() here if you are anyways passing size to read()?
> 
> The min() call needs to be assigned to size, e.g.: size = min(size,
> mbx->size);
> 

Yes, I will fix this error.

> > +
> > +/**
> > + * mucse_write_mbx - Write a message to the mailbox
> > + * @hw: pointer to the HW structure
> > + * @msg: the message buffer
> > + * @size: length of buffer
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> 
> > +
> > +/**
> > + * mucse_mbx_reset - Reset mbx info, sync info from regs
> > + * @hw: pointer to the HW structure
> > + *
> > + * This function reset all mbx variables to default.
> > + **/
> > +static void mucse_mbx_reset(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int v;
> > +
> 
> Variable 'v' should be declared as u32 to match the register read.
> 

Got it, I will fix it.

> > +	v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
> > +	hw->mbx.fw_req = v & GENMASK(15, 0);
> > +	hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
> > +	mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> > +	mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
> > +}
> > +
> > +/**
> > + * mucse_mbx_configure_pf - Configure mbx to use nr_vec interrupt
> > + * @hw: pointer to the HW structure
> > + * @nr_vec: vector number for mbx
> > + * @enable: TRUE for enable, FALSE for disable
> > + *
> > + * This function configure mbx to use interrupt nr_vec.
> > + **/
> > +static void mucse_mbx_configure_pf(struct mucse_hw *hw, int nr_vec,
> > +				   bool enable)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u32 v;
> > +
> > +	if (enable) {
> > +		v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
> > +		hw->mbx.fw_req = v & GENMASK(15, 0);
> > +		hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
> > +		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> > +		mbx_wr32(hw, FW2PF_MBOX_VEC(mbx), nr_vec);
> > +		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
> > +	} else {
> > +		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), 0xfffffffe);
> > +		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> > +		mbx_wr32(hw, RNPGBE_DMA_DUMY, 0);
> > +	}
> > +}
> > +
> > +/**
> > + * mucse_init_mbx_params_pf - Set initial values for pf mailbox
> > + * @hw: pointer to the HW structure
> > + *
> > + * Initializes the hw->mbx struct to correct values for pf mailbox
> > + */
> > +static void mucse_init_mbx_params_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	mbx->usec_delay = 100;
> > +	mbx->timeout = (4 * 1000 * 1000) / mbx->usec_delay;
> 
> Use appropriate constants like USEC_PER_SEC instead of hardcoded values.
> 

Ok, I will update it.

> > +	mbx->stats.msgs_tx = 0;
> > +	mbx->stats.msgs_rx = 0;
> 
> 
> -- 
> Thanks and Regards,
> Md Danish Anwar
> 
> 

Thanks for your feedback.

