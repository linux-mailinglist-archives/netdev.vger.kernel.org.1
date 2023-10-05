Return-Path: <netdev+bounces-38329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF837BA6A9
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 14929281E68
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A136AEC;
	Thu,  5 Oct 2023 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHixNa63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12529425;
	Thu,  5 Oct 2023 16:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DA30C433C9;
	Thu,  5 Oct 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696524025;
	bh=7XaG2GVyPHp1/W38bWaJQuHP6bwhoDCUos4hHFNyh1k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FHixNa63p9+sq9sl9xv45dsxDc4xz16wlMyHd+TEaNB0Zs0N96RDDlqmwEYPjAaIS
	 lxdY1eSdyyKLUY9ps3r4UXEKqpqYHkATZ5E5/fg5ZGbkD0MDFyHQ1HOT0qrqxUFIgZ
	 OOecBBpV5yrvJwNUp+oze+Y269Y8lbXbc9mBLpLXidTc6ehVHuMFQU9o2tzdnX+fBY
	 JllUzRVuCsvJ5zKNzbA197qjlyJUT6BZrvTLYk6R9fbfQdfLWfSC9wUzLfgycD2uTe
	 I5/SZm74Dzy4T+Mdq2dmigJIE2UOVI1HK3VpC8H+UCJ4b2qbPx9/SlIdVv1UaLT3+e
	 m6xBvc+eDDPww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67275E11F50;
	Thu,  5 Oct 2023 16:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: Fixes and maintainer email update for v6.6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169652402541.29548.3696837409901235215.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 16:40:25 +0000
References: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
In-Reply-To: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: matttbe@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, kishen.maloor@intel.com, fw@strlen.de,
 stable@vger.kernel.org, geliang.tang@suse.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Oct 2023 13:38:10 -0700 you wrote:
> Patch 1 addresses a race condition in MPTCP "delegated actions"
> infrastructure. Affects v5.19 and later.
> 
> Patch 2 removes an unnecessary restriction that did not allow additional
> outgoing subflows using the local address of the initial MPTCP subflow.
> v5.16 and later.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: fix delegated action races
    https://git.kernel.org/netdev/net/c/a5efdbcece83
  - [net,2/3] mptcp: userspace pm allow creating id 0 subflow
    https://git.kernel.org/netdev/net/c/e5ed101a6028
  - [net,3/3] MAINTAINERS: update Matthieu's email address
    https://git.kernel.org/netdev/net/c/8eed6ee362b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



