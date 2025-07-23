Return-Path: <netdev+bounces-209188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDA2B0E903
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 05:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB794E3EF6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A00C23815B;
	Wed, 23 Jul 2025 03:22:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8E237707;
	Wed, 23 Jul 2025 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753240969; cv=none; b=o6hXrp0LzDGbAyikhdX9YyrSMpA4B6GaygGIlM5O/vi4b6T6FzBB49GqtvIFxyu3KaLvP6erfzG9hwNAtOkurMFPqO5VQ5OPjlot7BXS2DFl9YwI6Do1Ez7yAjNX7mma2BfqKw6lAR7TxG5Q7gFkL0V6Yhqz4cuAoPhQ4t1YpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753240969; c=relaxed/simple;
	bh=wBLfKnptCIzz6fwAEUY+F/zYvyBszk8hRXb2twlCJVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrOSvSHKAU83KxxdHPZgBgc68xAEhgxHuHAISOeY9Nv5hoSkAGzpl1fRLB+VTdN6cWBJU2R4uZMc+NiZOrLLuLc4NMVWdqlH1pVCUKfOBTp/svzmI0r5B/IuRQ3Ir7AWvi/qo5cPfGLhBjKj9860pNzcmNeo1w7zSagvHMqKon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz1t1753240902t74ac2590
X-QQ-Originating-IP: 0WyzUicdjTovc4r0xuxleDj003Py6V/V5Dhgxplj4wc=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 11:21:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1131523505386046130
Date: Wed, 23 Jul 2025 11:21:40 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] net: rnpgbe: Add irq support
Message-ID: <877641DC760A0FDE+20250723032140.GD169181@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-9-dong100@mucse.com>
 <20250722132557.GI2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722132557.GI2459@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Oar1+YVNquOnqrSJLkA808nWWwgRKVsXB33TT8xxBmjWKPRtbceUSH88
	Md3EaBXt5UlEnZxElO76riQadHyXX/x5sAgwLdk10PDq1ur8re5Mgyi8wglt+cTEqmWyGye
	MzDnsQyyOk+6hzl5xQxJg7nQ5LDE8kHcuRcAufcwu5UqPyd85IcXdbf/FZeGkcJfcbDynUq
	4QBwBEeFmb+faMKBEAkRDNOhN4q8snaAM5348oBZIGD1SBy+bPu+0Do8tGsg7UbDpGub1W6
	7vlSM6lTOaqKH57BL8khKXGhHl3cQJv+7WDjpilxWjHPkZArZP4rkLoNFEcbnjwpC21JKM1
	l9NZagzaHM07q/Xib01DoEru3nP6xAO7uO1kcETAznsRWY7YB7D1rTexePLMrav9eQLUYgY
	7KEWqRaT53zD2lTb84H1orQ6vOUaFA6FFNj/esMsiuSps+wPz8uJi+ZSzwQkmAkP/aFmRhb
	0W48Vn8bVh0oqk2zmM7z2DNb6jzf3JP03pjKtmEId+6EQNa+WtzEfasyNa6rhWDyXf91Lw+
	6Tkz51HI0DpK3pkXANGFG+RpvpaKbfn0N1x1gFEj723lMDBydYlGGayjmNNkaXskUCzl18Z
	laHSzwyBHESmTb4mDFZyUE3RH2eweFe1nHuHlMaWxCaxcJGAUNO39bslhCdph+gUGYlGslQ
	RHnfHm7Mb/xvgRxAqD72S8CKnC2LUy0vBYTJZjiDZXAN/Uo5/VyZa161DGdjXoOAkETP/oY
	vszHYHVOOE11v3ZXlsFaSCJQGvOHlN3AxaT8GvHBhnyg12xxr81e8o2HAKYde6+Q/5xg8T0
	50z3xfRiuGoBPk3HZwDH1ao+g2PC4B4dT54eYuSsgN25+WsHXv2MAMPn5F6zNuDrdjZIaY3
	40cxMFyUX9uxRFe2XXi8BtcKDJzPxWLckyAHrh6x3KA7xFs7AyJ3r6XgHjctPuKb3eoDpl4
	YvKcJZbEBEaeOCBKifR1PD0CLjSBZAln6pP+LXavtBEQgErAlcdlSt0az0A+qNPFRNSyDR+
	KKePREsBzFj1wJ929HCtZndMWxYTcdJpnL4YIU+xsDWruwvUhfFbITY2I4BbAL63L5XIF0v
	rDCLh4wDDgm0TJwz2muA6ujh5PWecERZg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 02:25:57PM +0100, Simon Horman wrote:
> On Mon, Jul 21, 2025 at 07:32:31PM +0800, Dong Yibo wrote:
> > Initialize irq functions for driver use.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> 
> ...
> 
> > +/**
> > + * rnpgbe_acquire_msix_vectors - Allocate msix vectors
> > + * @mucse: pointer to private structure
> > + * @vectors: number of msix vectors
> 
> Please also document the return value for functions
> that have one and a kernel doc.
> 
> Flagged by ./scripts/kernel-doc --none -Wall
> 

Got it, I will fix it.

> > + **/
> > +static int rnpgbe_acquire_msix_vectors(struct mucse *mucse,
> > +				       int vectors)
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> 
> ...
> 
> > +/**
> > + * rnpgbe_msix_other - Other irq handler
> > + * @irq: irq num
> > + * @data: private data
> > + *
> > + * @return: IRQ_HANDLED
> > + **/
> > +static irqreturn_t rnpgbe_msix_other(int irq, void *data)
> > +{
> > +	struct mucse *mucse = (struct mucse *)data;
> > +
> > +	set_bit(__MUCSE_IN_IRQ, &mucse->state);
> > +	clear_bit(__MUCSE_IN_IRQ, &mucse->state);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/**
> > + * register_mbx_irq - Regist mbx Routine
> 
> Register
> 

Got it, I will fix it.

> > + * @mucse: pointer to private structure
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int register_mbx_irq(struct mucse *mucse)
> > +{
> > +	struct mucse_hw *hw = &mucse->hw;
> > +	struct net_device *netdev = mucse->netdev;
> > +	int err = 0;
> 
> Nit, unlike most of this patch(set) the above doesn't follow
> reverse xmas tree order - longest line to shortest - for variable
> declarations.
> 
> Edward Cree's tool can be useful here.
> https://github.com/ecree-solarflare/xmastree/
> 
> 

Got it, I will fix it.
Great tool! Thanks.

> > +
> > +	/* for mbx:vector0 */
> > +	if (mucse->num_other_vectors == 0)
> > +		return err;
> > +	/* only do this in msix mode */
> > +	if (mucse->flags & M_FLAG_MSIX_ENABLED) {
> > +		err = request_irq(mucse->msix_entries[0].vector,
> > +				  rnpgbe_msix_other, 0, netdev->name,
> > +				  mucse);
> > +		if (err)
> > +			goto err_mbx;
> > +		hw->mbx.ops.configure(hw,
> > +				      mucse->msix_entries[0].entry,
> > +				      true);
> > +		hw->mbx.irq_enabled = true;
> > +	}
> > +err_mbx:
> > +	return err;
> > +}
> 
> ...
> 

Thanks for your feedback.


