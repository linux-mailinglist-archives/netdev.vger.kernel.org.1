Return-Path: <netdev+bounces-208899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BBDB0D7E1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824831C23E31
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753BC22B5A5;
	Tue, 22 Jul 2025 11:09:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2A28B3FD
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182594; cv=none; b=anSjCkO4b5rdUEK0qL9MqplfUT4K0Fpx+PehKyg1I3pyVmN1ZUoPoKMvWY0Wqa5WunDV2I1YYSj94o5ZeEj6BlGnT4CTsu9/DAKet65q6Qzp9HNpEKDEq7LIFIMho+FlgoBSGJzGcWdcf59MG9GDbzc7MbNKt7isdGad/9IFiRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182594; c=relaxed/simple;
	bh=V01CpwPhoYRMkgTbnuw9OB2Maccg5FkbrxzKPuX1L7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKmiJJoUuZkjsO1T4mXzKDdqihzo27e6PDJ4wgeMBQN/44v09F+CxYuTCHto+4m1vWgTueQeIbQpX55HlUolrgjIVW+vzeH27DX+1wUVjx6YJKXYu7waZGrN0tJH5z0tpTsQil7fQz/Xd+a0d1oIUJoIGhed0ZdVQxdr1Btwjew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz3t1753182582t50d83c8d
X-QQ-Originating-IP: qS7gnAFAEUU6fV4kYj+XcTJ/fX7x++qnIxygmFN6+r4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 19:09:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10533247899007251616
Date: Tue, 22 Jul 2025 19:09:39 +0800
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
Subject: Re: [PATCH v2 02/15] net: rnpgbe: Add n500/n210 chip support
Message-ID: <CE56210DD2A0C069+20250722110939.GB125862@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-3-dong100@mucse.com>
 <b4233af1-7143-402b-a45c-379c39edf274@linux.dev>
 <911D202AA380FB7F+20250722095159.GA120552@nic-Precision-5820-Tower>
 <fc0d3fa9-67a8-4ac7-a213-283e2971227d@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0d3fa9-67a8-4ac7-a213-283e2971227d@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MheB71eWvOshw4BsUZ4Q1KbbCHXuGGgIFqdDktr09Ss1MqPo1SOuet7J
	o/coV+4ArHZ/QDBzaEIl5fSTi1lSBXTjW9bBjtRKmbyHIBXou3YCKnnLv6zrTlKym/+X0zl
	pMAC/79HVZWW1008QZazYbLCKTP7jgHp0syZSoijX8aGp5FmrAUx68tjOP35ujGc8yCbepb
	MxSMpYvn4JoxSWChRJMYCvWyJOyRbyeF+BQh3+5kHYiKLjnH3fpJkER6PMBL5Pkr31KDTKP
	0nxZ9wuWUO364icWamp0RPLSDBJT82jBtljNgdx9Up9zYsftTi0ZLZKkAEDohRy5N1/DsaM
	RU1rpj2qrWYVk29pxBYeN0im6UvxwFRdjQVRhnlpUDsY6i+dSFb04m1Br5MrfGBx5BJozua
	4Zq2AZInZ2oekt/Lv4NqB1FcVXt/+/dShZGTr+FoXogPU0mDu0V4xR8auVQW1FJbZnRdoIy
	09C6Ha4eKnw9IIz2i1G005Jz4zQRgiBcVgIwAuvsXbaV8Mv+6ZbITpnW/JuroWG3xiiBvgl
	8xLK6BfXMZmy4rDRye2nHLIbdzmIy/YHGjQ75siHD7pqncNm81l4YhMSsULAu75iCtMXwih
	4SXY7+wvjvQXPeTolJsF7El8wX4DEuVYcUkSOk/Ugwh+zGvDiPy7F/7v0LN67hc6Uw+6UYT
	yOeWW9sKj+fEZQdpFCwBsrLsBC60h9sjDd4t3uqQ+2/F1qn97qhQeOhSzexqMDaa5gQmDSO
	FpBiKzdRdlnBO7ziNKHm6FWFBLRpMbVBEvZafX5ecy3s4X4ksA3xso1pJ5KRG66weNs2GpP
	34/K2Or0uDYC6VwpA+xS3rBWi49mV/WaYy/VoW6+16s/af2oCjunZW2cxkLlahFw7f0y3RF
	fWy7+LQ7yIporP2tIUkTSSG/ccN72nt+2YXMLhXu+b6SNIpmT08iZO1QH8n22i7j700o0EB
	U9AMIOP4cH+PjCjKGIWHK11sH8K6ZU+ktcGQztJejEWqvHFk9oJW2oSHXzAYQAd2nZJ/djg
	6UDITdFJpQvi18SAL6dVz77zWHy7SYoqopY04kXwGcincrPbgNFcpBgXsQpoI=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 11:26:44AM +0100, Vadim Fedorenko wrote:
> On 22/07/2025 10:51, Yibo Dong wrote:
> > On Mon, Jul 21, 2025 at 03:21:23PM +0100, Vadim Fedorenko wrote:
> > > On 21/07/2025 12:32, Dong Yibo wrote:
> > > > Initialize n500/n210 chip bar resource map and
> > > > dma, eth, mbx ... info for future use.
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > > ---
> > > >    drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
> > > >    drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 138 ++++++++++++++++++
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 138 ++++++++++++++++++
> > > >    drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  27 ++++
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  68 ++++++++-
> > > >    5 files changed, 370 insertions(+), 5 deletions(-)
> > > >    create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > > >    create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > > > 
> 
> [...]
> 
> > > > +/**
> > > > + * rnpgbe_get_invariants_n500 - setup for hw info
> > > > + * @hw: hw information structure
> > > > + *
> > > > + * rnpgbe_get_invariants_n500 initializes all private
> > > > + * structure, such as dma, eth, mac and mbx base on
> > > > + * hw->addr for n500
> > > > + **/
> > > > +static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
> > > > +{
> > > > +	struct mucse_dma_info *dma = &hw->dma;
> > > > +	struct mucse_eth_info *eth = &hw->eth;
> > > > +	struct mucse_mac_info *mac = &hw->mac;
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +
> > > > +	/* setup msix base */
> > > > +	hw->ring_msix_base = hw->hw_addr + 0x28700;
> > > > +	/* setup dma info */
> > > > +	dma->dma_base_addr = hw->hw_addr;
> > > > +	dma->dma_ring_addr = hw->hw_addr + RNPGBE_RING_BASE;
> > > > +	dma->max_tx_queues = RNPGBE_MAX_QUEUES;
> > > > +	dma->max_rx_queues = RNPGBE_MAX_QUEUES;
> > > > +	dma->back = hw;
> > > > +	/* setup eth info */
> > > > +	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
> > > > +	eth->back = hw;
> > > > +	eth->mc_filter_type = 0;
> > > > +	eth->mcft_size = RNPGBE_MC_TBL_SIZE;
> > > > +	eth->vft_size = RNPGBE_VFT_TBL_SIZE;
> > > > +	eth->num_rar_entries = RNPGBE_RAR_ENTRIES;
> > > > +	/* setup mac info */
> > > > +	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
> > > > +	mac->back = hw;
> > > > +	/* set mac->mii */
> > > > +	mac->mii.addr = RNPGBE_MII_ADDR;
> > > > +	mac->mii.data = RNPGBE_MII_DATA;
> > > > +	mac->mii.addr_shift = 11;
> > > > +	mac->mii.addr_mask = 0x0000F800;
> > > > +	mac->mii.reg_shift = 6;
> > > > +	mac->mii.reg_mask = 0x000007C0;
> > > > +	mac->mii.clk_csr_shift = 2;
> > > > +	mac->mii.clk_csr_mask = GENMASK(5, 2);
> > > > +	mac->clk_csr = 0x02; /* csr 25M */
> > > > +	/* hw fixed phy_addr */
> > > > +	mac->phy_addr = 0x11;
> > > > +
> > > > +	mbx->mbx_feature |= MBX_FEATURE_NO_ZERO;
> > > > +	/* mbx offset */
> > > > +	mbx->vf2pf_mbox_vec_base = 0x28900;
> > > > +	mbx->fw2pf_mbox_vec = 0x28b00;
> > > > +	mbx->pf_vf_shm_base = 0x29000;
> > > > +	mbx->mbx_mem_size = 64;
> > > > +	mbx->pf2vf_mbox_ctrl_base = 0x2a100;
> > > > +	mbx->pf_vf_mbox_mask_lo = 0x2a200;
> > > > +	mbx->pf_vf_mbox_mask_hi = 0;
> > > > +	mbx->fw_pf_shm_base = 0x2d000;
> > > > +	mbx->pf2fw_mbox_ctrl = 0x2e000;
> > > > +	mbx->fw_pf_mbox_mask = 0x2e200;
> > > > +	mbx->fw_vf_share_ram = 0x2b000;
> > > > +	mbx->share_size = 512;
> > > > +
> > > > +	/* setup net feature here */
> > > > +	hw->feature_flags |= M_NET_FEATURE_SG |
> > > > +			     M_NET_FEATURE_TX_CHECKSUM |
> > > > +			     M_NET_FEATURE_RX_CHECKSUM |
> > > > +			     M_NET_FEATURE_TSO |
> > > > +			     M_NET_FEATURE_VLAN_FILTER |
> > > > +			     M_NET_FEATURE_VLAN_OFFLOAD |
> > > > +			     M_NET_FEATURE_RX_NTUPLE_FILTER |
> > > > +			     M_NET_FEATURE_RX_HASH |
> > > > +			     M_NET_FEATURE_USO |
> > > > +			     M_NET_FEATURE_RX_FCS |
> > > > +			     M_NET_FEATURE_STAG_FILTER |
> > > > +			     M_NET_FEATURE_STAG_OFFLOAD;
> > > > +	/* start the default ahz, update later */
> > > > +	hw->usecstocount = 125;
> > > > +}
> > > > +
> > > > +/**
> > > > + * rnpgbe_get_invariants_n210 - setup for hw info
> > > > + * @hw: hw information structure
> > > > + *
> > > > + * rnpgbe_get_invariants_n210 initializes all private
> > > > + * structure, such as dma, eth, mac and mbx base on
> > > > + * hw->addr for n210
> > > > + **/
> > > > +static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
> > > > +{
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +	/* get invariants based from n500 */
> > > > +	rnpgbe_get_invariants_n500(hw);
> > > 
> > > it's not a good pattern. if you have some configuration that is
> > > shared amoung devices, it's better to create *base() or *common()
> > > helper and call it from each specific initializer. BTW, why do you
> > > name these functions get_invariants*()? They don't get anything, but
> > > rather init/setup configuration values. It's better to rename it
> > > according to the function.
> > > 
> > 
> > I try to devide hardware to dma, eth, mac, mbx modules. Different
> > chips may use the same mbx module with different reg-offset in bar.
> > So I setup reg-offset in get_invariants for each chip. And common code,
> > such as mbx achieve functions with the reg-offset.
> > Ok, I will rename it.
> 
> I fully understand your intention. My point is that calling
> rnpgbe_get_invariants_n500(hw) in rnpgbe_get_invariants_n210() and
> then replace almost half of the values is not a good pattern.
> It's better to have another function to setup values that are the same
> across models, and keep only specifics in *n500() and *n210().
> 

Got your point, I will improve it.

> > 
> > > > +
> > > > +	/* update msix base */
> > > > +	hw->ring_msix_base = hw->hw_addr + 0x29000;
> > > > +	/* update mbx offset */
> > > > +	mbx->vf2pf_mbox_vec_base = 0x29200;
> > > > +	mbx->fw2pf_mbox_vec = 0x29400;
> > > > +	mbx->pf_vf_shm_base = 0x29900;
> > > > +	mbx->mbx_mem_size = 64;
> > > > +	mbx->pf2vf_mbox_ctrl_base = 0x2aa00;
> > > > +	mbx->pf_vf_mbox_mask_lo = 0x2ab00;
> > > > +	mbx->pf_vf_mbox_mask_hi = 0;
> > > > +	mbx->fw_pf_shm_base = 0x2d900;
> > > > +	mbx->pf2fw_mbox_ctrl = 0x2e900;
> > > > +	mbx->fw_pf_mbox_mask = 0x2eb00;
> > > > +	mbx->fw_vf_share_ram = 0x2b900;
> > > > +	mbx->share_size = 512;
> > > > +	/* update hw feature */
> > > > +	hw->feature_flags |= M_HW_FEATURE_EEE;
> > > > +	hw->usecstocount = 62;
> > > > +}
> 
> [...]
> 
> > > > @@ -58,7 +72,54 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev)
> > > >    		 rnpgbe_driver_name, mucse->bd_number);
> > > >    	pci_set_drvdata(pdev, mucse);
> > > > +	hw = &mucse->hw;
> > > > +	hw->back = mucse;
> > > > +	hw->hw_type = ii->hw_type;
> > > > +
> > > > +	switch (hw->hw_type) {
> > > > +	case rnpgbe_hw_n500:
> > > > +		/* n500 use bar2 */
> > > > +		hw_addr = devm_ioremap(&pdev->dev,
> > > > +				       pci_resource_start(pdev, 2),
> > > > +				       pci_resource_len(pdev, 2));
> > > > +		if (!hw_addr) {
> > > > +			dev_err(&pdev->dev, "map bar2 failed!\n");
> > > > +			return -EIO;
> > > > +		}
> > > > +
> > > > +		/* get dma version */
> > > > +		dma_version = m_rd_reg(hw_addr);
> > > > +		break;
> > > > +	case rnpgbe_hw_n210:
> > > > +	case rnpgbe_hw_n210L:
> > > > +		/* check bar0 to load firmware */
> > > > +		if (pci_resource_len(pdev, 0) == 0x100000)
> > > > +			return -EIO;
> > > > +		/* n210 use bar2 */
> > > > +		hw_addr = devm_ioremap(&pdev->dev,
> > > > +				       pci_resource_start(pdev, 2),
> > > > +				       pci_resource_len(pdev, 2));
> > > > +		if (!hw_addr) {
> > > > +			dev_err(&pdev->dev, "map bar2 failed!\n");
> > > > +			return -EIO;
> > > > +		}
> > > > +
> > > > +		/* get dma version */
> > > > +		dma_version = m_rd_reg(hw_addr);
> > > > +		break;
> > > > +	default:
> > > > +		err = -EIO;
> > > > +		goto err_free_net;
> > > > +	}
> > > > +	hw->hw_addr = hw_addr;
> > > > +	hw->dma.dma_version = dma_version;
> > > > +	ii->get_invariants(hw);
> > > > +
> > > >    	return 0;
> > > > +
> > > > +err_free_net:
> > > > +	free_netdev(netdev);
> > > > +	return err;
> > > >    }
> > > 
> > > You have err_free_net label, which is used only in really impossible
> > > case of unknown device, while other cases can return directly and
> > > memleak netdev...>>
> > 
> > Yes, It is really impossible case of unknown device. But maybe switch
> > should always has 'default case'? And if in 'default case', nothing To
> > do but free_netdev and return err.
> > Other cases return directly with return 0, and netdev will be freed in
> > rnpgbe_rm_adapter() when rmmod. Sorry, I may not have got the memleak
> > point?
> 
> Both rnpgbe_hw_n500 and rnpgbe_hw_n200 cases have error paths which
> directly return -EIO. In this case netdev is not freed and
> rnpgbe_rm_adapter() will not happen as rnpgbe_add_adapter() didn't
> succeed.
> 
> 

Yes, you are right, memleak may happen here, I will fix it.

Thanks for your feedback.
> > 
> > > >    /**
> > > > @@ -74,6 +135,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev)
> > > >     **/
> > > >    static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >    {
> > > > +	const struct rnpgbe_info *ii = rnpgbe_info_tbl[id->driver_data];
> > > >    	int err;
> > > >    	err = pci_enable_device_mem(pdev);
> > > > @@ -97,7 +159,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >    	pci_set_master(pdev);
> > > >    	pci_save_state(pdev);
> > > > -	err = rnpgbe_add_adapter(pdev);
> > > > +	err = rnpgbe_add_adapter(pdev, ii);
> > > >    	if (err)
> > > >    		goto err_regions;
> > > 
> > > 
> > 
> > Thanks for your feedback.
> > 
> 
> 

