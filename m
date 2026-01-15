Return-Path: <netdev+bounces-250002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA58AD22459
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 04:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BECE301D60B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 03:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B332040B6;
	Thu, 15 Jan 2026 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULcwZOoq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5D8F4A;
	Thu, 15 Jan 2026 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768446898; cv=none; b=LCaJGq9aqELkoVLsYOUwBLn33K74OJLe7cxcZztMwUbgFJxDkGyA0ggN385e0LsxJCR/pcFSOrVkPXbE00NWlTsunQvel/WLv/1c9y+70IBgtEqCtn9VjyHIzTiIkHPJfAdyvmI5bMLb46PoiRxhqfbw1+Eovfx8S6H0Kv5jOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768446898; c=relaxed/simple;
	bh=xtBLsRtcp+hQsQVvzJIgMHZC6qdZzw0SgcgoTW93HbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMieo1SflVwTf7xLVcyb3hmkpyWWUUdPWRI3s67YrX5HwARBlJyO4XCMDBV44cuWekAIH9pn6Z5Hj1afnV5i0eLw7RPY81r0ifdVRKH5T24NN6q2Bhggf5emKcG+hvp49cxMbyWm87yUKfm72YO44JDfxrrc2Rkr9ATEmVLEeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULcwZOoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C59C4CEF7;
	Thu, 15 Jan 2026 03:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768446898;
	bh=xtBLsRtcp+hQsQVvzJIgMHZC6qdZzw0SgcgoTW93HbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ULcwZOoqioRbH12Rk/SqNX9809yIOwfmZQglqaE+BUWxSVv4l3OKHMKOGYNPG2qb7
	 6ITNbS/wO97xfZWNSYeoU63KceLz3kV9VQP08A/ih1vQR2jQgZ5+DwJa4neah4KWZh
	 Jr9Ba7R40Dh02H7Wka8PVN7peNRMIj3bGPx3CUnsLxRfAkVsTrrmN+1PXkGrbCsQQ4
	 Q//WazqrJkk/9SsCD4iR2JFgEaiEizNxnl1RxwdKZVHLi5CKOABs6l7IoE7XvHYFnC
	 CSUI73Z4u+vjvF+BW3rJEVcsajbo5RVQZov342OfSF6A5bsY8re7LtdC2a7pYcRWUL
	 JuGPOjBzH9hyQ==
Date: Wed, 14 Jan 2026 19:14:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>, Saeed Mahameed
 <saeed@kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 01/13] octeontx2-af: npc: cn20k: Index
 management
Message-ID: <20260114191457.24046bdc@kernel.org>
In-Reply-To: <aWcvE-WN09pvpS4g@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
	<20260109054828.1822307-2-rkannoth@marvell.com>
	<20260110145842.2f81ffdc@kernel.org>
	<aWYebi6adm9zD2gB@rkannoth-OptiPlex-7090>
	<20260113070732.6eb491de@kernel.org>
	<aWcvE-WN09pvpS4g@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 11:22:19 +0530 Ratheesh Kannoth wrote:
> > > Customer can change subbank search order by modifying the search order
> > > thru this devlink.  
> >
> > Unclear what you're trying to say.  
> TCAM memory is dividied into 32 horizontal chunks. Each chunk is called
> a subbank. When a request to alloc a free TCAM slot is requested by PF,
> these 32 subbank are searched in a specific order. Since bottom subbank rules
> have higher priority than top subbanks, customer may need to alter the
> search order to control the distribution of allocation to different subbanks.
> 
> Example search order format to debugfs entry is as below
> 
> "[0]=[8],[1]=7,[2]=30,[3]=0,[4]=1,[5]=2,[6]=3,[4]=4,[5]=5,[6]=6,[7]=9,[9]=10,[10]=11,[11]=12,[12]=13,[13]=14......[31]=0"
> 
> This input "string" is too long for devlink ?
> 
> union devlink_param_value {
>         u8 vu8;
>         u16 vu16;
>         u32 vu32;
>         char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
>         bool vbool;
> };

Sounds like:

https://lore.kernel.org/netdev/20250907012953.301746-11-saeed@kernel.org/

This was never fully merged but I think it's the best fit for your
needs. Saeed are you planning to come back to it?

