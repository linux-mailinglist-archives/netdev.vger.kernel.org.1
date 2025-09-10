Return-Path: <netdev+bounces-221561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95787B50DFF
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E791C2656F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 06:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD23305970;
	Wed, 10 Sep 2025 06:22:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B41124C676;
	Wed, 10 Sep 2025 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485378; cv=none; b=IRzkWN7JP0/jJWLkyEpt7Ol7A8vtZ6eQv1YG+N7Cuk3VIxcGPjsKhI29zBod8S1bx0FYjR7huhe4b596TxT/3rGuAak4IC+43qskTAIM6Sh2VOh08wRLkO9oBQRnVsBPUu4+hUg3l87ceAuvkMqM5cP7V8YpMFl960FheRE5XPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485378; c=relaxed/simple;
	bh=m+R1W/M3puWz7LopfUDBFdfky5zc/hL0+mmbhkVpLXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDvy2m+9SNNaeitWL4BYnjHetiSkJQhDRch+G6G9MxasKwRlo06QgaaFqMpsC+DLQSsOmwPu7XRGVHp0SG7njpHGfN+u2/6985yb4FkwmaQz4DhUrQOm4CMq7ZqrwGFxWVMqXNoU4s8flYIOqvOfVj4X5Md4AyVgef7yJ06W6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz3t1757485358tf0f8328e
X-QQ-Originating-IP: GvKLTUOR+tQwCuIW6pSEJKaDGjCgZmDZVsz6vR3QrKU=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Sep 2025 14:22:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2655984975433566693
Date: Wed, 10 Sep 2025 14:22:36 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v11 5/5] net: rnpgbe: Add register_netdev
Message-ID: <6C0625E60A7E1E95+20250910062236.GA1832954@nic-Precision-5820-Tower>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-6-dong100@mucse.com>
 <2ec8c7f8-cf79-4701-97dc-2d0a687f0f3b@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec8c7f8-cf79-4701-97dc-2d0a687f0f3b@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M5znx2hx04lbdDzfTtmcjIwM9Boq5F55QxCvGVEo0+o5yuc2tvIZs1RU
	kUid4L2U97xdLoiiIGD7Ej/jeP8Ae9VV4FRM78hipxy4J8Mm6qgRbUSJSeD7sANH1uEUJQI
	IfnmjJrfWzDflcPXsStS0QPWEWou2EX687kkALDnwQEadh/3kUgRl5xchQ1vP0OFKtz8egD
	NMXJSBSvfWLnZi3l5CTrJYRsFgPhNqUx53nwvj6427aBMl+laRiL0g3N/KIQ3mc9Ywz/CBb
	R8xUlFLTk2ZheUxkQZrUgTrVMlfAiwPeQwOlctiflctIDarVi4w9tg2v7W4Da3mFkVN8B8O
	/JLSu/ow7OWHHVbHmXVk/pGBmDzkoRJd5mn5nxL29Sc6O2po92n3npkU5YDwbmjeC6XaCEz
	rhUZ7TuE7sDDlagCybHQJVkzMKxhWB8/nk7yuhXdgPgM5JJXqTriAomt1uatLG1X8OwjbHE
	pzigD08j4fHvdGgAq2DFZdYaBWUuzpQjHP2w/G95otOEBwRmolQVdhuH0fQntHSc6uaIEc2
	Ra1iDo4jH40wRNRA7ZCAAlWSv5JrXkDrjF9OHiJqJTI8VQgLPbTqVzTgFXM1u3NTutMzEPq
	GPemi9hIpDx1r86rktjczJqSGReHjgftTJxVe/yecVX7oNN+8z9pjQTD9EVFOgYyKIZ4ZVG
	D0utzyXLf9tFR9L8XAjxIcXmlkbaBLZNHwuHe7MME7r/8YgKflCcu/8tA4cbnh+NXkDWv0J
	6bgc/xPZyK/2r3lzyomMoGsG3tvFLYeOFuVn/apn2ltaV72F9iPvrinfrkdZqqublEk9nPe
	BZn/pRW8NowmW7IIRtPde5rRRWuSGw4qSNNBh1VOSft+TQcEofWzpcYB/n54uy1pDoROpzy
	EKGZu28Q1z4/m4VZ6g0OAfH5nYOQP7YJ9p1XXr9MBk/4MwCTo1Ur6NlHT3o03sJRBjjNXGt
	3l/U/7EonRtwRYBOLSl8ndljY2fQFE15vfVs5DgF/zYfXc+AnRu2BOtyMvvuhgkYoGxojY2
	7r6Z+7M+ir4Af+wUCf6E/mJhtpNLM=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Tue, Sep 09, 2025 at 03:37:19PM +0100, Vadim Fedorenko wrote:
> On 09/09/2025 13:09, Dong Yibo wrote:
> > Complete the network device (netdev) registration flow for Mucse Gbe
> > Ethernet chips, including:
> > 1. Hardware state initialization:
> >     - Send powerup notification to firmware (via echo_fw_status)
> >     - Sync with firmware
> >     - Reset hardware
> > 2. MAC address handling:
> >     - Retrieve permanent MAC from firmware (via mucse_mbx_get_macaddr)
> >     - Fallback to random valid MAC (eth_random_addr) if not valid mac
> >       from Fw
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> [...]
> 
> > +struct mucse_hw;
> 
> why do you need this forward declaration ...> +
> > +struct mucse_hw_operations {
> > +	int (*reset_hw)(struct mucse_hw *hw);
> > +	int (*get_perm_mac)(struct mucse_hw *hw);
> > +	int (*mbx_send_notify)(struct mucse_hw *hw, bool enable, int mode);
> > +};
> > +
> > +enum {
> > +	mucse_fw_powerup,
> > +};
> > +
> >   struct mucse_hw {
> >   	void __iomem *hw_addr;
> > +	struct pci_dev *pdev;
> > +	const struct mucse_hw_operations *ops;
> > +	struct mucse_dma_info dma;
> >   	struct mucse_mbx_info mbx;
> > +	int port;
> > +	u8 perm_addr[ETH_ALEN];
> >   	u8 pfvfnum;
> >   };
> 
> ... if you can simply move mucse_hw_operations down here?
> 

Got it, I will update it. At the beginning I defined 
'struct mucse_hw_operations ops' in 'struct mucse_hw'. I missed to
consider this when it is changed to 'struct mucse_hw_operations *ops'.

> > @@ -54,4 +76,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
> >   #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
> >   #define PCI_DEVICE_ID_N210 0x8208
> >   #define PCI_DEVICE_ID_N210L 0x820a
> > +
> > +#define rnpgbe_dma_wr32(dma, reg, val) \
> > +	writel((val), (dma)->dma_base_addr + (reg))
> 
> [...]
> 
> > @@ -48,8 +127,14 @@ static void rnpgbe_init_n210(struct mucse_hw *hw)
> >    **/
> >   int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
> >   {
> > +	struct mucse_dma_info *dma = &hw->dma;
> >   	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	hw->ops = &rnpgbe_hw_ops;
> > +	hw->port = 0;
> > +
> > +	dma->dma_base_addr = hw->hw_addr;
> 
> not quite sure why do you need additional structure just to store the
> value that already exists in mucse_hw?
> 

The original meaning was that all submodules have their own base, such
as dma, mbx... Just that 'dma_base_addr' is 'offset 0 from hw_addr'.
And maybe it is not good to do it like this?
...
#define MUCSE_GBE_DMA_BASE 0
dma->dma_base_addr = hw->hw_addr + MUCSE_GBE_DMA_BASE;
...
If so, I will remove dma_base_addr, and use hw_addr instead.

> > +
> >   	mbx->pf2fw_mbx_ctrl = MUCSE_GBE_PFFW_MBX_CTRL_OFFSET;
> >   	mbx->fwpf_mbx_mask = MUCSE_GBE_FWPF_MBX_MASK_OFFSET;
> 

Thanks for your feedback.


