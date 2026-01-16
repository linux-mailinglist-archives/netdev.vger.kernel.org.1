Return-Path: <netdev+bounces-250533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F10D31F21
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F15E3002D3F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1470826CE0A;
	Fri, 16 Jan 2026 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NwpCnzDH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F3BEACD;
	Fri, 16 Jan 2026 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570690; cv=none; b=TPGRSmQPiPXFtRkhxan+vXHC1lgdvGHyTI2WuZCBeQto5tpO+By4YKZf4s0VyswvQ4AlCL8NjKMD1fB0alfmI1YZ2yhRtoiFRJAQ3FPC0i9IETpGoZrFIGakk3/XTA89L6j5D8UH3l6q3Ds4SUF9Kg7KyvoaEvWIs8oEUXJ8s6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570690; c=relaxed/simple;
	bh=JTC1pdUlTXTnciOTM3GzaepjRusA+OY4fCCHGwJtnd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upvTP0Y7TtsYx/X3M+brgIvgsvr1MDRszm5B610cLtsBTR8b3xRH0feefP43gTMyF1vlGXdSDPMjAy+af9lFhfs3F8q1JwTxAY1zIIVC4Xd9BSZvvsrAHFptErhd0DICNIT/BMmkLB/YlFg56tyW7+uyXRIKjolRts942sb95ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NwpCnzDH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YbUJvWjZg5Gp5lUyzT1dd9lszS+ppdNrSyuG65trSl8=; b=NwpCnzDHX19af34HFw+Njzwyi2
	ZOqhYX0HAWLYZmMBQzZp1qOVC1kxD0xLiDiG3UzKrBITXxS9HmBiQlU2pD7/Tx6pp5JP3iRy0Kh0j
	GZsdfhjedm4KcPSrc8ncVQTyVVKetTCJy69M4DjoxQUDGm01XFlfwIMV1t76Qt5NsOdAt8tiCpkEs
	Vq9+uwEftsCUwEMxCgGJXFOYNpv5yGk9pf1C0pZcyni8P68dYOotxl8/G+TYBIXumXah9kNUygEKq
	HA6/ogSGiv08SO1r+mGQS95qSPU5cMJ5s3EO57UF+FnNJhFYL3oLzzGjWP2JW2k0p50vIaCUnqG7L
	Nva0wEAw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59078)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgk1T-000000002JP-0Dvp;
	Fri, 16 Jan 2026 13:37:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgk1M-000000003dz-0ixQ;
	Fri, 16 Jan 2026 13:37:48 +0000
Date: Fri, 16 Jan 2026 13:37:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Tao Wang <tao03.wang@horizon.auto>, alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
Message-ID: <aWo_K0ocxs5kWcZT@shell.armlinux.org.uk>
References: <aWd9WUUGhSU5tWcn@shell.armlinux.org.uk>
 <20260115070853.116260-1-tao03.wang@horizon.auto>
 <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
 <aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
 <6a946edc-297e-469a-8d91-80430d88f3e5@bootlin.com>
 <51859704-57fd-4913-b09d-9ac58a57f185@bootlin.com>
 <aWmLWxVEBmFSVjvF@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWmLWxVEBmFSVjvF@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 16, 2026 at 12:50:35AM +0000, Russell King (Oracle) wrote:
> However, while this may explain the transmit slowdown because it's
> on the transmit side, it doesn't explain the receive problem.

I'm bisecting to find the cause of the receive issue, but it's going to
take a long time (in the mean time, I can't do any mainline work.)

So far, the range of good/bad has been narrowed down to 6.14 is good,
1b98f357dadd ("Merge tag 'net-next-6.16' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next") is bad.

14 more iterations to go. Might be complete by Sunday. (Slowness in
building the more fully featured net-next I use primarily for build
testing, the slowness of the platform to reboot, and the need to
manually test each build.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

