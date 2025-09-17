Return-Path: <netdev+bounces-223836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C3B7D496
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963A52A3C7D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 02:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13642F39CF;
	Wed, 17 Sep 2025 02:55:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264936B;
	Wed, 17 Sep 2025 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077758; cv=none; b=D+kvvvvT77Lv+lDBNBIhIrI0rM3KnoS01zQAL6kJUUxTx9KMp2XjZKB+7NbuA3TC9WJU8wX0iHCdR6ieiN/QDhNjlE6NdH/NE4L5zN0FI6E2ttIV1tUVmMZyL86LhvECMILeQYnpSRHm5WQSWVKukaRqL2Q2DosPk78K4p7nfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077758; c=relaxed/simple;
	bh=qUq8Q3z5Q8qtlDvqGRzHbq4dAHb8JSSi/7JiOQEOCBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLB/xQVVAKY5qX6VNXOBd1ely5H9iLQhFEAwAX4DeYyyPtgQ/H4wjD4HudVgmQCvkvpbi0+zvG6A+Z1uhJXe/RG2FlTITGvDS5ov3/mk0v2zsjrhjGK1VqjNkcPCstQVijH+NtM+Iz7ukvNBuJPK/mtV2gcjilnDqbBjEUAYDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1758077720tb6380467
X-QQ-Originating-IP: If3ftM+h5ecRkZhnKZ/Cf9QysWz86SRv1K+x3zCD3Jg=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Sep 2025 10:55:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12543657476232281646
Date: Wed, 17 Sep 2025 10:55:17 +0800
From: Yibo Dong <dong100@mucse.com>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v12 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <1EEF4BDF881EDC0C+20250917025517.GB33236@nic-Precision-5820-Tower>
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-4-dong100@mucse.com>
 <7d4olrtuyagvcma5sspca6urmkjotkjtthbbekkeqltnd6mgq6@pn4smgsdaf4c>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d4olrtuyagvcma5sspca6urmkjotkjtthbbekkeqltnd6mgq6@pn4smgsdaf4c>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M5znx2hx04lbdDzfTtmcjIxST+aiDSQl+jL+t/vAvUuA4PhJn8Ku0+cq
	owZJlk6GPhAFE3kplEgMarMuHUeXEBkv/GAkfpSuz+Oi92VjI0WFyvc09En69JayH0+zCB/
	p0kyg4vofCeg66Xx6r2WXNmKtNQKVyDJmyPGUcQ4QytUa6pEkqwDP7Qd1mAkcQG+EwOYkgH
	Hbr8Uo/bznC9KT9myMLQa+0gTu1wE9/GfXQ0CUZpic6+8rJGUQRusy0k/7LcBGrGrc5q/Qe
	i5CB/ozW16D7/apWGxmoYf4jofe0oKcHHVO7/5E3ATlpWrKzdo0vtnf8GDdilwgvATa/uhg
	XgKAIuqLw2i+n19q1/vRV53XYV/1tW7by/QnF+C8XlH8+wRS9wf9akLcSRZjqKySYjhLgIj
	Il33EU4iII8GWsak2sA9HRiZ0ABYdk09AaX1PweiAPK53g6l+pg/JjOo0I3j5To7xq6txgX
	7Iv4W0XaDvVpopFKebNs0aQc78xJItAUz+/zfTGJ99nGFTmEQoEJhXq8yIpKPhdFeEOZqMX
	covkKkBisFg8MsJE/5NVO6VdtNs+KU99k61QD1ZIhnrB19zXsWJa2r/0RlrBS6CJvwz8dJR
	9kotOn0lkil34Px0TQkywPz3T+oZOUgLfcrm608ug6mbu08jrho8phm/pzqdTh9TyqEfFMZ
	ReOi/QIufRb7iKjeGjt1TmPKrOH5i8ewPzzh5vkK00CxUi1UU8BjpYb3El0J/jRyOE8kBfm
	GsNidJueivTF1KosnnjpWypDNaI5Lkdhc9RwDhzwH0H6p2J8n/9L4KUjMWdQ1H3auPcqvph
	HpP5dA9pG+4f88I352jUUEO2ru7fdQKXRVUjUnRkVoUsJJAqjl3UwSOletbrBcVhqG06rIQ
	bSIrxebh740HfnQS7A+819NseDX2JWbhtHzKcKutkWk9SXFRkKaATESuj0DwdQKm7MpyfzE
	g79UI4nRWO2af/hdbZcUvtrLjQ5awKVZTFMXlo3C8HvMryQ2z876QvcrwOGfRb0+MYWlEgx
	7vwra/eI2aXu1Mwr/Dwd0Vo5GwU4E=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Tue, Sep 16, 2025 at 08:42:44PM +0200, Jörg Sommer wrote:
> Hi,
> 
> only some minor suggestions.
> 
> Dong Yibo schrieb am Di 16. Sep, 19:29 (+0800):
> > Add fundamental mailbox (MBX) communication operations between PF
> > (Physical Function) and firmware for n500/n210 chips
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 ++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  70 +++
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   7 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   5 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 420 ++++++++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
> >  7 files changed, 550 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > index 9df536f0d04c..5fc878ada4b1 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > @@ -5,4 +5,6 @@
> >  #
> >  
> >  obj-$(CONFIG_MGBE) += rnpgbe.o
> > -rnpgbe-objs := rnpgbe_main.o
> > +rnpgbe-objs := rnpgbe_main.o\
> > +	       rnpgbe_chip.o\
> > +	       rnpgbe_mbx.o
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 3b122dd508ce..7450bfc5ee98 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -4,13 +4,36 @@
> >  #ifndef _RNPGBE_H
> >  #define _RNPGBE_H
> >  
> > +#include <linux/types.h>
> > +
> >  enum rnpgbe_boards {
> >  	board_n500,
> >  	board_n210
> >  };
> >  
> > +struct mucse_mbx_stats {
> > +	u32 msgs_tx; /* Number of messages sent from PF to fw */
> > +	u32 msgs_rx; /* Number of messages received from fw to PF */
> > +	u32 acks; /* Number of ACKs received from firmware */
> > +	u32 reqs; /* Number of requests sent to firmware */
> > +};
> > +
> > +struct mucse_mbx_info {
> > +	struct mucse_mbx_stats stats;
> > +	u32 timeout_us;
> > +	u32 delay_us;
> > +	u16 fw_req;
> > +	u16 fw_ack;
> > +	/* fw <--> pf mbx */
> > +	u32 fwpf_shm_base;
> > +	u32 pf2fw_mbx_ctrl;
> > +	u32 fwpf_mbx_mask;
> > +	u32 fwpf_ctrl_base;
> > +};
> > +
> >  struct mucse_hw {
> >  	void __iomem *hw_addr;
> > +	struct mucse_mbx_info mbx;
> >  };
> >  
> >  struct mucse {
> > @@ -19,6 +42,8 @@ struct mucse {
> >  	struct mucse_hw hw;
> >  };
> >  
> > +int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
> > +
> >  /* Device IDs */
> >  #define PCI_VENDOR_ID_MUCSE 0x8848
> >  #define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > new file mode 100644
> > index 000000000000..86f1c75796b0
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +
> > +#include <linux/errno.h>
> > +
> > +#include "rnpgbe.h"
> > +#include "rnpgbe_hw.h"
> > +#include "rnpgbe_mbx.h"
> > +
> > +/**
> > + * rnpgbe_init_n500 - Setup n500 hw info
> > + * @hw: hw information structure
> > + *
> > + * rnpgbe_init_n500 initializes all private
> > + * structure for n500
> > + **/
> > +static void rnpgbe_init_n500(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	mbx->fwpf_ctrl_base = MUCSE_N500_FWPF_CTRL_BASE;
> > +	mbx->fwpf_shm_base = MUCSE_N500_FWPF_SHM_BASE;
> > +}
> > +
> > +/**
> > + * rnpgbe_init_n210 - Setup n210 hw info
> > + * @hw: hw information structure
> > + *
> > + * rnpgbe_init_n210 initializes all private
> > + * structure for n210
> > + **/
> > +static void rnpgbe_init_n210(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	mbx->fwpf_ctrl_base = MUCSE_N210_FWPF_CTRL_BASE;
> > +	mbx->fwpf_shm_base = MUCSE_N210_FWPF_SHM_BASE;
> > +}
> > +
> > +/**
> > + * rnpgbe_init_hw - Setup hw info according to board_type
> > + * @hw: hw information structure
> > + * @board_type: board type
> > + *
> > + * rnpgbe_init_hw initializes all hw data
> > + *
> > + * Return: 0 on success, negative errno on failure
> 
> Maybe say that -EINVAL is the only error returned.
> 

Got it.

> > + **/
> > +int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	mbx->pf2fw_mbx_ctrl = MUCSE_GBE_PFFW_MBX_CTRL_OFFSET;
> > +	mbx->fwpf_mbx_mask = MUCSE_GBE_FWPF_MBX_MASK_OFFSET;
> > +
> > +	switch (board_type) {
> > +	case board_n500:
> > +		rnpgbe_init_n500(hw);
> > +		break;
> > +	case board_n210:
> > +		rnpgbe_init_n210(hw);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	/* init_params with mbx base */
> > +	mucse_init_mbx_params_pf(hw);
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > index 3a779806e8be..aad4cb2f4164 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > @@ -4,5 +4,12 @@
> >  #ifndef _RNPGBE_HW_H
> >  #define _RNPGBE_HW_H
> >  
> > +#define MUCSE_N500_FWPF_CTRL_BASE 0x28b00
> > +#define MUCSE_N500_FWPF_SHM_BASE 0x2d000
> > +#define MUCSE_GBE_PFFW_MBX_CTRL_OFFSET 0x5500
> > +#define MUCSE_GBE_FWPF_MBX_MASK_OFFSET 0x5700
> > +#define MUCSE_N210_FWPF_CTRL_BASE 0x29400
> > +#define MUCSE_N210_FWPF_SHM_BASE 0x2d900
> > +
> >  #define RNPGBE_MAX_QUEUES 8
> >  #endif /* _RNPGBE_HW_H */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > index 0afe39621661..c6cfb54f7c59 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > @@ -68,6 +68,11 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
> >  	}
> >  
> >  	hw->hw_addr = hw_addr;
> > +	err = rnpgbe_init_hw(hw, board_type);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Init hw err %d\n", err);
> > +		goto err_free_net;
> > +	}
> >  
> >  	return 0;
> >  
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > new file mode 100644
> > index 000000000000..7501a55c3134
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > @@ -0,0 +1,420 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2022 - 2025 Mucse Corporation. */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/iopoll.h>
> > +
> > +#include "rnpgbe_mbx.h"
> > +
> > +/**
> > + * mbx_data_rd32 - Reads reg with base mbx->fwpf_shm_base
> > + * @mbx: pointer to the MBX structure
> > + * @reg: register offset
> > + *
> > + * Return: register value
> > + **/
> > +static u32 mbx_data_rd32(struct mucse_mbx_info *mbx, u32 reg)
> > +{
> > +	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
> > +
> > +	return readl(hw->hw_addr + mbx->fwpf_shm_base + reg);
> > +}
> > +
> > +/**
> > + * mbx_data_wr32 - Writes value to reg with base mbx->fwpf_shm_base
> > + * @mbx: pointer to the MBX structure
> > + * @reg: register offset
> > + * @value: value to be written
> > + *
> > + **/
> > +static void mbx_data_wr32(struct mucse_mbx_info *mbx, u32 reg, u32 value)
> > +{
> > +	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
> > +
> > +	writel(value, hw->hw_addr + mbx->fwpf_shm_base + reg);
> > +}
> > +
> > +/**
> > + * mbx_ctrl_rd32 - Reads reg with base mbx->fwpf_ctrl_base
> > + * @mbx: pointer to the MBX structure
> > + * @reg: register offset
> > + *
> > + * Return: register value
> > + **/
> > +static u32 mbx_ctrl_rd32(struct mucse_mbx_info *mbx, u32 reg)
> > +{
> > +	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
> > +
> > +	return readl(hw->hw_addr + mbx->fwpf_ctrl_base + reg);
> > +}
> > +
> > +/**
> > + * mbx_ctrl_wr32 - Writes value to reg with base mbx->fwpf_ctrl_base
> > + * @mbx: pointer to the MBX structure
> > + * @reg: register offset
> > + * @value: value to be written
> > + *
> > + **/
> > +static void mbx_ctrl_wr32(struct mucse_mbx_info *mbx, u32 reg, u32 value)
> > +{
> > +	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
> > +
> > +	writel(value, hw->hw_addr + mbx->fwpf_ctrl_base + reg);
> > +}
> > +
> > +/**
> > + * mucse_mbx_get_lock_pf - Write ctrl and read back lock status
> > + * @hw: pointer to the HW structure
> > + *
> > + * Return: register value after write
> > + **/
> > +static u32 mucse_mbx_get_lock_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u32 reg = MUCSE_MBX_PF2FW_CTRL(mbx);
> > +
> > +	mbx_ctrl_wr32(mbx, reg, MUCSE_MBX_PFU);
> > +
> > +	return mbx_ctrl_rd32(mbx, reg);
> > +}
> > +
> > +/**
> > + * mucse_obtain_mbx_lock_pf - Obtain mailbox lock
> > + * @hw: pointer to the HW structure
> > + *
> > + * Pair with mucse_release_mbx_lock_pf()
> > + * This function maybe used in an irq handler.
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u32 val;
> > +
> > +	return read_poll_timeout_atomic(mucse_mbx_get_lock_pf,
> > +					val, val & MUCSE_MBX_PFU,
> > +					mbx->delay_us,
> > +					mbx->timeout_us,
> > +					false, hw);
> > +}
> > +
> > +/**
> > + * mucse_release_mbx_lock_pf - Release mailbox lock
> > + * @hw: pointer to the HW structure
> > + * @req: send a request or not
> > + *
> > + * Pair with mucse_obtain_mbx_lock_pf():
> > + * - Releases the mailbox lock by clearing MUCSE_MBX_PFU bit
> > + * - Simultaneously sends the request by setting MUCSE_MBX_REQ bit
> > + *   if req is true
> > + * (Both bits are in the same mailbox control register,
> > + * so operations are combined)
> > + **/
> > +static void mucse_release_mbx_lock_pf(struct mucse_hw *hw, bool req)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u32 reg = MUCSE_MBX_PF2FW_CTRL(mbx);
> > +
> > +	if (req)
> > +		mbx_ctrl_wr32(mbx, reg, MUCSE_MBX_REQ);
> > +	else
> > +		mbx_ctrl_wr32(mbx, reg, 0);
> 
> Maybe combine this to:
> 
> mbx_ctrl_wr32(mbx, reg, req ? MUCSE_MBX_REQ : 0);
> 
> or also inlining reg:
> 
> mbx_ctrl_wr32(mbx, MUCSE_MBX_PF2FW_CTRL(mbx), req ? MUCSE_MBX_REQ : 0);
> 

Got it, I will update to
mbx_ctrl_wr32(mbx, reg, req ? MUCSE_MBX_REQ : 0)
I think it is too long to inlining reg...

> > +}
> > +
> > +/**
> > + * mucse_mbx_get_fwreq - Read fw req from reg
> > + * @mbx: pointer to the mbx structure
> > + *
> > + * Return: the fwreq value
> > + **/
> > +static u16 mucse_mbx_get_fwreq(struct mucse_mbx_info *mbx)
> > +{
> > +	u32 val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
> > +
> > +	return FIELD_GET(GENMASK_U32(15, 0), val);
> > +}
> > +
> > +/**
> > + * mucse_mbx_inc_pf_ack - Increase ack
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_inc_pf_ack reads pf_ack from hw, then writes
> > + * new value back after increase
> > + **/
> > +static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u16 ack;
> > +	u32 val;
> > +
> > +	val = mbx_data_rd32(mbx, MUCSE_MBX_PF2FW_CNT);
> > +	ack = FIELD_GET(GENMASK_U32(31, 16), val);
> > +	ack++;
> > +	val &= ~GENMASK_U32(31, 16);
> > +	val |= FIELD_PREP(GENMASK_U32(31, 16), ack);
> > +	mbx_data_wr32(mbx, MUCSE_MBX_PF2FW_CNT, val);
> > +	hw->mbx.stats.msgs_rx++;
> > +}
> > +
> > +/**
> > + * mucse_read_mbx_pf - Read a message from the mailbox
> > + * @hw: pointer to the HW structure
> > + * @msg: the message buffer
> > + * @size: length of buffer
> > + *
> > + * mucse_read_mbx_pf copies a message from the mbx buffer to the caller's
> > + * memory buffer. The presumption is that the caller knows that there was
> > + * a message due to a fw request so no polling for message is needed.
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int size_in_words = size / 4;
> 
> * Make this `const int` or I'm in favour of inlining, because it's used only
>   once.
> 
> * Maybe `size / sizeof(*msg)` makes it more clearly where the 4 is coming
>   from.
> 

Maybe like this?
const int size_in_words = size / sizeof(u32);
'4 is the number of bytes in u32' here.
(https://lore.kernel.org/netdev/20250909135554.5013bcb0@kernel.org/)

I think use 'size_in_words' maybe more clearly than inlining...

> > +	int ret;
> > +	int i;
> 
> Because this variable is only used in the for-loop, I would narrow its scope
> and write `for (int i = 0;`
> 

Got it, I will update it in next version.

> > +
> > +	ret = mucse_obtain_mbx_lock_pf(hw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < size_in_words; i++)
> > +		msg[i] = mbx_data_rd32(mbx, MUCSE_MBX_FWPF_SHM + 4 * i);
> > +	/* Hw needs write data_reg at last */
> > +	mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM, 0);
> > +	/* flush reqs as we have read this request data */
> > +	hw->mbx.fw_req = mucse_mbx_get_fwreq(mbx);
> > +	mucse_mbx_inc_pf_ack(hw);
> > +	mucse_release_mbx_lock_pf(hw, false);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * mucse_check_for_msg_pf - Check to see if the fw has sent mail
> > + * @hw: pointer to the HW structure
> > + *
> > + * Return: 0 if the fw has set the Status bit or else -EIO
> > + **/
> > +static int mucse_check_for_msg_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u16 fw_req;
> > +
> > +	fw_req = mucse_mbx_get_fwreq(mbx);
> > +	/* chip's register is reset to 0 when rc send reset
> > +	 * mbx command. This causes 'fw_req != hw->mbx.fw_req'
> > +	 * be TRUE before fw really reply. Driver must wait fw reset
> > +	 * done reply before using chip, we must check no-zero.
> > +	 **/
> 
> If I get this right, fw_req == 0 means that the request was send, but
> nothing returned so far. Would not be -EAGAIN a better return value in this
> case?
> 
> And fw_req == hw->mbx.fw_req means that we've got the old fw_req again which
> means there was an error (-EIO).
> 

Maybe not accurate, fw_req == 0 is the condition after fw reset chips,
and fw_req == hw->mbx.fw_req means no new req/response in mbx.
Driver gets hw->mbx.fw_req first, send the request and wait to check the response with
fw_req != hw->mbx.fw_req. (but the req maybe a reset command, then before
fw true response, fw_req from register will be 0 make fw_req !=
hw->mbx.fw_req be true, that is not correct).

This is caused by registers in chip always reset to 0 after fw reset it.
Fw records the register value, then call the reset and write back the value.
And also, fw adds value to the register when powerup to make register
no-zero before driver use it.

> > +	if (fw_req != 0 && fw_req != hw->mbx.fw_req) {
> > +		hw->mbx.stats.reqs++;
> > +		return 0;
> > +	}
> > +
> > +	return -EIO;
> 
> Only a suggestion: Might it be clearer to flip the cases and handle the if
> as error case and continue with the success case?
> 
> if (fw_req == 0 || fw_req == hw->mbx.fw_req)
> 	return -EIO;
> 
> hw->mbx.stats.reqs++;
> return 0;
> 

That's a good idea. I will update this in next version.

> > +}
> > +
> > +/**
> > + * mucse_poll_for_msg - Wait for message notification
> > + * @hw: pointer to the HW structure
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +static int mucse_poll_for_msg(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int val;
> > +
> > +	return read_poll_timeout(mucse_check_for_msg_pf,
> > +				 val, !val, mbx->delay_us,
> > +				 mbx->timeout_us,
> > +				 false, hw);
> > +}
> > +
> > +/**
> > + * mucse_poll_and_read_mbx - Wait for message notification and receive message
> > + * @hw: pointer to the HW structure
> > + * @msg: the message buffer
> > + * @size: length of buffer
> > + *
> > + * Return: 0 if it successfully received a message notification and
> > + * copied it into the receive buffer, negative errno on failure
> > + **/
> > +int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	int ret;
> > +
> > +	ret = mucse_poll_for_msg(hw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return mucse_read_mbx_pf(hw, msg, size);
> > +}
> > +
> > +/**
> > + * mucse_mbx_get_fwack - Read fw ack from reg
> > + * @mbx: pointer to the MBX structure
> > + *
> > + * Return: the fwack value
> > + **/
> > +static u16 mucse_mbx_get_fwack(struct mucse_mbx_info *mbx)
> > +{
> > +	u32 val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
> > +
> > +	return FIELD_GET(GENMASK_U32(31, 16), val);
> > +}
> > +
> > +/**
> > + * mucse_mbx_inc_pf_req - Increase req
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_inc_pf_req reads pf_req from hw, then writes
> > + * new value back after increase
> > + **/
> > +static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u16 req;
> > +	u32 val;
> > +
> > +	val = mbx_data_rd32(mbx, MUCSE_MBX_PF2FW_CNT);
> > +	req = FIELD_GET(GENMASK_U32(15, 0), val);
> 
> Why not assign the values in the declaration like done with mbx?
> 

Just like Andrew said, Reverse Christmas tree.

> > +	req++;
> > +	val &= ~GENMASK_U32(15, 0);
> > +	val |= FIELD_PREP(GENMASK_U32(15, 0), req);
> > +	mbx_data_wr32(mbx, MUCSE_MBX_PF2FW_CNT, val);
> > +	hw->mbx.stats.msgs_tx++;
> > +}
> > +
> > +/**
> > + * mucse_write_mbx_pf - Place a message in the mailbox
> > + * @hw: pointer to the HW structure
> > + * @msg: the message buffer
> > + * @size: length of buffer
> > + *
> > + * Return: 0 if it successfully copied message into the buffer
> 
> ... "otherwise the error from obtaining the lock" or something better.
> 

Got it.

> > + **/
> > +static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int size_in_words = size / 4;
> > +	int ret;
> > +	int i;
> > +
> > +	ret = mucse_obtain_mbx_lock_pf(hw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < size_in_words; i++)
> > +		mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM + i * 4, msg[i]);
> > +
> > +	/* flush acks as we are overwriting the message buffer */
> > +	hw->mbx.fw_ack = mucse_mbx_get_fwack(mbx);
> > +	mucse_mbx_inc_pf_req(hw);
> > +	mucse_release_mbx_lock_pf(hw, true);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * mucse_check_for_ack_pf - Check to see if the fw has ACKed
> > + * @hw: pointer to the HW structure
> > + *
> > + * Return: 0 if the fw has set the Status bit or else -EIO
> > + **/
> > +static int mucse_check_for_ack_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u16 fw_ack;
> > +
> > +	fw_ack = mucse_mbx_get_fwack(mbx);
> > +	/* chip's register is reset to 0 when rc send reset
> > +	 * mbx command. This causes 'fw_ack != hw->mbx.fw_ack'
> > +	 * be TRUE before fw really reply. Driver must wait fw reset
> > +	 * done reply before using chip, we must check no-zero.
> > +	 **/
> > +	if (fw_ack != 0 && fw_ack != hw->mbx.fw_ack) {
> > +		hw->mbx.stats.acks++;
> > +		return 0;
> > +	}
> > +
> > +	return -EIO;
> > +}
> > +
> > +/**
> > + * mucse_poll_for_ack - Wait for message acknowledgment
> > + * @hw: pointer to the HW structure
> > + *
> > + * Return: 0 if it successfully received a message acknowledgment,
> > + * else negative errno
> > + **/
> > +static int mucse_poll_for_ack(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int val;
> > +
> > +	return read_poll_timeout(mucse_check_for_ack_pf,
> > +				 val, !val, mbx->delay_us,
> > +				 mbx->timeout_us,
> > +				 false, hw);
> > +}
> > +
> > +/**
> > + * mucse_write_and_wait_ack_mbx - Write a message to the mailbox, wait for ack
> > + * @hw: pointer to the HW structure
> > + * @msg: the message buffer
> > + * @size: length of buffer
> > + *
> > + * Return: 0 if it successfully copied message into the buffer and
> > + * received an ack to that message within delay * timeout_cnt period
> > + **/
> > +int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	int ret;
> > +
> > +	ret = mucse_write_mbx_pf(hw, msg, size);
> 
> If I see it right, this function is the only user of mucse_write_mbx_pf.
> 
> > +	if (ret)
> > +		return ret;
> > +	return mucse_poll_for_ack(hw);
> 
> The same here?
> 

Yes, it is. So how do I to improve?

> > +}
> > +
> > +/**
> > + * mucse_mbx_reset - Reset mbx info, sync info from regs
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_reset resets all mbx variables to default.
> > + **/
> > +static void mucse_mbx_reset(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u32 val;
> > +
> > +	val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
> 
> Because val is assigned only once, you could make it `const u32 val = ...`
> 
like this?
struct mucse_mbx_info *mbx = &hw->mbx;
const u32 val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);

But it is not reverse christmas tree

> > +	hw->mbx.fw_req = FIELD_GET(GENMASK_U32(15, 0), val);
> > +	hw->mbx.fw_ack = FIELD_GET(GENMASK_U32(31, 16), val);
> > +	mbx_ctrl_wr32(mbx, MUCSE_MBX_PF2FW_CTRL(mbx), 0);
> > +	mbx_ctrl_wr32(mbx, MUCSE_MBX_FWPF_MASK(mbx), GENMASK_U32(31, 16));
> > +}
> > +
> > +/**
> > + * mucse_init_mbx_params_pf - Set initial values for pf mailbox
> > + * @hw: pointer to the HW structure
> > + *
> > + * Initializes the hw->mbx struct to correct values for pf mailbox
> > + */
> > +void mucse_init_mbx_params_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	mbx->delay_us = 100;
> > +	mbx->timeout_us = 4 * USEC_PER_SEC;
> > +	mbx->stats.msgs_tx = 0;
> > +	mbx->stats.msgs_rx = 0;
> > +	mbx->stats.reqs = 0;
> > +	mbx->stats.acks = 0;
> > +	mucse_mbx_reset(hw);
> 
> Is mucse_init_mbx_params_pf the only user of mucse_mbx_reset? If so, the
> function should inlined.
> 
inline?
You mean make mucse_mbx_reset a inline function? Maybe it is too large
for inline?
or
Remove function mucse_mbx_reset, and copy all code in mucse_init_mbx_params_pf?
But mucse_mbx_reset reads value from reg, and other code in
mucse_init_mbx_params_pf is to init some variables in driver, I think it is not
good to combine all codes in one function?

> > +}
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > new file mode 100644
> > index 000000000000..eac99f13b6ff
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +
> > +#ifndef _RNPGBE_MBX_H
> > +#define _RNPGBE_MBX_H
> > +
> > +#include "rnpgbe.h"
> > +
> > +#define MUCSE_MBX_FW2PF_CNT 0
> > +#define MUCSE_MBX_PF2FW_CNT 4
> > +#define MUCSE_MBX_FWPF_SHM 8
> 
> Are these constants used by other c files or should they be private to
> rnpgbe_mbx.c?
> 

It is used only in rnpgbe_mbx.c.
But I check other drivers, it seems not common to make this condition
be private?

Just link
GMAC_EXT_CONFIG in dwmac4.h, only used in dwmac4_dma.c, 
or
IXGBE_PFMAILBOX_ACK in ixgbe_mbx.h, only used in ixgbe_mbx.c.

> > +#define MUCSE_MBX_PF2FW_CTRL(mbx) ((mbx)->pf2fw_mbx_ctrl)
> > +#define MUCSE_MBX_FWPF_MASK(mbx) ((mbx)->fwpf_mbx_mask)
> > +#define MUCSE_MBX_REQ BIT(0) /* Request a req to mailbox */
> > +#define MUCSE_MBX_PFU BIT(3) /* PF owns the mailbox buffer */
> > +
> > +int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
> > +void mucse_init_mbx_params_pf(struct mucse_hw *hw);
> > +int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
> > +#endif /* _RNPGBE_MBX_H */
> > -- 
> > 2.25.1
> > 
> > 
> 
> -- 
> “Perl—the only language that looks the same
>  before and after RSA encryption.”           (Keith Bostic)

Thanks for your feedback.


