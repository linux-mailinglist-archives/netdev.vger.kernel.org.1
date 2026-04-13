Return-Path: <netdev+bounces-278182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGu5NUE73Wk3awkAu9opvQ
	(envelope-from <netdev+bounces-278182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:51:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D723F242A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3111301258E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317C38C40A;
	Mon, 13 Apr 2026 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AGyOB4mg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89D23EAB2
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106204; cv=none; b=nhZC1g7ROuYIEPkDRfO7HNrF9T6B7sKWH+kCfB/+APMxHkTkEp3elQkPo0IMwtY6GCP83mPGRGJit38Mbiw7cvkvK37YPH9MnI6qebfXjPSruXJ8QRawoPj307x2INxqlY7vE8zV22iyuw5X3C8OOosXw24Phs4XmIxk9dzxVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106204; c=relaxed/simple;
	bh=c2m6X7DshEPqy/aQ1yGgZ+TnunbUxe5Jgaihcimsa6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7AlsvvcbFzVDzsOkTDJ4AkjsG4jOmWZEYTewFeHuBnL/2wHSkPPuvGQALYOzQOXF1hsLG+mf76xB2/XHu1Nm2IgDUXkXWhl/vSzcJyyoEo68sElfP56+ykE7/0xhFiq4cjboz++hbWkJDonefKI7MRdLac6e4YVHeeLDNhI4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AGyOB4mg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7/4Rz38FYHztW6Uw1aNeN0nYjBCQSBspRwjLSoc/tsM=; b=AGyOB4mgu+d1VyICZUwGFZYT7Y
	K5ED2R/bZWOpa+WMGx1kypTsJun3aoDxwDmxuspMMi8EcrLx1zd1lR8YLlhb6vKyT0RW5WvpZKuYq
	cxURkcwXpCCLK6PzcmdaXdvjY/fnwnH6ieYN/E/WxIgSs3Exs3lizWZqArxy6t4V4LSnl7kvTLdPi
	NKPNRBKpUga6LGv9FxnneG2EIS6+HJjFwAgo8/2b0g9npPpfKIpu8RmkZ8uMhMciskcsRToRnu9Wz
	iV7yFrXKyKrG90eT1uK1AjJuoACzDOrH/29hAbh8zTS44fWhJtdDYIe1zAkCWmVTUzk3GCYry9qXn
	0LkeLXpw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51338)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wCMM1-000000000Bu-2Naq;
	Mon, 13 Apr 2026 19:49:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wCMLy-000000000RD-22Jt;
	Mon, 13 Apr 2026 19:49:46 +0100
Date: Mon, 13 Apr 2026 19:49:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <20260413110222.49fc3759@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413110222.49fc3759@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,foss.st.com,davemloft.net,google.com,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-278182-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.222];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: D0D723F242A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 11:02:22AM -0700, Jakub Kicinski wrote:
> On Fri, 10 Apr 2026 14:07:51 +0100 Russell King (Oracle) wrote:
> > Since we are seeing receive buffer exhaustion on several platforms,
> > let's enable the interrupts so the statistics we publish via ethtool -S
> > actually work to aid diagnosis. I've been in two minds about whether
> > to send this patch, but given the problems with stmmac at the moment,
> > I think it should be merged.
> 
> Sorry for a under-research response but wasn't there are person trying
> to fix the OOM starvation issue? Who was supposed to add a timer?
> Is your problem also OOM related or do you suspect something else?

It is not OOM related. I have this patch applied:

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 131ea887bedc..614d0e10e3e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5095,14 +5095,18 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 
 		if (!buf->page) {
 			buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
-			if (!buf->page)
+			if (!buf->page) {
+				netdev_err(priv->dev, "q%u: no buffer 1\n", queue);
 				break;
+			}
 		}
 
 		if (priv->sph_active && !buf->sec_page) {
 			buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
-			if (!buf->sec_page)
+			if (!buf->sec_page) {
+				netdev_err(priv->dev, "q%u: no buffer 2\n", queue);
 				break;
+			}
 
 			buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
 		}

and it is silent, so we are not suffering starvation of buffers.

However, the hardware hangs during iperf3, and because it triggers the
MAC to stream PAUSE frames, and my network uses Netgear GS108 and GS116
unmanaged switches that always use flow-control between them (there's no
way not to) it takes down the entire network - as we've discussed
before. So, this problem is pretty fatal to the *entire* network.

With this patch, the existing statistical counters for this condition
are incremented, and thus users can use ethtool -S to see what happened
and report whether they are seeing the same issue.

Without this patch applied, there are no diagnostics from stmmac that
report what the state is. ethtool -d doesn't list the appropriate
registers (as I suspect part of the problem is the number of queues
is somewhat dynamic - userspace can change that configuration through
ethtool).

Thus, one has to resort to using devmem2 to find out what's happened.
That's not user friendly.

For me, devmem2 shows:

Channel 0 status register:
Value at address 0x02491160: 0x00000484
bit 10: ETI early transmit interrupt - set
bit 9 : RWT receive watchdog - clear
bit 8 : RPS receieve process stopped - clear
bit 7 : RBU receive buffer unavailable - set
bit 6 : RI  receive interrupt - clear
bit 2 : TBU transmit buffer unavailable - set
bit 1 : TPS transmit process stopped - clear
bit 0 : TI  transmit interrupt - clear

Debug status register:
Value at address 0x0249100c: 0x00006300
TPS[3:0] = 6 = Suspended, Tx descriptor unavailable or Tx buffer
		underflow
RPS[3:0] = 3 = Running, waiting for Rx packet

Metal Queue 0 debug register:
Value at address 0x02490d38: 0x002e0020
PRXQ[13:0] = 0x2e = 46 packets in receive queue
RXQSTS[1:0] = 2 = Rx queue fill-level above flow-control activate
		threshold
RRCSTS[1:0] = 0 = Rx Queue Read Controller State = Idle

> Firing interrupts when Rx fill ring runs dry (which IIUC this patches
> dies?) is not a good idea.

Well, I'm thinking that at least on some platforms, such as the Jetson
Xavier NX, unless a different solution can be found, we need the RBU
interrupt to fire off a reset of the stmmac IP when this happens to
reduce the PAUSE frame flood on the network.

If we can't do that, then I think stmmac on these platforms needs to be
marked with CONFIG_BROKEN because right now there doesn't seem to be any
other viable solution.

My intention with this patch is merely to start collecting the already
existing statistics so other users can start seeing whether they are
hitting the same or similar problem. If we're not prepared to do that,
then we should delete the useless statistics from ethtool -S, but I
suspect they're now part of the UAPI, even though without this patch
they will remain stedfastly stuck at zero.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

