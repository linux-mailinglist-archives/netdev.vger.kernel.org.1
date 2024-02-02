Return-Path: <netdev+bounces-68293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F338466B0
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 05:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB78B24365
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 04:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF889D521;
	Fri,  2 Feb 2024 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+r3CcwH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC298C2D2
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846445; cv=none; b=ZP32Wycm/nRLZkhrB2InACvqBF8aGtx34ZrQQNnw2JXgXRDJscWoph+cEmdLeFFWkjSH7b7+X6DII5QPDL/jkuRiZx+A//8qCk2Xo+1Fref9DPlrGYQoviInDfviP6MEjCXWvwJVT/6zwo/MMCyR4RTTOYxGSHfvkZZjjjXOihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846445; c=relaxed/simple;
	bh=y4q7hQACeV81fQ6npTHo5NvpJQIjp/BFVJPgkB2ty8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbAA5e0oTSTelpbrAOCCCiFlsaQifjXTW9uuEVHPMfZqI25zufutQWFyD9WGYNgESzySTCCjfbV4XYr2qxYELazfMAt7fnQmPIxdZ4nslUOXP0G0jMwKVVheYGAHOYSdP2ayh6D66raL38109eYaMFrLrmdl2xsaZvtEeGi6+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+r3CcwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAB7C433C7;
	Fri,  2 Feb 2024 04:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706846445;
	bh=y4q7hQACeV81fQ6npTHo5NvpJQIjp/BFVJPgkB2ty8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l+r3CcwH2HzVBIqLfN6DqZba3nh8RELv7UotiPsulcoGAaayJBFTgB7xOoX5WHkvK
	 PjAi3TGZcVozgbOoPylEmOH/8b7B94N9/rsh5lkShzzUE7/+5+hU3Ung9GpZihaLTZ
	 5KkzWnpeYthOrVKzoja02U0PewtTBOqaWSwzaSPWc/rpIJ4Fyy1/9Rd0T5/ZVWdEw3
	 UTk8XHXaO0e2W9diur3mBplWjh5dHM9paRo3POVK/xlBplWupZIQYx4Q8HnyOUvsRR
	 ey1zoXj+v7ZP62H8Jmzwiuu8cOMWck57yqAlFvePf3ry5U/Iu2m395EYUJQ81HxwQC
	 rmsA87hOU9uiw==
Date: Thu, 1 Feb 2024 20:00:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: William Tu <witu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com, "aleksander.lobakin@intel.com"
 <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240201200041.241fd4c1@kernel.org>
In-Reply-To: <Zbtu5alCZ-Exr2WU@nanopsycho>
References: <20240130170702.0d80e432@kernel.org>
	<748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
	<20240131110649.100bfe98@kernel.org>
	<6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
	<20240131124545.2616bdb6@kernel.org>
	<2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
	<777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
	<20240131143009.756cc25c@kernel.org>
	<dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
	<20240131151726.1ddb9bc9@kernel.org>
	<Zbtu5alCZ-Exr2WU@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 11:13:57 +0100 Jiri Pirko wrote:
> Thu, Feb 01, 2024 at 12:17:26AM CET, kuba@kernel.org wrote:
> >> I guess bnxt, ice, nfp are doing tx buffer sharing?  
> >
> >I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
> >I'm 99.9% sure nfp does.  
> 
> Wait a sec.

No, you wait a sec ;) Why do you think this belongs to devlink?
Two months ago you were complaining bitterly when people were
considering using devlink rate to control per-queue shapers.
And now it's fine to add queues as a concept to devlink?

> You refer to using the lower device (like PF) to actually
> send and receive trafic of representors. That means, you share the
> entire queues. Or maybe better term is not "share" but "use PF queues".
> 
> The infra William is proposing is about something else. In that
> scenario, each representor has a separate independent set of queues,
> as well as the PF has. Currently in mlx5, all representor queues have
> descriptors only used for the individual representor. So there is
> a huge waste of memory for that, as often there is only very low traffic
> there and probability of hitting trafic burst on many representors at
> the same time is very low.
> 
> Say you have 1 queue for a rep. 1 queue has 1k descriptors. For 1k
> representors you end up with:
> 1k x 1k = 1m descriptors

I understand the memory waste problem:
https://people.kernel.org/kuba/nic-memory-reserve

> With this API, user can configure sharing of the descriptors.
> So there would be a pool (or multiple pools) of descriptors and the
> descriptors could be used by many queues/representors.
> 
> So in the example above, for 1k representors you have only 1k
> descriptors.
> 
> The infra allows great flexibility in terms of configuring multiple
> pools of different sizes and assigning queues from representors to
> different pools. So you can have multiple "classes" of representors.
> For example the ones you expect heavy trafic could have a separate pool,
> the rest can share another pool together, etc.

Well, it does not extend naturally to the design described in that blog
post. There I only care about a netdev level pool, but every queue can
bind multiple pools.

It also does not cater naturally to a very interesting application
of such tech to lightweight container interfaces, macvlan-offload style.
As I said at the beginning, why is the pool a devlink thing if the only
objects that connect to it are netdevs?

Another netdev thing where this will be awkward is page pool
integration. It lives in netdev genl, are we going to add devlink pool
reference to indicate which pool a pp is feeding?

When memory providers finally materialize that will be another
netdev thing that needs to somehow connect here.

