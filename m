Return-Path: <netdev+bounces-278470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCGcMuNL3mkzqAkAu9opvQ
	(envelope-from <netdev+bounces-278470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:14:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C8F3FAF68
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 858FD305DFB0
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701EA3E717F;
	Tue, 14 Apr 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Xy8DegYU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911013D891
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176037; cv=none; b=aK0hf32g5j9ddtoCQcqKmKoC7fbNgprm/NxJlmzdkbGI7vC5fU/ahWNvAHI6noKHuixB+TzuHWJebxQ4uG2PWBfXGjEi25y860HLp4nIZifEHW2CV8nGFLViMzAxiZpVJeCh42VuR0bxnf+ieayTdYfVHWLDYX/j7TC58t7GDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176037; c=relaxed/simple;
	bh=WPOviA6HJqDPXnEosTB2SZiNPfvLepdNnxcVremXflM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgsmgVHh6hKDdt3aL5FT7/I7XoPZDnd2K/29M0vCVkzlpsn9ar8wib8ev9OZeeu/ec9HFs7CC7ky35GoDe/vH8X2Xq8iRRpyMCnDT9TirBx5C/LvupThNmqZ5keFRg1JBuoz2oXbJ/MyFFJ7QBs/5a805OMXF7kt1YnLE7HOzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Xy8DegYU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bsBaXpNwI9biepD5DuuX73+8/Sux5QohEO/bGIUXfks=; b=Xy8DegYUTGoivNy2SMfRiIu3lz
	o2+N8ZMt5+PVNEzTOFRDK0ZWBFJ2HQTsy0A9PKoqF0HnN7P5XtXhFPV2VEFtlok2bCx6FsJWjpnw4
	CS5h8uZXBq1F/jXFSA/VavRyFskuHTNA8WAH/VFJklN2FNa6EL+18rk89Jwma9CPtrQhBP8T6R4oX
	H2qF3BrwL/SwaGp9NbSPmsuisHKEvnF3TdfIU+ElcrYeIJsgPzJdUZoI1Pz5glJbyMkLyHCtyfeSY
	+o4B17PAkoR1VhiW7Ztk5mLRFsXoiuaq2gibSoktvueEdPw31FGIG4Z9PaM2mtVH1BEwD7GkUQplE
	KAQWW+0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39914)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wCeWO-0000000015i-302d;
	Tue, 14 Apr 2026 15:13:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wCeWL-000000001Gu-1VF4;
	Tue, 14 Apr 2026 15:13:41 +0100
Date: Tue, 14 Apr 2026 15:13:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <ad5LlXzeQ8j14Mjg@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <20260413110222.49fc3759@kernel.org>
 <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
 <CAH5Ym4i7VV53hQGY3AjAUW3B8g_ffgmw69kPhPrk2CmcRbguuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5Ym4i7VV53hQGY3AjAUW3B8g_ffgmw69kPhPrk2CmcRbguuQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278470-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.687];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49C8F3FAF68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sam,

Most of this email was written this morning, but I didn't have a chance
to finish nor send it due to how busy I am.

I had also written a separate reply last night with detailed results of
what I was seeing but didn't/haven't got around to sending it. Not
currently sure whether I saved it as draft or got rid of it yet.

On Mon, Apr 13, 2026 at 02:54:30PM -0700, Sam Edwards wrote:
> On Mon, Apr 13, 2026, 11:49 Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> >
> > On Mon, Apr 13, 2026 at 11:02:22AM -0700, Jakub Kicinski wrote:
> > > On Fri, 10 Apr 2026 14:07:51 +0100 Russell King (Oracle) wrote:
> > > > Since we are seeing receive buffer exhaustion on several platforms,
> > > > let's enable the interrupts so the statistics we publish via ethtool -S
> > > > actually work to aid diagnosis. I've been in two minds about whether
> > > > to send this patch, but given the problems with stmmac at the moment,
> > > > I think it should be merged.
> > >
> > > Sorry for a under-research response but wasn't there are person trying
> > > to fix the OOM starvation issue? Who was supposed to add a timer?
> > > Is your problem also OOM related or do you suspect something else?
> >
> > It is not OOM related. I have this patch applied:
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 131ea887bedc..614d0e10e3e6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5095,14 +5095,18 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
> >
> >                 if (!buf->page) {
> >                         buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
> > -                       if (!buf->page)
> > +                       if (!buf->page) {
> > +                               netdev_err(priv->dev, "q%u: no buffer 1\n", queue);
> >                                 break;
> > +                       }
> >                 }
> >
> >                 if (priv->sph_active && !buf->sec_page) {
> >                         buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
> > -                       if (!buf->sec_page)
> > +                       if (!buf->sec_page) {
> > +                               netdev_err(priv->dev, "q%u: no buffer 2\n", queue);
> >                                 break;
> > +                       }
> >
> >                         buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
> >                 }
> >
> > and it is silent, so we are not suffering starvation of buffers.
> >
> > However, the hardware hangs during iperf3, and because it triggers the
> > MAC to stream PAUSE frames, and my network uses Netgear GS108 and GS116
> > unmanaged switches that always use flow-control between them (there's no
> > way not to) it takes down the entire network - as we've discussed
> > before. So, this problem is pretty fatal to the *entire* network.
> >
> > With this patch, the existing statistical counters for this condition
> > are incremented, and thus users can use ethtool -S to see what happened
> > and report whether they are seeing the same issue.
> >
> > Without this patch applied, there are no diagnostics from stmmac that
> > report what the state is. ethtool -d doesn't list the appropriate
> > registers (as I suspect part of the problem is the number of queues
> > is somewhat dynamic - userspace can change that configuration through
> > ethtool).
> >
> > Thus, one has to resort to using devmem2 to find out what's happened.
> > That's not user friendly.
> >
> > For me, devmem2 shows:
> >
> > Channel 0 status register:
> > Value at address 0x02491160: 0x00000484
> > bit 10: ETI early transmit interrupt - set
> > bit 9 : RWT receive watchdog - clear
> > bit 8 : RPS receieve process stopped - clear
> > bit 7 : RBU receive buffer unavailable - set
> > bit 6 : RI  receive interrupt - clear
> > bit 2 : TBU transmit buffer unavailable - set
> > bit 1 : TPS transmit process stopped - clear
> > bit 0 : TI  transmit interrupt - clear
> 
> Should that reset trigger be RPS, not RBU? My understanding of these
> status bits is RBU is just "RxDMA has failed to take a frame from the
> RxFIFO" while RPS is "the RxFIFO is full." That would make RBU our
> critical threshold to start proactively refilling, and RPS the "too
> late, we lose" threshold.

That's a fine theory, but look at the channel 0 status register above,
noting that any interrupts that are raised but not enabled remain set.
RPS is not set, so RPS is not being raised, only RBU when this
condition occurs.

> Thinking aloud: Do you suppose the RxDMA waits for a wakeup signal
> sent whenever a frame is added to RxFIFO? That might explain why the
> former never recovers once the latter is full: a manual wakeup needs
> to be sent whenever we resolve RBU. Does the .enable_dma_reception()
> op need to be implemented for dwmac5, or have you tried that already?

I've not found anything in the closest documentation I have. The Xavier
is Synopsys IP v5.0, whereas i.MX8M is v5.1 - and v5.1 compared to
previous versions reads the same for statements concerning recovering
from a RBU condition:

"In ring mode, the application should advance the Receive Descriptor
Tail Pointer register of a channel. This bit is set only when the DMA
owns the previous Rx descriptor."

I've tried expanding what happens when RBU fires, dumping some of the
receive state and the receive ring:

[   55.766199] dwc-eth-dwmac 2490000.ethernet eth0: q0: receive buffer unavailable: cur_rx=309 dirty_rx=309 last_cur_rx=245 last_cur_rx_post=309 last_dirty_rx=245 count=64 budget=64

cur_rx == dirty_rx _should_ mean that we fully refilled the ring. These
are their values at the point the RBU interrupt fires.

last_cur_rx and last_dirty_rx are the values of cur_rx/dirty_rx when
stmmac_rx() was last entered.

last_cur_rx_post is the value of cur_rx when stmmac_rx() finished
looping but before we have refilled the ring.

count is the value of count just before stmmac_rx() returns, budget is
the limit at that point.

The patch that prints errors should we fail to allocate a buffer is in
place, none of those errors fire, so we are fully repopulating the ring
each time stmmac_rx() runs.

[   55.766785] RX descriptor ring:
[   55.766802] 000 [0x0000007fffffe000]: 0x0 0x12 0x0 0x340105ee
[   55.766826] 001 [0x0000007fffffe010]: 0x0 0x12 0x0 0x340105ee
[   55.766843] 002 [0x0000007fffffe020]: 0x0 0x12 0x0 0x340105ee
[   55.766860] 003 [0x0000007fffffe030]: 0x0 0x12 0x0 0x340105ee
...
[   55.772205] 308 [0x0000007ffffff340]: 0x0 0x12 0x0 0x340105ee
[   55.772221] 309 [0x0000007ffffff350]: 0x0 0x12 0x0 0x340105ee
[   55.772237] 310 [0x0000007ffffff360]: 0x0 0x12 0x0 0x340105ee
[   55.772253] 311 [0x0000007ffffff370]: 0x0 0x12 0x0 0x340105ee
[   55.772268] 312 [0x0000007ffffff380]: 0x0 0x12 0x0 0x340105ee
[   55.772284] 313 [0x0000007ffffff390]: 0x0 0x12 0x0 0x340105ee
[   55.772300] 314 [0x0000007ffffff3a0]: 0x0 0x12 0x0 0x340105ee
[   55.772315] 315 [0x0000007ffffff3b0]: 0x0 0x12 0x0 0x340105ee
...
[   55.775539] 511 [0x0000007ffffffff0]: 0x0 0x12 0x0 0x340105ee

Every ring entry contains the same RDES3 value, so it really is
completely full at the point RBU fires (bit 31 clear means software
owns the descriptor, and it's basically saying first/last segment,
RDES1 valid, buffer 1 length of 1518.

The Rx tail pointer register contains 0xfffff3a0 which is entry 314.
The current receive descriptor address is also 0xfffff3a0. Note that
these values were obtained some time after the RBU interrupt fired
(due to the time taken for devmem2 to access every stmmac register -
I have a script that dumps the entire stmmac register state via
devmem2.)

The other thing to note is that when looking at debugfs
stmmaceth/eth0/descriptor* (or whatever it's called, I don't have the
NX powered to look at the moment, and I didn't take a copy of it last
night) all tne descriptor entries are fully repopulated with buffers
and owned by the hardware.

I've tried using devmem2 to write to the rx tail pointer to kick it
back into action, but that changes nothing. I've tried writing the
next descriptor value and previous descriptor value, but that appears
to have no effect, it stedfastly remains stuck - and as that is the
documented recovery from RBU and there's no "receive demand" register
listed in dwmac v4 or v5 documentation, there seems to be no other
documented way.

The debug registers that I provided in my previous email suggest that
the MAC is waiting for a packet, and MTL's descriptor reader is idle
(I'm guessing it would only briefly change when the tail pointer is
updated.)

Note that I have augmented the driver with more dma_rmb() + dma_wmb()
in stmmac_rx(), dwmac4_wrback_get_rx_status(), and stmmac_rx_refill()
to ensure that reads and writes to the descriptor ring are correctly
ordered. While this generally allows iperf3 to run for a few more
seconds, it doesn't solve the problem - it is very rare for iperf3
to actually complete before stmmac has taken down my entire network.

I have noticed that on some occasions I see a small number of RBU
interrupts before it falls over.

I'm not going to have much time to look at this today due to further
appointments (I also didn't yesterday - only an hour in the morning
and a bit more time late in the evening/night.) I should have more
time during the rest of the week... but that may change.


From the above, it looks like NAPI/stmmac driver isn't keeping up with
the packet flow coming from an i.MX6 platform (which is limited to
around 470Mbps due to internal SoC bus limitations.)


I'll also mention that stmmac falls apart even more if I run iperf3 -c
-R against an x86 machine that is capable of saturating the network,
so much so that the arm-smmu IOMMU throws errors even after the stmmac
hardware has been soft-reset for addresses that were in the ring
*prior* to the soft-reset occuring (stmmac is soft-reset each time the
netdev is brought up.) The only recovery from that is to reboot -
down/up the interface just spews more IOMMU errors. I don't have the
details of that to hand and I don't have enough time to re-run that
test this morning. From what I remember, the transmit side also stops
processing descriptors (one can see them accumulate in the debugfs
file,) which eventually leads to the netdev watchdog firing.


It currently looks like the stmmac v5 EQoS IP works fine only under
light packet loads. If one puts any stress on it, then the hardware
totally falls apart. This may point to an issue with the AXI bus
configuration that is specific to this platform, but that requires
further investigation.

I'll mention again, in case anyone's forgotten, that these problems
pre-date any of my cleanups I've made to stmmac. From what I remember
they are reproducible with the kernels that are supplied as part of
the nVidia BSP. Again, as I don't have access to the nVidia platform
at the moment, I can't include the details in this email.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

