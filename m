Return-Path: <netdev+bounces-200378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F5AAE4BAF
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 19:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948A31898C51
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DCB26D4F7;
	Mon, 23 Jun 2025 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY7BTott"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A451C84D2;
	Mon, 23 Jun 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699162; cv=none; b=ae8RlpSlMcKJ/d4u+sGZBcCh0q5cs1P/4eAlGbQqyya7DUaj3FNjs4JF/OgEwCrDztmRjI9GDxLB68PCZjObITGchDBzT0Y5BUuDtjarfRTpSme6DzaK7Pf1W6PqnLpghDjL/aiB3pzoWp4YbKblATIiW5OH3t6xQpCj78XD1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699162; c=relaxed/simple;
	bh=chsg6qxkKFFdpB+SOietLh5gD1Uz4tT6FryWURP8s9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoOxYkecDRtLAm1BMCcMcTPVBV00/Ctv+cOOAGIO2y2xH61nnUHK5kmoKRC1xa0hAhjdsNxJ2TcJ13F2Un4rQ7k11AekQ0H0d/9QhpQyW4gtUkn6l6r9K2dZGVjVhg6eqewnciheuwRbZ0CFEOeLH0XR6zH4zeW9IikpT0Mt3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY7BTott; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE54C4CEEA;
	Mon, 23 Jun 2025 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750699161;
	bh=chsg6qxkKFFdpB+SOietLh5gD1Uz4tT6FryWURP8s9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jY7BTottz7L4L2kAucQnKwH+2lq8sxPkRngSzGRJTPfRgIrJ4jHICUKRZ+2b5wW3J
	 3DqhYDrREhQkhvjDsIC2PHVw188+Gu6NGg66EJENyqq/JpOxPeIVYEqJA4n7AXUfBe
	 YxZY9K0J/SR9h1OOccy3JD1WMclyID46f2YjQPu+thTZcidoNVoZKXwy1lomkKFKRn
	 Z4Y3M7Ib20bkDkSIOGmH6o6Lrw32mVoJhDjfCMDkB9aCmD90SpWsauvTAgBcv17sZE
	 5kbVKgpcR4aZM/XbWeK2mL0JsfpoDz27yFrA8FSkjtY9p/Fipmvx5Qml5UYrVxOyEr
	 aL9mmnAMoWzRg==
Date: Mon, 23 Jun 2025 10:19:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <20250623101920.69d5c731@kernel.org>
In-Reply-To: <aFk-Za778Bk38Dxn@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
	<20250516184510.2b84fab4@kernel.org>
	<aFU9o5F4RG3QVygb@pengutronix.de>
	<20250621064600.035b83b3@kernel.org>
	<aFk-Za778Bk38Dxn@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 13:45:41 +0200 Oleksij Rempel wrote:
> On Sat, Jun 21, 2025 at 06:46:00AM -0700, Jakub Kicinski wrote:
> > On Fri, 20 Jun 2025 12:53:23 +0200 Oleksij Rempel wrote:
> > > Let me first describe the setup where this issue was observed and my findings.
> > > The problem occurs on a system utilizing a Microchip DSA driver with an STMMAC
> > > Ethernet controller attached to the CPU port.
> > > 
> > > In the current selftest implementation, the TCP checksum validation fails,
> > > while the UDP test passes. The existing code prepares the skb for hardware
> > > checksum offload by setting skb->ip_summed = CHECKSUM_PARTIAL. For TCP, it sets
> > > the thdr->check field to the complement of the pseudo-header checksum, and for
> > > UDP, it uses udp4_hwcsum. If I understand it correct, this configuration tells
> > > the kernel that the hardware should perform the checksum calculation.
> > > 
> > > However, during testing, I noticed that "rx-checksumming" is enabled by default
> > > on the CPU port, and this leads to the TCP test failure.  Only after disabling
> > > "rx-checksumming" on the CPU port did the selftest pass. This suggests that the
> > > issue is specifically related to the hardware checksum offload mechanism in
> > > this particular setup. The behavior indicates that something on the path
> > > recalculated the checksum incorrectly.  
> > 
> > Interesting, that sounds like the smoking gun. When rx-checksumming 
> > is enabled the packet still reaches the stack right?  
> 
> No. It looks like this packets are just silently dropped, before they was
> seen by the stack. The only counter which confirms presence of this
> frames is HW specific mmc_rx_tcp_err. But it will be increasing even if
> rx-checksumming is disabled and packets are forwarded to the stack.

If you happen to have the docs for the STMMAC instantiation in the SoC
it'd be good to check if discarding frames with bad csum can be
disabled. Various monitoring systems will expect the L4 checksum errors
to appear in nstat, not some obscure ethtool -S counter.

> > If so does the frame enter the stack with CHECKSUM_COMPLETE or
> > UNNECESSARY?  
> 
> If rx-checksumming is enabled and packet has supported ethertype,
> then CHECKSUM_UNNECESSARY will be set. Otherwise CHECKSUM_NONE.
> 
> > > When examining the loopbacked frames, I observed that the TCP checksum was
> > > incorrect. Upon further investigation, the xmit helper in net/dsa/tag_ksz.c
> > > includes the following:
> > > 
> > > if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
> > >     return NULL;
> > > 
> > > I assume skb_checksum_help() is intended to calculate the proper checksum when
> > > CHECKSUM_PARTIAL is set, indicating that the software should complete the
> > > checksum before handing it to the hardware. My understanding is that the STMMAC
> > > hardware then calculates the checksum for egress frames if CHECKSUM_PARTIAL is
> > > used.  
> > 
> > stmmac shouldn't touch the frame, note that skb_checksum_help() sets
> > skb->ip_summed = CHECKSUM_NONE; so the skb should no longer be considered
> > for csum offload.  
> 
> It looks like skb_checksum_help(), which is used in tag_ksz.c, generates
> a TCP checksum without accounting for the IP pseudo-header. The
> resulting checksum is then incorrect and is filtered out by the STMMAC
> HW on ingress

The pseudo-header csum is filled in net_test_get_skb(), where it calls
tcp_v4_check(). But I think you're right, it's incorrect. Could you try:

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 35f807ea9952..1166dd1ddb07 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -160,8 +160,10 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
        skb->csum = 0;
        skb->ip_summed = CHECKSUM_PARTIAL;
        if (attr->tcp) {
-               thdr->check = ~tcp_v4_check(skb->len, ihdr->saddr,
-                                           ihdr->daddr, 0);
+               int l4len;
+
+               l4len = skb->tail - skb_transport_header(skb);
+               thdr->check = ~tcp_v4_check(l4len, ihdr->saddr, ihdr->daddr, 0);
                skb->csum_start = skb_transport_header(skb) - skb->head;
                skb->csum_offset = offsetof(struct tcphdr, check);
        } else {

Or some such?

> If I generate the checksum manually by combining the result of
> skb_checksum() with the csum_tcpudp_magic() function - I get a different
> checksum from the skb_checksum_help() result, which is then not dropped
> by STMMAC on ingress.
> 
> Should tag_ksz.c use a different helper function instead of
> skb_checksum_help()?

