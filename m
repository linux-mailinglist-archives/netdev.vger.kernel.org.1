Return-Path: <netdev+bounces-208781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7071B0D1C1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528AD1AA3F5C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3722CBE6;
	Tue, 22 Jul 2025 06:21:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2C30100
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165298; cv=none; b=Z7qpsnpGywHGS/3hm5TxHw9bHX66YhaCLjLeBBcx9kjepIrRwx39kzykGBu53Hv49kFCjkldOCQ4JbyJ6wV1DJYWK2YCyM04vAtzODKGeu0x4TSw7jncyLmeYmheKfxP6ncoZyeZ1rGR7V843LOs1zH+bHn8fhR7Kw3MmxGCbvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165298; c=relaxed/simple;
	bh=bm/0DewNWhRUjoUqr0+r7OAExtR9mkSYTE/5p7SKNtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAGYQYqx+QQxx40j9gUU8IQte0iRt4WGP8hId4WY0pcKNiHsmRqxzosZW7wXXB2am3nHC7WcwGPzXtcEQ8+qAOQaa0ISYSITwkCS3/wRW3TfQsqfWqIKvwsZhvXpgdQ6xbVE/L7VaSxVON0tt5rZ7/EYjBTzbPGISZLWSqaVHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1753165282t2f934e90
X-QQ-Originating-IP: Srug0ruEEZGlFgQJ0LPW05zAj9t45SjKes719PTSLlM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 14:21:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10154226307366438883
Date: Tue, 22 Jul 2025 14:21:20 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] net: rnpgbe: Add n500/n210 chip support
Message-ID: <8E12C5B26514F60A+20250722062120.GB99399@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-3-dong100@mucse.com>
 <4dea5acc-dd7d-463c-b099-53713dd3d7ee@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dea5acc-dd7d-463c-b099-53713dd3d7ee@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MJWNsjxQgzaELW7hOUWpY6f+iEYFAa0mb0lZxsAIuQHkkaLVJAp9xtlE
	XSzlGS8dZPhQqe7RASNvm+tjwcCteS7htNHekVSL7CGrNE2e0CapRqBQXCTjBJLiLI8toZH
	e4pYLYjU9sSOqhfP+oBKZDLH2S0+QF8SY2mEl85K7vhLVTlNkyrAFM6+nsWcJlowbj0Pu/I
	tYN9WYjk0nLSqDppnSZAB2a4ZWjcBZNAkYMpSiIpcshMr72ITHr2dLp+Pa/JpYHlSS4YTgt
	uuC8TqDAvUFc4oES7mlMyd5DvX493j2xpSyiM2az6pALOS87b4cKrWmWUFZ4nlG5pSX/nmR
	d1axxBETs44h0Lz6zQuj+APE343RURQ/9y5HJxIoJd4ynW0qVe2peLQtUegzRXAvXTb1z0+
	VirFpgKpmiAYBPCPfQvZZ4uwN5OKT0YS3vJPFooaNLm00zfxBGRHD0P0XfKBqPaxKJN3Y40
	yDPISUfXzG8OhgpNiH74lIInOzjNkx+40ab59EruzdqiaVlNo1J198OTxKiCNQbGDHzfru7
	+VVNlYAiWQavbrJb2akk1bOK5DEjQHag+yacykjlf1mH5jmSn4eD3h0WlMPJANwasHlpntn
	CcNqOyHipoPeApKFoA8Ezrr7FO4vkdu+35xdBAFHXtGecJ+fkesARYJERHQw/sU2P8yBM4o
	MirA2yaLS8xs9n3RxIqB3aK8htkZ4gLwibRaOTWRHludswqvf8qeXi9mmJTZxRh0pWvCKOc
	jF5nnTj3ZXE8Skn/5a0tAbN/g9Bog6Am1WX89oPm0oMW3vbCo2cSNmq1gd8GibEGfA07WBi
	ksc97APznOJQMMVuNTIth8d4FBFd5Xye/NXyLaB6/8nYllRTIBOUgm5C0dHxh4oonfgPafB
	0+oQfPc52vdRsjoiMPqRU4geIC76e+d0FE8jEw2j62rfLoczI9/OK0TPJH4tENtxoH6+Paq
	FBSw1kssy/ti4mD6PJH6hy6HX8EEq2cvuoQrc1w9mZiMecuq5v1QuJkhFQLV4WKJLYqbRVO
	NHvY8DWA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 05:25:12PM +0200, Andrew Lunn wrote:
> > +struct mii_regs {
> > +	unsigned int addr; /* MII Address */
> > +	unsigned int data; /* MII Data */
> > +	unsigned int addr_shift; /* MII address shift */
> > +	unsigned int reg_shift; /* MII reg shift */
> > +	unsigned int addr_mask; /* MII address mask */
> > +	unsigned int reg_mask; /* MII reg mask */
> > +	unsigned int clk_csr_shift;
> > +	unsigned int clk_csr_mask;
> > +};
> 
> So MII interests me, being the MDIO/PHY maintainer....
> 
> You have introduced this without any user, which is not good, so i
> cannot see how it is actually used. It is better to introduce
> structures in the patch which makes use of them.
> 
> Please add this only when you add the mdiobus driver, so i can see how
> it is used. Please look at the other structures you have here. Please
> add them as they are actually used.
> 

Yes, you are right, I should add the structures when they are actually
used. I will improve it.

> > +struct mucse_hw {
> > +	void *back;
> > +	u8 pfvfnum;
> > +	u8 pfvfnum_system;
> > +	u8 __iomem *hw_addr;
> > +	u8 __iomem *ring_msix_base;
> 
> I spotted this somewhere else. A u8 __iomem * is odd. Why is this not
> a void *? ioremap() returns a void __iomem *, and all the readb(),
> readw(), readX() functions expect a void * __iomem. So this looks odd.
> 

Got it, I will change it. I just consider the wrong cast before. Sorry
for not check this define error.

> > +#define m_rd_reg(reg) readl(reg)
> > +#define m_wr_reg(reg, val) writel((val), reg)
> 
> Please don't wrap standard functions like this. Everybody knows what
> readl() does. Nobody has any idea what m_rd_reg() does! You are just
> making your driver harder to understand and maintain.
> 

Got it.

> > +	mac->mii.addr = RNPGBE_MII_ADDR;
> > +	mac->mii.data = RNPGBE_MII_DATA;
> > +	mac->mii.addr_shift = 11;
> > +	mac->mii.addr_mask = 0x0000F800;
> 
> GENMASK()? If you are using these helpers correctly, you probably
> don't need the _shift members.
> 
> > +	mac->mii.reg_shift = 6;
> > +	mac->mii.reg_mask = 0x000007C0;
> > +	mac->mii.clk_csr_shift = 2;
> > +	mac->mii.clk_csr_mask = GENMASK(5, 2);
> > +	mac->clk_csr = 0x02; /* csr 25M */
> > +	/* hw fixed phy_addr */
> > +	mac->phy_addr = 0x11;
> 
> That is suspicious. But until i see the PHY handling code, it is hard
> to say.
> 

Those code should move to the patch which really use it.

> > +static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	/* get invariants based from n500 */
> > +	rnpgbe_get_invariants_n500(hw);
> > +
> > +	/* update msix base */
> > +	hw->ring_msix_base = hw->hw_addr + 0x29000;
> > +	/* update mbx offset */
> > +	mbx->vf2pf_mbox_vec_base = 0x29200;
> > +	mbx->fw2pf_mbox_vec = 0x29400;
> > +	mbx->pf_vf_shm_base = 0x29900;
> > +	mbx->mbx_mem_size = 64;
> > +	mbx->pf2vf_mbox_ctrl_base = 0x2aa00;
> > +	mbx->pf_vf_mbox_mask_lo = 0x2ab00;
> > +	mbx->pf_vf_mbox_mask_hi = 0;
> > +	mbx->fw_pf_shm_base = 0x2d900;
> > +	mbx->pf2fw_mbox_ctrl = 0x2e900;
> > +	mbx->fw_pf_mbox_mask = 0x2eb00;
> > +	mbx->fw_vf_share_ram = 0x2b900;
> > +	mbx->share_size = 512;
> > +	/* update hw feature */
> > +	hw->feature_flags |= M_HW_FEATURE_EEE;
> > +	hw->usecstocount = 62;
> 
> This variant does not have an MDIO bus?
> 

Some hw capabilies, such as queue numbers and hardware module 
reg-offset(dma_base_addr, eth_base_addr ..) in this function. Don't
have an MDIO bus now.

> > +#define RNPGBE_RING_BASE (0x1000)
> > +#define RNPGBE_MAC_BASE (0x20000)
> > +#define RNPGBE_ETH_BASE (0x10000)
> 
> Please drop all the () on plain constants. You only need () when it is
> an expression.
> 

Got it, I will fix this.

> > +			      const struct rnpgbe_info *ii)
> 
> I don't really see how the variable name ii has anything to do with
> rnpgbe_info. I know naming is hard, but why not call it info?
> 
> 

Got it, ii is unclear, I will use info instead.

> >  {
> >  	struct mucse *mucse = NULL;
> > +	struct mucse_hw *hw = NULL;
> > +	u8 __iomem *hw_addr = NULL;
> >  	struct net_device *netdev;
> >  	static int bd_number;
> > +	u32 dma_version = 0;
> > +	int err = 0;
> > +	u32 queues;
> >  
> > -	netdev = alloc_etherdev_mq(sizeof(struct mucse), 1);
> > +	queues = ii->total_queue_pair_cnts;
> > +	netdev = alloc_etherdev_mq(sizeof(struct mucse), queues);
> 
> I pointed out this before. Try to avoid changing code added in
> previous patches. I just wasted time looking up what the function is
> called which allocates a single queue, and writing a review comment.
> 
> Waiting reviewers time is a good way to get less/slower reviews.
> 
> 	Andrew
> 

Yes, I got it before, and I really tried to improve my code.
But this is really hard to avoid here. 'queues' is from ii->total_queue_pair_cnts
which is added in patch2. Maybe I should move the alloc_etherdev_mq to
patch2, never use it in patch1? And this conditon can improve.

thanks for your feedback.


