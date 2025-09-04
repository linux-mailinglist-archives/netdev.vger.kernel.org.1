Return-Path: <netdev+bounces-219794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A025B43036
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 05:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66561BC7915
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 03:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E41FE45A;
	Thu,  4 Sep 2025 03:06:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90E1531C8;
	Thu,  4 Sep 2025 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955213; cv=none; b=nQ+eIvaNKkCdDGlSHkWxMbm6x+JhpxMsmbLXizSHdqLtBWLvCFNJiQNkQWrBzwu+S03ewvAtNVdhR2+U5eRBms5MXmG0fq8Tji0YqnlpfNKNLoUIKUc0Br4M5rKn5FlMJty6Wwgs0QdBcNuidsIh66Ymhr9yl9IG6M+Ek1fZcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955213; c=relaxed/simple;
	bh=SLdDmixQ5xqhW55ySdh8VN5DM9+F8oX01s2pKa/DH6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK68zuthdjj4EbXZf+dx+3cdc6/L1XGm84OlG14hgWiUXIzxN+/ZiLXglT9mQ+yf14VRhK/ivf6KL2qmxpd2Xk094wvcGUzrAnqaSm5z1XmcqWaq1eLHt+yI/HnZsh7YK8J4YwT6DMrzpQPfLWvGvtiItHDqT67yAV5Af369lik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz6t1756955183t967df603
X-QQ-Originating-IP: c48yHqB4UNo0OeuTt4cMtpB33728CbYBNdyGcXJY+C8=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Sep 2025 11:06:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11714803036421506829
Date: Thu, 4 Sep 2025 11:06:21 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Subject: Re: [PATCH net-next v10 5/5] net: rnpgbe: Add register_netdev
Message-ID: <6B193997D4E4412A+20250904030621.GD1015062@nic-Precision-5820-Tower>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-6-dong100@mucse.com>
 <b9a066d0-17b5-4da5-9c5d-8fe848e00896@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a066d0-17b5-4da5-9c5d-8fe848e00896@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OYLtW6Z/0FVZzqayUpquJdjajqK8Qyq9xjpcAcZpYYslO3rY5oCOhUs3
	uMgpxK1/NcUBnvdxLbjBZq0H0oITfHEaiAio3IaUkgApRgn824268M59/DtBbZTWbFyatGd
	cW1kfji1en54YAv9y7bmwNbx4wlU/eLWdw5TmOSapqOwl2lTYawqdy1RaUY2QK67dkH8zl4
	zssjBdX03pOaYamcAJI2CH8abwr5NcpDrbUmf70YvE6Nfgrz3K29Rvx+innKnLM5YzssQnJ
	K4iXAIzi6iLf7+iA3AlFLx64BDEEP7BbAOkPiWvkT4oyWvZnQ4mD/TqdFBSQ6X7uYHkCiCG
	F+tN3sPmGm5s05PcJ2e/kkaaJjtoKuuw3TBRi4Qiu+iPsdF0w9ATiYIz4CGDAfich93eXAI
	N8EFCtEP0Q56jet06kFZfrYMETpEMplFPbwgWOlyXbchLdWZs7fyV4DnWK7l29MjegKKXzg
	v26qZ7wXvqb1Z8HItIabwhRNH440sKPdaLxRFAfV+x/vWc+BDM1nNKoNFGZmXE9sBkO+wYD
	+AUqOd4WOgB+Rn4y1tVkXAfhcLbLgYTrka5lEZNCKZ2IgJBDpypLJ8C25UVTpjcCLFRqz3X
	9lAYE+Z3D0NML5tAU+YZ+JF4GgOGaas5BoK4vsAWFk+0X77n97jecg2o1W6NmrjnMexHZrI
	yyXb8NhH61cquf9N8G2dbO2Wwvrp9PseDpX9vvl9j7/a/8qrPjW2vW4hTJlBykfGZdsqMTl
	mYI8JRS+0GrSlcDA6SqvKR7J7K3vh4je03YZIl4+7YiUNSsEw3OLIYY9hcY9hwayFnBDMuA
	9zVO36tYGTLBT/kjhhABsocTBnj9ylU3Inenipax6rY3tOD38IXP8S8PUmcaoNvzAdpPTBT
	N/sNuSPEx7gJnaPEqRHvM2CvKWn8+04Ff+MZy31DkzZykR0nV0vaQzfgfk+/QIC/kdrxaRO
	KLx6WU02lfiM292NYNRdUstQL8Wu+l5ThAPuluIcxcj1ZR0g7pBwR6cagNV657JPwwuxqAS
	lQBvWt6tzci1ruxtXjFNBUPrwiIwtfKrkqZgtUo/EvIzUG5iEt
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Thu, Sep 04, 2025 at 12:53:27AM +0200, Andrew Lunn wrote:
> >   * rnpgbe_add_adapter - Add netdev for this pci_dev
> >   * @pdev: PCI device information structure
> > @@ -78,6 +129,38 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
> >  
> >  	hw->hw_addr = hw_addr;
> >  	info->init(hw);
> > +	mucse_init_mbx_params_pf(hw);
> > +	err = hw->ops->echo_fw_status(hw, true, mucse_fw_powerup);
> > +	if (err) {
> > +		dev_warn(&pdev->dev, "Send powerup to hw failed %d\n", err);
> > +		dev_warn(&pdev->dev, "Maybe low performance\n");
> > +	}
> > +
> > +	err = mucse_mbx_sync_fw(hw);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Sync fw failed! %d\n", err);
> > +		goto err_free_net;
> > +	}
> 
> The order here seems odd. Don't you want to synchronise the mbox
> before you power up? If your are out of sync, the power up could fail,
> and you keep in lower power mode? 
> 

As I explained before, powerup sends mbx and wait fw read out, but
without response data from fw. mucse_mbx_sync_fw sends mbx and wait for
the corect response from fw, after mucse_mbx_sync_fw, driver->fw
request and fw->driver response will be both ok.

> > +	netdev->netdev_ops = &rnpgbe_netdev_ops;
> > +	netdev->watchdog_timeo = 5 * HZ;
> > +	err = hw->ops->reset_hw(hw);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
> > +		goto err_free_net;
> > +	}
> > +	err = hw->ops->get_perm_mac(hw);
> > +	if (err == -EINVAL) {
> > +		dev_warn(&pdev->dev, "Try to use random MAC\n");
> > +		eth_random_addr(hw->perm_addr);
> 
> eth_random_addr() cannot fail. So you don't try to use a random MAC
> address, you are using a random MAC address/
> 
> 	Andrew
> 

Maybe update it like this?
if (err == -EINVAL) {
	dev_warn(&pdev->dev, "Using a random MAC\n");
....

Thanks for your feedback.


