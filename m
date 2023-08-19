Return-Path: <netdev+bounces-29026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7FA7816C1
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7C51C20C76
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D868B817;
	Sat, 19 Aug 2023 02:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8CC634
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A218C433D9;
	Sat, 19 Aug 2023 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692412821;
	bh=jEmwpmZVCQjEo9aO/G/cfJsVaSfEiBo0p67MSeY05rQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mS474LYwEUfYxf7fgvMBrUGKb5mddabk+Yme1tdu0NgBBWVn1NDy5BBUkT6U87wkU
	 2vuEWlBznDDpBpQugVkJNUBmprNteD6zrDYIYnNIMWvkVKdIu2OwPJ3Js4ckkLzRJ/
	 sFFxswJdP+nLTUFzYqoZZEpjve+h+DK588mgMXPkDJ8lMpgxEXjU0xYCqBmGRDh/P9
	 tmI2mubUHobMnvOk+TcZX2WEyEDxKVGqkzb95B5KMqM7S5b6mrJD+kLzZZhwBYKYuw
	 EuPERN4djUYk1Bvr5RJ9FnRFdAb/Yt3Jn09SjnLZYO9/zRolkgWSpTPtGWy2XRyaGn
	 tCPtNdJacXSGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25307E1F65A;
	Sat, 19 Aug 2023 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: refine skb->ooo_okay setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169241282114.17352.8278901968485360457.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 02:40:21 +0000
References: <20230817182353.2523746-1-edumazet@google.com>
In-Reply-To: <20230817182353.2523746-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 soheil@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 18:23:53 +0000 you wrote:
> Enabling BIG TCP on a low end platform apparently increased
> chances of getting flows locked on one busy TX queue.
> 
> A similar problem was handled in commit 9b462d02d6dd
> ("tcp: TCP Small Queues and strange attractors"),
> but the strategy worked for either bulk flows,
> or 'large enough' RPC. BIG TCP changed how large
> RPC needed to be to enable the work around:
> If RPC fits in a single skb, TSQ never triggers.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: refine skb->ooo_okay setting
    https://git.kernel.org/netdev/net-next/c/726e9e8b94b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



