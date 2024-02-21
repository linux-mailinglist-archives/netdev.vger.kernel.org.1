Return-Path: <netdev+bounces-73511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C14585CD80
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D42284F23
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF6220E4;
	Wed, 21 Feb 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE4jAFzY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A51FDD
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708479191; cv=none; b=toKL83NsFO5Wc8YQxDEVcG693gX7IDwwjOREsMpA3XiJnGgRmKyAd6UxlKf/8WwhZ8mhoXFE6GRiueVc6JWa4cAJotvkkInPgW5FG4tBOKVTbiXWYR53bxLqaEiKgBM6Ha2ENokEwKpLRHMxjpzGoNP7fh8aCcwjI1ConfsxYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708479191; c=relaxed/simple;
	bh=2l4v5kObcwc//nC/L3WyqZtbDpuqWzhajLRoZOtbl8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jlc5jNoGh8TA6avb36WFZkOyguCtYsI2/O/qikPxP510YTsWU3xcR4t9UNFKjUhW+7E9TNvR1zbw9aPWoMOh2B8Kb24PKnQzaT0MNUSRQYsLQytsuDzItgjpRmq+uvMqAP28PYRuAb1vwDz/O3D7ofV3ouB1277wk6hxRVsNvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE4jAFzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A74C433F1;
	Wed, 21 Feb 2024 01:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708479191;
	bh=2l4v5kObcwc//nC/L3WyqZtbDpuqWzhajLRoZOtbl8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NE4jAFzYxyiom6hld5RWeM8oyYntOPHnXXANt/eNrG6gSapErzg98zyjfasPPfiC6
	 r0sAz0Mbq6CSaPDndsi9KF0pyEsS3G75xR3/J3Gzs9KZeTpSrk4KLIn8AzDImIhRgS
	 LHSUsCYoDtNlt8wmJBOv2vYmJSnQ3P3yVZN0Mrzay6XJDvGQQ6Nvp1Ndlq+zKnSLpT
	 eaW9LhWb6RHMqCnXrxf1ibTG+t5wH0edP8amwLZJqN4gAU6cSEko/MJFpcuFnn9BKj
	 IHrYWZOS5ojLAkJQ2yheOKaa7p5MO4uspW1ZpBfUmys6mmbxSxsALsdC4n2vNevg5M
	 Pon1KMNVjW8Cw==
Date: Tue, 20 Feb 2024 17:33:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <20240220173309.4abef5af@kernel.org>
In-Reply-To: <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
References: <20240215030814.451812-1-saeed@kernel.org>
	<20240215030814.451812-16-saeed@kernel.org>
	<20240215212353.3d6d17c4@kernel.org>
	<f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 17:26:36 +0200 Tariq Toukan wrote:
> > There are multiple devlink instances, right?  
> 
> Right.

Just to be clear I'm asking you questions about things which need to 
be covered by the doc :)

> > In that case we should call out that there may be more than one.
> >   
> 
> We are combining the PFs in the netdev level.
> I did not focus on the parts that we do not touch.

Sure but one of the goals here is to drive convergence.
So if another vendor is on the fence let's nudge them towards the same
decision.

> That's why I didn't mention the sysfs for example, until you asked.
> 
> For example, irqns for the two PFs are still reachable as they used to, 
> under two distinct paths:
> ll /sys/bus/pci/devices/0000\:08\:00.0/msi_irqs/
> ll /sys/bus/pci/devices/0000\:09\:00.0/msi_irqs/
> 
> >> +Currently the sysfs is kept untouched, letting the netdev sysfs point to its primary PF.
> >> +Enhancing sysfs to reflect the actual topology is to be discussed and contributed separately.  
> > 
> > I don't anticipate it to be particularly hard, let's not merge
> > half-baked code and force users to grow workarounds that are hard
> > to remove.
> 
> Changing sysfs to expose queues from multiple PFs under one path might 
> be misleading and break backward compatibility. IMO it should come as an 
> extension to the existing entries.

I don't know what "multiple PFs under one path" means, links in VFs are
one to one, right? :)

> Anyway, the interesting info exposed in sysfs is now available through 
> the netdev genl.

Right, that's true.

Greg, we have a feature here where a single device of class net has
multiple "bus parents". We used to have one attr under class net
(device) which is a link to the bus parent. Now we either need to add
more or not bother with the linking of the whole device. Is there any
precedent / preference for solving this from the device model
perspective?

> Now, is this sysfs part integral to the feature? IMO, no. This in-driver 
> feature is large enough to be completed in stages and not as a one shot.

It's not a question of size and/or implementing everything.
What I want to make sure is that you surveyed the known user space
implementations sufficiently to know what looks at those links,
and perhaps ethtool -i.
Perhaps the answer is indeed "nothing much will care" and given
we can link IRQs correctly we put that as a conclusion in the doc.

Saying "sysfs is coming soon" is not adding much information :(

> > Also could you add examples of how the queue and napis look when listed
> > via the netdev genl on these devices?
> >   
> 
> Sure. Example for a 24-cores system:

Could you reconfigure to 5 channels to make the output asymmetric and
shorter and include the example in the doc?

