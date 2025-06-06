Return-Path: <netdev+bounces-195482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 956CCAD06F3
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB047188E97D
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077A199E89;
	Fri,  6 Jun 2025 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cL0g/Nik"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5E19F12A
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228472; cv=none; b=UuFcyQ9DgiqWsCs5GftU8sWL2SPoVjlOZrR2MMDxc+8XatP0RRNkkkRocm8tqKrYrYnnYKHZ+1rsPqRqbzN/WwDbTFbYpY8oVQPlYNfQ72XW8JxD94/o4iyBWeOZQpGSp6pqL+kNcx+Ak4P5qJTCjujmPGVG3+UkynqZ2mrEHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228472; c=relaxed/simple;
	bh=fkAsEMgyS1bSRPz0tkQm8FZufxeaJ48wVByV5eKFnXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLvjhtuBiAH2S3x0Cs8FQWl2Ja7gvKtF7hU1gxtqYht8Sm1y9vBzpum0+g7ucJ5Y1P4mKK949uvvP7NwB0Zyx0oGoQYHttGlTnqfR22BiPcQMzhavrqCn+fDLRrjUd+vsjyPdiOk1Gip22F3iAG+Iq2+nFtdaNlvaxeWT4iNSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cL0g/Nik; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4bcj6SHlao7/THrMVPhGDS4/2D06LS6doLHg5oyHMDo=; b=cL0g/Niknl/7Gl5xD9pq3gCZCo
	KZ0yi80mrxx1LyGOnrtMxyAppqFMSk6JJlzCT+g/E8q4e03XWElFGj9pSa/hlQBUG7CcsapES6zBw
	mNRwIgjBQqKrvxfnuW4hE2Vj08LlVYR5TIh7GVI/2bAmSRA/tGHVTzqL7QVmdxeDraF47EhP6qNhA
	lTJY6VHvIC/rMzzXsEkh3xSrpXOzvAdRcngbHQbuP+Lc2z/RTzmokzBypinwW0Px5A9Voie4Gi1UJ
	h86ryp6th+76641qHNsFJIQl8T3Z5Irxs67RBQjfiHg3R+62viegUNcOP0O7ML6nY5RibS5fGJl8l
	re/9yrZw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40464)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uNaEN-00010k-1a;
	Fri, 06 Jun 2025 17:47:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uNaEM-0003N1-0X;
	Fri, 06 Jun 2025 17:47:46 +0100
Date: Fri, 6 Jun 2025 17:47:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chris Morgan <macroalpha82@gmail.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID: <aEMbsmdHxq7WwCHf@shell.armlinux.org.uk>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
 <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 06, 2025 at 02:53:46PM +0200, Andrew Lunn wrote:
> On Thu, Jun 05, 2025 at 09:22:03PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add quirk for Potron SFP+ XGSPON ONU Stick (YV SFP+ONT-XGSPON).
> > 
> > This device uses pins 2 and 7 for UART communication, so disable
> > TX_FAULT and LOS. Additionally as it is an embedded system in an
> > SFP+ form factor provide it enough time to fully boot before we
> > attempt to use it.
> > 
> > https://www.potrontec.com/index/index/list/cat_id/2.html#11-83
> > https://pon.wiki/xgs-pon/ont/potron-technology/x-onu-sfpp/
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> > 
> > Changes since V1:
> >  - Call sfp_fixup_ignore_tx_fault() and sfp_fixup_ignore_los() instead
> >    of setting the state_hw_mask.
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> You are supposed to wait 24 hours before posting a new version. We are
> also in the merge window at the moment, so please post patches as RFC.
> 
> Russell asked the question, what does the SFP report about soft LOS in
> its EEPROM? Does it correctly indicate it supports soft LOS? Does it
> actually support soft LOS? Do we need to force on soft LOS? Maybe we
> need a helper sfp_fixup_force_soft_los()?

Yep, too many people today seem to ignore questions and think they
mean "let's post a new patch". :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

