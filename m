Return-Path: <netdev+bounces-78850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA3876C57
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E2F1C2163F
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 21:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9245FB98;
	Fri,  8 Mar 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYQQLM1W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560E5FB8D
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932836; cv=none; b=MD44WV0a1PtgovxvRWZPxKT7nPdAsmga1m9SuKp6utV/IofrW8A21kjSza+1P73tbUxF2+eHTyYhS+ERi4gdnom6mQXaNPLH4ZJb9Osxyv9Sa768Y7h7m66GXBAUdnbSOJEMlwCFicA1KL4ZXm8d2H2Lh9JLqMDjRF83YqYl1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932836; c=relaxed/simple;
	bh=7+78oklhsNOulD6tNX/NINjtFsppNoyIJ3KugelH/z4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ig8Tn7WIy9Oes1dlXMej+44MOjzw4aMEfQAWGXdfzvpmonbE+JXwqaHy1viJ2zKZkknNu0+FTWbCk9ScucHp64QU0vzm8OIS/88K6DCpis07TbVIB1/wpr40EOtQiZRNZMMVXMvyZwEK920b8qEIDm3xCujGm/zCSag5lCKqMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYQQLM1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FE1EC43330;
	Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709932835;
	bh=7+78oklhsNOulD6tNX/NINjtFsppNoyIJ3KugelH/z4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TYQQLM1WLHktwrI+VSy3Xcjf8/KncPafIWM1LNpy6PkuwQOkW+LdQNuKL9FnkJATx
	 eCtGawc8+xLwMfyf+FEt8eJ4HBdtvjgtc9TUszsjEWCiit3+T3ZEe1fa+bNQzn+79e
	 Y+R3pxSHXg8j1eMD447Q0hTsSFmidQlKwc8wUjxYv5n/SB5i3BQspamWfDVeKtYx49
	 LZY3JcWOlXpPfJAU6C2RKVCoeiomgS59uC7zwqjDF1oQY42m1OB1CDxIgHhOS059aO
	 RyBMThCHgzdGZeny+dg5AY9Elh4HVsk9n5CG+T4t30XE0hv+r6mYu5De++CSxg7fPB
	 lrDzQYds3Avyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82ADED84BDC;
	Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nexthop: Simplify dump error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170993283553.29743.15411416591840690669.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 21:20:35 +0000
References: <20240307154727.3555462-1-idosch@nvidia.com>
In-Reply-To: <20240307154727.3555462-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 Mar 2024 17:47:27 +0200 you wrote:
> The only error that can happen during a nexthop dump is insufficient
> space in the skb caring the netlink messages (EMSGSIZE). If this happens
> and some messages were already filled in, the nexthop code returns the
> skb length to signal the netlink core that more objects need to be
> dumped.
> 
> After commit b5a899154aa9 ("netlink: handle EMSGSIZE errors in the
> core") there is no need to handle this error in the nexthop code as it
> is now handled in the core.
> 
> [...]

Here is the summary with links:
  - [net-next] nexthop: Simplify dump error handling
    https://git.kernel.org/netdev/net-next/c/5d9b7cb383bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



