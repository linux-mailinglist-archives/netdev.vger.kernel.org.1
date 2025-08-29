Return-Path: <netdev+bounces-218037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A2BB3AEBD
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8BC582D94
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5852D6410;
	Fri, 29 Aug 2025 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2s049CA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7172D9787
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425612; cv=none; b=fBHpv4w/d2lY4kVkOYnu/fxK8uhOmNhvpB4SEbI+GsibT5FAJzp2a8tiDrxnkBcp9Rv+KWyZK1Lsu7yM2QyxPhrNAhbDlrqF65nEo+/e7sAmUwgXQoCn9IWajWQ5lc+qXPDYmzZSkjXDz5Gt1jiqegzji1aQOXRqXGJPl6U3Vv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425612; c=relaxed/simple;
	bh=R3r3kOKxd+jbV7vvpXuYjE3PW3L18IGMbibe82xmtzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tgvS4+YSAEzaExqYe+fte/qF3Kcu5pIFm9GWWnrrQtjldVnz1JQjGm6ZWnEHZDdQKAaSHa3C+yktmsQe/ry2tIgQGQYZaojqcnTpehrbOZzGE6Xm3wEeYciHMNnZpA79Ai4VyAG6MMvsC1P3NF1JZB3CRjo/KTYMWuQzISsq1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2s049CA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800A3C4CEEB;
	Fri, 29 Aug 2025 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756425611;
	bh=R3r3kOKxd+jbV7vvpXuYjE3PW3L18IGMbibe82xmtzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b2s049CAgxjO61BM2QBiFH83ntL93hcfZzEQuXUkk5Qw+jRzTvYBo8tMAr5rdBfJy
	 U51N0bARKcXC2nhKd0AKyYDB08tdpEzpFo9tmXDyaaG2T/lTfpw6lI/gYG8VNBmwz9
	 expNoyGvQ2I13B/8aBKaSpOYOvr1W1hrwUdCxGd8rnrtKA4MNQhd+IcTD2jdAy3aYo
	 Da/D7xp8emIbW3EKWUopPyIFF+TYBUsaCq5Gba292cRuaRiGYy9IhUyTee20Pko14W
	 DqMwBRHCVBwZFryPatGKzOY3BEbx20NeX/F9VrTTXtyfEbaKEmiBye+k8vLACYZxXq
	 Mgot7TnESy44A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFFA383BF75;
	Fri, 29 Aug 2025 00:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net_sched: extend RCU use in dump() methods
 (II)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175642561824.1653564.6393132655868075557.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 00:00:18 +0000
References: <20250827125349.3505302-1-edumazet@google.com>
In-Reply-To: <20250827125349.3505302-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 12:53:45 +0000 you wrote:
> Second series adding RCU dump() to three actions
> 
> First patch removes BH blocking on modules done in the first series.
> 
> Eric Dumazet (4):
>   net_sched: remove BH blocking in eight actions
>   net_sched: act_vlan: use RCU in tcf_vlan_dump()
>   net_sched: act_tunnel_key: use RCU in tunnel_key_dump()
>   net_sched: act_skbmod: use RCU in tcf_skbmod_dump()
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net_sched: remove BH blocking in eight actions
    https://git.kernel.org/netdev/net-next/c/3133d5c15cb5
  - [net-next,2/4] net_sched: act_vlan: use RCU in tcf_vlan_dump()
    https://git.kernel.org/netdev/net-next/c/48b5e5dbdb23
  - [net-next,3/4] net_sched: act_tunnel_key: use RCU in tunnel_key_dump()
    https://git.kernel.org/netdev/net-next/c/e97ae742972f
  - [net-next,4/4] net_sched: act_skbmod: use RCU in tcf_skbmod_dump()
    https://git.kernel.org/netdev/net-next/c/53df77e78590

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



