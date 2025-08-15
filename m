Return-Path: <netdev+bounces-213989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6DBB27958
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106725A510F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 06:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3971299AB5;
	Fri, 15 Aug 2025 06:45:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880E1A8412
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240300; cv=none; b=NBnA0WgEimfOC5iwsBpNlC4XSuEcdaqumoMuBPAyY9vQU+3lac4peiQD8yJHwtiPJsiuA/xRGehAq9HCIB5/88VZ336p10Iu9sBO2ySFxNKbIsi6SFNzNfZbNADLjbhJv2r/xznBoc5gWOlykNIkry3IsCojMAy1CFtij/cTABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240300; c=relaxed/simple;
	bh=tEYwNdWsfaPWhqRUsz8dOddZWJIw9qXs0jEIMUzQHJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA22/s9H06kbMq3s9qRctRID8hAMmmWQdn6n1boK8mNFBsPiPXCrGVdHa8vCSZBDsrmvdEi/SQqZ7ZTJJz6jsaAnBwLhg+vnG+kv9JBAFjCe9K+B2+Dqi5uY48adkg9xLZIO39ATM0OdgA0SWOye5BqkxJ39Df230EhRUZ3zQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1755240284t3a0337c4
X-QQ-Originating-IP: 4PXFKC6B5UuvqH9rvC/iz4N+iXgh6lVYJYQxy9vEjCc=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 14:44:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8016404537619868178
Date: Fri, 15 Aug 2025 14:44:41 +0800
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
Message-ID: <CFAA902406A8215F+20250815064441.GB1148411@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-6-dong100@mucse.com>
 <099a6006-02e4-44f0-ae47-7de14cc58a12@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <099a6006-02e4-44f0-ae47-7de14cc58a12@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MqjGdKQeE31XJseuFJLcOQSC+06IZxIzYwMFA7WXtuUY5jLNjf1pWUmS
	nexqWbHdb2j0i7Hufk6U1z1wTLJKm8YUpiDP60uJE++dKiFvIyXQt1lTZyT9KpTs+ND1Eez
	z1/YH9k1O4m9iHYI3MOzikew8XUThMJhdK8QvGIok3WOFcMjHyeWnFo3sX7Mvg1SAXdcKcQ
	R+J9jOb6HojSe1O9eboxEFVQA0TNrl/iuwxDrgigqaa2OFd/7sfyJk0fnWrghqjGdpgqdXT
	mJT+z8ASyKfULM9N7GAQmaczmOynu5B33bvww+MCy4xzhc6WvIUTjzQ/Nt8DpDDuco/hn8/
	SWh41qCTxQ1NK5Ilm+CeA72J4Aqmgj5ot3m3nFYCkQeJS85P3jHI+WEK9itjHMRWeWWoGkj
	JeJrRdjILMQw1Tp0kNWASb2mG1ckHFC6f0ENY0MyII2fuQQh7gruh9rrZfUNgs14BPK85qr
	YexdITdo57+goMBJ7AkLquoTSWSVoOfs0a7b0egL4izADvh4xkpLn/Mh28FWyqzpJZh+y9K
	6VEX6vh3i9Rh7GMNk6CEGeYJzH2JXsJMSMnH3+jYkZ8lFRw9+Z3kwLHOF2qixb+25DtN3ie
	5nSMqT1KIcMijZNcB1qSaPbd1AkorGonoAcY3jlw6SC60AMNAQW1kGvVUE44gk08DzyLO2d
	KUkYXRkclNmvbvGDbZ2CjDkZwdwuBrKo4gcI91j2JgDVFbLh7e3CDUYL0YHNIDvF6oXOaes
	xG+UBx6NW4tZUatFTwpcV3lUfEHgCwalP7XqIx8O1TNYPcICgPVpTB79uwtJdYuFRMD2WgC
	JAmELfqLqeR+6nD1ZdDwL3B7nVBu0I27ml4bZrgXoW7SgyLKz2Xuv7TWPGdOK0RBLYlyF5M
	Id50Tuye9vBJDdJvWdcjKDSXNPaofapkvd+QwZA9eOx3+hEj+sgwjLFuFOiRsLl/vO98W3m
	Rw8Y/KCifsDV83L0hXBL2Ot1UrHJD5WB2EJ6cwAN2Q4+JjwgxY5C46ZVhEvrcDFh2ErrZOu
	9yiEvVTNTb/OED5LrLPDtjjfQ9bpC5UFvAKaRLdXGHbDuPt9DJV/tZGAuhkUA=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 05:42:05AM +0200, Andrew Lunn wrote:
> > +struct mucse_hw_operations {
> > +	int (*reset_hw)(struct mucse_hw *hw);
> > +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> > +};
> 
> Again, there is only one instance of this. Will there be more?
> 

It is one instance now, but maybe more hw in the furture.
I want to keep this...

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
> > +	struct device *dev = &hw->pdev->dev;
> > +
> > +	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->lane) ||
> > +	    !is_valid_ether_addr(mac_addr)) {
> > +		dev_warn(dev, "Failed to get valid MAC from FW, using random\n");
> > +		eth_random_addr(mac_addr);
> > +	}
> 
> With a function named rnpgbe_get_permanent_mac(), i would not expect
> it to return a random MAC address. If there is no permanent MAC
> address, return -EINVAL, and let the caller does with the error.
> 

Ok, I will update this.

> > +static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
> > +{
> > +	struct mucse_dma_info *dma = &hw->dma;
> > +	int err;
> > +
> > +	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
> > +	err = mucse_mbx_fw_reset_phy(hw);
> > +	if (err)
> > +		return err;
> > +	/* Store the permanent mac address */
> > +	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS))
> 
> What do this hw->flags add to the driver? Why is it here?
> 

It is used to init 'permanent addr' only once.
rnpgbe_reset_hw_ops maybe called when netdev down or hw hang, no need
try to get 'permanent addr' more times.

> >  static void rnpgbe_rm_adapter(struct pci_dev *pdev)
> >  {
> >  	struct mucse *mucse = pci_get_drvdata(pdev);
> > +	struct mucse_hw *hw = &mucse->hw;
> >  	struct net_device *netdev;
> >  
> >  	if (!mucse)
> >  		return;
> >  	netdev = mucse->netdev;
> > +	if (netdev->reg_state == NETREG_REGISTERED)
> > +		unregister_netdev(netdev);
> 
> Is that possible?
> 

Maybe probe failed before register_netdev? Then rmmod the driver.

> >  	mucse->netdev = NULL;
> > +	hw->ops->driver_status(hw, false, mucse_driver_insmod);
> >  	free_netdev(netdev);
> >  }
> >  
> > -- 
> > 2.25.1
> > 
> 

