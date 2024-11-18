Return-Path: <netdev+bounces-145911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9809D1510
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E9BB24541
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF781A08BC;
	Mon, 18 Nov 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="biXQoHyB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B0196C7C;
	Mon, 18 Nov 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945425; cv=none; b=hMum4Mpmb+JluT3f/DHojVgA09S5RYQRXbydfSa7jf0Oknodds5NLjOMRcQanme0wl6NSJeOy5p0iA/imRYvGd58vwIXNj9rx6v2C16gBkWYh2tOpllYqYya318XMJkgHZkKLBJEOb/W5dUF0lqeJI725AOPGWly8piGV1uA5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945425; c=relaxed/simple;
	bh=qYWFVCn3q14APeuwcYUZ72A5Kwi+646sYdvJU+kgKP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv0WheCmCJCAVxU4KbMzjrQH/08qqkIIKXfUN2O3oFWjjx3OCQSHV5DEredyZwATm+rhBNCpV1NYu75Wzaehs3mdwxeSOl7H6lMS46QUhQZuOGeyPRsXnnMVzsAVNB5W4+XFsgGzD0q+hoBEJAyJOOMjg0trErAM2yHoPCsprr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=biXQoHyB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sz1jHbHlp8QHDI8p6axcNSLoVuizF3hYscPtQCpLJQk=; b=biXQoHyBnaIUDYP3xC0QYwCpdL
	tBc+spdPnAfSbQvxnCkiL4+VaZQeQfDT+/2kMJaP6vsKf0wzOVR3Bh08pg8cvUfKVW1uHTYUZyP4p
	fJ+09bOWxGRUaLYeM5y6sNeofl4PchDZxCmBORt/9uJ5KdewChMjorjwQOrEXPPf3fLVeUm6lmIvg
	LEiMAa+AdDz+6fhQsFaEDQV2D37zPoeR+tDeP5u+FLW2ICRlN7wojvq8EYaflu2lnx4EmfGnbgQVH
	BJdH7Ec5wqBy6J/l8dFXMWVlqvCd8aE0L2o1EzysPs80B6MPR2uGMgACkoVMoqdTmfE4gqqFlyOxQ
	ILV4N1Vg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35228)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tD47O-00024l-0K;
	Mon, 18 Nov 2024 15:56:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tD47K-0005CP-2Y;
	Mon, 18 Nov 2024 15:56:46 +0000
Date: Mon, 18 Nov 2024 15:56:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	sean.anderson@linux.dev, radhey.shyam.pandey@amd.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Message-ID: <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118081822.19383-3-suraj.gupta2@amd.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
> Add AXI 2.5G MAC support, which is an incremental speed upgrade
> of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property
> is used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> If max-speed property is missing, 1G is assumed to support backward
> compatibility.
> 
> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---

...

> -	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
> -		MAC_10FD | MAC_100FD | MAC_1000FD;
> +	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
> +
> +	/* Set MAC capabilities based on MAC type */
> +	if (lp->max_speed == SPEED_1000)
> +		lp->phylink_config.mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
> +	else
> +		lp->phylink_config.mac_capabilities |= MAC_2500FD;

The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?

Normally, max speeds can be limited using phylink_limit_mac_speed()
which will clear any MAC capabilities for speeds faster than the
speed specified.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

