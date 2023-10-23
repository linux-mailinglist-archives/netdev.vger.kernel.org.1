Return-Path: <netdev+bounces-43369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DD07D2BE0
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95E91C20868
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E91079C;
	Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EweMUBYu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5710950
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42650C433C9;
	Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698047424;
	bh=dHi+keDEb+GtKsSiQKQEa36ciu9EEvDxbZpAlC4iFQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EweMUBYusow8uVHPK8cbs7pIJBrObqBxRiMxAfOHGEVa963x/y3alApJc7zXr6Yfo
	 ZgG9ei8V7gVPnJeFhnQSz9DKa9Rd84Ca/Amr2PY9Dk/BLyzc6k953hxANTZvbf8MMW
	 BfueLEyrNjyAftIcawFrAnag47EP1u4dekmMfZUaNmLg3N9FkK7O5gtonQcbZ+Ktn7
	 yE4TKAHCbyInf7Wz3rzufrjEHltIVv8F7JVYzNV23zZ7uPQYwDmjkCpZu4Z83s8etJ
	 vZMcNljffx1gLwl5+u1jk9cFMmcDwukoYM9oeBtjht85i6L+fTZUoEQH27XX6Zzbwt
	 xlWu9nBnP1zqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29641C41620;
	Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: consolidate IPv6 route lookup for UDP
 tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169804742416.31388.8610752301166615591.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 07:50:24 +0000
References: <20231020115529.3344878-1-b.galvani@gmail.com>
In-Reply-To: <20231020115529.3344878-1-b.galvani@gmail.com>
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, gnault@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 13:55:24 +0200 you wrote:
> At the moment different UDP tunnels rely on different functions for
> IPv6 route lookup, and those functions all implement the same
> logic.
> 
> Extend the generic lookup function so that it is suitable for all UDP
> tunnel implementations, and then adapt bareudp, geneve and vxlan to
> use it.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] ipv6: rename and move ip6_dst_lookup_tunnel()
    https://git.kernel.org/netdev/net-next/c/fc47e86dbfb7
  - [net-next,2/5] ipv6: remove "proto" argument from udp_tunnel6_dst_lookup()
    https://git.kernel.org/netdev/net-next/c/7e937dcf96d0
  - [net-next,3/5] ipv6: add new arguments to udp_tunnel6_dst_lookup()
    https://git.kernel.org/netdev/net-next/c/946fcfdbc5b9
  - [net-next,4/5] geneve: use generic function for tunnel IPv6 route lookup
    https://git.kernel.org/netdev/net-next/c/69d72587c17b
  - [net-next,5/5] vxlan: use generic function for tunnel IPv6 route lookup
    https://git.kernel.org/netdev/net-next/c/2aceb896ee18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



