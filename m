Return-Path: <netdev+bounces-199726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A57AE1942
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CFB1BC5A11
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1792283FEE;
	Fri, 20 Jun 2025 10:53:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6435255250
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416818; cv=none; b=Gc9GfdD0X5J3tgecGVgUGgl/an859ZgA+XrBbTmg91aquZfOch7b3aBt7b0eQgYNujay7rf3TNp5OjySKoIG7ZlXveCZISObh0xHqMZl8jBPJGh2emNrwyCUlu4/HUOBrsiMi6yI8B/Jsj/pkbEihy8+Mr+SAG6gzKc9BZ7Vchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416818; c=relaxed/simple;
	bh=qjt6va4bHv90YxsmS+LUwFTu/P0G68OsG6HgL0/WgmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7+4bvPw8SPKOTA1IJ4TnGYNa0gRCuk00TgicAd0arCp27ZQXgWFaoLP8uQHWYL9fN/360nkSc+eDFF6cir+kOUt2ibThCr3El5IsbYVztBwLBY6Dwh21W2q1T848jCRmfJTz0y7iFW/t5z+g8pqTUphjKRE4SPnAxHK0x/zifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uSZN7-0002ME-02; Fri, 20 Jun 2025 12:53:25 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uSZN5-004Rpo-2I;
	Fri, 20 Jun 2025 12:53:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uSZN5-007MU9-1u;
	Fri, 20 Jun 2025 12:53:23 +0200
Date: Fri, 20 Jun 2025 12:53:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <aFU9o5F4RG3QVygb@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
 <20250516184510.2b84fab4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516184510.2b84fab4@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Jakub,

Sorry for the delay in getting back to you.

On Fri, May 16, 2025 at 06:45:10PM -0700, Jakub Kicinski wrote:
> On Thu, 15 May 2025 10:30:56 +0200 Oleksij Rempel wrote:
> > - Inconsistent checksum behavior: On DSA setups and similar
> >   environments, checksum offloading is not always available or
> >   appropriate. The previous selftests did not distinguish between software
> >   and hardware checksum modes, leading to unreliable results. This
> >   patchset introduces explicit csum_mode handling and adds separate tests
> >   for both software and hardware checksum validation.
> 
> What device are you talking about? How is this a problem with 
> the selftest and not with the stack? If the test is flaky I'd 
> think real traffic will suffer too. We pass these selftest packets
> thru xmit validation AFAICT, so the stack should compute checksum
> for the if the device can't.
> 

Let me first describe the setup where this issue was observed and my findings.
The problem occurs on a system utilizing a Microchip DSA driver with an STMMAC
Ethernet controller attached to the CPU port.

In the current selftest implementation, the TCP checksum validation fails,
while the UDP test passes. The existing code prepares the skb for hardware
checksum offload by setting skb->ip_summed = CHECKSUM_PARTIAL. For TCP, it sets
the thdr->check field to the complement of the pseudo-header checksum, and for
UDP, it uses udp4_hwcsum. If I understand it correct, this configuration tells
the kernel that the hardware should perform the checksum calculation.

However, during testing, I noticed that "rx-checksumming" is enabled by default
on the CPU port, and this leads to the TCP test failure.  Only after disabling
"rx-checksumming" on the CPU port did the selftest pass. This suggests that the
issue is specifically related to the hardware checksum offload mechanism in
this particular setup. The behavior indicates that something on the path
recalculated the checksum incorrectly.

When examining the loopbacked frames, I observed that the TCP checksum was
incorrect. Upon further investigation, the xmit helper in net/dsa/tag_ksz.c
includes the following:

if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
    return NULL;

I assume skb_checksum_help() is intended to calculate the proper checksum when
CHECKSUM_PARTIAL is set, indicating that the software should complete the
checksum before handing it to the hardware. My understanding is that the STMMAC
hardware then calculates the checksum for egress frames if CHECKSUM_PARTIAL is
used. Since these egress frames are passed from the DSA framework with a
tailtag, the checksum calculated by the hardware would then be incorrect for
the original packet. The STMMAC then seems to drop ingress packets if they have
an incorrect checksum.

I'm still trying to grasp the full picture of checksumming in such complex
environments. I would be grateful for your guidance on how this problem should
be addressed properly.

Regarding the current patch series, do these tests and the csum_mode
implementation make sense to you in this context? I believe it would be good
practice to have selftests that can detect these kinds of checksum
inconsistencies in drivers.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

