Return-Path: <netdev+bounces-199247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD2BADF8BF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCAC1BC18F8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082EF27E046;
	Wed, 18 Jun 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3vIzdKA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396E27E041;
	Wed, 18 Jun 2025 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282178; cv=none; b=HzDPR3UGnKvsSmO0RLwj3nyXAb2wcxHCweTYgfYdm8djMXiOjKmKFdAUcQKehba/RtDRvzEzkPhkcZYfwVjmHLTkMjweIdUma2j5IcJLyl8v2rjtMJF4R4jmVzIktvOtmDEpM3/dbKdN616Kje9Vh2uH/BrpLkFd3HM7p5Q8eqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282178; c=relaxed/simple;
	bh=aMEbEW+IeHhujQGTuZEocOXaM+WKUzqlMtYJd8Rdhok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bpG1+05u3f8oJlxk1gm9qYJVC3z4p1jEk50xS+appoQoO0cL7gGNFcm7qEb+H/gdaf9cofvnJ0WJIdUgRVOc0PYYwJ9uZTvJNdIKtp2piei5JnzOTkvvtNLQYHRfO0xx64VJHfeXWuAzeH9hSy2USUq+KvhWkLLI089AvaNL7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3vIzdKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF13C4CEF0;
	Wed, 18 Jun 2025 21:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750282178;
	bh=aMEbEW+IeHhujQGTuZEocOXaM+WKUzqlMtYJd8Rdhok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C3vIzdKARteWUzv4tIZshMl183ZRMEK5hxrLaRLfDtAtAK6MFLgVzbuh9fBJuDo+Q
	 CV2G9pYXe9OnSvZzIweMApFKYd3be0BqQAdNnmq0RH7aOruLKKoQ9Lx07p5lU3B6M2
	 fPQyQ3Rb42O2SSbD+XN15NvVyVSOo3qmJiUeuN8wiRQKYJqeC2QlLNxBwHumjnbwz5
	 Z18Vz5JPJnT5/3pAjQFXAVz01AgXrEzsx9XzFxClbi4ENV4j0bD3nExWuNZwnzIqWO
	 Imeq1k6XZnRsObF3gO3YmbngHS9jXrRsOwgOq8OGPnPeTg4D8HCOIvZlXUd5L3H9zS
	 41reZ8QZysIaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7E3806649;
	Wed, 18 Jun 2025 21:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net] tipc: fix null-ptr-deref when acquiring remote ip
 of
 ethernet bearer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175028220675.262925.8913605552414579923.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 21:30:06 +0000
References: <20250617055624.2680-1-hxqu@hillstonenet.com>
In-Reply-To: <20250617055624.2680-1-hxqu@hillstonenet.com>
To: Haixia Qu <hxqu@hillstonenet.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 05:56:24 +0000 you wrote:
> The reproduction steps:
> 1. create a tun interface
> 2. enable l2 bearer
> 3. TIPC_NL_UDP_GET_REMOTEIP with media name set to tun
> 
> tipc: Started in network mode
> tipc: Node identity 8af312d38a21, cluster identity 4711
> tipc: Enabled bearer <eth:syz_tun>, priority 1
> Oops: general protection fault
> KASAN: null-ptr-deref in range
> CPU: 1 UID: 1000 PID: 559 Comm: poc Not tainted 6.16.0-rc1+ #117 PREEMPT
> Hardware name: QEMU Ubuntu 24.04 PC
> RIP: 0010:tipc_udp_nl_dump_remoteip+0x4a4/0x8f0
> 
> [...]

Here is the summary with links:
  - [v4,net] tipc: fix null-ptr-deref when acquiring remote ip of ethernet bearer
    https://git.kernel.org/netdev/net/c/f82727adcf29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



