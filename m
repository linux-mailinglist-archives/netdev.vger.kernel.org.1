Return-Path: <netdev+bounces-223906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E70CB805F2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F57A2CB0
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F13828751B;
	Wed, 17 Sep 2025 08:33:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B2627935F;
	Wed, 17 Sep 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098024; cv=none; b=j6BBQqaDX7voE9rv4iaE46zHcM91BcCT3iBEXVkYUr4RNSwKSP4a6W3x/77RV5qWbsxu9PM9Bb9ToL1Cjb8siQotPswAHZ8ZfVJncqpATflPIK/Jths+R8vCxHmDQa34Bdg2O9m5F5JpxkZPXABXNnqT8iV7QnNt3tSDqUXD3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098024; c=relaxed/simple;
	bh=ytCZP5Yar4/l+GMVyn3Wm0FCCeTtCPRlc0LrgNBzMmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGYCooK/tf9L8kf2AspIxjIh7Zl/+aBGttVYnVqH7fkQnMT0zn/dopsSnD+uiVUKREKkSMPqlVxTdB/iJmdWTeGQ4VL6cTz0KTnz9EyFMyJa1RXSqlLV2yWbaSf5cccSIbI/yUdlsSP21iIkH1M4GaWbz9cSdf5VIpCoKpI8abs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz19t1758097989t378d3e97
X-QQ-Originating-IP: nb0lliC7CGn1VoQ20o+EYjKtzODXCXagx4Ag1+9lwsc=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Sep 2025 16:33:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5419755831941980133
Date: Wed, 17 Sep 2025 16:33:07 +0800
From: Yibo Dong <dong100@mucse.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, joerg@jo-so.de, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v12 5/5] net: rnpgbe: Add register_netdev
Message-ID: <7ABD3AEE5360FED8+20250917083307.GA55664@nic-Precision-5820-Tower>
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-6-dong100@mucse.com>
 <f095f31c-b725-4a3f-bc73-7cc57428e5f2@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f095f31c-b725-4a3f-bc73-7cc57428e5f2@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NOIkHYnr7VzdiiVdQ6aDdxidLAW21uYeAUpXUQOc0FUaJT9YgHe5cv8B
	U+GFaWhCrcT4YkYhD3DKtIlqb0lcBPVZSWjOTv+X3KbqDKfUiXg8h2NaMnop8zdV8QEbuKX
	njIMViJNjR37GraR8C+pjEfmZs90hrJlJdXkNvMQ+Y2s+iQbwavgZLUDTmZzMtNxMPDPRxv
	AH8zZT3nmYmBD/b6DjNgU7kiGsfvYwLqUNqefpa0UMwO0hw56pDekdN+S+PMC7+6FQ0pCGr
	IkvMFTmei09CioafNMc3gmjsiO1zUoq9E1ORYsyyZVwESC7qcdUKVBzEeAVvEo/zsxKYjq7
	XmuD+vKYT2gMf14hASYdjDuLcP5h7bRH0BeRuIpIJrVIble2caJo7nbvJ/1Is5am18DrUJb
	OtJZsm2N2jowkeXbF60zcQaHjLo0AGjCOjihkAeshOkp5kVqpnVTfe3g2hXMhJot2qXGANJ
	YQt5ybDeG66e5r4cncccnJmJASFmydxITOi0joiaQoPRA8mv6hv522MC3PrhO7XdSSZae4r
	jAOEqSRJM1PITFr0bAaPugFIB9IVsSVyc0ajXDGP+ofqm1IyNPVO+KqiggyBtD8bZpny7Iq
	z6GrpbVz3Nu69VippvG1U1mZwv4J7n94zjRBDipAlnYBnGWY45D4GZ8Kxx9U5+E9Vw4tQGo
	kxf86G2pcPmZ2WxFi7LR3gB4scuDpCTi1CfgApSxa1acyU0O6gvHMCWv/qOVtKHxK8+hpMH
	gVjkBS2JnIUK0cYEOVkwkr/P30KOZsRPY5B2wcj0+JrpKw0EAHZlbkh27RDoCENn4606/mU
	lEAcEn2db/6KWV9quZXib7oa6u6fwxdSTsmAnd8P9CKjU0AXGu32BR8+VZcqHJW2pbT+T19
	GZe18x7AubPT4TN4/LX9qBN3C9wLPRlbpY6V5wausxhd6FpMTrMhzE3eBJVnegDUVR5edtB
	b7gCDw2buhH/t4FU8Bq0E9TJsDdNAtXE8SaWFoyL2lj3qqVXB8Z+znKB9GoYr5aw5eYnvMl
	urFrqBCQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Wed, Sep 17, 2025 at 12:39:59PM +0530, MD Danish Anwar wrote:
> On 16/09/25 4:59 pm, Dong Yibo wrote:
> > Complete the network device (netdev) registration flow for Mucse Gbe
> > Ethernet chips, including:
> > 1. Hardware state initialization:
> >    - Send powerup notification to firmware (via echo_fw_status)
> >    - Sync with firmware
> >    - Reset hardware
> > 2. MAC address handling:
> >    - Retrieve permanent MAC from firmware (via mucse_mbx_get_macaddr)
> >    - Fallback to random valid MAC (eth_random_addr) if not valid mac
> >      from Fw
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  18 +++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  80 ++++++++++++++
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 103 ++++++++++++++++++
> >  4 files changed, 203 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 41b580f2168f..4c4b2f13cb4a 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -6,6 +6,7 @@
> >  
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > +#include <linux/netdevice.h>
> >  
> >  enum rnpgbe_boards {
> >  	board_n500,
> > @@ -34,12 +35,26 @@ struct mucse_mbx_info {
> >  	u32 fwpf_ctrl_base;
> >  };
> >  
> > +enum {
> > +	mucse_fw_powerup,
> > +};
> > +
> 
> This enum has only one value. You should either use a #define or add
> more values to justify having an enum.
> 

Yes, it has only one value now, but more values will be added in the
future.
If I add new value here, but this patch not use it, it is
confict with 'add define along with truely use'.
If I use a #define here, when I add new values in the future, I should
redefine it as enum.

So can I keep enum here with a commit like this ?
/* Enum for firmware notification modes,
   more modes (e.g., portup, link_report) will be added in future */
+enum {
+	mucse_fw_powerup,
+};
+

> >  struct mucse_hw {
> >  	void __iomem *hw_addr;
> > +	struct pci_dev *pdev;
> > +	const struct mucse_hw_operations *ops;
> >  	struct mucse_mbx_info mbx;
> > +	int port;
> > +	u8 perm_addr[ETH_ALEN];
> >  	u8 pfvfnum;
> >  };
> >  
> > +struct mucse_hw_operations {
> > +	int (*reset_hw)(struct mucse_hw *hw);
> > +	int (*get_perm_mac)(struct mucse_hw *hw);
> > +	int (*mbx_send_notify)(struct mucse_hw *hw, bool enable, int mode);
> > +};
> > +
> >  struct mucse {
> >  	struct net_device *netdev;
> >  	struct pci_dev *pdev;
> > @@ -54,4 +69,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
> >  #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
> >  #define PCI_DEVICE_ID_N210 0x8208
> >  #define PCI_DEVICE_ID_N210L 0x820a
> > +
> > +#define mucse_hw_wr32(hw, reg, val) \
> > +	writel((val), (hw)->hw_addr + (reg))
> >  #endif /* _RNPGBE_H */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index 86f1c75796b0..667e372387a2 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -1,11 +1,88 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright(c) 2020 - 2025 Mucse Corporation. */
> >  
> > +#include <linux/pci.h>
> >  #include <linux/errno.h>
> > +#include <linux/etherdevice.h>
> >  
> >  #include "rnpgbe.h"
> >  #include "rnpgbe_hw.h"
> >  #include "rnpgbe_mbx.h"
> > +#include "rnpgbe_mbx_fw.h"
> > +
> > +/**
> > + * rnpgbe_get_permanent_mac - Get permanent mac
> > + * @hw: hw information structure
> > + *
> > + * rnpgbe_get_permanent_mac tries to get mac from hw
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +static int rnpgbe_get_permanent_mac(struct mucse_hw *hw)
> > +{
> > +	struct device *dev = &hw->pdev->dev;
> > +	u8 *mac_addr = hw->perm_addr;
> > +	int err;
> > +
> > +	err = mucse_mbx_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port);
> > +	if (err) {
> > +		dev_err(dev, "Failed to get MAC from FW %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	if (!is_valid_ether_addr(mac_addr)) {
> > +		dev_err(dev, "Failed to get valid MAC from FW\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * rnpgbe_reset - Do a hardware reset
> > + * @hw: hw information structure
> > + *
> > + * rnpgbe_reset calls fw to do a hardware
> > + * reset, and cleans some regs to default.
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +static int rnpgbe_reset(struct mucse_hw *hw)
> > +{
> > +	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, 0);
> > +	return mucse_mbx_reset_hw(hw);
> > +}
> > +
> > +/**
> > + * rnpgbe_mbx_send_notify - Echo fw status
> > + * @hw: hw information structure
> > + * @enable: true or false status
> > + * @mode: status mode
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +static int rnpgbe_mbx_send_notify(struct mucse_hw *hw,
> > +				  bool enable,
> > +				  int mode)
> > +{
> > +	int err;
> > +
> > +	switch (mode) {
> > +	case mucse_fw_powerup:
> > +		err = mucse_mbx_powerup(hw, enable);
> > +		break;
> > +	default:
> > +		err = -EINVAL;
> > +	}
> > +
> 
> Since you only have one mode currently, this switch statement seems
> unnecessary.
> 

The same reason with enum....

Can I keep switch here with a commit?

/* Keep switch structure to support more modes in the future */
switch (mode) {
case mucse_fw_powerup:
	err = mucse_mbx_powerup(hw, enable);
	break;
default:
	err = -EINVAL;
}

> > +	return err;
> > +}
> 
> 
> -- 
> Thanks and Regards,
> Danish
> 
> 

Thanks for feedback.


