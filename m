Return-Path: <netdev+bounces-83146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4383289108A
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C03E6B20D9B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B01B17BDA;
	Fri, 29 Mar 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE0v6Jjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFD14A8F
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677030; cv=none; b=kRfLRx/64/ggZ22ZEyVpNS6237XW2/CQwqHZWSyfLlRA/cHdGyr/ZQQWnPeYKM5HbhHEz+pOuRB0p/UE+HNRFan2OIZbh0Vs/sWQg6B4jErLeT+L/Usrc0jWADtzsbrtpXEKEbhjj7CeghbJb/yiYKZVnEr2o6gQKFMZ3MbY49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677030; c=relaxed/simple;
	bh=LadFdNAs2gpLM+Z83RwB1YgHe33AxmBjBG1qdF9v/KE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N314Dm8LLpd6TN35UWV5eMv+gjygblFopyftHZg0O8HZZllk38llJSJfnzRUD9tQTD8XeCA/Ov3wGB3++wW0zKve+Zf3Hk2kZ4kOueLNZDc8Qp6nMD5X0wCmMxDGSpOGY7ZzNCfekfyNyKadEusRwChv85B8dnMBMts7+RaO1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE0v6Jjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6F79C43394;
	Fri, 29 Mar 2024 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711677030;
	bh=LadFdNAs2gpLM+Z83RwB1YgHe33AxmBjBG1qdF9v/KE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nE0v6JjoY/LFuCnfpSDV7ZHt278ZCYBN+PU/uw02W6pWrVBW9aDwsIuP2TOPC6bhV
	 FqSPdVxE7o4WWujh1RTsKe3f3JzVHQJ6VgjFGqOLdI/tKGHkYW6E3n6Au7s5HglENk
	 BTWJv6XYrtFDbPg0m77yapwSfBkcVqgsBkVAS+ZgbDPif+10B1elw9SdFbEt5fVg6b
	 +qXHbD2IERxu7K4njn3nxTaXyJzbS6Vn5B/mfLP83i4hxgfhUr/MLHLCBHlIiubsm1
	 A1Xlzgui7+jhbwmBZPtugw469ia5/eAKnF8wXEtE2uJbK9+CDWnzYZj9gD76SHSuzg
	 /+xUZ11adfNZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE6E2D95064;
	Fri, 29 Mar 2024 01:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: remove gfp_mask from napi_alloc_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167702984.13430.7602410766409441835.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 01:50:29 +0000
References: <20240327040213.3153864-1-kuba@kernel.org>
In-Reply-To: <20240327040213.3153864-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, aleksander.lobakin@intel.com, alexs@kernel.org,
 siyanteng@loongson.cn, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
 intel-wired-lan@lists.osuosl.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Mar 2024 21:02:12 -0700 you wrote:
> __napi_alloc_skb() is napi_alloc_skb() with the added flexibility
> of choosing gfp_mask. This is a NAPI function, so GFP_ATOMIC is
> implied. The only practical choice the caller has is whether to
> set __GFP_NOWARN. But that's a false choice, too, allocation failures
> in atomic context will happen, and printing warnings in logs,
> effectively for a packet drop, is both too much and very likely
> non-actionable.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: remove gfp_mask from napi_alloc_skb()
    https://git.kernel.org/netdev/net-next/c/6e9b01909a81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



