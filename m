Return-Path: <netdev+bounces-70073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B5084D830
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802E71F233B3
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85211D530;
	Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9wzNqUm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA51D52D
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361831; cv=none; b=IcGcPitpzQo5gg6Fj2VP+Qia7K58VpeCCl1Hg0yC6Wblbeb+dOvek3/l6bQQ5eaXtF9oSDvijdylmsLZ9ot0I5MiFdKZCH4GSxemNYzPeHMhRB3IfibThWwWrVMi/XP87G+FB53Njh1tuQMWvlx4chOjjZfkZOeU5pOgEyUdgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361831; c=relaxed/simple;
	bh=rWlR20dxEQGVxmBKH4h7lMxjFjpizcgl3ZxP/fr31tE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ni7+yf8MmugboCQl2cBe2N+kCx/JLKuuwqSvKwC/WqK33hK50Fn6hy0u81UN+g/AAFP9KU+sc5ejYkYD6Szdb6iY1Ro9P6FC55ALzA7dl+EJlpHqA4CPGWCyMB9i09TnD1U4RGXDm2TgqQv9PSy1OiPOu6Kfo+J6hYdlpHXi0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9wzNqUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43CB9C433C7;
	Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707361831;
	bh=rWlR20dxEQGVxmBKH4h7lMxjFjpizcgl3ZxP/fr31tE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q9wzNqUmrjAAHHNmkH0Yz8cTglaI9EyNDfpPl9AO0gXc5hKfOUAYNYK1WJcKQOeqr
	 kBQpfnPFsqXNUUlMc3qH1qHkH8kLdwZ3ecaB+dXFyyfhdZCChxMbl2hZPwKBAmVdv3
	 FXj3mvT7rlr3OdrSkFmWKFb9Jn6ugNYVfizUUzzS0j7TiGfbPJP0J+AbYbEJRmlIbM
	 Yntj47qHCuK1WkfHniOjs7c/Al6S05t7Ze8+US4POXqzBxsO9I1xy6YeCxg9fteNjW
	 d5ulVQcvmDPsNv5HwAe+WTibzcatb864zR3b3+hhxrJpXXCB+MJQ6BnmZYIfTh7m9Z
	 dskNTrKrc/sKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 173D7E2F2F1;
	Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 00/15] net: more factorization in cleanup_net()
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170736183108.28016.16429043012584720341.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 03:10:31 +0000
References: <20240206144313.2050392-1-edumazet@google.com>
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 atenart@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Feb 2024 14:42:56 +0000 you wrote:
> This series is inspired by recent syzbot reports hinting to RTNL and
> workqueue abuses.
> 
> rtnl_lock() is unfair to (single threaded) cleanup_net(), because
> many threads can cause contention on it.
> 
> This series adds a new (struct pernet_operations) method,
> so that cleanup_net() can hold RTNL longer once it finally
> acquires it.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,01/15] net: add exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/fd4f101edbd9
  - [v4,net-next,02/15] nexthop: convert nexthop_net_exit_batch to exit_batch_rtnl method
    https://git.kernel.org/netdev/net-next/c/a7ec2512ad7b
  - [v4,net-next,03/15] bareudp: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/422b5ae9c5e5
  - [v4,net-next,04/15] bonding: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/669966bc94d8
  - [v4,net-next,05/15] geneve: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/f4b57b9dc96b
  - [v4,net-next,06/15] gtp: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/6eedda01b2bf
  - [v4,net-next,07/15] ipv4: add __unregister_nexthop_notifier()
    https://git.kernel.org/netdev/net-next/c/70f16ea2e4f6
  - [v4,net-next,08/15] vxlan: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/110d3047a3ec
  - [v4,net-next,09/15] ip6_gre: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/bc50c535c3a0
  - [v4,net-next,10/15] ip6_tunnel: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/a1fab9aff5c0
  - [v4,net-next,11/15] ip6_vti: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/7a99f3c1994b
  - [v4,net-next,12/15] sit: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/de02deab27fd
  - [v4,net-next,13/15] ip_tunnel: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/9b5b36374ed6
  - [v4,net-next,14/15] bridge: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/806b67850787
  - [v4,net-next,15/15] xfrm: interface: use exit_batch_rtnl() method
    https://git.kernel.org/netdev/net-next/c/8962daccc2d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



