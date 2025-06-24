Return-Path: <netdev+bounces-200534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F5FAE5F18
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91253AA79C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D63C257AEE;
	Tue, 24 Jun 2025 08:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9615221739
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753590; cv=none; b=fnjRexsBg8S18isr89LlxRXxpjz2DkIt2FWMD146SF5KhkehBvuhZPvVzUOZy42F8RK1/qHYg0TaTqrMehxkhy5JMavjH2nku1DspnRqKj5aQ8l/1ZYX55Jos40KoUkr5FLxPDmLGJxGfHYFrmqPki6Rx93qfgXU/J18IDl5mC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753590; c=relaxed/simple;
	bh=IeWGG3hyAvbwB6tvfqkj8zEqSmmgUr88kLWUMzQ6I48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt76baC56O+s0/5arXMkH2dFS7bac4CXdMUk17hMBk2ZcqlBG0ECU6aFcp9ac9gkqj34t3i2cAVjbX0UK52jbF1BMx7pdQx6v+fr0Aby7jB8rlQOCk/n9ZfvB9nz2mLct8B5+2adr3zlRzlEL8Jpd9x+TAv+/oe9bg0q1hzgd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uTyyi-0000Bp-H9; Tue, 24 Jun 2025 10:26:04 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uTyyg-00559E-1m;
	Tue, 24 Jun 2025 10:26:02 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uTyyg-00F6ln-1M;
	Tue, 24 Jun 2025 10:26:02 +0200
Date: Tue, 24 Jun 2025 10:26:02 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <aFphGj_57XnwyhW1@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
 <20250516184510.2b84fab4@kernel.org>
 <aFU9o5F4RG3QVygb@pengutronix.de>
 <20250621064600.035b83b3@kernel.org>
 <aFk-Za778Bk38Dxn@pengutronix.de>
 <20250623101920.69d5c731@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623101920.69d5c731@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Jun 23, 2025 at 10:19:20AM -0700, Jakub Kicinski wrote:
> On Mon, 23 Jun 2025 13:45:41 +0200 Oleksij Rempel wrote:
> > On Sat, Jun 21, 2025 at 06:46:00AM -0700, Jakub Kicinski wrote:
> > > On Fri, 20 Jun 2025 12:53:23 +0200 Oleksij Rempel wrote:
> > > > Let me first describe the setup where this issue was observed and my findings.
> > > > The problem occurs on a system utilizing a Microchip DSA driver with an STMMAC
> > > > Ethernet controller attached to the CPU port.
> > > > 
> > > > In the current selftest implementation, the TCP checksum validation fails,
> > > > while the UDP test passes. The existing code prepares the skb for hardware
> > > > checksum offload by setting skb->ip_summed = CHECKSUM_PARTIAL. For TCP, it sets
> > > > the thdr->check field to the complement of the pseudo-header checksum, and for
> > > > UDP, it uses udp4_hwcsum. If I understand it correct, this configuration tells
> > > > the kernel that the hardware should perform the checksum calculation.
> > > > 
> > > > However, during testing, I noticed that "rx-checksumming" is enabled by default
> > > > on the CPU port, and this leads to the TCP test failure.  Only after disabling
> > > > "rx-checksumming" on the CPU port did the selftest pass. This suggests that the
> > > > issue is specifically related to the hardware checksum offload mechanism in
> > > > this particular setup. The behavior indicates that something on the path
> > > > recalculated the checksum incorrectly.  
> > > 
> > > Interesting, that sounds like the smoking gun. When rx-checksumming 
> > > is enabled the packet still reaches the stack right?  
> > 
> > No. It looks like this packets are just silently dropped, before they was
> > seen by the stack. The only counter which confirms presence of this
> > frames is HW specific mmc_rx_tcp_err. But it will be increasing even if
> > rx-checksumming is disabled and packets are forwarded to the stack.
> 
> If you happen to have the docs for the STMMAC instantiation in the SoC
> it'd be good to check if discarding frames with bad csum can be
> disabled. Various monitoring systems will expect the L4 checksum errors
> to appear in nstat, not some obscure ethtool -S counter.

Ack. I will it add to my todo.


For proper understanding of STMMAC and other drivers, here is how I currently
understand the expected behavior on the receive path, with some open questions:

Receive Path Checksum Scenarios

* No Hardware Verification
    * The hardware is not configured for RX checksum offload
      or does not support the packet type, passing the packet to the driver
      as-is.
    * Expected driver behavior: The driver should set the packet's state to
      `CHECKSUM_NONE`, signaling to the kernel that a software checksum
      validation is required.

* Hardware Verifies and Reports All Frames (Ideal Linux Behavior)
    * The hardware is configured not to drop packets with bad checksums.
      It verifies the checksum of each packet and reports the result (good
      or bad) in a status field on the DMA descriptor.
    * Expected driver behavior: The driver must read the status for every
      packet.
        * If the hardware reports the checksum is good, the driver should set
          the packet's state to `CHECKSUM_UNNECESSARY`.
        * If the hardware reports the checksum is bad, the driver should set
          the packet's state to `CHECKSUM_NONE` and still pass it to the
          kernel.
    * Open Questions:
        * When the hardware reports a bad checksum in this mode, should the
          driver increment `rx_crc_errors` immediately? Or should it only set
          the packet's state to `CHECKSUM_NONE` and let the kernel stack find
          the error and increment the counter, in order to avoid
          double-counting the same error?

* Hardware Verifies and Drops on Error
    * The hardware's RX checksum engine is active and configured to
      automatically discard any packet with an incorrect checksum before it is
      delivered to the driver.
    * Open Questions:

        * When reporting these hardware-level drops, what is the most
          appropriate existing standard `net_device_stats` counter to use
          (e.g., `rx_crc_errors`, `rx_errors`)?
        * If no existing standard counter is a good semantic fit, add new
          standard counters?
        * If the "drop on error" feature cannot be disabled independently,
          and reporting the error via a standard counter is not feasible,
          does this imply that the entire RX checksum offload feature must be
          disabled to ensure error visibility?

* Hardware Provides Full Packet Checksum (`CHECKSUM_COMPLETE`)
    * The hardware calculates a single checksum over the entire packet and
      provides this value to the driver, without needing to parse the
      L3/L4 headers.
    * Expected driver behavior: The driver should place the checksum provided
      by the hardware into the `skb->csum` field and set the packet's state
      to `CHECKSUM_COMPLETE`.

Anything I forgot?

> > > If so does the frame enter the stack with CHECKSUM_COMPLETE or
> > > UNNECESSARY?  
> > 
> > If rx-checksumming is enabled and packet has supported ethertype,
> > then CHECKSUM_UNNECESSARY will be set. Otherwise CHECKSUM_NONE.
> > 
> > > > When examining the loopbacked frames, I observed that the TCP checksum was
> > > > incorrect. Upon further investigation, the xmit helper in net/dsa/tag_ksz.c
> > > > includes the following:
> > > > 
> > > > if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
> > > >     return NULL;
> > > > 
> > > > I assume skb_checksum_help() is intended to calculate the proper checksum when
> > > > CHECKSUM_PARTIAL is set, indicating that the software should complete the
> > > > checksum before handing it to the hardware. My understanding is that the STMMAC
> > > > hardware then calculates the checksum for egress frames if CHECKSUM_PARTIAL is
> > > > used.  
> > > 
> > > stmmac shouldn't touch the frame, note that skb_checksum_help() sets
> > > skb->ip_summed = CHECKSUM_NONE; so the skb should no longer be considered
> > > for csum offload.  
> > 
> > It looks like skb_checksum_help(), which is used in tag_ksz.c, generates
> > a TCP checksum without accounting for the IP pseudo-header. The
> > resulting checksum is then incorrect and is filtered out by the STMMAC
> > HW on ingress
> 
> The pseudo-header csum is filled in net_test_get_skb(), where it calls
> tcp_v4_check(). But I think you're right, it's incorrect. Could you try:
> 
> diff --git a/net/core/selftests.c b/net/core/selftests.c
> index 35f807ea9952..1166dd1ddb07 100644
> --- a/net/core/selftests.c
> +++ b/net/core/selftests.c
> @@ -160,8 +160,10 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
>         skb->csum = 0;
>         skb->ip_summed = CHECKSUM_PARTIAL;
>         if (attr->tcp) {
> -               thdr->check = ~tcp_v4_check(skb->len, ihdr->saddr,
> -                                           ihdr->daddr, 0);
> +               int l4len;
> +
> +               l4len = skb->tail - skb_transport_header(skb);
> +               thdr->check = ~tcp_v4_check(l4len, ihdr->saddr, ihdr->daddr, 0);
>                 skb->csum_start = skb_transport_header(skb) - skb->head;
>                 skb->csum_offset = offsetof(struct tcphdr, check);
>         } else {
> 
> Or some such?

Ah, it works now!

So, for my understanding:
- does skb_checksum_help() rely on a precalculated and integrated
  pseudo-header csum?
- And is this how typical HW-accelerated checksumming works?
- Is this why it is called CHECKSUM_PARTIAL, because only one part of the
  checksum is pre-calculated?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

