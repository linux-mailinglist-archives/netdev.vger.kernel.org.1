Return-Path: <netdev+bounces-42153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27317CD682
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C25C281BB8
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D458F4F;
	Wed, 18 Oct 2023 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAGcn7ss"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD79156C5
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50C95C433C8;
	Wed, 18 Oct 2023 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697617825;
	bh=D316q8A5VYyiraz/w9ayT2aRrlLM4rzR7G1TNj5EpWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WAGcn7ssRnm/5wrRuZxqRerHo79GZqq4wAWqisw9AGPb8gWDy3Ie23hHJA5d7L4a4
	 V3GFrxPLDxUjo3rPii4b2nsDAY4ooOwDTpLZwWAqTN/jMtoGVjgiDLZveSOSIw84vl
	 fdiwI/CxzZnBawDkwwDL3i1oUvEBWFtO9LPKUrtX0FG6r7hZkyY4tGfrKBTJUFNf3G
	 RDZvbXQ3c5nL0qiYJIIdQPItpsQ6gDhg8ydbtWNmZgFMx3UNjlCyIxOw6hGplCigl/
	 A3e2hTyX8IONsyccHssmUvJ3C0qMXIo1kOPpZl/7GDmMM6/ZvStK5d9N6eQCy+MgvL
	 L6tFqu03LjRPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EA2BE00080;
	Wed, 18 Oct 2023 08:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v3 0/7] devlink: fix a deadlock when taking devlink
 instance lock while holding RTNL lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169761782525.24723.6762513832243789657.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 08:30:25 +0000
References: <20231013121029.353351-1-jiri@resnulli.us>
In-Reply-To: <20231013121029.353351-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 13 Oct 2023 14:10:22 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> devlink_port_fill() may be called sometimes with RTNL lock held.
> When putting the nested port function devlink instance attrs,
> current code takes nested devlink instance lock. In that case lock
> ordering is wrong.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/7] net: treat possible_net_t net pointer as an RCU one and add read_pnet_rcu()
    https://git.kernel.org/netdev/net-next/c/2034d90ae41a
  - [net-next,v3,2/7] devlink: call peernet2id_alloc() with net pointer under RCU read lock
    https://git.kernel.org/netdev/net-next/c/c503bc7df602
  - [net-next,v3,3/7] devlink: take device reference for devlink object
    https://git.kernel.org/netdev/net-next/c/a380687200e0
  - [net-next,v3,4/7] devlink: don't take instance lock for nested handle put
    https://git.kernel.org/netdev/net-next/c/b5f4e371336a
  - [net-next,v3,5/7] Documentation: devlink: add nested instance section
    https://git.kernel.org/netdev/net-next/c/b6f23b319aad
  - [net-next,v3,6/7] Documentation: devlink: add a note about RTNL lock into locking section
    https://git.kernel.org/netdev/net-next/c/bb11cf9b2c4a
  - [net-next,v3,7/7] devlink: document devlink_rel_nested_in_notify() function
    https://git.kernel.org/netdev/net-next/c/5d77371e8c85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



