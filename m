Return-Path: <netdev+bounces-94598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5F8BFF76
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2691C23461
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C731F84FB8;
	Wed,  8 May 2024 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2KoI68r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2885281
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176163; cv=none; b=dIiGqytGkhlidgsK2pLO4bORieZMV5QENhmacc/ccDx3Mu49mOGfAPvqZ2aSOzJcNpPS0Owvt9pQVJVcE2ow9jEX3Nh0ynsgMr+z2yj3GzNuTNQYD3JqnOIfKBWpi5WKCokJG/uEixJVRieD1LRRW83aE0/lddiLFyzohDImdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176163; c=relaxed/simple;
	bh=ha24tXh+FlN2ZY/wMaMW9zpguQyt/JjmW9Q1piyIZrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDF39pO9cjN4hapqlJMMi4pabydHP8WnZ0eLks4AkB2hDwUcFHXGNWyWGu5VtXVytsDxDEdXluOV7ysNVJCweE3SA6vhIh0XUVhMq4SnzA3OJuBhpNPUstcK7DmMtdV33q8tgLWAO9YTyhnM4W01jgZWmoQdVWfYHSOyGlVyfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2KoI68r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3525C113CC;
	Wed,  8 May 2024 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715176163;
	bh=ha24tXh+FlN2ZY/wMaMW9zpguQyt/JjmW9Q1piyIZrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q2KoI68r+hjDmAXjs544ebWuCgh04mi2IWm2LUWGgjgbC1EQ+LkP+VfENZPQFgiBD
	 a52sS9ZjwVzd0S5FYD1LrrXcTZRspqUXPhxatRV4k/CSuaid+IDvM21HrvtvkGe5Ni
	 Zh7zMRkz8WQZCAdlaE7zWH0NRL4TNXtzmYu1tHf/qB76PBzhbYKNKqV0Q6y1l6Mpmj
	 3KbE2RO13uftb1mADGfb3mv5Kahb6yU6ghVkYkL6OYRlrfrJW/GUqerMjEOR2sXV9F
	 8+F7BctK2zl+71hHEp93Ily6n0RcNWynNKgavBy0MJ01nfyLzYpDgqyL2lwXO/sBSn
	 jt8aPZreWiJwQ==
Date: Wed, 8 May 2024 06:49:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
 horms@kernel.org
Subject: Re: [PATCH net-next v4 1/6] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
Message-ID: <20240508064922.77e4a69a@kernel.org>
In-Reply-To: <20240508.163618.289658716761599768.fujita.tomonori@gmail.com>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
	<20240501230552.53185-2-fujita.tomonori@gmail.com>
	<20240506183825.116df362@kernel.org>
	<20240508.163618.289658716761599768.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 May 2024 16:36:18 +0900 (JST) FUJITA Tomonori wrote:
> > On Thu,  2 May 2024 08:05:47 +0900 FUJITA Tomonori wrote:  
> >> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
> >> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));  
> > 
> > This fallback is unnecessary, please see commit f0ed939b6a or one of
> > many similar removals..  
> 
> I see, fixed.
> 
> It might not be necessary to check the returned value here? I keep the
> checking alone like the majority of drivers though.

Right, keep the error check. It's just that the failure, if it happens,
will not be related to the length of the mask. So "fallback" to 32b if
64b fails is unnecessary.

