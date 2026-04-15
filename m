Return-Path: <netdev+bounces-278863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMQKJ/Po32kNaQAAu9opvQ
	(envelope-from <netdev+bounces-278863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 21:37:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB79407678
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 21:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89D24307A2A5
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8730C618;
	Wed, 15 Apr 2026 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nTXNzDNZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DB1552FD
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776281841; cv=none; b=jFIo+HiJq6y4XKAzqnNWTOOkK3sRos9pZtB4dK/357kIBCgql/1JBCr0CAaf+aGZ7vw3e0wUwcr1cCno0lyGik/WK00uqphrBsYQWrw0M+ZhI6rgO2OtNwsb4qpmkcYnNveln+bLAaVBeITeQyAvQX63P3vpQx9JpuPbQZMexxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776281841; c=relaxed/simple;
	bh=3gPRrIdN0UvwOJPgBX5OV97Z7ZHOEPaY3ABJezFy3iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZUF5jtd2d0SRMMgsSYFETu/39F5TTIq+YlU5CyIs75QDYl0WTK0pYrqCaW32ZuWQHL9jPG08tt7NcNNzAInewbJtjiYTrvAB8lNjRVianskkJQZODv5rhaARS284Y4NAGqMtKcoatVGcL3hB7tqDBNUtyQaqeNlSyXKKaJPTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nTXNzDNZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=viRXQtxeBKpI0EkGaS8qTA342mbqqDTJOZSG74686rI=; b=nTXNzDNZWJKpe+cgsUONE7k1Ay
	GXwieD0e6klzbadXdIzM5BVMIpwA0eJE5m3ejACrkF98lc5ZVlQItspJrAwRWcrAu2oVC8jWPIdtQ
	eeS3P7f5I8BDL7NnO8dT2enzGFIsP+Q6CBL+pKC9Y3E4+I2+WZpVk5LdBboaug675s3GDtwNqNcoU
	/+Di75u4hK5UyoI4LUXpnQLYLxZnzGeXyJCiMjstFB9qep0Z2BaDIhF6Eag6Wz8Mwwughpj4HQaYb
	7vBsoh+BSQ8wVwQykD8/ZW3DdFKQALQI3euQxmZeFEd5pLzqwp/sE+3J0GyTQHDhOhlsaHSS/1ubw
	1IrWsNWg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35866)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wD62v-000000002Rn-2o8T;
	Wed, 15 Apr 2026 20:37:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wD62r-000000002UH-1hC5;
	Wed, 15 Apr 2026 20:37:05 +0100
Date: Wed, 15 Apr 2026 20:37:05 +0100
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
Message-ID: <ad_o4aDP0UBY_8i4@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <20260413110222.49fc3759@kernel.org>
 <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
 <CAH5Ym4i7VV53hQGY3AjAUW3B8g_ffgmw69kPhPrk2CmcRbguuQ@mail.gmail.com>
 <ad5LlXzeQ8j14Mjg@shell.armlinux.org.uk>
 <ad7nsUQvksJF7JFK@shell.armlinux.org.uk>
 <CAH5Ym4jA8w9=UxMT4vKJpnXkuDHtkFtMcg4u2sy_0S+8wgy-9w@mail.gmail.com>
 <ad-ID2WaPgPJqdsa@shell.armlinux.org.uk>
 <CAH5Ym4jKdzDeYwCfkMLmUz0FsiD2vFwfuAvqFE=uvMtPmakeMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5Ym4jKdzDeYwCfkMLmUz0FsiD2vFwfuAvqFE=uvMtPmakeMQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278863-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.676];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAB79407678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 10:38:29AM -0700, Sam Edwards wrote:
> On Wed, Apr 15, 2026 at 5:44 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Apr 14, 2026 at 07:12:34PM -0700, Sam Edwards wrote:
> > > On Tue, Apr 14, 2026 at 6:19 PM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > > Okay, just a quick note to say that nvidia's 5.10.216-tegra kernel
> > > > survives iperf3 -c -R to the imx6.
> > >
> > > Hi Russell,
> > >
> > > Aw, you beat me to it! I was about to report that 5.10.104-tegra is
> > > unaffected. And my iperf3 server is a multi-GbE amd64 machine.
> > >
> > > > Dumping the registers and comparing, and then forcing the RQS and TQS
> > > > values to 0x23 (+1 = 36, *256 = 9216 bytes) and 0x8f (+1 = 144,
> > > > *256 = 36864 ytes) respectively seems to solve the problem. Under
> > > > net-next, these both end up being 0xff (+1 = 256, *256 = 65536 bytes.)
> > > > Suspiciously, 36 * 4 = 144, and I also see that this kernel programs
> > > > all four of the MTL receive operation mode registers, but only the
> > > > first MTL transmit operation mode register. However, DMA channels 1-3
> > > > aren't initialised.
> > >
> > > Wow, great! I wonder if the problem is that the MTL FIFOs are smaller
> > > than that, so when the DMA suffers a momentary hiccup, the FIFOs are
> > > allowed to overflow, putting the hardware in a bad state.
> > >
> > > Though I suspect this is only half of the problem: do you still see
> > > RBUs? Everything you've shared so far suggests the DMA failures are
> > > _not_ because the rx ring is drying up.
> >
> > Yes. Note that RBUs will happen not because of DMA failures, but if
> > the kernel fails to keep up with the packet rate. RBU means "we read
> > the next descriptor, and it wasn't owned by hardware".
> 
> Are you speaking from observation, documentation, or understanding?

Observation.

> I'd define RBU the same way, but you reported:

It's not a question about how I define RBU - this is defined by Synopsys
and I'm using it *exactly* that way as stated in the documentation.

"This bit indicates that the host owns the Next Descriptor in the
Receive List and the DMA cannot acquire it. The Receive Process is
suspended. ... This bit is set only when the previous Receive
Descriptor is owned by the DMA."

In other words, DMA has processed the previous receive descriptor which
_was_ owned by the hardware, written back to clear the OWN bit, and
then fetches the next descriptor and finds that the OWN bit is also
clear.

> 
> ```
> [   55.766199] dwc-eth-dwmac 2490000.ethernet eth0: q0: receive buffer
> unavailable: cur_rx=309 dirty_rx=309 last_cur_rx=245
> last_cur_rx_post=309 last_dirty_rx=245 count=64 budget=64
> 
> cur_rx == dirty_rx _should_ mean that we fully refilled the ring. [...]
> [...]
> Every ring entry contains the same RDES3 value, so it really is
> completely full at the point RBU fires (bit 31 clear means software
> owns the descriptor, and it's basically saying first/last segment,
> RDES1 valid, buffer 1 length of 1518.
> ```

Right, because the _last_ time stmmac_rx() was called, the ring was
completely refilled (as it always is for me).

There are two scenarios that what I'm seeing may happen.

1) The ring was fully refilled, but before stmmac_rx() is next
   executed, all descriptors end up being consumed due to the rate
   at which packets are being received. Thus, the hardware encounters
   a descriptor that has OWN=0

2) The kernel has been slow to respond to packets that have been
   received, and because of the NAPI throttling stmmac_rx() to only
   process 64 descriptors at a time, we are falling way behind the
   hardware position. Eventually, the hardware catches up with
   the point at which stmmac_rx_refill() is repopulating the receive
   descriptors, and encounters a descriptor that has OWN=0.

For (2), for example, let's take the example which you've quoted from
me.

stmmac_rx() gets called, and cur_rx = dirty_rx = 245. We're limited to
a count of 64 meaning we're not going to process more than 64 entries
no matter how far ahead the hardware is. Let's say the hardware is at
e.g. descriptor 400 at this point.

stmmac_rx() runs, processing descriptors. It works its way up to entry
309, at which point count == limit, so it stops, and we now have
cur_rx = 309, dirty_rx = 245.

The next thing stmmac_rx() does is call stmmac_rx_refill(). This looks
at the difference, and calculates how many entries need to be
repopulated. stmmac_rx_dirty() returns 64, as that's the number of
entries between dirty_rx and the updated cur_rx. It populates those
entries.

At this point, dirty_rx = 309. All well and good. However, during that
process, packet reception hasn't stopped, and let's say it's now at
descriptor 500.

In that scenario, we're consuming 100 descriptors, but only repopulating
64 descriptors. As this continues, the hardware is slowly catching up
with point in the ring that stmmac_rx_refill() is repopulating the
descriptors.

When it does catch up, it will encounter a descriptor with OWN=0, which
will fire the RBU interrupt.

At this point, my debug dumps the state of the ring. If the RBU was
raised when stmmac_rx()/stmmac_rx_refill() was not running, _and_ we
are always successfully refilling all the entries that stmmac_rx()
processed, then cur_rx will equal dirty_rx, even when the hardware
could be way ahead of cur_rx. Neither of these indexes have any
relevance to where the hardware actually is in the ring.

The dump of the ring state *clearly* shows that all descriptors have
a RDES3 value which indicates that every single descriptor is not
hardware owned at this point (since RBU has been raised, the receive
process is suspended, so hardware is no longer changing the ring.)

> It would seem* that the kernel isn't really failing to keep up with
> the packet rate. If RBU is firing with a ring that's not even close to
> empty, that tells me there's another way for it to fire. So I suspect
> the hardware designers implemented it to mean:
> "We couldn't read the next descriptor, _or_ it wasn't owned by hardware."
> 
> (* However, if bit 31 is clear everywhere, wouldn't that mean the ring
> is actually completely depleted, not full? If count==budget, wouldn't
> that mean the whole ring hasn't been visited, so we only refilled 64
> entries and not necessarily the entire ring? Maybe the kernel isn't
> keeping up after all.)

Ah, I think that's where our terminology differs.

You seem to define full as "populated with empty buffers". I define
full to mean "the hardware has filled every buffer with a packet that
it has received and handed it over to software to process." Note even
the terminology there - filling buffers with data. That ultimately
ends up filling the ring, and when completely filled, it is full.

I think of buffers like buckets. If a buffer contains no data, it
is empty. If a buffer contains data, it has been filled or is full.
Apply that to a list of buffers and you get the same thing. Many
ethernet driver documentation uses this same terminology, so I
thought it would be widely understood.

> > That has:
> >
> >         const nveu32_t rx_fifo_sz[2U][OSI_EQOS_MAX_NUM_QUEUES] = {
> >                 { FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U),
> >                   FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U) },
> >                 { FIFO_SZ(36U), FIFO_SZ(2U), FIFO_SZ(2U), FIFO_SZ(2U),
> >                   FIFO_SZ(2U), FIFO_SZ(2U), FIFO_SZ(2U), FIFO_SZ(16U) },
> >         };
> >         const nveu32_t tx_fifo_sz[2U][OSI_EQOS_MAX_NUM_QUEUES] = {
> >                 { FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U),
> >                   FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U) },
> >                 { FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U),
> >                   FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U) },
> >         };
> >
> > where each of those values is the RQS/TQS value to use in KiB:
> >
> > #define FIFO_SZ(x)              ((((x) * 1024U) / 256U) - 1U)
> >
> > This doesn't correspond with the values I'm seeing programmed into
> > the hardware under the 5.10.216-tegra kernel. I'm seeing TQS = 143
> > (36KiB), and RQS = 35 (9KiB). Yes, these values exist in the tables
> > above from a quick look, but they're not in the right place!
> 
> True, but:
> a) I doubt 5.10.216-tegra includes exactly the same version of the
> driver found in this random GitHub mirror. (My intent was only to
> point out that they don't use 5.10's stmmac; I should have been more
> clear that I wasn't trying to link the same version, sorry!)
> b) This is vendor code; I don't know how good their testing/review
> process is. It might not run the way it looks. The intent seems to be
> for RQS > TQS (which makes intuitive sense), but as you're seeing the
> registers programmed the other way 'round, they might have gotten them
> subtly mixed up.
> 
> > Now, as for FIFO sizes, if we sum up all the entries, then we
> > get:
> >
> > SUM(rx_fifo_size[0][]) = 60KiB
> > SUM(rx_fifo_size[1][]) = 64KiB
> > SUM(tx_fifo_size[0][]) = 60KiB
> > SUM(tx_fifo_size[1][]) = 64KiB
> 
> I follow the math with 64KiB, but surely the 60KiB should be
> 9+9+9+9+1+1+1+1=40KiB? This seems to me that the "legacy EQOS" simply
> shifts with smaller FIFOs. Since dwmac is licensed as a soft IP core,
> perhaps the FIFO size is an elaboration parameter? That would mean
> this isn't an issue with dwmac 5.0 broadly, but with Nvidia's specific
> instantiation of it.

Right, 40KiB. Sorry, I'm getting interrupted almost constantly while
trying to do anything.

However, I've tested with 0x7f in both fields, and it still falls flat
on its face. I've also tried other values, but because I had to unplug
the laptop from the nvidia board to use the laptop portably due to the
medical emergency situation, that caused screen to quit, so I've lost
all that. Chaos reigns supreme here :/

So, I'm not sure we understand what's going on - I don't think it's that
the FIFOs are smaller than specified. I suspect that the 9KiB vs 36KiB
results in some kind of throttling that prevents the condition which
hangs the hardware.

I'm not getting as much time as I'd like to really test out scenarios
due to everything that is going on, and honestly I feel like just
writing this week off now and giving up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

