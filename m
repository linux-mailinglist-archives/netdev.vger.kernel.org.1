Return-Path: <netdev+bounces-214435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B07BB2960F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 03:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F6F7AAC79
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A71487E9;
	Mon, 18 Aug 2025 01:21:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76B1A26B
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480094; cv=none; b=MntsGUScl/Ecfn8fKo8q7vJpm2a/m2UPZdjj7OSZesOp/19S4QEvJekD7kLZEtxggCeHwd8ZoBDr3vX4/0ubtuPQ9FEB1hqXExM2GdivDTn2qm1ZqnAIWjJaHrnX3P2OL5A/Yl45VErVZpSZ/g+m5f83EhqhNXV1FJAt57c4W5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480094; c=relaxed/simple;
	bh=fOQpiaXSWhdRBx87IMV+h6Ad7W+80WZ4ofnOSc8GllQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSrmmEFmm32NKPCQMKTXKGtHTDnUcXYLb5hUBIhEREsENuCDUfGwZLxOTUPHHfXnT0OGjZoIBmtIjTfEDMnnhk7QEnUy8kSB6v0g+fLrIhMfDyXKqwL8hfQx3yYZJsSjdhVTLDq2jIWP95hhQe88TcRr9aNIsqcokf5wh0xNRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1755480073tfa152b0d
X-QQ-Originating-IP: J4zOZYfdEVPwo6f9K36pp7u0T/5DQRVYSlsV84VpeYA=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 09:21:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11348850142159916151
Date: Mon, 18 Aug 2025 09:21:11 +0800
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
Subject: Re: [PATCH v4 5/5] net: rnpgbe: Add register_netdev
Message-ID: <BE62E79A10943B82+20250818012111.GB1370135@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-6-dong100@mucse.com>
 <099a6006-02e4-44f0-ae47-7de14cc58a12@lunn.ch>
 <CFAA902406A8215F+20250815064441.GB1148411@nic-Precision-5820-Tower>
 <b669db06-83f8-447c-8081-7ef6ae9d2aba@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b669db06-83f8-447c-8081-7ef6ae9d2aba@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OXA0paR4HBoFIuQMgGFlBcC2H23vlDZf6JJoOQw43iR7ShpdppyY9EwJ
	4w/ZonPMEvwuePHqqteqDhKtPOE5jVCYCyTa+u0CQOLp6LPJi408GnNy5NG/kX3aC0Okodc
	910VOQyTizuUALONiiE2WHKmVdiX8qpLsaqk8r0jiDYQPV17LreTh2jutIBoq/AetUWJ7wD
	bbZR64V4m3b9l4OjeFRVDce6HUQBXbdZPo5u/deZE+lfFhE3Cwt5jyLAQM7pTogl4FhURb5
	sjn1We4Lu6q3DmvvxFB7+F6a6EpaWtdCg8A2ClbLzJFkN0K2lGa2WZ1q5kZ2qq0jMFy1kYy
	ZaLTnwMnTC/1bHyJBuV6Ba3ifIpGI33/G9E4Hw9qmjP5CO+jIHLssRBE1IhDKXcgTF2kQkV
	3GGFpziJjwMrRt7HxKWZo+Tvvve8gdPf9+pVCNg2gPVDmRrMjC42pmr8dkGMZFo+RYx8VGq
	IlyFTI5K5paIkdvOv0Buvd/yCqKjhv3Sdz7UtgMPTF7ftdZKEy0SDXXa+mmjbbDFjJ9oaia
	J7IyiAyiygT0sUqnn/kODzJiUJ1p8BHMbjPyTt4cjCmn+eyz+4LRfSbAhvABZe+tdCOCsP3
	TYJkF3zw8A9n2VyItDEJqQ1lvp4jmDEv2f7GiyVur4rqw/7D6R5lqcVo6mMsuYO347spwDF
	F3qnjwHfmRiyNoPvSWiZBVkwPPDKpcc0QlgfdyN/qgBdbI+VDaGUIhShiXZnb5O7jwH/Ral
	l5yowHuuE7YlPkVCLhSALekH4LT+ctfY31MaVL8H8VIZLMKye5xP8Kx+5/pGcpcQ3vnNFGh
	5UCEPJ1sz//U5br+XvIjLTBUxjXC7VBsQ9Nx9f3DoYEOGNKyDOjqfvmd7OR8dHVuIh6lmBY
	j0qKmiiTa+6AVs0AKJRbDqGfSosrq/SLcwnEBpLHvPvuj36sDfcGshFT5xs28PEqk+QBitr
	2Y94Pk22CbAjMld+E3R8RpP7E0qPx7lBr2EO2dkPDS1eyufbDSg7fOL89FjNydsXlKnAY2O
	CwPpGq/g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 08:06:35PM +0200, Andrew Lunn wrote:
> > > > +static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
> > > > +{
> > > > +	struct mucse_dma_info *dma = &hw->dma;
> > > > +	int err;
> > > > +
> > > > +	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
> > > > +	err = mucse_mbx_fw_reset_phy(hw);
> > > > +	if (err)
> > > > +		return err;
> > > > +	/* Store the permanent mac address */
> > > > +	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS))
> > > 
> > > What do this hw->flags add to the driver? Why is it here?
> > > 
> > 
> > It is used to init 'permanent addr' only once.
> > rnpgbe_reset_hw_ops maybe called when netdev down or hw hang, no need
> > try to get 'permanent addr' more times.
> 
> It normally costs ~0 to ask the firmware something. So it is generally
> simpler to just ask it. If the firmware is dead, you should not really
> care, the RPC should timeout, ETIMEDOUT will get returned to user
> space, and likely everything else will fail anyway.
>  

Ok, I will remove 'M_FLAGS_INIT_MAC_ADDRESS', and ask the firmware when
the function is called.

> > > >  static void rnpgbe_rm_adapter(struct pci_dev *pdev)
> > > >  {
> > > >  	struct mucse *mucse = pci_get_drvdata(pdev);
> > > > +	struct mucse_hw *hw = &mucse->hw;
> > > >  	struct net_device *netdev;
> > > >  
> > > >  	if (!mucse)
> > > >  		return;
> > > >  	netdev = mucse->netdev;
> > > > +	if (netdev->reg_state == NETREG_REGISTERED)
> > > > +		unregister_netdev(netdev);
> > > 
> > > Is that possible?
> > > 
> > 
> > Maybe probe failed before register_netdev? Then rmmod the driver.
> 
> Functions like this come in pairs. There is some sort of setup
> function, and a corresponding teardown function. probe/remove,
> open/close. In Linux, if the first fails, the second is never called.
> 
> 	Andrew
> 

Got it, 'if (netdev->reg_state == NETREG_REGISTERED)' will be removed.

Thansk for you feedback.


