Return-Path: <netdev+bounces-129441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD26983F15
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBD11C22703
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807B146580;
	Tue, 24 Sep 2024 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4yYFBMg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F0145B27
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162981; cv=none; b=gr8LIgtfZEE0GM84F3IxI64egcITPFMHA/dAb0VF6H5x19sTZ1JNCVOGAsbjjM6Aw7id3RmeOsH3nByVCHiieEBggYE9MxeI0anjRhe2omYPqvKLOxE00CeAQlPi4kh6XdVOS08a6ouWNBNJRgH6d8lq75s2u96kZCULEZnpEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162981; c=relaxed/simple;
	bh=rOAJduxl5bvpn7lDFGbGgG3kNMf0K7nmL+pHNzW1pHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmTtBGYoWAoEcMMNxedHm7RBbTnUhUYXIPR28aMdCP5tX5PBWg1/xtZUhiePFW9B4a94BtxuvbjyXfNBcp+sDANRroKa/LK8TU41SmMtB435aX/Vdz0Tzdb6TNb7YbhjBdMrAdsaEv1lUtG/epF0Lj7PLhbXXxofOMTDZbtcWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4yYFBMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A07EC4CEC4;
	Tue, 24 Sep 2024 07:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727162981;
	bh=rOAJduxl5bvpn7lDFGbGgG3kNMf0K7nmL+pHNzW1pHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4yYFBMggBBWxH5Ufq5Kj2iHaIHXRptq9Qda2joSSErXpzyJwPlfAmEK9OzGPWEWw
	 lNd9NRmM5egZWxaUeEWaSqJHZz6OxzcKcch9zpXcNu1laWeEJw+QfYIiEqXt83fH8c
	 ZPpvzDEhK/eBg/+kTv8jBB7R1qE1J22zeVKT5l6x+tRssTjLuipye+PiShvhMfuLZ0
	 fpBOOnvM+knhRcTmdEvnP0dUNtYgXSGsYTrTg1ZAYQ9wowwpI7Z6FROu0FKYiD7Q1k
	 HnCaaBuPNUJV8FaAWN0Zo7qhEvuH16N4RVkdENiPICr5DRDvpXzwFzuZd0vIRnEJgC
	 E35FGgWV5o2Hg==
Date: Tue, 24 Sep 2024 08:29:37 +0100
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: Switch back to struct
 platform_driver::remove()
Message-ID: <20240924072937.GE4029621@kernel.org>
References: <20240923162202.34386-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923162202.34386-2-u.kleine-koenig@baylibre.com>

On Mon, Sep 23, 2024 at 06:22:01PM +0200, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert ethernet clk drivers to use .remove(), with the eventual goal to drop
> struct platform_driver::remove_new(). As .remove() and .remove_new() have
> the same prototypes, conversion is done by just changing the structure
> member name in the driver initializer.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> I converted all drivers below drivers/net/ethernet in a single patch. If
> you want it split, just tell me (per vendor? per driver?). Also note I
> didn't add all the maintainers of the individual drivers to Cc: to not
> trigger sending restrictions and spam filters.

Hi Uwe,

My 2c worth on this:

I think that given that the changes to each file are very simple,
and the number of files changed, a single, or small number of patches
make sense. Because the overhead of managing per-driver patches,
which I would ordinarily prefer, seems too large.

However, touching so many files does lead to a substantial risk of
conflicts. And indeed, the patch does not currently apply cleanly
to net-next (although it can trivially be made to do so). Perhaps
the maintainers can handle that, but I would suggest reposting in
a form that does apply cleanly so that automations can run.

Which brings me to to a separate, process issue: net-next is currently
closed for the v6.12 merge window. It should reopen once v6.12-rc1 has
been released. And patches for net-next should be posted after it
has reopened, with the caveat that RFC patches may be posted any time.

...

-- 
pw-bot: defer

