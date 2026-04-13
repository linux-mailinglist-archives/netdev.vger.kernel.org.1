Return-Path: <netdev+bounces-277968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKCaFMac3GkxUAkAu9opvQ
	(envelope-from <netdev+bounces-277968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:35:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 936263E850E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4D6F3017C2B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46273932E0;
	Mon, 13 Apr 2026 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vGVrmcFP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB323932CA
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065334; cv=none; b=OayT3vdyz+vzY9ebwZceRlIAH3MOPOyfN1kP2Ae60NSppJ8WN0W3QJuOs6wA39U1UDuyOocfcBFzxncJTCoHWTxAVaDRdRmdU3WmONZv+snQSIRbFPfOz9YpDKT5IFKxfdHl3+WoM0hyEMCAxcyEQPEyQM1mr84EDHjyLv9RBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065334; c=relaxed/simple;
	bh=b+REnLyFlt8gAAHb0UfigkbwOTdNQ/EP71OIdJOdRZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3gFvQ3LPokclZHqiAvDCpODlkqzpXZ/a6VTOXPTxrvj+0QbpzCBppQBECX9chwQ1oLT2z/6Y3HLCoUCGsGPvgyOIohhd2Ptp53YEzLItENANiCBnn/LuotqgxUrpG24++rCyXsGtBCwAKdGdCwclLLb/sTKNr1JRsI5fJOJm7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vGVrmcFP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vBAkUVC0LMguyggH1Fj4JtxZi9KWJ36XVZrJatk2ddU=; b=vGVrmcFPQ6S49Z9B7XUiJ2/XJx
	TCePPJ2Ig0JP/H6FFr0MQ4Icbi5GdYptvkxEcqqALfQeLVdCu4ZXrmo81ZP75Pa/c8jnMjIbTOMOo
	fFuRQyBW0FruqRiC4GKGfZh3sw13Dfp51fGH2wi8gewQXzrEVxWTmVT9xCmdVeRkcaG4y4LwwInqB
	umUXdX8MsLxLHlkf8/YsQiT+lqJ0H7GgARReY0yz3qUPLWvXfKPpHUnWS3THK0j5dvSoAhgknRDjU
	lfwY0Mssi9nMN9WvYBY7p5D0+hyn5iEuoKj2WyOFPYNOOiLJJNYFvVxiAabutE3z3WDzKWIu9Ef2R
	JqTNF7Dw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37492)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wCBix-000000007wY-3NJR;
	Mon, 13 Apr 2026 08:28:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wCBiw-000000008Rt-2JjB;
	Mon, 13 Apr 2026 08:28:46 +0100
Date: Mon, 13 Apr 2026 08:28:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <adybLvNCLw8jT5Yo@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <266998d8-7e38-4bae-a4df-2f889538fe88@bootlin.com>
 <aduq7Lvkfrz971Rb@shell.armlinux.org.uk>
 <CAH5Ym4hEX15dmJhGBqhhk--_PoFRKRSyE1AomY4D3ipwAz+pKg@mail.gmail.com>
 <adyaS3EauyrNrjMy@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adyaS3EauyrNrjMy@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277968-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 936263E850E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 08:24:59AM +0100, Russell King (Oracle) wrote:
> On Sun, Apr 12, 2026 at 06:42:04PM -0700, Sam Edwards wrote:
> > On Sun, Apr 12, 2026 at 7:23 AM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > As the dwmac 5.0 core receive path seems to lock up after the first
> > > RBU, I never see more than one of those at a time.
> > >
> > > Right now, I consider this pretty much unsolvable - I've spent quite
> > > some time looking at it and trying various approaches, nothing seems
> > > to fix it. However, adding dma_rmb() in the descriptor cleanup/refill
> > > paths does seem to improve the situation a little with the 480Mbps
> > > case, because I think it means that we're reading the descriptors in
> > > a more timely manner after the hardware has updated them.
> > 
> > Hey Russell,
> > 
> > I'd like to repro this but I currently can't boot net-next. My issue
> > is the same as [1], and the patch to fix it [2] isn't yet committed
> > anywhere apparently.
> > 
> > This prevents my Jetson Xavier NX from starting at all (and after
> > enough attempts, corrupts eMMC); I'm surprised you're not suffering
> > the same effects. But because this bug lives in the IOMMU subsystem
> > (and it has somewhat inconsistent effects), perhaps this is just a
> > different way it manifests? Could you confirm whether your dwmac hang
> > happens with IOMMU disabled, and/or with [1] reverted or [2] applied?
> > 
> > I'm using a defconfig build and a fairly minimal cmdline (just
> > console=, root=, and rootwait).
> > 
> > Cheers,
> > Sam
> > 
> > [1] https://lore.kernel.org/all/8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com/
> > [2] https://lore.kernel.org/all/0-v1-664d3acaabb9+78b-iommu_gather_always_jgg@nvidia.com/
> 
> In the second link, there is this sub-thread:
> 
> https://lore.kernel.org/all/ee2c2044-e329-4cdd-ac35-9365824d3677@arm.com/
> 
> which was committed into -rc as:
> 
> 7e0548525abd iommu: Ensure .iotlb_sync is called correctly
> 
> which does fix IOMMU problems which caused net-next which reports itself
> as v7.0-rc6 failing to boot with ext4 errors. See:
> 
> https://lore.kernel.org/r/adZTGOjjJrVJOcT8@shell.armlinux.org.uk
> 
> which resulted in it being merged into v7.0-rc7 just before Thursday's
> net tree merge. Due to the way net-next is operated, that means that
> net-next on Thursday evening gained this fix.
> 
> Involving Linus in the problem meant he was aware of it, and explaining
> how netdev works allowed him to delay the merging of the net tree to
> ensure net-next gained the fix.

I'll also state what I've stated previously about the iperf3 problem:
it seems to go back a long time, certainly before I started cleaning
up the stmmac driver which is now well over a year ago.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

