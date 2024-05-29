Return-Path: <netdev+bounces-98927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF58D3246
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0251F220A4
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99E17B504;
	Wed, 29 May 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DXkkWZ0E"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A817B433;
	Wed, 29 May 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972536; cv=none; b=u2VONaSjqJxFf5psXuFJLF08DFXknGUbe8jqpteX6YsnFrBRPu10pOcdJSOEdwyplfRothrUGaa/pk1osXuZcxLcDNG5Bw7Fly3jk/dw8eo/fXkdSQlHBkkqBYIxwos1INaJIj16axUpYCm5ButGrFr7ExrKGqvRFuVCU01HpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972536; c=relaxed/simple;
	bh=05mPMURiJUzB68uwZ1AnFCRU9HvmdnaueMsK6PvezjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFYJmHZuRDJUg3+OP+JSuPFGJ3tmrD4n0BsB+QlCPT2NK5NQQge3khil1FAxfTLCoumijoutstVyyIMgiOYsx9fywFquHjNOH7oRGj+hJiyqyqw82SymwcdS7zVu0zfZjmkCzThUiLU2o8iLJwcjno0nV87K27jvCOXPwMOKqW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DXkkWZ0E; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fy/VN4d93AK58QWLNniu+JNSSAyKTkDFLr45JXQ5Bzs=; b=DXkkWZ0Esh+3Ku43CUqs2kR56L
	S6ClNqQdm5L+GJn4agj4N/jzOMZFcWU8Z63sliv6R3BbOmaZIT02J4lW10dxZKzutKDSZlejmv0v6
	TWDISFNFG8xPNlA+SvivbcenRpCITMm7RCgKRUmzAB8qzmP3GZwlvSzhs3TeGj/nLKcLkz3O2keNg
	x6+Z1FMLu8UGhaXMvpZdGvGBZm7qO03SYsBqTbRvkAYzsy1yoMBdK6v5C5/LzHyWdGbiT5eOO1yLH
	5IfQ91PmRDXwsaPrF8+aXvmcWB8Nbfqaa72v326Wl+nElipaL2GTnXWbA+PW+4xscr1gt0CxJmT9O
	eWlU2d0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38530)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCEzB-0005qn-1p;
	Wed, 29 May 2024 09:48:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCEzB-00045O-Pl; Wed, 29 May 2024 09:48:41 +0100
Date: Wed, 29 May 2024 09:48:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: xiaolei wang <xiaolei.wang@windriver.com>, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: stmmac: update priv->speed to SPEED_UNKNOWN
 when link down
Message-ID: <Zlbr6ZCI0GZR6FKn@shell.armlinux.org.uk>
References: <20240528092010.439089-1-xiaolei.wang@windriver.com>
 <775f3274-69b4-4beb-84f3-a796343fc095@lunn.ch>
 <b499cbcd-a3c9-4f38-a69a-ad465e7f8d5a@windriver.com>
 <98e6266f-805c-4da2-b2dc-b25297c53742@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98e6266f-805c-4da2-b2dc-b25297c53742@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 29, 2024 at 02:57:27AM +0200, Andrew Lunn wrote:
> On Wed, May 29, 2024 at 08:22:01AM +0800, xiaolei wang wrote:
> > 
> > On 5/28/24 21:20, Andrew Lunn wrote:
> > > CAUTION: This email comes from a non Wind River email account!
> > > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > > 
> > > On Tue, May 28, 2024 at 05:20:10PM +0800, Xiaolei Wang wrote:
> > > > The CBS parameter can still be configured when the port is
> > > > currently disconnected and link down. This is unreasonable.
> > > This sounds like a generic problem. Can the core check the carrier
> > > status and error out there? Maybe return a useful extack message.
> > > 
> > > If you do need to return an error code, ENETDOWN seems more
> > 
> > Currently cbs does not check link status. If ops->ndo_setup_tc() returns
> > failure, there will only be an output of "Specified device failed to setup
> > cbs hardware offload".
> 
> So it sounds like we should catch this in the core then, not the
> driver. And cbs_enable_offload() takes an extack, so you can report a
> user friendly reason for failing, the at the carrier is off.

It's worse than that (see my other reply.) If the link speed changes,
there's nothing that deals with updating the CBS configuration for the
new speed. CBS here is basically buggy - unless one reconfigures CBS
each time the link comes up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

