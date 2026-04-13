Return-Path: <netdev+bounces-277965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAzdC1+a3GkxUAkAu9opvQ
	(envelope-from <netdev+bounces-277965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:25:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4F3E82E2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25E063006833
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129743932D1;
	Mon, 13 Apr 2026 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F3c8B0/Q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F238947C
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065114; cv=none; b=eNUtlD4kNJyMN3TcHiwyuf6eIdnSmrrmvswYZjgtb85EalmPilyKsJtLhFW62a2a1FX4l9MTMn8rGQxaybSaxs7xVohMitfmR3a8B28pKX9eHVLxgwEZZvOlqaQEzTOWA8rJWMm8ZMmeSzCmit45SLhmQxjhos2UiVoEjPrVNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065114; c=relaxed/simple;
	bh=6x7cFv1uzOlGSxYGgw+EVQBRYfXhNwsSyJjYXoAWjHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc9ZiBcPWI0/dpGPDUPWpUM4xCcxw0pUmNNyLhwi8l/GYbCVAHfvBeTr30f/WCmDJYLctPogHACRnrryXUZk3xBWD9AHzzA48wgouxC4WdYZ0ACPjfm7pyEvgM/EWZQ778wOcI0FZ5ex53HnMZTVqOPQeJjG1oZ7DQwvovWxNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F3c8B0/Q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6UfJz29jZ/mDOwE6MDp0t4YF4VN3Gzp/B3Pai9lhUsA=; b=F3c8B0/QIt2+9CIrfCWknmZZeO
	5Gf3AK+0v92dafXSnLeBS75fQ9GiSAly37Nj7hrIoodHNglk5igk4AQajg8JvH6I7004BiBhj/dqn
	/rA+qCS+ZpUSuEC9nYvPG74mx5IJqqAeh0Zi/PKybmy2TqW9rYLNr5ThCTC0vr/3khdxT61xBmODh
	MQSILXKl68l/YGqt/nrTa/TEUCXf3eMTaHe5UKjXYK97VimUhvO7Q7hpZclik3Z7umtTlU9ggy0dm
	4mS4quRmPdlSpg8MIRb6SDmjM5v63Y2nGJVrST02wNvd+23aoVVATa42Jeyat3wqzvEJm5b7d0gs3
	E4MBzHhw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45994)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wCBfK-000000007vb-44FK;
	Mon, 13 Apr 2026 08:25:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wCBfH-000000008Rc-0zFk;
	Mon, 13 Apr 2026 08:24:59 +0100
Date: Mon, 13 Apr 2026 08:24:59 +0100
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
Message-ID: <adyaS3EauyrNrjMy@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <266998d8-7e38-4bae-a4df-2f889538fe88@bootlin.com>
 <aduq7Lvkfrz971Rb@shell.armlinux.org.uk>
 <CAH5Ym4hEX15dmJhGBqhhk--_PoFRKRSyE1AomY4D3ipwAz+pKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5Ym4hEX15dmJhGBqhhk--_PoFRKRSyE1AomY4D3ipwAz+pKg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277965-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 21D4F3E82E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 06:42:04PM -0700, Sam Edwards wrote:
> On Sun, Apr 12, 2026 at 7:23 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > As the dwmac 5.0 core receive path seems to lock up after the first
> > RBU, I never see more than one of those at a time.
> >
> > Right now, I consider this pretty much unsolvable - I've spent quite
> > some time looking at it and trying various approaches, nothing seems
> > to fix it. However, adding dma_rmb() in the descriptor cleanup/refill
> > paths does seem to improve the situation a little with the 480Mbps
> > case, because I think it means that we're reading the descriptors in
> > a more timely manner after the hardware has updated them.
> 
> Hey Russell,
> 
> I'd like to repro this but I currently can't boot net-next. My issue
> is the same as [1], and the patch to fix it [2] isn't yet committed
> anywhere apparently.
> 
> This prevents my Jetson Xavier NX from starting at all (and after
> enough attempts, corrupts eMMC); I'm surprised you're not suffering
> the same effects. But because this bug lives in the IOMMU subsystem
> (and it has somewhat inconsistent effects), perhaps this is just a
> different way it manifests? Could you confirm whether your dwmac hang
> happens with IOMMU disabled, and/or with [1] reverted or [2] applied?
> 
> I'm using a defconfig build and a fairly minimal cmdline (just
> console=, root=, and rootwait).
> 
> Cheers,
> Sam
> 
> [1] https://lore.kernel.org/all/8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com/
> [2] https://lore.kernel.org/all/0-v1-664d3acaabb9+78b-iommu_gather_always_jgg@nvidia.com/

In the second link, there is this sub-thread:

https://lore.kernel.org/all/ee2c2044-e329-4cdd-ac35-9365824d3677@arm.com/

which was committed into -rc as:

7e0548525abd iommu: Ensure .iotlb_sync is called correctly

which does fix IOMMU problems which caused net-next which reports itself
as v7.0-rc6 failing to boot with ext4 errors. See:

https://lore.kernel.org/r/adZTGOjjJrVJOcT8@shell.armlinux.org.uk

which resulted in it being merged into v7.0-rc7 just before Thursday's
net tree merge. Due to the way net-next is operated, that means that
net-next on Thursday evening gained this fix.

Involving Linus in the problem meant he was aware of it, and explaining
how netdev works allowed him to delay the merging of the net tree to
ensure net-next gained the fix.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

