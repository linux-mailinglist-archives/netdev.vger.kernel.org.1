Return-Path: <netdev+bounces-55511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399E280B16C
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 02:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8AE281942
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F57FB;
	Sat,  9 Dec 2023 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+0AUy1e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB457F8
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0B0DC433C8;
	Sat,  9 Dec 2023 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702085423;
	bh=Qc4xPd5VP3/h+0Xko7wapCQf2w+iemkUfBhWvq+21nI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O+0AUy1eMrF7Q77aUo7TPTbKcp6LuxuSjuaVQ3OEg5s6OW0nPcogmfTwaauD62QFl
	 yzheVoHCO3VAoen4KzHrTXw2LYpSZxgLmXae8JqoJCbiQZgb0OqnluDp3C1TW2wpir
	 Mi2QCnpc+Vm6PSeS7bhOE7jlwbbG0amqDvv0oYdfBX5Oi5sqz4JnGpZjvvZBXhcPBe
	 7YAdSEkAs0m8zSea0yGcKeMb6RDVE4IeP8EH2AVobNvoc+6yWbI/O3yrF2gGW+AtE/
	 1sNRL3wlB3WTpRu0cp7w3bsLqJhCf6TcL4DrEWHDkQU1sew7yLsya7+3VaxWfkBd//
	 VxZHIQpTRReQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F159C04DD9;
	Sat,  9 Dec 2023 01:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix tcp_disordered_ack() vs usec TS resolution
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170208542364.22393.11705664552724086672.git-patchwork-notify@kernel.org>
Date: Sat, 09 Dec 2023 01:30:23 +0000
References: <20231207181342.525181-1-edumazet@google.com>
In-Reply-To: <20231207181342.525181-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 ncardwell@google.com, morleyd@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Dec 2023 18:13:42 +0000 you wrote:
> After commit 939463016b7a ("tcp: change data receiver flowlabel after one dup")
> we noticed an increase of TCPACKSkippedPAWS events.
> 
> Neal Cardwell tracked the issue to tcp_disordered_ack() assumption
> about remote peer TS clock.
> 
> RFC 1323 & 7323 are suggesting the following:
>   "timestamp clock frequency in the range 1 ms to 1 sec per tick
>    between 1ms and 1sec."
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix tcp_disordered_ack() vs usec TS resolution
    https://git.kernel.org/netdev/net/c/9c25aae0132b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



