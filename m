Return-Path: <netdev+bounces-225435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8827DB939EF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B963189EA34
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DEC302CB2;
	Mon, 22 Sep 2025 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVvWcj/d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C42EA46F;
	Mon, 22 Sep 2025 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584420; cv=none; b=U9uWLA73Kiv7DBxd1Xj+bcBxICJfsRg/wj1pHTZlQIfPtAigBNGC04PdHHiUyh60p0opeM6TI6KpKmbciBiofM+1/UgveFyTatl68ClOMSYEpb5LKXsqBxHo36U6+95muElCbvckXQ+sePC0+1iHQcaWPJJWtm34iUZvA+trEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584420; c=relaxed/simple;
	bh=nOnerZmRV0c5WJjU8VhwkEjiAKaD2K/BYYOQhijJfIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Edo5fqUCdW0+qPmRxQHfMgtIq/8knvl2L4zcXfkKZCvtJjKAVo40O5v68UO05MRtuRa30aYnAUpkzTsHpf4/yk/zvb12WyfhxYVNQlK/zEbjZGhwsMM16vOLSfaJ3l74vGJKSPzmCvJeViASXH1UHIhtyIiVVkOodBirEpWCFy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVvWcj/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33106C4CEF0;
	Mon, 22 Sep 2025 23:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758584420;
	bh=nOnerZmRV0c5WJjU8VhwkEjiAKaD2K/BYYOQhijJfIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uVvWcj/d0yvTzBZDzbmzaCkaA+HwY1/+ztqjUkAPwBGkQmYWD+afeV2VTWk2Biz5j
	 +qIEF9I91+EB1NyPSdpNe5GLcdzoHp38Qj9LplT1G72W0b3pZBlVnHlKRqbxcE/fth
	 5EVClVWy/KfwgO0Ac/O/UACM9gj/pAEnOR+XVC8kEqkYj8/QUW6WDqeg5ybc00eoHP
	 rfS4Tgx4UO/+7SN8skCnM7YKQSYoYhJfpxecdumcjp8bUY07dpwwjOkYOXjDSn0GfH
	 QILHSOhqh0WxXsZ4zL/6p0eVB2v5vIZyhOcTv2yC5CAhV+EYlwDUnHwpjEWCM4pMWy
	 v9tN3L08gSDxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1A39D0C20;
	Mon, 22 Sep 2025 23:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3] net: xilinx: axienet: Fix kernel-doc warnings
 for
 missing return descriptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175858441749.1195312.3629295031958677070.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 23:40:17 +0000
References: <20250919103754.434711-1-suraj.gupta2@amd.com>
In-Reply-To: <20250919103754.434711-1-suraj.gupta2@amd.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 sean.anderson@linux.dev, radhey.shyam.pandey@amd.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harini.katakam@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Sep 2025 16:07:54 +0530 you wrote:
> Add missing "Return:" sections to kernel-doc comments for four functions:
> - axienet_calc_cr()
> - axienet_device_reset()
> - axienet_free_tx_chain()
> - axienet_dim_coalesce_count_rx()
> 
> Also standardize the return documentation format by replacing inline
> "Returns" text with proper "Return:" tags as per kernel documentation
> guidelines.
> 
> [...]

Here is the summary with links:
  - [net-next,V3] net: xilinx: axienet: Fix kernel-doc warnings for missing return descriptions
    https://git.kernel.org/netdev/net-next/c/312e6a58f764

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



