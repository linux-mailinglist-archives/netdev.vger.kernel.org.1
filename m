Return-Path: <netdev+bounces-70403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D1D84EE95
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 02:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D6D28853B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 01:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBAC139E;
	Fri,  9 Feb 2024 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grvM6Ulx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA579139B
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707441994; cv=none; b=ISrAXj7uOA/KQUuYAeTo0ijtpOPopMyRK5zZ2/DWg8NNBPy6tCzKO0u1zN7pEiZ5jRudEeAZiHDEjTRPpPefoZXqtvFYIrcf1eXf56w5IdO6t55+5qUvGKVtJpZA7gEaeZbAPQOVqylSkT4drLGjthIhI6XBHEP9wXA+hk9EXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707441994; c=relaxed/simple;
	bh=umzRWk2GQ5G4E97Rimjurx/eN1UyYYiJ408/lBWUFnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nf8IXA+YvvY87GO1iWE4DxNZp0fEdj8UViJp7HTkzJi2FlXagHy/7ASHS3/OVZp/8QUco+ViXedWY3j8+hnhTyI7VofZqSigPoLkuykaNZwV/kRDFS3PWbgvZbj0gShvgHB5rF1jqnKxbFbswbGURuf4NCgMJ8HI9QZ9NvqaVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grvM6Ulx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C73C433C7;
	Fri,  9 Feb 2024 01:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707441994;
	bh=umzRWk2GQ5G4E97Rimjurx/eN1UyYYiJ408/lBWUFnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=grvM6UlxR2biUrFowxGHnGKVMq79waDBR/3kPMLjyNEPjg5KYmHUsIwqVWOldbgAZ
	 8VaynVEgSQVz3BZfIbX8W0Ez0cFyISCiiXNuBg+lumqJoYaWCwAKHmmv/At0C/FeDK
	 CQndJedsZ7kvgTA8Ahgbvnl5leD1YhzSZHRKGtw9y0O12sJcVMiFH+oC61vIpD5ei6
	 2j3g3Hl+meyWxeCZxmhgD2ii2OuH1OCvAbimbpTq9rT1Ph2AVsrUQqyP7c4HqO2QUZ
	 d+n2iQgOrhxBk8SyQdjVQH8WFEDKTSnLuCetKYTIaJodGxR61qTBUS2D6k39Jc1bbp
	 TkTjcJZOKkdnQ==
Date: Thu, 8 Feb 2024 17:26:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: William Tu <witu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com, "aleksander.lobakin@intel.com"
 <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240208172633.010b1c3f@kernel.org>
In-Reply-To: <Zbyd8Fbj8_WHP4WI@nanopsycho>
References: <20240131110649.100bfe98@kernel.org>
	<6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
	<20240131124545.2616bdb6@kernel.org>
	<2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
	<777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
	<20240131143009.756cc25c@kernel.org>
	<dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
	<20240131151726.1ddb9bc9@kernel.org>
	<Zbtu5alCZ-Exr2WU@nanopsycho>
	<20240201200041.241fd4c1@kernel.org>
	<Zbyd8Fbj8_WHP4WI@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 08:46:56 +0100 Jiri Pirko wrote:
> Fri, Feb 02, 2024 at 05:00:41AM CET, kuba@kernel.org wrote:
> >On Thu, 1 Feb 2024 11:13:57 +0100 Jiri Pirko wrote:  
> >> Wait a sec.  
> >
> >No, you wait a sec ;) Why do you think this belongs to devlink?
> >Two months ago you were complaining bitterly when people were
> >considering using devlink rate to control per-queue shapers.
> >And now it's fine to add queues as a concept to devlink?  
> 
> Do you have a better suggestion how to model common pool object for
> multiple netdevices? This is the reason why devlink was introduced to
> provide a platform for common/shared things for a device that contains
> multiple netdevs/ports/whatever. But I may be missing something here,
> for sure.

devlink just seems like the lowest common denominator, but the moment
we start talking about multi-PF devices it also gets wobbly :(
I think it's better to focus on the object, without scoping it to some
ancestor which may not be sufficient tomorrow (meaning its own family
or a new object in netdev like page pool).

> >> With this API, user can configure sharing of the descriptors.
> >> So there would be a pool (or multiple pools) of descriptors and the
> >> descriptors could be used by many queues/representors.
> >> 
> >> So in the example above, for 1k representors you have only 1k
> >> descriptors.
> >> 
> >> The infra allows great flexibility in terms of configuring multiple
> >> pools of different sizes and assigning queues from representors to
> >> different pools. So you can have multiple "classes" of representors.
> >> For example the ones you expect heavy trafic could have a separate pool,
> >> the rest can share another pool together, etc.  
> >
> >Well, it does not extend naturally to the design described in that blog
> >post. There I only care about a netdev level pool, but every queue can
> >bind multiple pools.
> >
> >It also does not cater naturally to a very interesting application
> >of such tech to lightweight container interfaces, macvlan-offload style.
> >As I said at the beginning, why is the pool a devlink thing if the only
> >objects that connect to it are netdevs?  
> 
> Okay. Let's model it differently, no problem. I find devlink device
> as a good fit for object to contain shared things like pools.
> But perhaps there could be something else. Something new?

We need something new for more advanced memory providers, anyway.
The huge page example I posted a year ago needs something to get
a huge page from CMA and slice it up for the page pools to draw from.
That's very similar, also not really bound to a netdev. I don't think
the cross-netdev aspect is the most important aspect of this problem.

> >Another netdev thing where this will be awkward is page pool
> >integration. It lives in netdev genl, are we going to add devlink pool
> >reference to indicate which pool a pp is feeding?  
> 
> Page pool is per-netdev, isn't it? It could be extended to be bound per
> devlink-pool as you suggest. It is a bit awkward, I agree.
> 
> So instead of devlink, should be add the descriptor-pool object into
> netdev genl and make possible for multiple netdevs to use it there?
> I would still miss the namespace of the pool, as it naturally aligns
> with devlink device. IDK :/

Maybe the first thing to iron out is the life cycle. Right now we
throw all configuration requests at the driver which ends really badly
for those of us who deal with heterogeneous environments. Applications
which try to do advanced stuff like pinning and XDP break because of
all the behavior differences between drivers. So I don't think we
should expose configuration of unstable objects (those which user
doesn't create explicitly - queues, irqs, page pools etc) to the driver.
The driver should get or read the config from the core when the object
is created.

This gets back to the proposed descriptor pool because there's a
chicken and an egg problem between creating the representors and
creating the descriptor pool, right? Either:
 - create reprs first with individual queues, reconfigure them to bind
   them to a pool
 - create pool first bind the reprs which don't exist to them,
   assuming the driver somehow maintains the mapping, pretty weird
   to configure objects which don't exist
 - create pool first, add an extra knob elsewhere (*cough* "shared-descs
   enable") which produces somewhat loosely defined reasonable behavior

Because this is a general problem (again, any queue config needs it)
I think we'll need to create some sort of a rule engine in netdev :(
Instead of configuring a page pool you'd add a configuration rule
which can match on netdev and queue id and gives any related page pool
some parameters. NAPI is another example of something user can't
reasonably configure directly. And if we create such a rule engine 
it should probably be shared...

