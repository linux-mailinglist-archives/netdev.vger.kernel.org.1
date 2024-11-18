Return-Path: <netdev+bounces-145928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457EA9D1512
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB9B281291
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26D11BD007;
	Mon, 18 Nov 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jll7pIfW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64521AF0DE;
	Mon, 18 Nov 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946150; cv=none; b=ZBqrU9tPykErbAVeM8pmByTcspqlLdF82I8078fh/ZXymtgp7K7gic0sDLKhYEcXaKcmHV+vT4EJo1nsl8E1OWdHTjChG3HlSKmUeWtbOvC5FOux94WRkrYYI/8M0c5f+hPEu6mrH/IkHdkV0W+Za+JMMYdR/1JrLhWvgODOb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946150; c=relaxed/simple;
	bh=nEvthwO+4LqLtkXsIaNW/tRVsCKmJTHXmqJVAOrMq3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxBDp47byG72+pSNaXFfMa+14NURGH9+qMSPWAC/S5FkIBVFVwWciXVuDXJgzxwjSl4LSg9NPkYyWbThIdylzhCbcy7tX1mkMPMB+63zPzIv9dhLENRSA38G7Yi97F36MDbZ6XaUYVI3lirFDKt82cV/rtvhpPwukoY92qiee5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Jll7pIfW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gZuZhrm0652z1EXnExgABXIbM9+BwJr+Kdt0AwKAMU0=; b=Jll7pIfW2nbVFGgch2ygidFhCi
	Rni6unl3BkZ0/wVEt3lFfCADnKXeLCyPqdBABrpZwSDpgYj5FLsaLlnJXTMNv/y+ClQbt2b0f36OZ
	+FM7RXKbCAuJO8c9OOAyXcSYm4I22ACS1h+6ifnLGK7lP2UBMdv2wHoqnkzNJiDqsJx065CvnZjA0
	xu+dr81JSNDFLIVaclttjsTnfq4ffyiSNKLyEVq+AaD+kqPXXnH1TzRYyAoYEhErk6bhtBU0A4Qtg
	pySkMgQrCqJCTuqff3Tf34Qb+vDFmPy3CBCny60KZOAiYxcDadZQQPDh2/pnDG4teftKcdCBkQe6A
	0e/SxJig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33504)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tD4J6-00026H-1z;
	Mon, 18 Nov 2024 16:08:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tD4J5-0005CY-1G;
	Mon, 18 Nov 2024 16:08:55 +0000
Date: Mon, 18 Nov 2024 16:08:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Message-ID: <Zztml-Te38P3M7cM@shell.armlinux.org.uk>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
 <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 18, 2024 at 11:00:22AM -0500, Sean Anderson wrote:
> On 11/18/24 10:56, Russell King (Oracle) wrote:
> > On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
> >> Add AXI 2.5G MAC support, which is an incremental speed upgrade
> >> of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property
> >> is used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> >> If max-speed property is missing, 1G is assumed to support backward
> >> compatibility.
> >> 
> >> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> >> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> >> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> >> ---
> > 
> > ...
> > 
> >> -	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
> >> -		MAC_10FD | MAC_100FD | MAC_1000FD;
> >> +	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
> >> +
> >> +	/* Set MAC capabilities based on MAC type */
> >> +	if (lp->max_speed == SPEED_1000)
> >> +		lp->phylink_config.mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
> >> +	else
> >> +		lp->phylink_config.mac_capabilities |= MAC_2500FD;
> > 
> > The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?
> 
> It's a PCS limitation. It either does (1000Base-X and/or SGMII) OR
> (2500Base-X). The MAC itself doesn't have this limitation AFAIK.

That means the patch is definitely wrong, and the proposed DT
change is also wrong.

If it's a limitation of the PCS, that limitation should be applied
via the PCS's .pcs_validate() method, not at the MAC level.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

