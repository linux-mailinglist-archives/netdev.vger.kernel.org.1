Return-Path: <netdev+bounces-54331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7BE806A92
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AF81F215C8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442121A718;
	Wed,  6 Dec 2023 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNzRf8zy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6A1A720
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 09:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A462C433CA;
	Wed,  6 Dec 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701854423;
	bh=gzlkjQfmWVccL59AU12EX6SfF/xftROkPP8PH4cN+PI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HNzRf8zyr/bAruseOy/c2Y+QmKrrhtvd6EeOl8sBcU8AhMrnry3t7mBlAATr62dt3
	 PejvIbnrTO4iGflCijrPcwMJitNJQznVjNmaU23IJ4TMJ/ZBBTXc6agRf2gKIODyIN
	 rjfiDN+srUGKOlid+4vfsEBl8mU/EaHl4MBodUa0QVfm+hOsVInSVanBY2JJZvDP4E
	 dFUy2XeKH0jix5cRImZch1OrgdaGlulxU4k+FdCVg87ns02Mmo5BBBEv/SpTB6365c
	 F2bH45ZxwiYrXKmFULnpuqyFpviyy/Ull/y63kM3OpeqyeVgOUNS9RXWojg2zX3ZOM
	 UaM1zQByhxj6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E562AC395DC;
	Wed,  6 Dec 2023 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170185442293.26512.8602654945960747871.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 09:20:22 +0000
References: <20231202161441.221135-1-syoshida@redhat.com>
In-Reply-To: <20231202161441.221135-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  3 Dec 2023 01:14:41 +0900 you wrote:
> In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
> true. For example, applications can use PF_PACKET to create a malformed
> packet with no IP header. This type of packet causes a problem such as
> uninit-value access.
> 
> This patch ensures that skb_pull() can pull the required size by checking
> the skb with pskb_network_may_pull() before skb_pull().
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()
    https://git.kernel.org/netdev/net/c/80d875cfc9d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



