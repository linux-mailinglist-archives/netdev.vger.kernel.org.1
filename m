Return-Path: <netdev+bounces-76517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF42786E008
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C4DB2238B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B4E6995C;
	Fri,  1 Mar 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV8+MMkK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC020E6
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292029; cv=none; b=CWdVI4VIWNIUmya5j7nfl8/zEdcBWnxDFma40lpRS/9fwYNlX73DiEEdWgw2phomHMt/jFFFDLlvQr5J2oMkcaSCfHfLNmm1P6OjuqHngaV2HU1/0rsnvv4WtNPhW4a5uiLBlSfv13cFFaXkiuduf/XxUmcwae9q/telmk3Oe1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292029; c=relaxed/simple;
	bh=ghxJTct4E94fafL37TnFIxwVxqrMVue4dkxdJNN1beg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oUXrClId30fWwQ3oPGkvG2ghfxziFg8E/a7KCH3mG4Ivh5nXJVgAURAJR4w7VjO01KXqUk/PCXGCOlE1/uVeZlnL0pYX1w1hF40H9TXDvYKbhlBoHqjk/A57HwlXpnhwu+04F082o74FYCHAFuxEy45bnM0KVXhitJxL1/hlF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV8+MMkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C630C43390;
	Fri,  1 Mar 2024 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709292028;
	bh=ghxJTct4E94fafL37TnFIxwVxqrMVue4dkxdJNN1beg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QV8+MMkKxXvsjbTWI4h5rlRGf/tcoT6pVlfOqMDoKcJSF8n4H4m66b8wRWRXA/tLQ
	 YU1UJG9U0cN/gD4BYHX/7G1pVW4QOELLsRFVYayAkVhXShNASwdqXP3xaxPmsKbrH7
	 nW62ESZFcXQ+pCUMI3Y7dUZeH72WVJ852l8zyAgF6Dd1gZnvwvAlOREjXK/tIoOeYN
	 H49/spMEpLrDpBsiHhFHjAo6zb5nGDtou/ucxmSdNXUYK8Go0VY2eTte5oGko9mYYm
	 FuQxYunVKdOfa4y0mt7CI6w1pvqaS7opgb0f+mb+LCuMq0ZnDrocdYv4vl9FOpdU2Q
	 7Yxv6r/qY69fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72055C595C4;
	Fri,  1 Mar 2024 11:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] inet: no longer use RTNL to protect
 inet_dump_ifaddr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170929202845.24139.9397794618694346159.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 11:20:28 +0000
References: <20240229114016.2995906-1-edumazet@google.com>
In-Reply-To: <20240229114016.2995906-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com,
 dsahern@kernel.org, netdev@vger.kernel.org, fw@strlen.de,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 11:40:10 +0000 you wrote:
> This series convert inet so that a dump of addresses (ip -4 addr)
> no longer requires RTNL.
> 
> Eric Dumazet (6):
>   inet: annotate data-races around ifa->ifa_tstamp and ifa->ifa_cstamp
>   inet: annotate data-races around ifa->ifa_valid_lft
>   inet: annotate data-races around ifa->ifa_preferred_lft
>   inet: annotate data-races around ifa->ifa_flags
>   inet: prepare inet_base_seq() to run without RTNL
>   inet: use xa_array iterator to implement inet_dump_ifaddr()
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] inet: annotate data-races around ifa->ifa_tstamp and ifa->ifa_cstamp
    https://git.kernel.org/netdev/net-next/c/3cd3e72ccb3a
  - [net-next,2/6] inet: annotate data-races around ifa->ifa_valid_lft
    https://git.kernel.org/netdev/net-next/c/a5fcf74d80be
  - [net-next,3/6] inet: annotate data-races around ifa->ifa_preferred_lft
    https://git.kernel.org/netdev/net-next/c/9f6fa3c4e722
  - [net-next,4/6] inet: annotate data-races around ifa->ifa_flags
    https://git.kernel.org/netdev/net-next/c/3ddc2231c810
  - [net-next,5/6] inet: prepare inet_base_seq() to run without RTNL
    https://git.kernel.org/netdev/net-next/c/590e92cdc835
  - [net-next,6/6] inet: use xa_array iterator to implement inet_dump_ifaddr()
    https://git.kernel.org/netdev/net-next/c/cdb2f80f1c10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



