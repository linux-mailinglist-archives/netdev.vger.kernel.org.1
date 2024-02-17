Return-Path: <netdev+bounces-72607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0A5858CFE
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 03:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473E61C2123F
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 02:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E576149E16;
	Sat, 17 Feb 2024 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBRDt+55"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B223D0
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708137814; cv=none; b=om0J/uyNpApirlQ/UCNSciMWHOlGzvSRPC8eBd/+ivwwbewBdZR1rq6RdO4fd4fnP/C5LGHiMXV8vVntmWWvLWA2bt3plfN2S+Whn1Z3DrjYwr/Ws6yTOz2n+k86CPgRUCxsEhASJfTZ7pKRBi2yJPw7+UJ4UBXlnkwjDydzbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708137814; c=relaxed/simple;
	bh=6eR2ubUSCEvc491YwSUdkSMKUfG9xDCAgwb3DXOG3Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N48Qs+3PNedoyDXaeCBUfrZCSICMjZAmTnNkGQKi+fXLtE3mCd17nEHpJmfx7Mr7IQN6PsoO5El2x9SvpXwGW8EjdpF+xQlfQ9959dA9xltiwLBKu/CtLioiK8xaNwc4PDC1WOQfnIbWUzF+lIud1U+A12kxO6ea7OQa/A1i9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBRDt+55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D639C433C7;
	Sat, 17 Feb 2024 02:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708137813;
	bh=6eR2ubUSCEvc491YwSUdkSMKUfG9xDCAgwb3DXOG3Ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DBRDt+555oSKmiIr0HNgUOWEE9JSRp5u2gn0jufsPt7Kqd0WaPH0/mVPO8/yOGpxa
	 Gvw1fqmfAB59Gn3/N2iDdQKM0fwezGp54P/i1Uk9fQeP8EbcKegERwen+SJNjB1u3r
	 7u/3ZbR+bTWtFxHE8OV8sm1qc7ORNl6n7/MNUoDB85B8ZvYzzKsi3KNqvyDXUDqJ95
	 kPBvDOkH578k5zn56/AMHQIt9ktmg6zSEADve7KW9HQ6kKp3Y5vq6lWulZ9YEz2x9g
	 TxcA0ylvzUTNAcAQIEFu2aHMieGEmmr/UfkbCZm0GZMj5Mfojl0xToSrd615ehwAuv
	 4o7WJ5SNwir4w==
Date: Fri, 16 Feb 2024 18:43:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: William Tu <witu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com, "aleksander.lobakin@intel.com"
 <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240216184332.7b7fdba5@kernel.org>
In-Reply-To: <Zc8XjcRLOH3TXHED@nanopsycho>
References: <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
	<20240131143009.756cc25c@kernel.org>
	<dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
	<20240131151726.1ddb9bc9@kernel.org>
	<Zbtu5alCZ-Exr2WU@nanopsycho>
	<20240201200041.241fd4c1@kernel.org>
	<Zbyd8Fbj8_WHP4WI@nanopsycho>
	<20240208172633.010b1c3f@kernel.org>
	<Zc4Pa4QWGQegN4mI@nanopsycho>
	<20240215175836.7d1a19e6@kernel.org>
	<Zc8XjcRLOH3TXHED@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 09:06:37 +0100 Jiri Pirko wrote:
> >We disagree how things should be modeled, sort of in principle.
> >I think it dates all the way back to your work on altnames.
> >We had the same conversation on DPLL :(
> >
> >I prefer to give objects unique IDs and a bunch of optional identifying
> >attributes, rather than trying to build some well organized hierarchy.
> >The hierarchy often becomes an unnecessary constraint.  
> 
> Sure, no problem on having floating objects with ids and attributes.
> But in case they relate to HW configuration, you need to somehow glue
> them to a device eventually. This is what I'm missing how you envision
> it. The lifetime of object and glue/unglue operations.

My desired lifetime is that the object (shared pool) gets created when
the first consumer (netdev) appears, and destroyed when the last one
disappears. Just like you can configure huge rings on a NIC while its
closed and that won't consume any memory, share pool shouldn't exist if
all its consumers are closed.

The tricky part is to come up with some way of saying that we want
multiple netdevs to not only use a shared pool, but which ones should
be sharing which pool, when the pools themselves don't get explicitly
created. Right?

Gluing to the device is easier, IIUC, once the pool is create we can
give it whatever attributes we want. devlink ID, bus/device, netdev,
IOMMU domain, anything.

