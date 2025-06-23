Return-Path: <netdev+bounces-200255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44F9AE3E64
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 13:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035D81895C1F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E8C244661;
	Mon, 23 Jun 2025 11:45:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD723C4E1
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679154; cv=none; b=RGePUN8BWcdTW4MCuWI4oV4pnsYHYD1gzrtpsJdQDoZN6wqvJBzfede4xgMoAqEpYiNe+L6j2Rxwk/tjm4bUj6UtZ1VOAUPRzsRZT45JzCyxADfnLR2fbbHhMT6ORDJTHSc3J5fAbFesZ+UoKNUWIh33eaStVLqv4P5z9Gfr/qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679154; c=relaxed/simple;
	bh=PB88Ag1tjLpD37sBATIJiag40Vpg4EuIEynBTyK6h0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwcKlRgXiCgxBEQMR22U6riFQB9S1YnyhVdK4B9K/YPliCGzsm7Rce8OJooBZt9d+qyVMdDKyD2lJ9Qr4TI1K0W6ldzB8KhoRehKDou6O+1XlcFnoeH81ud5DK8TboMv1gvOjLw1/NtqChHc5aseDLDLPsjz3x9cc+5PWG5Elp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uTfcM-0001fr-JD; Mon, 23 Jun 2025 13:45:42 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uTfcL-004wOX-0Y;
	Mon, 23 Jun 2025 13:45:41 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uTfcL-00DBQG-07;
	Mon, 23 Jun 2025 13:45:41 +0200
Date: Mon, 23 Jun 2025 13:45:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <aFk-Za778Bk38Dxn@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
 <20250516184510.2b84fab4@kernel.org>
 <aFU9o5F4RG3QVygb@pengutronix.de>
 <20250621064600.035b83b3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250621064600.035b83b3@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Jun 21, 2025 at 06:46:00AM -0700, Jakub Kicinski wrote:
> On Fri, 20 Jun 2025 12:53:23 +0200 Oleksij Rempel wrote:
> > > What device are you talking about? How is this a problem with 
> > > the selftest and not with the stack? If the test is flaky I'd 
> > > think real traffic will suffer too. We pass these selftest packets
> > > thru xmit validation AFAICT, so the stack should compute checksum
> > > for the if the device can't.
> > >   
> > 
> > Let me first describe the setup where this issue was observed and my findings.
> > The problem occurs on a system utilizing a Microchip DSA driver with an STMMAC
> > Ethernet controller attached to the CPU port.
> > 
> > In the current selftest implementation, the TCP checksum validation fails,
> > while the UDP test passes. The existing code prepares the skb for hardware
> > checksum offload by setting skb->ip_summed = CHECKSUM_PARTIAL. For TCP, it sets
> > the thdr->check field to the complement of the pseudo-header checksum, and for
> > UDP, it uses udp4_hwcsum. If I understand it correct, this configuration tells
> > the kernel that the hardware should perform the checksum calculation.
> > 
> > However, during testing, I noticed that "rx-checksumming" is enabled by default
> > on the CPU port, and this leads to the TCP test failure.  Only after disabling
> > "rx-checksumming" on the CPU port did the selftest pass. This suggests that the
> > issue is specifically related to the hardware checksum offload mechanism in
> > this particular setup. The behavior indicates that something on the path
> > recalculated the checksum incorrectly.
> 
> Interesting, that sounds like the smoking gun. When rx-checksumming 
> is enabled the packet still reaches the stack right?

No. It looks like this packets are just silently dropped, before they was
seen by the stack. The only counter which confirms presence of this
frames is HW specific mmc_rx_tcp_err. But it will be increasing even if
rx-checksumming is disabled and packets are forwarded to the stack.

> If so does the frame enter the stack with CHECKSUM_COMPLETE or
> UNNECESSARY?

If rx-checksumming is enabled and packet has supported ethertype,
then CHECKSUM_UNNECESSARY will be set. Otherwise CHECKSUM_NONE.

> > When examining the loopbacked frames, I observed that the TCP checksum was
> > incorrect. Upon further investigation, the xmit helper in net/dsa/tag_ksz.c
> > includes the following:
> > 
> > if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
> >     return NULL;
> > 
> > I assume skb_checksum_help() is intended to calculate the proper checksum when
> > CHECKSUM_PARTIAL is set, indicating that the software should complete the
> > checksum before handing it to the hardware. My understanding is that the STMMAC
> > hardware then calculates the checksum for egress frames if CHECKSUM_PARTIAL is
> > used.
> 
> stmmac shouldn't touch the frame, note that skb_checksum_help() sets
> skb->ip_summed = CHECKSUM_NONE; so the skb should no longer be considered
> for csum offload.

It looks like skb_checksum_help(), which is used in tag_ksz.c, generates
a TCP checksum without accounting for the IP pseudo-header. The
resulting checksum is then incorrect and is filtered out by the STMMAC
HW on ingress

If I generate the checksum manually by combining the result of
skb_checksum() with the csum_tcpudp_magic() function - I get a different
checksum from the skb_checksum_help() result, which is then not dropped
by STMMAC on ingress.

Should tag_ksz.c use a different helper function instead of
skb_checksum_help()?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

