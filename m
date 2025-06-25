Return-Path: <netdev+bounces-200940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E4AE7652
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979E37AE376
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784681E1E12;
	Wed, 25 Jun 2025 05:07:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D554A04
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 05:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750828077; cv=none; b=tlbhT1C1Z8VUQ8fGCpSFRbYwnjJOHqPPZjnmdxUFLbK/JbXWtm7wCg3Cef0Z2r9jb0jA0mAPq9HBZLjmB7j6dpKK6IPFG8l6PjsDHKbV50ioEAARJdgVPdoVXDtMK7J/FAfbB9IaX2XfquATlNu18m0dXeM8KW2xe8s0zF4bIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750828077; c=relaxed/simple;
	bh=waXfcG5v0rXqRcCAzxpLXzM9P7vWSOedGgAQ0IRkqT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byFCk13YFjmfWRPdzpfX0RxsetUCI0OeJTlWjiqB3SJyuYicQeY/nLlZWwpoNbQyEQraFScQxktOr+ZIRWR34dPUHBkTNebMz5zlHgq/0te+czXVq1JqTwbg5QnuYA8diqRiHjyIvbeK+xTDaciGjInzAWEA+0laBNxdLbkABmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uUIMK-0003XV-KB; Wed, 25 Jun 2025 07:07:44 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUIMI-005EFQ-2d;
	Wed, 25 Jun 2025 07:07:42 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUIMI-00H3UX-2A;
	Wed, 25 Jun 2025 07:07:42 +0200
Date: Wed, 25 Jun 2025 07:07:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <aFuEHpbjGILWich1@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
 <20250516184510.2b84fab4@kernel.org>
 <aFU9o5F4RG3QVygb@pengutronix.de>
 <20250621064600.035b83b3@kernel.org>
 <aFk-Za778Bk38Dxn@pengutronix.de>
 <20250623101920.69d5c731@kernel.org>
 <aFphGj_57XnwyhW1@pengutronix.de>
 <20250624090953.1b6d28e6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624090953.1b6d28e6@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jun 24, 2025 at 09:09:53AM -0700, Jakub Kicinski wrote:
> On Tue, 24 Jun 2025 10:26:02 +0200 Oleksij Rempel wrote:
> > On Mon, Jun 23, 2025 at 10:19:20AM -0700, Jakub Kicinski wrote:
> > > On Mon, 23 Jun 2025 13:45:41 +0200 Oleksij Rempel wrote:  
> > > > On Sat, Jun 21, 2025 at 06:46:00AM -0700, Jakub Kicinski wrote:  
> > > > > On Fri, 20 Jun 2025 12:53:23 +0200 Oleksij Rempel wrote:  
> > > > > > Let me first describe the setup where this issue was observed and my findings.
> > > > > > The problem occurs on a system utilizing a Microchip DSA driver with an STMMAC
> > > > > > Ethernet controller attached to the CPU port.
> > > > > > 
> > > > > > In the current selftest implementation, the TCP checksum validation fails,
> > > > > > while the UDP test passes. The existing code prepares the skb for hardware
> > > > > > checksum offload by setting skb->ip_summed = CHECKSUM_PARTIAL. For TCP, it sets
> > > > > > the thdr->check field to the complement of the pseudo-header checksum, and for
> > > > > > UDP, it uses udp4_hwcsum. If I understand it correct, this configuration tells
> > > > > > the kernel that the hardware should perform the checksum calculation.
> > > > > > 
> > > > > > However, during testing, I noticed that "rx-checksumming" is enabled by default
> > > > > > on the CPU port, and this leads to the TCP test failure.  Only after disabling
> > > > > > "rx-checksumming" on the CPU port did the selftest pass. This suggests that the
> > > > > > issue is specifically related to the hardware checksum offload mechanism in
> > > > > > this particular setup. The behavior indicates that something on the path
> > > > > > recalculated the checksum incorrectly.    
> > > > > 
> > > > > Interesting, that sounds like the smoking gun. When rx-checksumming 
> > > > > is enabled the packet still reaches the stack right?    
> > > > 
> > > > No. It looks like this packets are just silently dropped, before they was
> > > > seen by the stack. The only counter which confirms presence of this
> > > > frames is HW specific mmc_rx_tcp_err. But it will be increasing even if
> > > > rx-checksumming is disabled and packets are forwarded to the stack.  
> > > 
> > > If you happen to have the docs for the STMMAC instantiation in the SoC
> > > it'd be good to check if discarding frames with bad csum can be
> > > disabled. Various monitoring systems will expect the L4 checksum errors
> > > to appear in nstat, not some obscure ethtool -S counter.  
> > 
> > Ack. I will it add to my todo.
> > 
> > For proper understanding of STMMAC and other drivers, here is how I currently
> > understand the expected behavior on the receive path, with some open questions:
> > 
> > Receive Path Checksum Scenarios
> > 
> > * No Hardware Verification
> >     * The hardware is not configured for RX checksum offload
> >       or does not support the packet type, passing the packet to the driver
> >       as-is.
> >     * Expected driver behavior: The driver should set the packet's state to
> >       `CHECKSUM_NONE`, signaling to the kernel that a software checksum
> >       validation is required.
> > 
> > * Hardware Verifies and Reports All Frames (Ideal Linux Behavior)
> >     * The hardware is configured not to drop packets with bad checksums.
> >       It verifies the checksum of each packet and reports the result (good
> >       or bad) in a status field on the DMA descriptor.
> >     * Expected driver behavior: The driver must read the status for every
> >       packet.
> >         * If the hardware reports the checksum is good, the driver should set
> >           the packet's state to `CHECKSUM_UNNECESSARY`.
> >         * If the hardware reports the checksum is bad, the driver should set
> >           the packet's state to `CHECKSUM_NONE` and still pass it to the
> >           kernel.
> >     * Open Questions:
> >         * When the hardware reports a bad checksum in this mode, should the
> >           driver increment `rx_crc_errors` immediately? Or should it only set
> >           the packet's state to `CHECKSUM_NONE` and let the kernel stack find
> >           the error and increment the counter, in order to avoid
> >           double-counting the same error?
> 
> Driver can increment its local counter. It doesn't matter much.
> 
> But one important distinction, we're talking about layer 3 and up
> checksums. IPv4 checksum, and TCP/UDP checksums. Those are not CRC.
> The HW _should_ discard packets with bad CRC / Layer 2 checksum
> unless the NETIF_F_RXALL feature is enabled.
> 
> > * Hardware Verifies and Drops on Error
> >     * The hardware's RX checksum engine is active and configured to
> >       automatically discard any packet with an incorrect checksum before it is
> >       delivered to the driver.
> >     * Open Questions:
> > 
> >         * When reporting these hardware-level drops, what is the most
> >           appropriate existing standard `net_device_stats` counter to use
> >           (e.g., `rx_crc_errors`, `rx_errors`)?
> 
> I'd say rx_errors, most likely to be noticed.
> 
> >         * If no existing standard counter is a good semantic fit, add new
> >           standard counters?
> 
> Given this is behavior we don't want to encourage I think adding a
> standard stat would send the wrong signal.
> 
> >         * If the "drop on error" feature cannot be disabled independently,
> >           and reporting the error via a standard counter is not feasible,
> >           does this imply that the entire RX checksum offload feature must be
> >           disabled to ensure error visibility?
> 
> Probably not, users should also monitor rx_errors.
> 
> > * Hardware Provides Full Packet Checksum (`CHECKSUM_COMPLETE`)
> >     * The hardware calculates a single checksum over the entire packet and
> >       provides this value to the driver, without needing to parse the
> >       L3/L4 headers.
> 
> Not entire, it skips the base Ethernet header (first 14 bytes)
> 
> >     * Expected driver behavior: The driver should place the checksum provided
> >       by the hardware into the `skb->csum` field and set the packet's state
> >       to `CHECKSUM_COMPLETE`.
> 
> Correct.

Hm... at least part of this behavior can be verified with self-tests:

- Send a TCP packet with an intentionally incorrect checksum,
  ensuring its state is CHECKSUM_NONE so the transmit path doesn't change it.
- Test if we receive this packet back via the PHY loopback.
   - If received: The test checks the ip_summed status of the
     received packet.
      - A status of CHECKSUM_NONE indicates the hardware correctly passed
        the packet up without validating it.
      - A status of CHECKSUM_UNNECESSARY indicates a failure, as the hardware
        or driver incorrectly marked a bad checksum as good.
   - If not received (after a timeout): The test then checks the device's
     error statistics.
      - If the rx_errors counter has incremented
      - If the counter has not incremented, the packet was lost for an unknown
        reason, and the test fails.

What do you think?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

