Return-Path: <netdev+bounces-190819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5E9AB8F50
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B69250088B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9025A2AA;
	Thu, 15 May 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT9Q7nQY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E0D20A5F1
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335007; cv=none; b=PEfpPSgZG8pzCMtlk8qRiyw5SMyzU71FdvB9MqjmbcesCoG+DBgPAjV/dZEEbetTGdaVD5IMhahoW0pIV0U+YBFS2wfKiSzcnNm6grGgkMdstB8xVNl1z8JfwpE7cYaxIaMy8TUcWR+yuIdwqLHE9kE9a5G55ZAZv/Y1bK8HzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335007; c=relaxed/simple;
	bh=iOyxMnFLySE7FbMqi6RlI6iTHcjjkHDkvPQeB8ZKGAo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pC4m3kSo4Nrx5zHB/xbHVP2Yc6I0WcWeSpuRjfSNQo4FvrPyqcpMWnxa7lmW8jGGfmCEFhUsVkmOz0FSFeopRIXxcN46MpVhK+gEJjZfHhfalw+U24EOlDMqR54qES2cVUipz1G92PPNIdOnrxTGLzOGiqhs9ekTN/fkZPGVXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT9Q7nQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C67C4CEE7;
	Thu, 15 May 2025 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747335006;
	bh=iOyxMnFLySE7FbMqi6RlI6iTHcjjkHDkvPQeB8ZKGAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kT9Q7nQYGeRJQ2mKQryLdhI2w3jo1eObxyYEsGBnszcgUC4n95D7rHNV3lCKOwdzU
	 8O/NrHYjYFh/tlnJ3DFDsAqC2KawCJhP9u3cAwqmiz1WacWBLr+ZHy4ldzuzodopod
	 sm61XQ7CFRwbfnn+7kNj6JYMzMNsqBOzSaJ05Q9cnC4ZKcUCHpcNeEfCcpAVuiBzj6
	 VYTjuZ0/N71eATjmN6poNXDKY+l4xQWTddSpPH5i5kiKCkruWTdkM4ktXw3pVupXqt
	 ES+EiO3oPk6zhGWe9/02iEzjtkl/2vXJmEFudGhg33Wuw/ybmcmleu8BlQXtm1Dxyo
	 2Q4lbaeEq9uaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D923806659;
	Thu, 15 May 2025 18:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] tcp: receive side improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174733504401.3213749.1321333360222183745.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 18:50:44 +0000
References: <20250513193919.1089692-1-edumazet@google.com>
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@amazon.com,
 jonesrick@google.com, weiwan@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 19:39:08 +0000 you wrote:
> We have set tcp_rmem[2] to 15 MB for about 8 years at Google,
> but had some issues for high speed flows on very small RTT.
> 
> TCP rx autotuning has a tendency to overestimate the RTT,
> thus tp->rcvq_space.space and sk->sk_rcvbuf.
> 
> This makes TCP receive queues much bigger than necessary,
> to a point cpu caches are evicted before application can
> copy the data, on cpus using DDIO.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] tcp: add tcp_rcvbuf_grow() tracepoint
    https://git.kernel.org/netdev/net-next/c/c1269d3d12b8
  - [net-next,02/11] tcp: fix sk_rcvbuf overshoot
    https://git.kernel.org/netdev/net-next/c/65c5287892e9
  - [net-next,03/11] tcp: adjust rcvbuf in presence of reorders
    https://git.kernel.org/netdev/net-next/c/63ad7dfedfae
  - [net-next,04/11] tcp: add receive queue awareness in tcp_rcv_space_adjust()
    https://git.kernel.org/netdev/net-next/c/ea33537d8292
  - [net-next,05/11] tcp: remove zero TCP TS samples for autotuning
    https://git.kernel.org/netdev/net-next/c/d59fc95be9d0
  - [net-next,06/11] tcp: fix initial tp->rcvq_space.space value for passive TS enabled flows
    https://git.kernel.org/netdev/net-next/c/cd171461b90a
  - [net-next,07/11] tcp: always seek for minimal rtt in tcp_rcv_rtt_update()
    https://git.kernel.org/netdev/net-next/c/b879dcb1aeec
  - [net-next,08/11] tcp: skip big rtt sample if receive queue is not empty
    https://git.kernel.org/netdev/net-next/c/a00f135cd986
  - [net-next,09/11] tcp: increase tcp_limit_output_bytes default value to 4MB
    https://git.kernel.org/netdev/net-next/c/9ea3bfa61b09
  - [net-next,10/11] tcp: always use tcp_limit_output_bytes limitation
    https://git.kernel.org/netdev/net-next/c/c4221a8cc3a7
  - [net-next,11/11] tcp: increase tcp_rmem[2] to 32 MB
    https://git.kernel.org/netdev/net-next/c/572be9bf9d0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



