Return-Path: <netdev+bounces-83139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E889105C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1FFB21C66
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB017576;
	Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv7GnLgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7B12B83
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675832; cv=none; b=Hcto60jVZ+sUeu2537E5Ie13WqN8p82LXNWKRtdgyb6Tx+eyNYTiI9J7yElbvJc1DpGZxuzXneThleaz3HyNbgi3omQnhci3SUGhs9WLWtInJxGoDmW6urbLlzzOyYCv+rHmKjAycmSavLw90PwIkNNnLAnUcgsWETZ9xMQS62c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675832; c=relaxed/simple;
	bh=KqG1/6CNOZ3/zscWyJ6iaAoQm4UN8htqnkzRjpthG2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nqbGZZffg6AYB3KOqUEhGBPC8GlQQ3c9ZK2z2FbGI6tZvrWnvgvoX70zK9WFhtZKuLZvizC56y784QwnTEReasArri2qq5NwILfhXBtmDCUqoyPeM7/OMjJpI3HvsAw3ylj+ZKlhFFBcoiXm4kHQgvw0JmnwAksU1DClhKS83K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv7GnLgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EEAFC43330;
	Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711675832;
	bh=KqG1/6CNOZ3/zscWyJ6iaAoQm4UN8htqnkzRjpthG2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cv7GnLgIPd8XQzjdw0hg2IgzshjoaT92/3mhtn1tBGRYV4HMClp5wHj2px59ROo5q
	 qKLJnmu19Tv6MVT5h5nY2y0dYeWuwRFDXi+1HiAV9qqgVzpArG9oH7I3b5LUsNNozx
	 9mhrY/jEWY80k2Gz9CajET2StFxfVYgDX7rsqB3vbWjUVxqdKChgf85bjpMlE34x1J
	 vQGuRut5qzv7RCkEeeVT0pNajpeQZ9Pilnkk9NklqWdy2sHW740LV93Lrlwy1mFtQR
	 Fm3ZjbtXf+u/jPdTVjYnVq7rHO8gZPnfPJYjwWXKpLsbKojOGbqyxtCYSitoC6Fg8R
	 7e4puL/RmxAGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87AF1D2D0EB;
	Fri, 29 Mar 2024 01:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xen-netfront: Add missing skb_mark_for_recycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167583255.32458.14379553283592807838.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 01:30:32 +0000
References: <171154167446.2671062.9127105384591237363.stgit@firesoul>
In-Reply-To: <171154167446.2671062.9127105384591237363.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, arthurborsboom@gmail.com,
 ilias.apalodimas@linaro.org, wei.liu@kernel.org, paul@xen.org,
 kuba@kernel.org, kirjanov@gmail.com, dkirjanov@suse.de,
 kernel-team@cloudflare.com, security@xenproject.org,
 andrew.cooper3@citrix.com, xen-devel@lists.xenproject.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Mar 2024 13:14:56 +0100 you wrote:
> Notice that skb_mark_for_recycle() is introduced later than fixes tag in
> 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling").
> 
> It is believed that fixes tag were missing a call to page_pool_release_page()
> between v5.9 to v5.14, after which is should have used skb_mark_for_recycle().
> Since v6.6 the call page_pool_release_page() were removed (in 535b9c61bdef
> ("net: page_pool: hide page_pool_release_page()") and remaining callers
> converted (in commit 6bfef2ec0172 ("Merge branch
> 'net-page_pool-remove-page_pool_release_page'")).
> 
> [...]

Here is the summary with links:
  - [net] xen-netfront: Add missing skb_mark_for_recycle
    https://git.kernel.org/netdev/net/c/037965402a01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



