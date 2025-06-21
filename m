Return-Path: <netdev+bounces-199965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23145AE2933
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD6C189C58A
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF4511CAF;
	Sat, 21 Jun 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e73cpPQP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BCADDC1;
	Sat, 21 Jun 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750513562; cv=none; b=THXVgtkBegL/jF+PXHHoC91xC3YQB210196DHfJdyEHnG/OB47clHax4HzA7cZp7RhceAFh8G9tSPLRYwju240PWWK5Mlh0uk9juKrNqmikycTgvM817FKohmW6L+B2k9u9pgm7Ht7VYjRY8LXVV6EJBSfUBDR2tYJB5CaqDyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750513562; c=relaxed/simple;
	bh=UxmVwMNn5uY3aRjiNF2e0j3+k2xJ/ByFE2+u+ULLi8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7ybD7QwgPD8tzxJSMrH30K0LjymXKDZq68s0F6noH7C7tEP9488GhIbYRd+EEY3+wAk3jT3kJnZ35VeLLetyP3BwmUIyoOt7PTPS3w3bFsjJIm75kqT/hfAvbPA84qeY4+1C7hQOuFxQRvczQD9clkfCcT+GGGN+adlAVvYDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e73cpPQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9201CC4CEE7;
	Sat, 21 Jun 2025 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750513562;
	bh=UxmVwMNn5uY3aRjiNF2e0j3+k2xJ/ByFE2+u+ULLi8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e73cpPQPW7TPEk+Lvwgt9TLQDsSunVtDrDwzrHKhfkmu/wsI/K1ntMFYs9//YZ2Aa
	 a1PkGfE340bqenITjYbuBC3Nu2ve5E3pMfGvdmPcprGc1lU5kfY1B+BNVFfGSq9Bya
	 puuLtsLuzudpu1cmTALnKBJP0GERLq1Hte83uU5pbRZWvJ9SnqPejgcMEHtGZAlbfb
	 T3h2ejLJHPn5eIRGyuN9o34IrLUXDcuCExWJEBdfpUg4pVmcRjnWKPuGWk8imGTdB7
	 SBqifzqxiV8NFZ0S2yqzovvgOJ2G0FZbGMtmRXvwg90yysrQVxfcFPuvXRFYePNO6Z
	 ZUodL6M5YiUoQ==
Date: Sat, 21 Jun 2025 06:46:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <20250621064600.035b83b3@kernel.org>
In-Reply-To: <aFU9o5F4RG3QVygb@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
	<20250516184510.2b84fab4@kernel.org>
	<aFU9o5F4RG3QVygb@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 12:53:23 +0200 Oleksij Rempel wrote:
> > What device are you talking about? How is this a problem with 
> > the selftest and not with the stack? If the test is flaky I'd 
> > think real traffic will suffer too. We pass these selftest packets
> > thru xmit validation AFAICT, so the stack should compute checksum
> > for the if the device can't.
> >   
> 
> Let me first describe the setup where this issue was observed and my findings.
> The problem occurs on a system utilizing a Microchip DSA driver with an STMMAC
> Ethernet controller attached to the CPU port.
> 
> In the current selftest implementation, the TCP checksum validation fails,
> while the UDP test passes. The existing code prepares the skb for hardware
> checksum offload by setting skb->ip_summed = CHECKSUM_PARTIAL. For TCP, it sets
> the thdr->check field to the complement of the pseudo-header checksum, and for
> UDP, it uses udp4_hwcsum. If I understand it correct, this configuration tells
> the kernel that the hardware should perform the checksum calculation.
> 
> However, during testing, I noticed that "rx-checksumming" is enabled by default
> on the CPU port, and this leads to the TCP test failure.  Only after disabling
> "rx-checksumming" on the CPU port did the selftest pass. This suggests that the
> issue is specifically related to the hardware checksum offload mechanism in
> this particular setup. The behavior indicates that something on the path
> recalculated the checksum incorrectly.

Interesting, that sounds like the smoking gun. When rx-checksumming 
is enabled the packet still reaches the stack right?
If so does the frame enter the stack with CHECKSUM_COMPLETE or
UNNECESSARY?

> When examining the loopbacked frames, I observed that the TCP checksum was
> incorrect. Upon further investigation, the xmit helper in net/dsa/tag_ksz.c
> includes the following:
> 
> if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
>     return NULL;
> 
> I assume skb_checksum_help() is intended to calculate the proper checksum when
> CHECKSUM_PARTIAL is set, indicating that the software should complete the
> checksum before handing it to the hardware. My understanding is that the STMMAC
> hardware then calculates the checksum for egress frames if CHECKSUM_PARTIAL is
> used.

stmmac shouldn't touch the frame, note that skb_checksum_help() sets
skb->ip_summed = CHECKSUM_NONE; so the skb should no longer be considered
for csum offload.

> Since these egress frames are passed from the DSA framework with a
> tailtag, the checksum calculated by the hardware would then be incorrect for
> the original packet. The STMMAC then seems to drop ingress packets if they have
> an incorrect checksum.
> 
> I'm still trying to grasp the full picture of checksumming in such complex
> environments. I would be grateful for your guidance on how this problem should
> be addressed properly.
> 
> Regarding the current patch series, do these tests and the csum_mode
> implementation make sense to you in this context? I believe it would be good
> practice to have selftests that can detect these kinds of checksum
> inconsistencies in drivers.

Not yet, at least. Once we figure out the problem you're seeing we can
decide whether we should adjust the tests or the tests are failing
because they are doing their job.

