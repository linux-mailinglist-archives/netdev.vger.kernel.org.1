Return-Path: <netdev+bounces-213774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60705B268EE
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2389A16CA54
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395015E5C2;
	Thu, 14 Aug 2025 14:00:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0666512FF69;
	Thu, 14 Aug 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180033; cv=none; b=fOcmOSYAn0yY1IOKnXxJnni5Tehd20PU14IbIn1yqWN8AhO0GhP2kPAxmabzWUb8SQrB0ismycXyx6VVckTAxoqCDNvKyTKnkjzKy3y6zlvByAhVfeV8peyQbwuKjXamvBrgBSF1i9UqYGsaQ+2FVdPIgga41beyULkjaALa3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180033; c=relaxed/simple;
	bh=KHG7xwAlZo5KtTQwWmzzzmt2xUyzEvURPn80RuE61H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyziuP3NGzwOlXlYpTgtPrmBmWfkuSEoJIbID22l0D4mzQ2E0qNnT88itKJv6diZ5XYHcVDlIRlZ+bGkqFTn6hWavKIV2kS2VVhV+QO5nC50+AxSkHR3iTkooIuY5JnU6Z1PlC9EEuFHgoQj3Dw6qEHKEF4ypAzTV0avkbzjGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz5t1755179969tcc391592
X-QQ-Originating-IP: oo50RviW9iR1o+OtONEechxBV1y/n/Sj+n0GrlQ3YP4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 21:59:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6429672801832651080
Date: Thu, 14 Aug 2025 21:59:26 +0800
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
Subject: Re: [PATCH v4 5/5] net: rnpgbe: Add register_netdev
Message-ID: <933ACEBDA5823549+20250814135926.GC1094497@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-6-dong100@mucse.com>
 <dd6ece66-ae4b-424a-aa09-872ac15e1549@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6ece66-ae4b-424a-aa09-872ac15e1549@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MgRO26CFjEybqIR83FmKs4gEh8++NeWfcuOdUd3x6X0XNdyiI8GBHAmJ
	LOD720A0RBmR3TuWFSylxdUo8RB7BuqEDa7oNNrHZyI2fDspsXiI9G6Dzq30sofb9EtgiWL
	bmCux0/vo7j/uV6SS181L/3WPgZITDjKc5Pmdru3AbWJvzjFbtx+d5LAAycAP/sP8nDdwH1
	PWdaC1WE3KS4w9MSwhVVSg3QQRN6oKdj02RcdjDYyuNEBJub+EDxKsSi2MrurYpSU1ZGNAp
	84qv9UVr/0WJPn/3+1YcC2qhwdMaIg7Cq+J4kn4OWpvKn+ZeAxIAnAbhuwxVdfjFhnEg9kQ
	ZLjLo1hOe03j5fEILCPqy0fAMY6Y2Rvk+kuAUFGv2rvC9To+7zOaowJRd+XGG6KQN8jOcoF
	lwkrrXTiDt0HjBmIZkNAID6LQNl62zCnqunNrSDVp9e2+XwIvxsw7DlvcC6hc+eGC/x+kCb
	RE3fIS3Z2eypkrUxXeFeDieIwzfAr233LWHqRRPevf4khqtiWRzeUWm5msIfOcSfM3NShAr
	u2yA6QIDkVNUU8uEYjvb3VfdN6ad/cmYURPv0gb7zZgNEonkOBqnlum2/81l5Ka+EQZrAJZ
	QgOjdPD2Lgk8CaxM7clTEI8+WWmAzWCTlSN/3Fp2OkoonCIUB4L2R20EQqKPaJEZ6Wq3SYK
	KEJNrSANxZjs0TC0kcnZO410iqZDLjHAKaIRRV9Gxe5eyPNdvFR0lZBzEyg/hp6J89qYKTq
	zbnKVimaTPTVEO5HUCsBLi1k1UePI0IWmJEYLVLC/4aewA5h0B4IG3LkY82TqR1YQ731Oq1
	OTwJbHGWHsWKBfS2WKi6AbAHcTdewtGx2nDiuJs4jgUl/EtsklxQ3XcjYU8IcmFL/W+D7iT
	4wrrbn+kvDqP9vHsDh4omLxdIfyORqUmd0WHosTTiI1W7s7ptsghhVrqhxGLWZOuswkmWRo
	ZsFtH+SJBgDeAW641jWcKRKPb691C/opGH6abo4h0qEuB3e/mSebRdZJZds2mKrZsXyaNJw
	fk6KMexlfcwADPUFo8EM2SmkiBmJCL6EAubCKDCQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Thu, Aug 14, 2025 at 05:44:51PM +0530, MD Danish Anwar wrote:
> On 14/08/25 1:08 pm, Dong Yibo wrote:
> > Initialize get mac from hw, register the netdev.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 18 +++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 75 +++++++++++++++++++
> >  4 files changed, 167 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 7ab1cbb432f6..7e51a8871b71 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -6,6 +6,7 @@
> >  
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > +#include <linux/netdevice.h>
> >  
> >  extern const struct rnpgbe_info rnpgbe_n500_info;
> >  extern const struct rnpgbe_info rnpgbe_n210_info;
> > @@ -82,6 +83,15 @@ struct mucse_mbx_info {
> >  	u32 fw2pf_mbox_vec;
> >  };
> >  
> > +struct mucse_hw_operations {
> > +	int (*reset_hw)(struct mucse_hw *hw);
> > +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> > +};
> > +
> > +enum {
> > +	mucse_driver_insmod,
> > +};
> > +
> >  struct mucse_hw {
> >  	u8 pfvfnum;
> >  	void __iomem *hw_addr;
> > @@ -91,12 +101,17 @@ struct mucse_hw {
> >  	u32 axi_mhz;
> >  	u32 bd_uid;
> >  	enum rnpgbe_hw_type hw_type;
> > +	const struct mucse_hw_operations *ops;
> >  	struct mucse_dma_info dma;
> >  	struct mucse_eth_info eth;
> >  	struct mucse_mac_info mac;
> >  	struct mucse_mbx_info mbx;
> > +	u32 flags;
> > +#define M_FLAGS_INIT_MAC_ADDRESS BIT(0)
> >  	u32 driver_version;
> >  	u16 usecstocount;
> > +	int lane;
> > +	u8 perm_addr[ETH_ALEN];
> >  };
> >  
> >  struct mucse {
> > @@ -117,4 +132,7 @@ struct rnpgbe_info {
> >  #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
> >  #define PCI_DEVICE_ID_N210 0x8208
> >  #define PCI_DEVICE_ID_N210L 0x820a
> > +
> > +#define dma_wr32(dma, reg, val) writel((val), (dma)->dma_base_addr + (reg))
> > +#define dma_rd32(dma, reg) readl((dma)->dma_base_addr + (reg))
> 
> These macros could collide with other definitions. Consider prefixing
> them with the driver name (rnpgbe_dma_wr32).
> 
> I don't see these macros getting used anywhere in this series. They
> should be introduced when they are used.
> 

Got it, I will introduce codes when they are used.

> >  #endif /* _RNPGBE_H */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index e0c6f47efd4c..aba44b31eae3 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -1,11 +1,83 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright(c) 2020 - 2025 Mucse Corporation. */
> >  
> > +#include <linux/pci.h>
> >  #include <linux/string.h>
> > +#include <linux/etherdevice.h>
> >  
> >  #include "rnpgbe.h"
> >  #include "rnpgbe_hw.h"
> >  #include "rnpgbe_mbx.h"
> > +#include "rnpgbe_mbx_fw.h"
> 
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
> > +		netdev->stats.tx_dropped++;
> > +		return NETDEV_TX_OK;
> > +}
> 
> You didn't fix this extra indentation. This was present in v3 as well
> 
> https://lore.kernel.org/all/94eeae65-0e4b-45ef-a9c0-6bc8d37ae789@ti.com/#:~:text=skb)%3B%0A%3E%20%2B%09%09return%20NETDEV_TX_OK%3B%0A%3E%20%2B-,%7D,-Extra%20indentation%20on
> 

Sorry, I missed fix this, I will fix it in the next version.

> > +
> > +static const struct net_device_ops rnpgbe_netdev_ops = {
> > +	.ndo_open = rnpgbe_open,
> > +	.ndo_stop = rnpgbe_close,
> 
> 
> -- 
> Thanks and Regards,
> Danish
> 
> 

Thanks for your feedback


