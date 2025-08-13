Return-Path: <netdev+bounces-213287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6AEB24641
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F6B3A9533
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46975212562;
	Wed, 13 Aug 2025 09:50:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9121257C;
	Wed, 13 Aug 2025 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078648; cv=none; b=jFJIzntItt/tAjclsCgy60fOhDUTvgkrZzaq01HoD4D8OQ8WCeMG2xwmD/bG2RpNJgODioSMiqIif4K+WmvAump99Ufbf/9jJGYLnMF5IwSR2Lcd2sbla02ABpcu1h0DhgTfRBnta6Rvewp8hfficg9vfCrXb2FLVs+hpAzeNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078648; c=relaxed/simple;
	bh=5NjWnfB3j0SmFDYMTbW6G/aUvyqoKnQU7ro3SxcuX84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ108eZUsn/IKQDc3DjHabZD2ExRLjKve2cq4Q80h8QvR2mEds54tE2hryQ0j2y7vdFE0bKt4xKxcIoauO1SHplbf59dT2V5/9fKKxJy3FJFtxCcaIdtQMZyZoR8TxyBJRK0Aa8AVGLTwFW/KYN73eklzKex0OTHypGIoSUT7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz16t1755078556t50122486
X-QQ-Originating-IP: jHUKPmaXLURVrfNnE3/1JIusEU5dtzB9sfHBB4pZc1s=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 17:49:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3286716278462949229
Date: Wed, 13 Aug 2025 17:49:14 +0800
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
Subject: Re: [PATCH v3 5/5] net: rnpgbe: Add register_netdev
Message-ID: <B301753EBB777DDB+20250813094914.GB972027@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-6-dong100@mucse.com>
 <94eeae65-0e4b-45ef-a9c0-6bc8d37ae789@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eeae65-0e4b-45ef-a9c0-6bc8d37ae789@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQNQM5UP8StMDdmKQ4cRpMKOIhXI86KRyY6GW62byRr3PlxyTbNjhc5l
	l/XiOGF3/9rMVo4hpO8kmd8ZY7d9/f50dVidSvlceUIheO8KHGzajutyGSAmUSIapnrsHBK
	g8vxds4EhAqaDK6qpnEuleRGxBtelCu13dZ+ovGe4Mokq5GoZ/bbn2T966KrokwufIUudjb
	2jbWje0DA7wMih7K6rWX3rD7sEgpaquhXbuELbX33CTxR1uW6aARNhI/q9DWrGElH+/9YWa
	B+MO0JmbjvJbmsJBB3Cu9bKrdh+gA8cor4C1PZmqxknJ1ju0BO35cA/m3BOSttgqk9sDrYA
	zkzcPgly7Sk37W+GNQ7ii2EGHvuVTVp+FqdNsqSIvs30spsIlOJCF66DuOQcWby7eJoJq1g
	uJ37h39XAa1o6dKQCM1uRIn+ZwUYXo87Qqo+nEMMc4QrW3umlBWBkXO+p/4dedRUhUmpZaD
	18l59jNFRKo8L2KgoI4PPHJKRWJ5No3ojnoJ6EvZJMa6IpPcQwmhLMxHOVDEua8keMJbzSU
	n0YqjI4c9eFlm10Q+TuRCEx6TRCec5GF1mSHgTAXaVAdUMWAELEbg9Idbe3Z6+OVGoE7m5x
	G5E8YBEFYcZSLxNzdMNOFv0xPKz7HvUUnUv/kxkwvFXS143D6FcgflNSexknfQ8dds/Xffu
	4KIk1qHHoMgY4Pt8ISdMjbN7GsH9hMcMHyexeEv6xBcBCzLbOheydjSLslyaj2h2XEzPwvw
	qCYcaWV6jXjuH26apLphuwVAAi1a9Oho1QLHsQbWCxmoxJotINUHhR9+1cdUzZx99F9kEZC
	Pp3ZD0fHPB5LqCI/O82meRaMU8d08bnLhN0cI3dXLAXan+htKtsKIMyOeGCm6OON/NfrSXL
	d7SoOocGZhdLvWcxQH7793GxN+K9y3ed1unjIcfL3gKcJs0AsJycItqz9CTtFycTAUFNwhH
	I1scdWZxGQrqOZuN/uSifPwnJBx6BTXZ3ykLD9dZZLBOyBfpNotFyQSLgX64NN5d/jmUbKX
	tUYxtS2w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Wed, Aug 13, 2025 at 01:56:07PM +0530, MD Danish Anwar wrote:
> On 12/08/25 3:09 pm, Dong Yibo wrote:
> > Initialize get mac from hw, register the netdev.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 22 ++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 76 +++++++++++++++++++
> >  4 files changed, 172 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 6cb14b79cbfe..644b8c85c29d 100644
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
> > @@ -86,6 +87,18 @@ struct mucse_mbx_info {
> >  	u32 fw2pf_mbox_vec;
> >  };
> >  
> > +struct mucse_hw_operations {
> > +	int (*init_hw)(struct mucse_hw *hw);
> > +	int (*reset_hw)(struct mucse_hw *hw);
> > +	void (*start_hw)(struct mucse_hw *hw);
> > +	void (*init_rx_addrs)(struct mucse_hw *hw);
> > +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> > +};
> 
> You define functions init_hw, start_hw, and init_rx_addrs in this
> structure but they aren't implemented in this patch. Either implement
> them or remove them if not needed yet.
> 
> 

Got it, I will remove not implemented define.

> > +
> > +enum {
> > +	mucse_driver_insmod,
> > +};
> > +
> >  struct mucse_hw {
> >  	void *back;
> >  	u8 pfvfnum;
> > @@ -96,12 +109,18 @@ struct mucse_hw {
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
> > +	u8 addr[ETH_ALEN];
> > +	u8 perm_addr[ETH_ALEN];
> >  };
> >  
> >  struct mucse {
> > @@ -123,4 +142,7 @@ struct rnpgbe_info {
> >  #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
> >  #define PCI_DEVICE_ID_N210 0x8208
> >  #define PCI_DEVICE_ID_N210L 0x820a
> > +
> > +#define dma_wr32(dma, reg, val) writel((val), (dma)->dma_base_addr + (reg))
> > +#define dma_rd32(dma, reg) readl((dma)->dma_base_addr + (reg))
> >  #endif /* _RNPGBE_H */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index 16d0a76114b5..3eaa0257f3bb 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -2,10 +2,82 @@
> >  /* Copyright(c) 2020 - 2025 Mucse Corporation. */
> >  
> >  #include <linux/string.h>
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
> > +
> 
> The function should log a warning when falling back to a random MAC
> address, especially in the second case where the hardware returned an
> invalid MAC.
> 

Got it, I will fix it.

> > +	hw->flags |= M_FLAGS_INIT_MAC_ADDRESS;
> > +}
> > +
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
> > +		return NETDEV_TX_OK;
> > +}
> 
> Extra indentation on these two lines. Also, the function just drops all
> packets without any actual transmission. This should at least increment
> the drop counter statistics.
> 

Got it, I will add 'netdev->stats.tx_dropped++;' here.

> > +
> > +static const struct net_device_ops rnpgbe_netdev_ops = {
> > +	.ndo_open = rnpgbe_open,
> > +	.ndo_stop = rnpgbe_close,
> > +	.ndo_start_xmit = rnpgbe_xmit_frame,
> > +};
> 
> 
> -- 
> Thanks and Regards,
> Danish
> 
> 

Thanks for your feedback.


