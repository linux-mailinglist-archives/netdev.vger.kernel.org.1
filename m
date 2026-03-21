Return-Path: <netdev+bounces-270244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P04JdbxvmlxlAMAu9opvQ
	(envelope-from <netdev+bounces-270244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:30:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D02E6FC9
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF39C300C59D
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB8331E826;
	Sat, 21 Mar 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a4uITRpy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C4313283;
	Sat, 21 Mar 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121377; cv=none; b=PwNqyoXS9i7UCZoBM5s804t1QaobiKEfuSkhcvKUL8ZGQcWylgRML/muU+5K7utAcfBXNk/ilLQdRGoxpjX+BJCANvIWFvIVUNv23dg+FIhJc+oulncevi00MI+A0lJQ+e26WU4olOBcNimkDcMDsjTMSFVRLoxKST5ns14r0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121377; c=relaxed/simple;
	bh=YLxMFG/uAi8d2pEsX0+IRHpIk2S7mC4GreH4DXFFWHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIZ2QsqL2pe5UWHQNzaIzWd9nC0S3VCEWXzjz1u9SSpN2XYKfiOv6SpEo7KV4vHFqfBlYKiYhPpv4vETgQ0nxIzV25fETVrmWt2QqrwkiOVmRxgWYLHpwJ1/dY4TECpFEfnp4kHZNsvsqvdgFtwMSAGzEAr1IqHz3tm7pt2FtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a4uITRpy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lSId2R4n5h5Caa3HQVy1kp5ItdOtiP98FOe14fx9xe0=; b=a4uITRpygSPp6wm/im4nXDeUqd
	Luj+KRHqcrffrMPpvzE3FyD5daP06CupTPUNV/sVUPluTStanSar/zA4oMH4/GJ905Ftee7rn5bxP
	UwN5RLF8Doepz/gov3VAdDdS1FTp1T+duBq1PH1J5TqK5TT+ZjC8R+8BX2cq+5NKOp4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w420e-00CkBU-Bh; Sat, 21 Mar 2026 20:29:20 +0100
Date: Sat, 21 Mar 2026 20:29:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 1/2] net: dsa: mxl862xx: add CRC for MDIO
 communication
Message-ID: <fa518f5d-8b68-459e-9d69-b8702a0b6b57@lunn.ch>
References: <cover.1774070039.git.daniel@makrotopia.org>
 <af6911188ee6becb9100d4bf13d0820e5bf9eaca.1774070039.git.daniel@makrotopia.org>
 <c5f29b9b-9447-488e-b8cc-e2f7e7cbf1a8@lunn.ch>
 <ab6-5XnC6Z3TdytJ@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6-5XnC6Z3TdytJ@makrotopia.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270244-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF2D02E6FC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > This is the question, what to do when you see a checksum failure? The
> > basic assumption is MDIO is reliable. PHYs don't do any sort of
> > checksums, nor any other switches using MDIO. Why would you want
> > checksums?
> > 
> > To detect the hardware is broken? If so, is returning EIO sufficient?
> > Would it not be better to admin down all the interfaces?
> > 
> > To allow the MDIO clock to run at a higher frequency, at the limit of
> > the bus, so you get occasionally failures? If so, should you not
> > retry? But are the commands idempotent? Can you safely retry?
> > 
> 
> Your guesses are all correct, and your concerns are justified.
> 
> Let me explain the whole picture:
> The switch driver transfers many rather large data structures over
> MDIO, and lacking support for interrupts (firmware doesn't support),
> this is often even interleaved with polling 8 PHYs and at least one
> PCS. To not have things get very slow (and then even sometimes see
> -ETIMEDOUT breaking the PHY state machine if timing is unlucky), it
> is common to overclock the MDIO bus to 20 MHz instead of the 2.5 MHz
> default (the switch claims to support up to 25 MHz, but 20 Mhz is
> sufficient and conservative enough).
> 
> That, combined with higher temperature of the switch IC (but still
> within the spec'ed range), can lead to bit-errors -- which, in case
> they remain unnoticed can introduce subtle (security relevant) issues
> such as bridging ports which should not be bridged or flooding to a
> port on which flooding should be disabled.

O.K. "Interesting" design.

You could solve the PHY timeout issue by claiming to support PHY
interrupts, doing the polling in the DSA driver, and raise an
interrupt if the conditions are met. The mv88e6xxx driver does
something like this. It has an interrupt controller which the PHYs are
connect to. Some designs have the switch interrupt output connected to
a GPIO and so can do real interrupts. Some don't. Rather than have all
the internal PHYs polled one per second by phylib, the mv88e6xxx polls
the interrupt status register every 1/5 of a second and raises the
interrupts instead. Bot faster, and less MDIO transfers.

> In case of the switch reporting back a CRC error for data received,
> a limited number of retries would be ok in every case.
> However, the same is not true for the opposite direction, ie. an
> error detected by the Linux host for data received from the switch:
> In case one of the *_ALLOC API calls we cannot simply repeat the
> call, and as the data was corrupted, we wouldn't even know how to
> undo the failed call.

Seems like somebody did not think through the design. I assume the
vendor driver does not attempt a retry?

> Setting all interfaces to admin-down is probably the best compromise
> in a case like this, as it would also reduce the energy consumption
> and hence heat emission of the IC (as all built-in PHYs are then down;
> that's where most of the heat comes from) and prevent damage -- I've
> only observed CRC errors with the heatsink removed and artifically
> overheating the IC...

So in the normal use cases you don't expect CRC errors. That seems
like it should driver the design. Consider any CRCs as fatal and
shutdown.

	Andrew

