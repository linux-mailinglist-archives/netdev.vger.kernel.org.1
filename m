Return-Path: <netdev+bounces-76015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801F386BFD2
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04AAFB232B7
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2C6381AA;
	Thu, 29 Feb 2024 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX0PwHLW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28D37705;
	Thu, 29 Feb 2024 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709180429; cv=none; b=D4NjeCQ+3ASl3P2yYSbrt0AzKc61jEpDVCUqfMKgqNCpNtno27757mSmqApa4jczF7SSCMsKg1XqddH/A9/mIujeRKgUsGmF2LFl/5ksZXfC9GJkGBHNw8FvB7Bm8oftIOktcT2Ut9x5WuBuVe9H/vPRdgzDkZ2u1WMHO516MjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709180429; c=relaxed/simple;
	bh=4p1jxEsEK4QSY6EU7uTlf24S6PSlWpg+/radI5Gwf0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BJ5Hvn47G796a1ZuadGrSSCp+lR5vURB6WlSitn3WN7BKphkRhx89JxASqEMFUZ7KWHEw5bM8tVbbbJKwgIXxaieMoC1432zSk38kGgZoPxJNuLuaShc+h3K0a1xIPkPTQDh3jHsYYMQfUHI9EUSP4prAIr2t/sTpEIAhqjjG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX0PwHLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36FCCC433F1;
	Thu, 29 Feb 2024 04:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709180429;
	bh=4p1jxEsEK4QSY6EU7uTlf24S6PSlWpg+/radI5Gwf0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pX0PwHLWO0+XktIezpb6Cm63+aFzb0hXsbzE5eTQ6w3RFxwNydx9LFQv3XCr7BwBS
	 8erGA5O+KphyInOckr4ElF9NyB92K0nUb+hvMvW2HQ9fmPAanVMucTNYgq7yzwcHQn
	 yALSxdAjadgP1fMwYtNnmz/gEDWdeRhlEdOEr/Mc/PypRHw0mdU4yIXJIE0vln2Wi9
	 uqjz+YB1pR0RkZSVwYlLzAI9AO0Bu1UmWUf56uL+sPlQEoRYUIGhY2F7+V6mqAMXsV
	 FZbtAq56iCtNHiwzhS3qiT4v8fWX0p6yW6WL4U6lVkgxKYhpTUdjypZYOzefFjBC5Z
	 RwbzM2TD/lBFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AF4FD88FAF;
	Thu, 29 Feb 2024 04:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: bridge: Do not allocate stats in the driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170918042910.11535.3465744324810868254.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 04:20:29 +0000
References: <20240227182338.2739884-1-leitao@debian.org>
In-Reply-To: <20240227182338.2739884-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, razor@blackwall.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 bridge@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 10:23:36 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: bridge: Do not allocate stats in the driver
    https://git.kernel.org/netdev/net-next/c/d35150c79ffc
  - [net-next,2/2] net: bridge: Exit if multicast_init_stats fails
    https://git.kernel.org/netdev/net-next/c/82a48affb36f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



