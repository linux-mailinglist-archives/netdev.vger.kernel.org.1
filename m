Return-Path: <netdev+bounces-44873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03237DA305
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA6DB214B6
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CD53FE5E;
	Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONiPHqSk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28C3FB02
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E7C2C433CA;
	Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698444024;
	bh=F5RvgEqzFtreet5x0H5Z1OTtGsP1dli3WMzHJ6LUkTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ONiPHqSkCF5Him91lDP9TOLqwN5a9uxQ4Eqqx5c6i7Mqa0NM0WWiYxGacaFNWoJUM
	 r6jsUzuH9jXOf4DSdVjmdxkglYR2BKQ6qsYDzGKblRFU8x+os31RAsafgLwJqcqoe/
	 98Nl+PF7D8cHMpM8kqdL2kJpD/qW5/fwFP6KUr42OGNKhkv5HEnhlUg5nbOn85PycM
	 f9P1Bv64ROZExzbmw9Kpeald71gg+B08/LuhKeVNHkU25KpnfFBIEPJ5aLYNMYZk48
	 hP9ki9UHrEU0rT8TibcSxNFex0MwJTA3jPKv2pJO0dCo3cGETMJ+yUceMCJbYmhGmH
	 l4cUwiqNhHqFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF56CE000BE;
	Fri, 27 Oct 2023 22:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v4] tools: ynl: introduce option to process unknown
 attributes or types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169844402397.23229.13480254568507181124.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 22:00:23 +0000
References: <20231027092525.956172-1-jiri@resnulli.us>
In-Reply-To: <20231027092525.956172-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 11:25:25 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In case the kernel sends message back containing attribute not defined
> in family spec, following exception is raised to the user:
> 
> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "trap-name": "source_mac_is_multicast"}'
> Traceback (most recent call last):
>   File "/home/jiri/work/linux/tools/net/ynl/lib/ynl.py", line 521, in _decode
>     attr_spec = attr_space.attrs_by_val[attr.type]
>                 ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
> KeyError: 132
> 
> [...]

Here is the summary with links:
  - [net-next,v4] tools: ynl: introduce option to process unknown attributes or types
    https://git.kernel.org/netdev/net-next/c/d96e48a3d55d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



