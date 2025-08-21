Return-Path: <netdev+bounces-215431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17905B2EAB0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9465417DF7A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FC61C3C14;
	Thu, 21 Aug 2025 01:30:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D621B9C5
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739805; cv=none; b=ZBNnB05RE4Hpaj6THwER7pR0H2l8J3VqfDhO7TekOGvE+aesAq0S26iUOhzftqtBOy37/NVOvpueyT5k1htK1qqTrM0GlZlWK3sjVVYFwi9cTsw0yx8Af4FOiS2dy5TAQGTfPM9QK40WZJBm+VNroxwTv8CgJrHaQc9qMUUiMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739805; c=relaxed/simple;
	bh=vSYcJ0aHEHWUirTFp5oX8P5I3M5GKhP0AGzOqF/u6Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtdkF1RmB5MReFYcTIOz9+H7MwWigY1PlRryq7ec0pfGyr71oFuR8HFeMBaYQ3wDSENhVS81UnHRXqYU4+jIXroVd80+jyNTLrMs5dQyYiVv4hQWCItrLXPopoIBIs6lHgxbbMvJL920DB7v5G7iO6Fb1LKpIyI2AL7cGhsHmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1755739791t57bdd104
X-QQ-Originating-IP: AHknXJ7UDHE8zUvEpK7b2spqug7488n8a6smgTHyaQw=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 09:29:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3096026230268940680
Date: Thu, 21 Aug 2025 09:29:49 +0800
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
Subject: Re: [PATCH v5 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <8DE9B7420E7CCA57+20250821012949.GA1742451@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-2-dong100@mucse.com>
 <7696f764-7046-4967-813e-5a14557b9711@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7696f764-7046-4967-813e-5a14557b9711@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MC2LmCE9YcPx8m4m2xUMBhfqWynfml5xxmbpjMWh1MGhEilwEES/Sp7R
	yJuCLKOaLzeQW/0mvUJKyYH0WuUlIMB22whrn0+CD7zpr8tSZMtKqH4qs/q4Glue1KO+q36
	ysYo0fkJejoJBo1AgJoTlmAojAZ35qIdQn+4BWkrlQm+ilypXRQBY404Zh0v6bqXWp6wFth
	bhMwsTfNbuK2sz4G/tQMBUSX6/Cac+9hem/Ba5OyJTGYP7Bwr3wi83NijA0/LTHWIjgo+LX
	sgWBNMGjnt6FvzcYQAC7mfkzX7NN6MWQu2ejIOJ8NSfM7wZbQxh8erxUnE88p8s/qSucnKY
	kUcePPPRy7zLaZRrEMBQXJ9ZGa53opZMYarQxbgH1Hw1pxHB5kFqMbVSzs2RA1KrudUDWR/
	uqZgHSOEzkNCB/hbMmW5j9XCz6x42SQ26XQNzoMzEYuHCcdW8KzsD4n7ZogocI+OTnOEzWO
	9jRbLDOKcRc1rzsywm5Z8nqlYezsNC/wzzIHS4WjjupKPMNcHfzlog8TcjbCT6Uf7Von03m
	g+UPEfYnYYeL61GJaS8dohRXlFOcb+9DWqF/Q6lkWYOQGn7c7ev41APhJiOY4M853B2rPfY
	ZFm4euVTtRaz24snpos7A32ovFUYR1rdwKUyRsG2x3k4hBBfN7DJyLU7y0pyxYsesgsUESE
	4f2Rz4wWxclywgqvZauCltzNg5k8AgpHy/H0UX7VdxWFAsiu3yt0MvlJx7dvhKYlu9B4EGw
	KKiOquYHZWTEVz0RAdSuB9BnV2ANiL9HP8n6dCZPJPflhiGIJ8vuvyVsg0gePJ7Hj+dcxOA
	acr8/rjy6MsvwF1f6Xtl6jdmB4q4NtyfoFimDBnn+kEPVWoMPrVHenUlNRRnhYVSoRpcO2H
	FRpe83IUJcY4CydOnRIb3QDg3jwvQwKUS1exUnT2md/MIFpHFjp0ZkYeVvERb++COuYPzu0
	WnMTQ6/aURgakgavo/2oFOerPvOtCAkDrhnAecdIvn9NdI5V9llgAET0xa6ildmiQBtg=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:06:00PM +0200, Andrew Lunn wrote:
> > +/**
> > + * rnpgbe_init_module - Driver init routine
> > + *
> > + * rnpgbe_init_module is called when driver insmod
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int __init rnpgbe_init_module(void)
> > +{
> > +	return pci_register_driver(&rnpgbe_driver);
> > +}
> > +
> > +module_init(rnpgbe_init_module);
> > +
> > +/**
> > + * rnpgbe_exit_module - Driver remove routine
> > + *
> > + * rnpgbe_exit_module is called when driver is removed
> > + **/
> > +static void __exit rnpgbe_exit_module(void)
> > +{
> > +	pci_unregister_driver(&rnpgbe_driver);
> > +}
> > +
> > +module_exit(rnpgbe_exit_module);
> 
> This can be replaced by module_pci_driver()
> 

Ok, I will improve it.
By the way, if I want to add some functions(maybe workqueue to handle
link status, or debugfs for the driver) in the future. The function is
only one for driver, not each for every pci device, should I turn back to
'module_exit' and 'module_init'?
Maybe workqueue can use 'system_power_efficient_wq' just like libwx
does? 

> 
>     Andrew
> 
> ---
> pw-bot: cr
> 

Thanks for your feedback.


