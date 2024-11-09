Return-Path: <netdev+bounces-143559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ABC9C2FA9
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 22:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD3C1F215F1
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E900819DF48;
	Sat,  9 Nov 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFKWPNB+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC22E628
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731189020; cv=none; b=kRkJtmfOxihtbGTIbwS6bEna+fnzyxdU561tODpERbaFH+nJf6y71CuySp5n8omowzt7oqHu+aTFNxQkLE4HN0/D6lXbuF+dJK1LzqrIJUt+e38tOplB9wBR0X+LPCf2uZARCjrMO7QoZ3vgawpR0IJjlDr56ruFSWzPy5UfK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731189020; c=relaxed/simple;
	bh=l/bkednoaFH+B4pIWBAofP8Z30XWavFQfE1jCzDbhQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BxAIXkij+MxjXsNsCkMevhOf3OgVtX/7dM+q8SF/Ium3y65iPabiDm/MbLB2esCc7PjqNSBn3ldZJTrVwQMSYjhRE8Qa/DxE6mZW0qj5rZFtRkX/QzJ/IcOXyvcRRdGIUgjwNxMJY6vAvx6rx4SITwnqj5UpqPCFzZh8bz2qjXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFKWPNB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD4EC4CECE;
	Sat,  9 Nov 2024 21:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731189019;
	bh=l/bkednoaFH+B4pIWBAofP8Z30XWavFQfE1jCzDbhQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iFKWPNB+XZcuoZZqcJE3tES4/WVUBt39VhwDiS1IqIw36e6mFNksAPV/eae1xY4Vb
	 CVnhchFqFHWhrbE6n6wztglfi6t/zCn3zbe1VL8XJzZDNo1KWUXY5CuRY6Ldvey8JT
	 2xz3aHybLCPykEUFSN1I0FTeqRlbdYXPh5ljC8FTw2gB4MluLhBbMPDt3VVY5NfKkt
	 +y6E2lxJrLZmcVZ/VOgwQYdEuO1pcQvbENm8WsyFIF9m2IXcR47vyZetnzhvqFtFKs
	 ESDpdQZvuP6hIYzTTROQfFTGqiS32XpjcK0GoKm/NtaiGDawR75/M/7gl8YSFij/HP
	 NaD9UMKNMs+vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7B3809A80;
	Sat,  9 Nov 2024 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/6] Improve neigh_flush_dev performance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173118902902.3018960.15714262334867949431.git-patchwork-notify@kernel.org>
Date: Sat, 09 Nov 2024 21:50:29 +0000
References: <20241107160444.2913124-1-gnaaman@drivenets.com>
In-Reply-To: <20241107160444.2913124-1-gnaaman@drivenets.com>
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 16:04:37 +0000 you wrote:
> This patchsets improves the performance of neigh_flush_dev.
> 
> Currently, the only way to implement it requires traversing
> all neighbours known to the kernel, across all network-namespaces.
> 
> This means that some flows are slowed down as a function of neigh-scale,
> even if the specific link they're handling has little to no neighbours.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/6] neighbour: Add hlist_node to struct neighbour
    https://git.kernel.org/netdev/net-next/c/41b3caa7c076
  - [net-next,v9,2/6] neighbour: Define neigh_for_each_in_bucket
    https://git.kernel.org/netdev/net-next/c/d7ddee1a522d
  - [net-next,v9,3/6] neighbour: Convert seq_file functions to use hlist
    https://git.kernel.org/netdev/net-next/c/00df5e1a3fdf
  - [net-next,v9,4/6] neighbour: Convert iteration to use hlist+macro
    https://git.kernel.org/netdev/net-next/c/0e3bcb0f78a0
  - [net-next,v9,5/6] neighbour: Remove bare neighbour::next pointer
    https://git.kernel.org/netdev/net-next/c/a01a67ab2fff
  - [net-next,v9,6/6] neighbour: Create netdev->neighbour association
    https://git.kernel.org/netdev/net-next/c/f7f52738637f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



