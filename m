Return-Path: <netdev+bounces-211830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E17B1BCFF
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 01:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99FD18A42F6
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81E26B74F;
	Tue,  5 Aug 2025 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoIQwYZd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7525B693
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754435999; cv=none; b=JA7M2r/OavUhf8zUhtRrqnPk6vUrf2+FeQYWcmRJPCT3IwXI3VTbnj61X34u0K6ECVNW4tu+2NpbRMAQcAufOTfNShr03EsQ+RdLlG9g10QsJ8EyUj3a4XjINJrfJntCoQbxjAUixMAmYiirJWu4ZctJQUyqYXuZd+aZIeOtiwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754435999; c=relaxed/simple;
	bh=TFw/I9lpDG79GSntIEIBV75XyYqyD2ZTO+aSVKEC83U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bu8jMAtEdlxroQiW4DIiEEF3URdJsisrjPcwT22PscmCmxLbB2DmMyHm269wvknWdxu0f9/q3aV+Fuj1w9gt8dLJS7LRziT1YUmWPR2EprHr1UInmdeZz9dehK6DoSLTA7XPoYkDinUV+QGlskerdFZTzHvlLRqOPhCCpXZz3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoIQwYZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BBDC4CEF0;
	Tue,  5 Aug 2025 23:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754435998;
	bh=TFw/I9lpDG79GSntIEIBV75XyYqyD2ZTO+aSVKEC83U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YoIQwYZdP0crxRu7U9f2Mgi+Q4j6GC0BUP/xkkB+9aE38L7X/xsRVfsvO4OBQ8+hd
	 wt+tE53uessAQxYS9Ck8GV8thWH/5OXn9YDEE5TkYDvCgvElE8OvstInJUNnhiPBJy
	 LoCl8ttB6Lkv0gptibu8CWSZh8/eucn80AAL303xwMzh6eClFb+4h5wT+m8+hJ52gL
	 8ndxmiziCIiGUeGwXPpPQQ/xzKI/Pu+0rwflT5yXntAS3Kv1Y7//39sCHWXDR8WGtq
	 qsdlEVBdLYxhM2IUKvs7E3nyAkoZPWRpOrvFtmLNt2xrWUNr7Q7ts4oJgjnZ+vQreN
	 foBAuCGyTEEbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD77383BF63;
	Tue,  5 Aug 2025 23:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ftgmac100: fix potential NULL pointer access in
 ftgmac100_phy_disconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175443601276.2197607.14083823596333056982.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 23:20:12 +0000
References: <2b80a77a-06db-4dd7-85dc-3a8e0de55a1d@gmail.com>
In-Reply-To: <2b80a77a-06db-4dd7-85dc-3a8e0de55a1d@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, horms@kernel.org, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jacky_chou@aspeedtech.com, jacob.e.keller@intel.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Jul 2025 22:23:23 +0200 you wrote:
> After the call to phy_disconnect() netdev->phydev is reset to NULL.
> So fixed_phy_unregister() would be called with a NULL pointer as argument.
> Therefore cache the phy_device before this call.
> 
> Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ftgmac100: fix potential NULL pointer access in ftgmac100_phy_disconnect
    https://git.kernel.org/netdev/net/c/e88fbc30dda1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



