Return-Path: <netdev+bounces-213191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C62B2414C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38DD17A39DA
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3B52BEC39;
	Wed, 13 Aug 2025 06:19:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CC42BD5BC
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065941; cv=none; b=nGVJctoddo4sgPB7mVM86h7GKZZUtd3zeH3CbIgNzPOjInDp1b4tbe7wJAFF4PbwuwHRi7hVhR4sRnfE5jOaG4+CT2QpJeMsivloZiAxtNEZiddqiO4TUCnvke3kMmNjQDXB49AGkD8tn6CeHvz8m/uFeLDeiTlop2vlCPfwA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065941; c=relaxed/simple;
	bh=3ZJkq7la5lVnwtTK2Th9D7Fhureaazu4IPy8mN/iHxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZWU+EpGTurgT0VWWS+o6vDRgdNG3Afd4ZthW43kkH66ARmPqSIn2CmygJpoyz3PKHH+4yKfhvoZCMAgMpijWeNnaryESwC6pxDLeCdVsgO/8HIUYWdGhjyoIWbi1HJ61MSQC3NR4hWvZBBZrnjqp4P3jL695XjUNy5mPXG+DEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1755065920t41ae54d8
X-QQ-Originating-IP: AdfvCmkw1jzKNuoTwujDV1j2Kvo/2VMby9S87bMpcEk=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 14:18:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3343729203366408891
Date: Wed, 13 Aug 2025 14:18:38 +0800
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
Subject: Re: [PATCH v3 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <2D407F75EE3286AE+20250813061838.GA944516@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-2-dong100@mucse.com>
 <590a44a2-20a2-4a3f-b57f-5bf194712bf2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590a44a2-20a2-4a3f-b57f-5bf194712bf2@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NiFdmnmiW14n+R0cPSofvRV8yu6lc28hML/N2PeedY0qLjjwc1RK/vTt
	8P9lkky8n7Rc3j6+hLXWuMpXl196PcvV5ENZcC8oevpLeP+xynv1ltAwpxYwCbnwGKx4LhD
	63WpBsiN3IhfCly1vo8Aoy74144xMGnb/2dWjUlUBFyrLAjUHjqMcELjmO8AoDfKsh4uv5p
	F8EJ6axx9tNSy4dq2ME0lKzl/ydJuvL1RyN0SfvdXVEE1DzLc4RsjOia4nTFtclpgFXqJZO
	j1ogNlZauf2n6YJwPuNPlg89NmilpFJwYdnLMW9UoQeuEI9FYACgzVZRWigvYcZreOse6gM
	L4vcnfW3tI18FBi079sq8mpzAEeLcrfazMIoeGxLBQBljKfEyTpXVMi1ZGFxk46QG6ktOXk
	rzva7pym+SLl5VZN/XBQ9+C8sCFRL7zE+TkYGDD6xAj0XP3ysL47HBg+b1epfLxzyqlg3Nx
	3REjMpdp93VG9eSmIdNSyfQFA4aWhVgbJuiowZKsQdi1x5qG2r391Hex3Qapx/gPLGg3Id0
	bonpReJnnU8tAYzD6BWkH4psWqntZll6qXuDOewdzwwWqyeEM/qH3eln7e7gTKrMSOJwrKj
	1RzS5SRdySPzHSPlvl3yGKJGz6t6dQg6ykLuOvTeDNiHbowW/BGP84eVc3Sx3o4+HVBVo/R
	3GQCQKh/c/D+6HUhgA46PFSPSu7xhT0milm7yayCRp46VGGACa5nmc5fAXSjCVpMKiQPnQy
	lO7ODrf1a//cR7yd4YPUxP3W2Oa0kWLNEbjhLh/n2jXhqDP0sgX9Qg3KtgkTAC3H7ECJOKR
	WRXxZ336zROiumMX6U1mW0RMKqsiawRfuyCOLGOP/pJ+3Ulbe4prutjPPHtEgZgZsqKvGTM
	IeDcnY6Q//Xk5FmwLBxst4s2JKQL+3o+M2fvE3wiwwbg4C+ZHYidaoDgWEKOaV9mqyg2Par
	SS0l+6vZ32o/hexMcRlaVrAfSS2y0ylwTjqkOwxDIK7Pw8ZOEZal0m/ykJWTUsW5QWWM=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 04:37:52PM +0100, Vadim Fedorenko wrote:
> On 12/08/2025 10:39, Dong Yibo wrote:
> > Add build options and doc for mucse.
> > Initialize pci device access for MUCSE devices.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> 
> [...]
> 
> > +/**
> > + * rnpgbe_probe - Device initialization routine
> > + * @pdev: PCI device information struct
> > + * @id: entry in rnpgbe_pci_tbl
> > + *
> > + * rnpgbe_probe initializes a PF adapter identified by a pci_dev
> > + * structure.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +	int err;
> > +
> > +	err = pci_enable_device_mem(pdev);
> > +	if (err)
> > +		return err;
> > +
> > +	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> > +	if (err) {
> > +		dev_err(&pdev->dev,
> > +			"No usable DMA configuration, aborting %d\n", err);
> > +		goto err_dma;
> > +	}
> > +
> > +	err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
> > +	if (err) {
> > +		dev_err(&pdev->dev,
> > +			"pci_request_selected_regions failed 0x%x\n", err);
> > +		goto err_pci_req;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +	pci_save_state(pdev);
> > +
> > +	return 0;
> > +err_dma:
> > +err_pci_req:
> > +	pci_disable_device(pdev);
> > +	return err;
> > +}
> 
> Why do you need 2 different labels pointing to the very same line? The
> code is not changed through patchset, I see no reasons to have it like
> this
> 
> 
> 
You are right, I should only 1 label here.

Thanks for your feedback.

