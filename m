Return-Path: <netdev+bounces-150950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F246F9EC275
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B04282E5A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B01B1FCD09;
	Wed, 11 Dec 2024 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUTVLrxF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163041FCCFF
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885421; cv=none; b=E24mrnY3/C5kHWWW1dtxDVrwW7cMPAFq914sTndlN3tcn4uMXQKNuGBKH5rlLDO9aHbXNao6wkhbzg2BP1qXH4OZQczvWXoF17ZqgmsZNh3pd/Rpr9P9Kuvc6RsfwFtWYnq0TNzqpRM/qEQ15jMPWQwtl993QCFd6uQY2qUPHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885421; c=relaxed/simple;
	bh=9e2JbQ5MwKpVXxmYAXntdafeDn9jHeCbLzgVtZo/An0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fg5SA9QOX0F+ky3ap9posFIx45pKmqrZUwVm6idg/FK3RS0L/EwBU29/db+52YAlPfb/bWlEnQX7jrJEiYcVOmLwnhwBAFXwRXGfp2BZ7WqqMwNmwBqLvGPg2a9c6Fs1N8cnmmCDsaDcaDVJzDdwH+dggSd9RxJSIZVT4dFclOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUTVLrxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981E6C4CED6;
	Wed, 11 Dec 2024 02:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733885420;
	bh=9e2JbQ5MwKpVXxmYAXntdafeDn9jHeCbLzgVtZo/An0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rUTVLrxFtAzDDPpG4o657HftRHoEyXpj7f1BrZ9ZFYLj9/3dHfcYCTmLX58L5zvzL
	 lHz+Ei+LXmsfpwc6DagEBGF7wg0D6dJCq0nIG8cKvksGGDJgZaTA20TJY10bjwYyE2
	 jvleSxXPQwdGuccQOhZr1IPMf0eS6qISPeHBcE2jmWP9n4hsIN4Z8jkKxWcb4XDjES
	 VyoQVK+Dj9dj+C+t4KLlgqbfdpxWzpcCUaijUPzWJC0oBvP7tqcunHchtBa9rIRXBN
	 409+oQroVUCQ65TaZ1BV8Q016KL5j8TqFsGWVFkgLbG8Ic8JHQbUDeB8D8ITa4trV4
	 cvGRgapDqTB2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE6E380A954;
	Wed, 11 Dec 2024 02:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: prepare for removal of
 net->dev_index_head
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388543649.1096205.7194178166875706340.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:50:36 +0000
References: <20241209100747.2269613-1-edumazet@google.com>
In-Reply-To: <20241209100747.2269613-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, roopa@nvidia.com,
 kuniyu@amazon.com, idosch@nvidia.com, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Dec 2024 10:07:44 +0000 you wrote:
> This series changes rtnl_fdb_dump, last iterator using net->dev_index_head[]
> 
> First patch creates ndo_fdb_dump_context structure, to no longer
> assume specific layout for the arguments.
> 
> Second patch adopts for_each_netdev_dump() in rtnl_fdb_dump(),
> while changing two first fields of ndo_fdb_dump_context.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] rtnetlink: add ndo_fdb_dump_context
    https://git.kernel.org/netdev/net-next/c/be325f08c432
  - [v2,net-next,2/3] rtnetlink: switch rtnl_fdb_dump() to for_each_netdev_dump()
    https://git.kernel.org/netdev/net-next/c/53970a05f799
  - [v2,net-next,3/3] rtnetlink: remove pad field in ndo_fdb_dump_context
    https://git.kernel.org/netdev/net-next/c/53a6d8912372

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



