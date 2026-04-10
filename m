Return-Path: <netdev+bounces-277411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IPkHFTz2GlJkAgAu9opvQ
	(envelope-from <netdev+bounces-277411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 14:55:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 720493D7C19
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 600CB3099427
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AF03C1978;
	Fri, 10 Apr 2026 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U0tX3hmj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6FB3C279D;
	Fri, 10 Apr 2026 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823817; cv=none; b=f1U2NxAwQdyGovRVKffwlMDhcfmOYwW1IxLzr5DKD/BW5jkAOzSmFJkt2uIDfX76EYrHOZ7/hf4xhhaMiGBhKtU6iaBJ4+2QANXjtf6otxlOCFqov5yh7uzfxCUrLxW1a0QgBGE7Y23Vfswcjp8adEPdupiIkjGd8oeBFjL0IRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823817; c=relaxed/simple;
	bh=ltLzBEZEW26oWyLyUNLdn7qogj3c9kMCHGbOHYB4BEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKgMWeMn6PKbXtC35Ra+eyP0qWWRIWx8DmQBVaWsDcH8gA2/A2zuaopd7oxGf73J6PS9Cqdjy0M4HYLNOw73OFpLKAo3A9/02ULu6eRgw4Kr5nIr2INC07i/jC/MRGKjNeTYq+wLbFl0usUnuhY1YkGJk4u2TXOP/ct+oQqjuik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U0tX3hmj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VvvpJ/qL3MAP3HugIiBTVzG72IPcnHfG1iqnkHNtFTQ=; b=U0tX3hmjJcm8tsXTtdEAC8/h1W
	LON04cNtMGN8ZEK5ppHySEkXKvnn92S3XIVyNP8bh0+prT160P9lajYz9nNr8GP8yRL0I4fafk5PN
	KLYE90UPlcZ+rAW09ET5aYUFiMcrf2ESf2opJ6EHeZR7tvkvUdkZBuy4wz616K+HvIg5cSYnIMXQn
	gV4s34DVxbYM+8GjhifF6nnLLBlsYESvPpqIzHE0OGETx49mCX1fLnsuBVrvHliHlozGUAG9p5iWU
	yGoT4MXjdD9iuGw9ng9OZEZUktWdzOkiOVDGVEWRZugPHSXmgRE4pR4a+MTa5RaFtrbsII9YxQee2
	mRZSapog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52432)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wBAtN-000000004xu-3ZEF;
	Fri, 10 Apr 2026 13:23:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wBAtJ-000000005cT-2CP5;
	Fri, 10 Apr 2026 13:23:17 +0100
Date: Fri, 10 Apr 2026 13:23:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/2] stmmac crash/stall fixes when under memory
 pressure
Message-ID: <adjrtRSepmac2hpN@shell.armlinux.org.uk>
References: <20260401041929.12392-1-CFSworks@gmail.com>
 <ac6kfQ98Xjt3dCGj@shell.armlinux.org.uk>
 <CAH5Ym4g3pbU_bWzMwJMdhEFv4K2sp3pty3g04=0=9Z80_LzW1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5Ym4g3pbU_bWzMwJMdhEFv4K2sp3pty3g04=0=9Z80_LzW1w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277411-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.425];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 720493D7C19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 10:39:32AM -0700, Sam Edwards wrote:
> On Thu, Apr 2, 2026 at 10:16 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > I've tested this on my Jetson Xavier platform. One of the issues I've
> > had is that running iperf3 results in the receive side stalling because
> > it runs out of descriptors. However, despite the receive ring
> > eventually being re-filled and the hardware appropriately prodded, it
> > steadfastly refuses to restart, despite the descriptors having been
> > updated.
> 
> Hi Russell,
> 
> Just to make sure I understand correctly: before my patches, you've
> been observing this problem on Xavier for a while (no interrupts, ring
> goes dry); with my patches, the ring is refilled, but the dwmac5
> doesn't resume DMA. (Ah, just saw your follow-up email.)
> 
> > Any ideas?
> 
> Off the top of my head, my hypothesis is that dwmac5 has an additional
> tripwire when the receive DMA is exhausted, and the
> stmmac_set_rx_tail_ptr()/stmmac_enable_dma_reception() at the end of
> stmmac_rx_refill() aren't sufficient to wake it back up.
> 
> I think this is new to dwmac5, because my RK3588 (dwmac4.20 iirc)
> happily resumes after the same condition.
> 
> You gave a lot of info; thanks! I'll try to scrape up some
> documentation on dwmac5 to see if there's something more
> stmmac_rx_refill() ought to be doing. I think I have a Xavier NX
> around here somewhere, I'll see if I can repro the problem.

I've added dma_rmb() into dwmac4_wrback_get_tx_status() and
dwmac4_wrback_get_rx_status(), and with that I've had an iperf3
instance finally complete... but only once:

root@tegra-ubuntu:~# iperf3 -c 192.168.248.1 -R
Connecting to host 192.168.248.1, port 5201
Reverse mode, remote host 192.168.248.1 is sending
[  5] local 192.168.248.174 port 42232 connected to 192.168.248.1 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  50.8 MBytes   426 Mbits/sec
[  5]   1.00-2.00   sec  54.9 MBytes   460 Mbits/sec
[  5]   2.00-3.00   sec  54.0 MBytes   453 Mbits/sec
[  5]   3.00-4.00   sec  53.8 MBytes   452 Mbits/sec
[  5]   4.00-5.00   sec  52.4 MBytes   438 Mbits/sec
[  5]   5.00-6.00   sec  54.3 MBytes   455 Mbits/sec
[  5]   6.00-7.00   sec  53.7 MBytes   452 Mbits/sec
[  5]   7.00-8.00   sec  52.8 MBytes   443 Mbits/sec
[  5]   8.00-9.00   sec  53.7 MBytes   451 Mbits/sec
[  5]   9.00-10.00  sec  54.3 MBytes   455 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.01  sec   537 MBytes   450 Mbits/sec   13             sender
[  5]   0.00-10.00  sec   535 MBytes   448 Mbits/sec                  receiver

iperf Done.

So, it seems better, but not completely solved.

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 2994df41ec2c..119f31c94b61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -17,10 +17,12 @@ static int dwmac4_wrback_get_tx_status(struct stmmac_extra_stats *x,
 				       struct dma_desc *p,
 				       void __iomem *ioaddr)
 {
-	u32 tdes3 = le32_to_cpu(p->des3);
+	u32 tdes3;
 	int ret = tx_done;
 
 	/* Get tx owner first */
+	dma_rmb();
+	tdes3 = le32_to_cpu(p->des3);
 	if (unlikely(tdes3 & TDES3_OWN))
 		return tx_dma_own;
 
@@ -70,12 +72,12 @@ static int dwmac4_wrback_get_tx_status(struct stmmac_extra_stats *x,
 static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
 				       struct dma_desc *p)
 {
-	u32 rdes1 = le32_to_cpu(p->des1);
-	u32 rdes2 = le32_to_cpu(p->des2);
-	u32 rdes3 = le32_to_cpu(p->des3);
+	u32 rdes1, rdes2, rdes3;
 	int message_type;
 	int ret = good_frame;
 
+	dma_rmb();
+	rdes3 = le32_to_cpu(p->des3);
 	if (unlikely(rdes3 & RDES3_OWN))
 		return dma_own;
 
@@ -107,6 +109,7 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
 
 	message_type = FIELD_GET(RDES1_PTP_MSG_TYPE_MASK, rdes1);
 
+	rdes1 = le32_to_cpu(p->des1);
 	if (rdes1 & RDES1_IP_HDR_ERROR) {
 		x->ip_hdr_err++;
 		ret |= csum_none;
@@ -152,6 +155,7 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
 	if (rdes1 & RDES1_TIMESTAMP_DROPPED)
 		x->timestamp_dropped++;
 
+	rdes2 = le32_to_cpu(p->des2);
 	if (unlikely(rdes2 & RDES2_SA_FILTER_FAIL)) {
 		x->sa_rx_filter_fail++;
 		ret = discard_frame;

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

