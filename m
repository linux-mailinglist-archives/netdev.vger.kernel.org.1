Return-Path: <netdev+bounces-219720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F3B42CB4
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78090565C1E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916942EDD5B;
	Wed,  3 Sep 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvpEoH6/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC02ECEBB;
	Wed,  3 Sep 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938013; cv=none; b=nviALpu/l77AZwy+xIXA8MwDf30Pr3DEhvqK1I6bkfBBJaNqR0GOMx3ZJ02fYOQ4vfCG+PWRAILCYn/ROjeXP1OKMtVQ2pceaqfXbDLWSKsropAKCszdlBbDkfZwHTQiFZg6AchTuBNfl6v5ZEBao8+Pk9woHdpL06RCLZmafZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938013; c=relaxed/simple;
	bh=GKskKvjwTQjxCOkWbjju75CXmHBhJO+i0NZuqMD0kCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DCmcCFI+D4Jj3VKIyhlElmBj/JzjAsvsOBMccRnQR356QIEZuxEdlYTv7u8EL0KiRoS+3SopUFXcxKDrDmeqYuxYqejxRzbdBTC6SMYFAPp3q3+6eM/Bsu78ALf+ueNjdI5YUNa8eX6qlTI2q4WuOHgVU9RHUV0ORbV5/oR1OVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvpEoH6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFB9C4CEF5;
	Wed,  3 Sep 2025 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756938012;
	bh=GKskKvjwTQjxCOkWbjju75CXmHBhJO+i0NZuqMD0kCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OvpEoH6/Fa7oCyKOIg4DnOEtvSjlneTY+iiGm8B3hcSiNLIUGpKsWxjriNTXKSQHr
	 WXiFWt8bBTzzlk86WrGZseFTm4gN33DIhUz5RhiR5UFJC1gQ9LQzVyXnE3pO0IVA7v
	 iPeVZoKgF4nOBvS/68X+08kGjR3h9ehc2K4YV/2SJ7y3wLDWCF4Iu6iLjsu7tab6Fs
	 /Ma6HlcgB8VGxPUt2Y35cDZ9fu8fgjxeOaBqopsAOhQrgilpO70pko6sJ3uvHekztn
	 e4W1vhjt5Pt4buiZ0z+AWiqF32FjvGvojKB/Xc3Qci+Qh4YZSxqhRpyEKlo57L6sXK
	 Yqtx7QGoSIWTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF5383C259;
	Wed,  3 Sep 2025 22:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] tools: ynl-gen: misc changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175693801774.1219827.14693293416647731068.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 22:20:17 +0000
References: <20250902154640.759815-1-ast@fiberby.net>
In-Reply-To: <20250902154640.759815-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, horms@kernel.org,
 jacob.e.keller@intel.com, matttbe@kernel.org, dsahern@kernel.org,
 chuck.lever@oracle.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Sep 2025 15:46:34 +0000 you wrote:
> Misc changes to ahead of wireguard ynl conversion, as
> announced in v1.
> 
> ---
> v2:
>   - Rewrite commit messages for net-next
> v1: https://lore.kernel.org/netdev/20250901145034.525518-1-ast@fiberby.net
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] netlink: specs: fou: change local-v6/peer-v6 check
    https://git.kernel.org/netdev/net-next/c/9f9581ba74a9
  - [net-next,v2,2/3] tools: ynl-gen: use macro for binary min-len check
    https://git.kernel.org/netdev/net-next/c/5fece054451b
  - [net-next,v2,3/3] genetlink: fix typo in comment
    https://git.kernel.org/netdev/net-next/c/017bda80fd0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



