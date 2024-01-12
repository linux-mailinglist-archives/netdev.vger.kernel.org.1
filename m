Return-Path: <netdev+bounces-63180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2E182B8D4
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 02:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1221F2294B
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A500657;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHVoiAOo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA1812
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14C00C433C7;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705021228;
	bh=MjuqrrP/k7ZAB4u1FwIHyo6DeztUIxK3xnrEd5re4FM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tHVoiAOousmIw5AX62xQq2+hDRMLD7r1tz86y29uqnZwIKSltL3W6SevcuOZ9DgsC
	 0/8AbMUYNZlKQDom+6KVONPuX2qgq/EvEgn568RHUCJaq4kZ2bEZNwuE4IdLe+MJ4n
	 SN5hheAXvBOrRDtg08oPSmXfi6yxEHHgfuvc1PhE1yubEP7pF1PvY+Dz0eE8EjUg5S
	 LPtIomsEt8ES1W2Ya5la2sdNPg8rfoaVGt9oQtabSLNoaueGsCfjjrAfn+NFLRwr0e
	 nsezrpct26ZXakEBc1T0hgkqti/ntL6Ba/iTaqexHMwNqJctHmLxjEYiR+uuYve3aq
	 NDdrj62/fbKyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFE7AD8C96E;
	Fri, 12 Jan 2024 01:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] amt: do not use overwrapped cb area
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502122797.27071.8122966905196411649.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 01:00:27 +0000
References: <20240107144241.4169520-1-ap420073@gmail.com>
In-Reply-To: <20240107144241.4169520-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, paulb@nvidia.com,
 jhs@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Jan 2024 14:42:41 +0000 you wrote:
> amt driver uses skb->cb for storing tunnel information.
> This job is worked before TC layer and then amt driver load tunnel info
> from skb->cb after TC layer.
> So, its cb area should not be overwrapped with CB area used by TC.
> In order to not use cb area used by TC, it skips the biggest cb
> structure used by TC, which was qdisc_skb_cb.
> But it's not anymore.
> Currently, biggest structure of TC's CB is tc_skb_cb.
> So, it should skip size of tc_skb_cb instead of qdisc_skb_cb.
> 
> [...]

Here is the summary with links:
  - [net] amt: do not use overwrapped cb area
    https://git.kernel.org/netdev/net/c/bec161add35b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



