Return-Path: <netdev+bounces-210371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C24EB12F58
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 13:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA276188634A
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF01FF5E3;
	Sun, 27 Jul 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtQzsQCY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D52B9BA;
	Sun, 27 Jul 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753616348; cv=none; b=CFPMSISbrs1hUSzQMryDXNq1UuO9kisOK9oh1dAKlf/KxoWOL/I8tdv9i3M531YfPCYGlNdcznj990GWxWXN8sf5FptGXCcD9ZpIdGLBT/hKdAYEXfiNCLYDWmRzzumHRk66o8FG3gqGKKX/Y9nq3fT6IbaAX9AELPyePufU31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753616348; c=relaxed/simple;
	bh=dCQ/5ACZXuFvlMS3yxQyTas5SeryViH4PPdHqfvtjHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnUN1RtShTT+8b3AokLsgoBdYM/FLkJjMWppEN6/yiaPfyf+rLrD35M4kGajfLTwOXzKpsGI7fRrqaVGEZPkac4M7mxND6z1AB9mhccn0z9XXMmXtzlVf5pGCpM10L/Hlv/54t0DCaZIMoz8MUUHziRhecN+NJ0xd7wdu5Qf1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtQzsQCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70085C4CEEB;
	Sun, 27 Jul 2025 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753616348;
	bh=dCQ/5ACZXuFvlMS3yxQyTas5SeryViH4PPdHqfvtjHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtQzsQCYYWW9nVqtBWrQZmQ8Uqd4RYBRQxDHRsuFD9brGCKYT/sVOgFe2LF3n3zB2
	 Jn8C9LCp7oAeyck6W2HGzrjPsHmLlAwrOQx1aHwWItIJ5g7M3YPSzIjOP2nL5cldzt
	 jePuMPrIqXb/nB3wpvCokAyoNxAaWzo7q2v+XLof7KEZMmecSvckApUgaACsIn+JyX
	 uNPAR08kmEe2zPnBTnn/LqEHwCmwubT+9hc6rDfZ/EgsPa0SInWiX8VLomd2Y8jO19
	 HVcA5xZYVaZRxEMYB6eCKuQF7WhV7FZ0w+F+8Qanbuls94Rq3T0CqxIQfly1UgUmR7
	 Hm0oaltBPfrAA==
Date: Sun, 27 Jul 2025 14:39:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH net v2 1/4] auxiliary: Support hexadecimal ids
Message-ID: <20250727113903.GA402218@unreal>
References: <03e04d98-e5eb-41c0-8407-23cccd578dbe@linux.dev>
 <2025071726-ramp-friend-a3e5@gregkh>
 <5ee4bac4-957b-481a-8608-15886da458c2@linux.dev>
 <20250720081705.GE402218@unreal>
 <e4b5e4fa-45c4-4b67-b8f1-7d9ff9f8654f@linux.dev>
 <20250723081356.GM402218@unreal>
 <991cbb9a-a1b5-4ab8-9deb-9ecea203ce0f@linux.dev>
 <2025072543-senate-hush-573d@gregkh>
 <20250727080705.GY402218@unreal>
 <2025072751-living-sheath-e601@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025072751-living-sheath-e601@gregkh>

On Sun, Jul 27, 2025 at 10:57:09AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 27, 2025 at 11:07:05AM +0300, Leon Romanovsky wrote:
> > On Fri, Jul 25, 2025 at 07:02:24AM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jul 24, 2025 at 09:55:59AM -0400, Sean Anderson wrote:
> > > > On 7/23/25 04:13, Leon Romanovsky wrote:
> > > > > On Mon, Jul 21, 2025 at 10:29:32AM -0400, Sean Anderson wrote:
> > > > >> On 7/20/25 04:17, Leon Romanovsky wrote:
> > > > >> > On Thu, Jul 17, 2025 at 01:12:08PM -0400, Sean Anderson wrote:
> > > > >> >> On 7/17/25 12:33, Greg Kroah-Hartman wrote:
> > > > >> > 
> > > > >> > <...>
> > > > >> > 
> > > > >> >> Anyway, if you really think ids should be random or whatever, why not
> > > > >> >> just ida_alloc one in axiliary_device_init and ignore whatever's
> > > > >> >> provided? I'd say around half the auxiliary drivers just use 0 (or some
> > > > >> >> other constant), which is just as deterministic as using the device
> > > > >> >> address.
> > > > >> > 
> > > > >> > I would say that auxiliary bus is not right fit for such devices. This
> > > > >> > bus was introduced for more complex devices, like the one who has their
> > > > >> > own ida_alloc logic.
> > > > >> 
> > > > >> I'd say that around 2/3 of the auxiliary drivers that have non-constant
> > > > >> ids use ida_alloc solely for the auxiliary bus and for no other purpose.
> > > > >> I don't think that's the kind of complexity you're referring to.
> > > > >> 
> > > > >> >> Another third use ida_alloc (or xa_alloc) so all that could be
> > > > >> >> removed.
> > > > >> > 
> > > > >> > These ID numbers need to be per-device.
> > > > >> 
> > > > >> Why? They are arbitrary with no semantic meaning, right?
> > > > > 
> > > > > Yes, officially there is no meaning, and this is how we would like to
> > > > > keep it.
> > > > > 
> > > > > Right now, they are very correlated with with their respective PCI function number.
> > > > > Is it important? No, however it doesn't mean that we should proactively harm user
> > > > > experience just because we can do it.
> > > > > 
> > > > > [leonro@c ~]$ l /sys/bus/auxiliary/devices/
> > > > > ,,,
> > > > > rwxrwxrwx 1 root root 0 Jul 21 15:25 mlx5_core.rdma.0 -> ../../../devices/pci0000:00/0000:00:02.7/0000:0
> > > > > 8:00.0/mlx5_core.rdma.0
> > > > > lrwxrwxrwx 1 root root 0 Jul 21 15:25 mlx5_core.rdma.1 -> ../../../devices/pci0000:00/0000:00:02.7/0000:0
> > > > > 8:00.1/mlx5_core.rdma
> > > > 
> > > > Well, I would certainly like to have semantic meaning for ids. But apparently
> > > > that is only allowed if you can sneak it past the review process.
> > > 
> > > Do I need to dust off my "make all ids random" patch again and actually
> > > merge it just to prevent this from happening?
> > 
> > After weekend thoughts on it. IDs need to be removed from the driver
> > access. Let's make them global at least.
> 
> Great, no objection from me, want to send a patch we can queue up for
> 6.18-rc1?

Sean proposed the initial idea to move IDs to aux core. Let's wait for him
to see if he wants to do such patch. If not, I'll send.

Thanks


