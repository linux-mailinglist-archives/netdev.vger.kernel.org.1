Return-Path: <netdev+bounces-131398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D6B98E6C4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A3C1C222FB
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04A19E98E;
	Wed,  2 Oct 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u+CHdYnm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267716419
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911566; cv=none; b=dHlVHXYyVsP9bHM7ZhO/tUxwCdAAR1aeZXqsbDp9PM+T5h7ZfNOl6WexBYNAq64j+bxJcFOG3YcskcgWv44HDASWoliGRNgR3FPF4NoS4MLhKmmiyqsBNhV3vrtTAIfq41+oO+1saCPkbQJ1fRx4e2nbBEOQd3UQGxP/gmrilT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911566; c=relaxed/simple;
	bh=amYVplJWLgiv0cOubWOJR0kFEupGEClKZHsYoPcfSf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9ylbzpKKg52+rzw9gf6WvBHsqTWh3YvA2qdqATK0bgBljtwyWFDqXIN9oLlitBTkXN2T7mrfsHr3arXplFOEMw+PwwZSO0dphpuK6ofEAJDmWB0zkrfOOgXI1q+KnqKXM+aV7MPv7XlBAWBVV5FKfQr/WR7l2Vfw5HF7MtOwp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=u+CHdYnm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K4+fzEoUN3OhErOHpAnLCAX8h/ybmyblHSLZ2uyOM4g=; b=u+CHdYnmsfJUNPnJeKi1yY1De9
	jRCs19Gq86vw5T2G4HikKQT70Ct9G7c5nIx4gP+0Xen9A923rwHj/sSx78lEXy40j0VxAUFadAUqh
	DTo3Aoh1t9xBpKcuU0ntEl9n53arRzHPmzNmHX7vwTQ4UcMJ8E/i5jZ3Dcd9Z+fgfQQNcm8sh7zQ3
	thXATGFVxkKArbyNisoJBI2+EGuuahbP42x+uj14Gb2Czn9NPz1qkirPtYGK+vK+JH3C5XLg2gxAw
	pIZT62b62XgT5i/hnOc/A8+0rFsA4R6MG18Z0YyIiftCvrhE180QwQsaPTk/Fq50k3b1kDGYTbC3w
	H0DAY9BQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37686)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sw8it-0008CU-29;
	Thu, 03 Oct 2024 00:25:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sw8ij-0006KH-1j;
	Thu, 03 Oct 2024 00:25:25 +0100
Date: Thu, 3 Oct 2024 00:25:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <Zv3WZYbX9TzitX5K@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
 <E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk>
 <fp2h6mc2346egjtcshek4jvykzklu55cbzly3sj3zxhy6sfblj@waakp6lr6u5t>
 <ZvxxJWCTD4PgoMwb@shell.armlinux.org.uk>
 <68bc05c2-6904-4d33-866f-c828dde43dff@lunn.ch>
 <pm7v7x2ttdkjygakcjjbjae764ezagf4jujn26xnk7driykbu3@hfh4lwpfuowk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm7v7x2ttdkjygakcjjbjae764ezagf4jujn26xnk7driykbu3@hfh4lwpfuowk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 03, 2024 at 01:56:27AM +0300, Serge Semin wrote:
> On Wed, Oct 02, 2024 at 12:09:22AM GMT, Andrew Lunn wrote:
> > > I'm wondering why we seem to be having a communication issue here.
> 
> No communication issue. I just didn't find the discussion over with
> all the aspects clarified. That's why I've got back to the topic here.
> 
> > > 
> > > I'm not sure which part of "keeping the functional changes to a
> > > minimum for a cleanup series" you're not understanding. This is
> > > one of the basics for kernel development... and given that you're
> > > effectively maintaining stmmac, it's something you _should_ know.
> > > 
> > > So no, I'm going to outright refuse to merge your patch in to this
> > > series, because as I see it, it would be wrong to do so. This is
> > > a _cleanup_ series, not a functional change series, and what you're
> > > proposing _changes_ the _way_ reset happens in this driver beyond
> > > the minimum that is required for this cleanup. It's introducing a
> > > completely _new_ way of writing to the devices registers to do
> > > the reset that's different.
> > 
> > I have to agree with Russell. Cleanups should be as simple as
> > possible, and hopefully obviously correct. They should be low risk.
> 
> In general as a thing in itself with no better option to improve the
> code logic I agree, it should be kept simple. But since the cleanups
> normally land to net-next, and seeing the patch set still implies some
> level of the functional change, I don't see much problem with adding a
> one more change to simplify the driver logic, decrease the level
> of cohesions (by eliminating the PHY-interface passing to the
> soft-reset method) and avoid some unneeded change in this patch set.
> Yes, my patch adds some amount of functional change, but is that that
> a big problem if both this series and my patch (set) are going to land
> in net-next anyway, and probably with a little time-lag?
> 
> Here what we'll see in the commits-tree if my patch is applied as a
> pre-requisite one of this series:
> 
> 1.0 Serge: net: pcs: xpcs: Drop compat arg from soft-reset method
> - 1.1 Russell: net: pcs: xpcs: move PCS reset to .pcs_pre_config()
> * This patch won't be needed since the PHY-interface will be no
>   longer used for the soft-reset to be performed.
> 1.2 Russell: net: pcs: xpcs: drop interface argument from internal functions
> - 1.3 net: pcs: xpcs: get rid of xpcs_init_iface()
> * This patch won't be applicable since the xpcs_init_iface() method
>   will be still utilized for the basic dw_xpcs initializations and the
>   controller soft-resetting.
> ...
> 1.1x Serge: my series rebased onto the Russell' patch set
> 
> Here is what we'll see in the git-tree if my patch left omitted in
> this patch set:
> 
> 2.1 Russell: net: pcs: xpcs: move PCS reset to .pcs_pre_config()
> 2.2 Russell: net: pcs: xpcs: drop interface argument from internal functions
> 2.3 Russell: net: pcs: xpcs: get rid of xpcs_init_iface()
> ...
> 2.1x Serge: net: pcs: xpcs: Drop compat arg from soft-reset method
> + 2.1y Serge: net: pcs: xpcs: Get back xpcs_init_iface()
> * Since the PHY-interface is no longer required for the XPCS soft-resetting
>   I'll move the basic dw_xpcs initializations to the xpcs_init_iface()
>   in order to simplify the driver logic by consolidating the initial
>   setups at the early XPCS-setup stage. This will basically mean to
>   revert the Russell' patches 2.1 and 2.3.
> 2.1z Serge: the rest of my series rebased onto the Russell' patch set
> 
> > 
> > Lets do all the simple cleanups first. Later we can consider more
> > invasive and risky changes.
> 
> Based on all the considerations above I still think that option 1.
> described above looks better since it decreases the changes volume
> in general and decreases the number of patches (by three actually),
> conserves the changes linearity.
> 
> But if my reasoning haven't been persuasive enough anyway, then fine by
> me. I'll just add a new patch (as described in 2.1y) to my series.
> But please be ready that it will look as a reversion of the Russell'
> patches 2.1 and 2.3.

Oh, sod it. Do whatever you bloody well want. I don't care. You're
constantly arguing against me, and I've had enough of this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

