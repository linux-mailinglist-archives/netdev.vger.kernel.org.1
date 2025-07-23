Return-Path: <netdev+bounces-209218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 183AEB0EAF7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022501AA4F7F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 06:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDAF26F463;
	Wed, 23 Jul 2025 06:50:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43226FA60;
	Wed, 23 Jul 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253459; cv=none; b=SJBbs/QJ+H9IKGwAUUnpiuxS16Rg5Dg0v4MDZsQnGDMuBpgGFipXnQ68u1yb15LZB0tZetDGGyo/F7W4OrZuHVOoXZcsrjEKzIDS0gyJgm7pzE9kjlwJCVSs0b7sysQvJbEFM3NXeK7eT5q46734WDub/iLCMgpPb0nqQbSgdcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253459; c=relaxed/simple;
	bh=G58YKvUujIBWrJkI0NYR1sVGNRm9J8ICp7P9MOotfgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhvVgPjs1Ln8bqP2JWHvyuWOum6p6iYEKCwgM2k3bNwZLRp4qQH6Sv3YghE5Kys4PgG4TExuliboOECJjwdO9dXBuwK1pn3SZ68iXwk++IVfJnceFsyyE7MyTpFmrZcrZF565VBbuuwVdLQbaTMrWFLCnmayeDpCaVfWUH2sZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz16t1753253380t0ab00ecb
X-QQ-Originating-IP: lRLKBcb1n0wzw/+enrJkpgcKfTXRxD93bs4sAWYliJs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 14:49:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11276420674999546687
Date: Wed, 23 Jul 2025 14:49:38 +0800
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
Subject: Re: [PATCH v2 14/15] net: rnpgbe: Add base rx function
Message-ID: <92D9F4A7FDB27183+20250723064938.GF169181@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-15-dong100@mucse.com>
 <20250722141426.GK2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722141426.GK2459@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MAN6sKHDZ5xSaGWXfe+7Bn96Kxr/zIytK58NzLYVZD5K0bPm9SWLPbmp
	ZgP5VO8dAJUVM+dyW4qci2FTMyNsyaDopEOFvcFylknYFjPI2icsAIuQ7htzKqySkeYbB4v
	80X2dVzQf9cDDwyf4as/thLg7Y9hetmU+egvMiQ9lX04fUutKQafB24sesfDbaaS0C0iwTv
	c26tEwOelqqDPi60HO3xcHZe33cL36M7aamUekb8HtIMC1IBE7y5inGAqKH2R6lXsPr0PjL
	hyC3B+C9nsmfFAAHbfo8/9KJ/WRkADl+e8yH12MYIClv/HfQ0kfA7e7ovpaVzoliNxaqqfg
	8nSX7XgXsWZu1eFJKCnEEeA/9VXt/TYLIw3Uw5BJx5C7bgGvc4srixU/OI2Pt5X6mmZpV4K
	JQVlxad565UWGVbF8ijYiwkqIEcZl+W8DYJlYWkEbD168Cf56fnCgLPawwBwCx0mXJ4xMiw
	MFAh1PgFvSGx0ohVWawEL3TYm9WE7HioReNbwkDQlRVdBDNJRD+x/ztW7MPPeKY4xjtHL0y
	/NCjWADs5k5cDJRrylRy7j9PqlZ7ZndzzmCRJF1uxYiaGRMxQIiYfDqJ79vpsPD9dFp6y6X
	CjUf9Kqv74/ZSjSMu7knuGrgYrEUNjIIIFPlGiep+tXGQkx7pbdISekLHwArJzl59Lf2d/k
	eFBU/yAWmsW+0+0ZnZ+RMHAg/rprf39gpGL5nqtEdUiMXZu8cuFGXnJUODc+A89fUO2Izyb
	ENCHJmbFCKhrIdOoaSkRRE4aodwG1ZUnoPo7Ye4dkcahV5a8F36JyRHuXDVvDrp9Xxswk7f
	DywhhTiLgzw3PjxRzGbUcx77wIVLrZ8lNAS7XDwBfxSj2GhhhqXZQEkAhah6A9cm41xl5i3
	Lm3mMdDOelrR8Xi0qMYI6dAbWy+0JjZMuBX9OeaDOtHI6FcCRaMUyOfkg4MgCroV1gmjDSZ
	O+E2hGym61TNSdeTSnaBSDRAoDgKhGbKEr3a5OJJXidy6qcxQenyFmZVcpskSvhRS080=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 03:14:26PM +0100, Simon Horman wrote:
> On Mon, Jul 21, 2025 at 07:32:37PM +0800, Dong Yibo wrote:
> > Initialize rx clean function.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> 
> ...
> 
> > @@ -299,12 +707,27 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
> >  	struct mucse_q_vector *q_vector =
> >  		container_of(napi, struct mucse_q_vector, napi);
> >  	struct mucse *mucse = q_vector->mucse;
> > +	int per_ring_budget, work_done = 0;
> >  	bool clean_complete = true;
> >  	struct mucse_ring *ring;
> > -	int work_done = 0;
> > +	int cleaned_total = 0;
> 
> cleaned_total is set but otherwise unused in this function.
> 
> Flagged by Clang 20.1.8 builds with KCFLAGS=-Wunused-but-set-variable.
> 

Got it, I can get this warning with KCFLAGS=-Wunused-but-set-variable
locally, I'll fix it.

> >  
> >  	mucse_for_each_ring(ring, q_vector->tx)
> >  		clean_complete = rnpgbe_clean_tx_irq(q_vector, ring, budget);
> > +	if (q_vector->rx.count > 1)
> > +		per_ring_budget = max(budget / q_vector->rx.count, 1);
> > +	else
> > +		per_ring_budget = budget;
> > +
> > +	mucse_for_each_ring(ring, q_vector->rx) {
> > +		int cleaned = 0;
> > +
> > +		cleaned = rnpgbe_clean_rx_irq(q_vector, ring, per_ring_budget);
> > +		work_done += cleaned;
> > +		cleaned_total += cleaned;
> > +		if (cleaned >= per_ring_budget)
> > +			clean_complete = false;
> > +	}
> >  
> >  	if (!netif_running(mucse->netdev))
> >  		clean_complete = true;
> 
> ...
> 
> > @@ -871,6 +1323,8 @@ static int rnpgbe_setup_rx_resources(struct mucse_ring *rx_ring,
> >  	memset(rx_ring->desc, 0, rx_ring->size);
> >  	rx_ring->next_to_clean = 0;
> >  	rx_ring->next_to_use = 0;
> > +	if (mucse_alloc_page_pool(rx_ring)
> 
> There is a trailing ')' missing from the line above.
> 

Yes, compile error here. I'll fix it.

> > +		goto err;
> >  
> >  	return 0;
> >  err:
> 
> ...
> 

Thanks for your feedback.


