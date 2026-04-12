Return-Path: <netdev+bounces-277804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JmpDuyr22mzEwkAu9opvQ
	(envelope-from <netdev+bounces-277804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:27:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7DC3E4432
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1714300EAA0
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86859376BCD;
	Sun, 12 Apr 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1uwnsKge"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875BB244667
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776003837; cv=none; b=e2YrkqWENHT89JIxFfJ908Zc9SIdejgzbZnHy43AL/se/20zP7RYDMbfxtL6mil56jFv1XZgzXM+oMdFSnoWyxEkrjNJ0ejxeaKRPzrrwZMsggSC96wL2YzLQD6gZye70tzVmO8cSG/e1lbuQDoIhJ+VXawKIpPCPh5nawnxSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776003837; c=relaxed/simple;
	bh=RF26n4CasjH4PgOl5ATDbgm/vGloIHue/axCLuVfJsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXZSX8aopmh1Bn/sZZ7s/v6IdDDx3ZNRk2H4WuW/QVeXoC+UYubX6kCrP+Is/WdL7JSW0sqirH1vVQKL2IXUHJHzRH2U9/Iymf2UD14lefmTcNNsspgZFkqbIvEZLIC2ARKK3deKwT4gODKlqxoiU33zsTr1dC/QCz8U3jwHxc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1uwnsKge; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/bZQaaA9y+PfxKdKkmD3Tt08LTFDotVPzB4Utjfybes=; b=1uwnsKge/Xsow/UXYATYTv5+JC
	4eEi/y/HAERoQHiG6FCixsZYLHu2e5FE/sVGKVh4pfwa5iy3BrAj5hDU78KtkIL9ljgZM07lFbJj5
	OIxZ8+d52hzEcdEewFgX0MMWvarxyXDkld3wN9mJH52UTJjlbZpyPpY6LPbW0EtX+Q2xVLymxdJUk
	+FGc0wedZufgbPy0v9yirPNdM9w9b8soAgiRLxsoyGqVOpVsGc0JcQepZqG+yyYWbWGP+39qy7KDV
	hcehgKYkkmtlnEAgAL1I9QV5+GCVTW9KZqg0xJL8v2dzC70n5zQozupnsRKg86PTlb08T94nskf+9
	TI26aymQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34374)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wBviy-000000007GH-0wVq;
	Sun, 12 Apr 2026 15:23:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wBviu-000000007iS-2XGL;
	Sun, 12 Apr 2026 15:23:40 +0100
Date: Sun, 12 Apr 2026 15:23:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <aduq7Lvkfrz971Rb@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <266998d8-7e38-4bae-a4df-2f889538fe88@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <266998d8-7e38-4bae-a4df-2f889538fe88@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277804-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B7DC3E4432
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 04:01:59PM +0200, Maxime Chevallier wrote:
> Hi Russell,
> 
> On 10/04/2026 15:07, Russell King (Oracle) wrote:
> > Enable receive process stopped and receive buffer unavailable
> > interrupts, so that the statistic counters can be updated.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > Since we are seeing receive buffer exhaustion on several platforms,
> > let's enable the interrupts so the statistics we publish via ethtool -S
> > actually work to aid diagnosis. I've been in two minds about whether
> > to send this patch, but given the problems with stmmac at the moment,
> > I think it should be merged.
> 
> Looks like my reply to your original RFC was lost in limbo as the review/test tags are missing.

Thanks. Unfortunately, I can't run iperf3 against stmmac on the Jetson
NX because stmmac just totally screws itself (at the first RBU, the
receive side irrevocably collapses.)

Against i.MX6 (which is limited to around 480Mbps,) it's recoverable by
taking the interface down and back up a couple of times.

Against x86 (which will saturate the link) its pretty much
irrecoverable without entire system reboot - if one tries the down+up,
we then get arm-smmu errors because it seems that, despite stmmac being
reset, it still attempts to access a previous receive buffer from
before the down/up sometime after the up. Moreover, transmit stops
working - packets get queued but they are never processed by the
hardware. This is a scenario that I can only rarely test myself (as
it depends on my physical location.)

As the dwmac 5.0 core receive path seems to lock up after the first
RBU, I never see more than one of those at a time.

Right now, I consider this pretty much unsolvable - I've spent quite
some time looking at it and trying various approaches, nothing seems
to fix it. However, adding dma_rmb() in the descriptor cleanup/refill
paths does seem to improve the situation a little with the 480Mbps
case, because I think it means that we're reading the descriptors in
a more timely manner after the hardware has updated them.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

