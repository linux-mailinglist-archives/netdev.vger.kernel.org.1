Return-Path: <netdev+bounces-251218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2EFD3B53E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A399B3013155
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3007832ED2C;
	Mon, 19 Jan 2026 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJo/v0Oz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539132E6AC
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846226; cv=none; b=Vt0vPf3b24vyQtgBCgTwWrZC7exM4RUhJTw326abkwCcGB449VH2g1XhD+JtJHi1Dd+t3V0Jb0yNrblOEht+ZJXdA94mpPyvMFSxsup2AunAaqGPVvXLM5iKT5OQQZWBvWTU9uk4Inwe+bsKdV0kC6Rrx+Mj/bBQ3Ct7YD5QAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846226; c=relaxed/simple;
	bh=WrlDWsoGFqLYk83QCgmZ44wiQz7PepzdJdgz38Xd/Ig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pO5ASpOdsTjGBYTgacoAIeQns/6BYbbWslfU6i0MiFGIBj8PQSN70KxcArWtUpICKoTuNgve93tfvsv0pDH50TBw6S6P9ouk47J47AXBpn3SRKyWY2pBpPY91Yxu3rOcOei2vGC1hm8xM+ozjUcxkSBt+qkrgH/xZbJS7yzEgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJo/v0Oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD58DC116C6;
	Mon, 19 Jan 2026 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846225;
	bh=WrlDWsoGFqLYk83QCgmZ44wiQz7PepzdJdgz38Xd/Ig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uJo/v0Ozw+3TfhpxYH8B8c5YzKgngazrsVm1laeNjMLUEpsSTioxLYDgY8NswWnSY
	 TuF0h+5OUbPZdG6844D6SDlZyUJ6WPrn1QSOmBsHQNLlgDlSG2Y2ZMoLbsQtmBG8qC
	 /OIVil0r0eL/wf9jaNdpKmPavWYJqPA8yXwbNbZ5J+bDTf8216Pmb73ju5KICcSyxw
	 Np3B7gyw5XgoLsVkozpW7H6saNHgIv8AhHK+aYPljQwwLbtcnSA+pW8UpNgEELxLn0
	 xJojB20s+jjXiCwBgGFiodDkSaOWE98tODP3aM2BRpqgP2M4hzORHTO23baPv3yrND
	 ZetYYwrwl5Ftw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B8BAB3806905;
	Mon, 19 Jan 2026 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] ipv6: more data-race annotations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176884622327.85277.16857633770768048884.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 18:10:23 +0000
References: <20260115094141.3124990-1-edumazet@google.com>
In-Reply-To: <20260115094141.3124990-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jan 2026 09:41:33 +0000 you wrote:
> Inspired by one unrelated syzbot report.
> 
> This series adds missing (and boring) data-race annotations in IPv6.
> 
> Only the first patch adds sysctl_ipv6_flowlabel group
> to speedup ip6_make_flowlabel() a bit.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ipv6: add sysctl_ipv6_flowlabel group
    https://git.kernel.org/netdev/net-next/c/e82a347d92d1
  - [net-next,2/8] ipv6: annotate data-races from ip6_make_flowlabel()
    https://git.kernel.org/netdev/net-next/c/ded139b59b5d
  - [net-next,3/8] ipv6: annotate date-race in ipv6_can_nonlocal_bind()
    https://git.kernel.org/netdev/net-next/c/3681282530e6
  - [net-next,4/8] ipv6: annotate data-races in ip6_multipath_hash_{policy,fields}()
    https://git.kernel.org/netdev/net-next/c/03e9d91dd64e
  - [net-next,5/8] ipv6: annotate data-races over sysctl.flowlabel_reflect
    https://git.kernel.org/netdev/net-next/c/5ade47c974b4
  - [net-next,6/8] ipv6: annotate data-races around sysctl.ip6_rt_gc_interval
    https://git.kernel.org/netdev/net-next/c/12eddc685744
  - [net-next,7/8] ipv6: exthdrs: annotate data-race over multiple sysctl
    https://git.kernel.org/netdev/net-next/c/978b67d28358
  - [net-next,8/8] ipv6: annotate data-races in net/ipv6/route.c
    https://git.kernel.org/netdev/net-next/c/f062e8e25102

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



