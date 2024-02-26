Return-Path: <netdev+bounces-74906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E218673DE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E791C28467
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C71EB33;
	Mon, 26 Feb 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rottws+y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69852210E4
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948232; cv=none; b=kROxifcFo86MWfvsJkT/UWKUxLTodvAL0McAo5zHiku2QPB/TfhTstgBBxBs5tkYS23ksgi5ZSs4/040Ngpt01ebW7Mhy8/iJYo+y2zlFpDkHLFlh5vfd4S3ol3FzZmCwLduZVcgaOesaU52uPk0nFH/sIt92i+uMjOdMu94vDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948232; c=relaxed/simple;
	bh=ANHwG2hR135dZBH2PI7VXlONXUVYcwnB0lnhKNFHkpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=crLQmC3XoCTYl8HUpV3Jssc+RW8QDW9bEiilMEuW/gHvgEmg23vpIW2woRdpLo57paVCDl9P+1PJf1PdgBeo2KhuAob3D+K5lrNiJCNyP9wjNKLZMEox9dsm5w8eEYZwwiTEmUkwX6dAOjZdxceCeWu0qC6I2V+tvVAxjyww/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rottws+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA6B2C43394;
	Mon, 26 Feb 2024 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708948231;
	bh=ANHwG2hR135dZBH2PI7VXlONXUVYcwnB0lnhKNFHkpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rottws+yoQwN4hqRVqTkgk/s1rTwb5XYXtHvWpFYSJL0IBv1bj8nfzfC/VB38vBN4
	 4Jsfpt3qlfF2aLdVAUl6w8vqdhkd1b3wJRZZIxtseV/GbNV5gXJVWeES9co4EG1OEx
	 Sjhlx2Ie05TL7fjpOgWmOlf/72pJZGX7s1/q/J/tLosuCXdKNldIvQpkbtjY9gcd72
	 0jRXaWk628JZSZB9wlR4FdZKy/aCYMuFxDQUfoOK7Z6eeXfcBn1KTVJ2E61/DgsDC9
	 lyWPAe195rjbXnUX057+Ps9gX+UYiVjlqT5YvpsiSZuYqsAoJ3SKsccph95YR6MSod
	 uAByQ7qJKKx9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3141D88FB4;
	Mon, 26 Feb 2024 11:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/14] rtnetlink: reduce RTNL pressure for dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170894823166.11140.9429430060271349194.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 11:50:31 +0000
References: <20240222105021.1943116-1-edumazet@google.com>
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, idosch@nvidia.com, jiri@nvidia.com,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 22 Feb 2024 10:50:07 +0000 you wrote:
> This series restarts the conversion of rtnl dump operations
> to RCU protection, instead of requiring RTNL.
> 
> In this new attempt (prior one failed in 2011), I chose to
> allow a gradual conversion of selected operations.
> 
> After this series, "ip -6 addr" and "ip -4 ro" no longer
> need to acquire RTNL.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/14] rtnetlink: prepare nla_put_iflink() to run under RCU
    https://git.kernel.org/netdev/net-next/c/e353ea9ce471
  - [v2,net-next,02/14] ipv6: prepare inet6_fill_ifla6_attrs() for RCU
    https://git.kernel.org/netdev/net-next/c/4ad268136421
  - [v2,net-next,03/14] ipv6: prepare inet6_fill_ifinfo() for RCU protection
    https://git.kernel.org/netdev/net-next/c/8afc7a78d55d
  - [v2,net-next,04/14] ipv6: use xarray iterator to implement inet6_dump_ifinfo()
    https://git.kernel.org/netdev/net-next/c/ac14ad9755d4
  - [v2,net-next,05/14] netlink: fix netlink_diag_dump() return value
    https://git.kernel.org/netdev/net-next/c/6647b338fc5c
  - [v2,net-next,06/14] netlink: hold nlk->cb_mutex longer in __netlink_dump_start()
    https://git.kernel.org/netdev/net-next/c/b5590270068c
  - [v2,net-next,07/14] rtnetlink: change nlk->cb_mutex role
    https://git.kernel.org/netdev/net-next/c/e39951d965bf
  - [v2,net-next,08/14] rtnetlink: add RTNL_FLAG_DUMP_UNLOCKED flag
    https://git.kernel.org/netdev/net-next/c/386520e0ecc0
  - [v2,net-next,09/14] ipv6: switch inet6_dump_ifinfo() to RCU protection
    https://git.kernel.org/netdev/net-next/c/69fdb7e411b6
  - [v2,net-next,10/14] inet: allow ip_valid_fib_dump_req() to be called with RTNL or RCU
    https://git.kernel.org/netdev/net-next/c/22e36ea9f5d7
  - [v2,net-next,11/14] nexthop: allow nexthop_mpath_fill_node() to be called without RTNL
    https://git.kernel.org/netdev/net-next/c/0ac3fa0c3b36
  - [v2,net-next,12/14] inet: switch inet_dump_fib() to RCU protection
    https://git.kernel.org/netdev/net-next/c/4ce5dc9316de
  - [v2,net-next,13/14] rtnetlink: make rtnl_fill_link_ifmap() RCU ready
    https://git.kernel.org/netdev/net-next/c/74808e72e0b2
  - [v2,net-next,14/14] rtnetlink: provide RCU protection to rtnl_fill_prop_list()
    https://git.kernel.org/netdev/net-next/c/0ec4e48c3a23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



