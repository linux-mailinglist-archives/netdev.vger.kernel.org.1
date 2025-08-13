Return-Path: <netdev+bounces-213211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C37F9B2421E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA052A81A1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A92C158D;
	Wed, 13 Aug 2025 07:02:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6029DB68
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068540; cv=none; b=hXWOSDJSur7KY8CSg6qwDMcxb22m5KiXhFgRvIksmg4NhOY/khrUxIjKK5U8ylx+JpPGKeTWq9pnXWpzb3/uBbPkh8S0wlX6l8UpPQjO8U0gAI8+1YHykkbVYxue+O/br35GeuupB4tkyOo/CpzGwwMLXu9pubpLhjrM4Ur1tjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068540; c=relaxed/simple;
	bh=qT9o6CB73jvOc1dAh2L6tM+gnP44Xl7OmT/+Hnyb8RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD1wTg/uzZWwwiA7rd0OUoEIc1sR287S5YrJ+EUKt4dUhNsoiQ7fcACvwNPcpnhgnSmxRfnCPnsx6UjpM/rrqi6yzs/0tLCflNvp7l4XBZrT7+S8OUjVbycQBoyF+xcK01osjINS+kJTPR9HySYoVmq5T2pI3sGvEWH3j4RAMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz1t1755068517t476d51cb
X-QQ-Originating-IP: MG483g31/GJY9i/Jt+OtReD7Xnxy/u5hqXTI3V5X8b4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 15:01:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8711740590628175254
Date: Wed, 13 Aug 2025 15:01:55 +0800
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
Subject: Re: [PATCH v3 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <7AD2F2D5BC45498D+20250813070155.GC944516@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-3-dong100@mucse.com>
 <69d797eb-4a17-4d54-a7c0-8409fa8bc066@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d797eb-4a17-4d54-a7c0-8409fa8bc066@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mr5DWW/Ecu/iAVXCSu1bqX53FHtK4P2CvUHPWdLteufzdt7PU5E77dW4
	Gv0kbQQ0IcsO86/nusb9ZTHttV+zBz21ukLL4WSso2AvbIk9xXgZSNiOGP9mSYpMDPO+dSy
	3HLu7Qw/0SAdtZVE38MTUZGzVlqPFtQYVWwJEAtLi6GWmP5HvNVXsnsGch2BFU5d/bC5uLw
	OykOyPvldH3uNJYUsE7vDPnZNy+tGXfaPprd4usuNtPT81UWMI7mjR792VsD2oUqhDAJLwu
	V7u1C7oxgMO6Oj4lO8AreBXtmuUt+Q89jokH6Tv7DQsCyoBBZKIGJlxLnZD1soGcToUnSEn
	gRmL7kcKfzeaA4V4ioBXGt4n5K1NxLStJ9IyZbVDkj62jf0bHlT3LvvRzSnBvQS1J/VlNor
	i87on5B+bajftM4OybQghPjVM8uAXOV0fxcwc1jdTKP/oD3SLj8pSc4gFb/JbfPM0prRasQ
	Jd0+mxLWr/EFLsisNPr/hE0Ptq/ZJjgvdwOJ/xhgFI5NSn0nCQZBVsuaB2O0wwq4yV5pSXI
	Da9uiPkL1IuFGfNklezZi3v0G8qTbhpYWsyCZWOaxr/Z1vJvD9xMGkGkM8/TIoMZaS2R3V6
	9NxtGeltYgZZFOyyKGMP+0iZtaP5vXvFnz83iIE/m9J6dXROdbGFJxg1WOA95cp++kbvc2K
	hKKQm96A7j4Agnt+O6ia/sK8lOv0+BxSyRUT+dVIQIR4a7BZ0Dn2dKQj6tqARCROSM5C/jR
	473EH9Og7n5UI/bZXjHLe+ipN1hr7+S2+3u6InkDOEkCsSq0Bu18AHPk6Lyc9R1h5ePoFeX
	JOey+GNKWJv1xxG8Umd0DAEkksQEVK3bNYyvlHxJqYBKWo6JjvxIEB5DnIBVQmWVec0rcWN
	aYy1yvouTe0trQz5wJEqLNeKsGbNQ7wQv3V12LCLYOKGRLwDL7/uXQIEkBxVIgV1+zNZ+M9
	uGD+HfkQZhHkyIDBWSwhuQoNFXrWZZMaXe11kiWfnkBy4YwR3n5vJDLri0gNLao1WcROK0/
	C8bzqzhQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 04:49:33PM +0100, Vadim Fedorenko wrote:
> > +struct mucse_dma_info {
> > +	void __iomem *dma_base_addr;
> > +	void __iomem *dma_ring_addr;
> > +	void *back;
> 
> it might be better to keep the type of back pointer and give it
> a bit more meaningful name ...
> 
> > +	u32 dma_version;
> > +};
> > +
> > +struct mucse_eth_info {
> > +	void __iomem *eth_base_addr;
> > +	void *back;
> 
> .. here ...
> 
> > +};
> > +
> > +struct mucse_mac_info {
> > +	void __iomem *mac_addr;
> > +	void *back;
> 
> and here...
> 
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
> 
> you can also use container_of() as all these structures are embedded and
> simple pointer math can give you proper result.
> 

Got it, I will use container_of(), and remove the '*back' define.
Maybe eth to hw like this:
#define eth_to_hw(eth) container_of(eth, struct rnpgbe_hw, eth)
It is ok?

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
> >   struct mucse {
> >   	struct net_device *netdev;
> >   	struct pci_dev *pdev;
> > +	struct mucse_hw hw;
> >   	u16 bd_number;
> >   };
> 
> [...]
> 
> > +/**
> > + * rnpgbe_add_adapter - Add netdev for this pci_dev
> > + * @pdev: PCI device information structure
> > + * @info: chip info structure
> > + *
> > + * rnpgbe_add_adapter initializes a netdev for this pci_dev
> > + * structure. Initializes Bar map, private structure, and a
> > + * hardware reset occur.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int rnpgbe_add_adapter(struct pci_dev *pdev,
> > +			      const struct rnpgbe_info *info)
> > +{
> > +	struct net_device *netdev;
> > +	void __iomem *hw_addr;
> > +	static int bd_number;
> 
> it's not clear from the patchset why do you need this static variable...
> 

Ok, bd_number seems no usefull, I will remove it.

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
> > +	mucse->bd_number = bd_number++;
> 
> ... but this code is racy by design
> 
> > +	pci_set_drvdata(pdev, mucse);
> > +
> > +	hw = &mucse->hw;
> > +	hw->back = mucse;
> > +	hw->hw_type = info->hw_type;
> > +	hw->pdev = pdev;
> > +
> 

Thanks for your feedback.


