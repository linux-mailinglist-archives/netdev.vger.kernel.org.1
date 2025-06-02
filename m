Return-Path: <netdev+bounces-194650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED22ACBB54
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73A87A97FA
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDBB19DF66;
	Mon,  2 Jun 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tvUiqwrA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8120029B0;
	Mon,  2 Jun 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748891222; cv=none; b=MyD58JEoM0+yYjnfOMBN+p6bGe3uqh3Co5vX8C7w23wgEMuBC7UFPmUN0tl7IBM/wy84ZJx/DqVWmoNJ8aXhepI2cL01a28/Ufu/lJ6dbjmMmGTJr2zWjk7jc1VKvQiUvquyR8jAbGdYA+vS2KDKh8ZVhDJT6tK+V/t4YAfNhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748891222; c=relaxed/simple;
	bh=PN3fmGoLa5kt7rDvHpwnwpvdP3RQ8sd6Qaoj4VTuTUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHlxt4Sjkqqog2bgukgKLInKVXQvW+0RJ8vqVV9L6PCCBdGROyZefmNW4xRNvohJFAT5d6mhUiqKrdLDPzH/DClWV3MGZ0YGJbJpCA7CiheVWGuIQUbUG3x4VlNdvNNMSJ/4KEd35xZAs2EruIK4Hv4AZ+UCStzJ9MMq0v/s4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tvUiqwrA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nGyo5dQjAPB8J+L3QOcvLvGg54g5jhrVrYCFrnRzTxc=; b=tvUiqwrAM8R3OlXTjiYGxjZcnX
	4lVFDulQ6QK+hABwtn5ut+laP+gBK7b/MMsz/yU7V3UW+WMghJX/x8tXviESdGy3EIXw2uEkqCUKB
	BwluKkf30/URDN0iS5tJ1jHcRt5yezT49Dq2fpq+Fzxb7y1lxESCfmGv0gXW5aG/5SBo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uMAUj-00EWdV-3n; Mon, 02 Jun 2025 21:06:49 +0200
Date: Mon, 2 Jun 2025 21:06:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kees Cook <kees@kernel.org>
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net: randomize layout of struct net_device
Message-ID: <25d96fc0-c54b-4f24-a62b-cf68bf6da1a9@lunn.ch>
References: <20250602135932.464194-1-pranav.tyagi03@gmail.com>
 <053507e4-14dc-48db-9464-f73f98c16b46@lunn.ch>
 <202506021057.3AB03F705@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202506021057.3AB03F705@keescook>

On Mon, Jun 02, 2025 at 11:03:18AM -0700, Kees Cook wrote:
> On Mon, Jun 02, 2025 at 04:46:14PM +0200, Andrew Lunn wrote:
> > On Mon, Jun 02, 2025 at 07:29:32PM +0530, Pranav Tyagi wrote:
> > > Add __randomize_layout to struct net_device to support structure layout
> > > randomization if CONFIG_RANDSTRUCT is enabled else the macro expands to
> > > do nothing. This enhances kernel protection by making it harder to
> > > predict the memory layout of this structure.
> > > 
> > > Link: https://github.com/KSPP/linux/issues/188
> 
> I would note that the TODO item in this Issue is "evaluate struct
> net_device".
> 
> > A dumb question i hope.
> > 
> > As you can see from this comment, some time and effort has been put
> > into the order of members in this structure so that those which are
> > accessed on the TX fast path are in the same cache line, and those on
> > the RX fast path are in the same cache line, and RX and TX fast paths
> > are in different cache lines, etc.
> 
> This is pretty well exactly one of the right questions to ask, and
> should be detailed in the commit message. Mainly: a) how do we know it
> will not break anything? b) why is net_device a struct that is likely
> to be targeted by an attacker?

For a), i doubt anything will break. The fact the structure has been
optimised for performance implies that members have been moved around,
and there are no comments in the structure saying don't move this,
otherwise bad things will happen.

There is a:

	u8			priv[] ____cacheline_aligned
				       __counted_by(priv_len);

at the end, but i assume RANDSTRUCT knows about them and won't move it.

As for b), i've no idea, not my area. There are a number of pointers
to structures contains ops. Maybe if you can take over those pointers,
point to something you can control, you can take control of the
Program Counter?

> > Does CONFIG_RANDSTRUCT understand this? It is safe to move members
> > around within a cache line. And it is safe to move whole cache lines
> > around. But it would be bad if the randomisation moved members between
> > cache lines, mixing up RX and TX fast path members, or spreading fast
> > path members over more cache lines, etc.
> 
> No, it'll move stuff all around. It's very much a security vs
> performance trade-off, but the systems being built with it are happy to
> take the hit.

It would be interesting to look back at the work optimising this
stricture to get a ball park figure how big a hit this is?

I also think some benchmark numbers would be interesting. I would
consider two different systems:

1) A small ARM/MIPS/RISC-V with 1G interfaces. The low amount of L1
cache on these systems mean that cache misses are important. So
spreading out the fast path members will be bad.

2) Desktop/Server class hardware, lots of cores, lots of cache, 10G,
40G or 100G interfaces. For these systems, i expect cache line
bouncing is more of an issue, so Rx and Tx fast path members want to
be kept in separate cache lines.

> The basic details are in security/Kconfig.hardening in the "choice" following
> the CC_HAS_RANDSTRUCT entry.

So i see two settings here. It looks like RANDSTRUCT_PERFORMANCE
should have minimal performance impact, so maybe this should be
mentioned in the commit message, and the benchmarks performed both on
full randomisation and with the performance setting.

I would also suggest a comment is added to the top of
Documentation/networking/net_cachelines/net_device.rst pointing out
this assumed RANDSTRUCT is disabled, and the existing comment in
struct net_device is also updated.

	Andrew

