Return-Path: <netdev+bounces-219385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC68B41133
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796641B615EA
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66A72639;
	Wed,  3 Sep 2025 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwSgGyya"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE904BA45
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858209; cv=none; b=aTi5kfrZho5Q4f2nI6cBUL/Fzlw6hrkhd7UAsisDYLzYyZtcS7wqdaVEUq/AI1orLHdJAMKz0FBPwUqrMhO6Pus7yiVMG0dU6pQYM0i+6QLWzx1z+mCjd2kAhow4YL2xGgStDYC0ZO3BPJj+JKNQTYKajySYgahZuiAhHwwLvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858209; c=relaxed/simple;
	bh=JifxtBI70mI0Qmk1r0YV94dWMv1pOv8RcMMbvlIHF2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uGhpmtEbtvBDEm48gu25RDNqdC+GKV2OjkppBluR26h8033Q5eciIpiVf8nB2nfE6cyyNUjKTovO+Rw037QQLRMcVpjdawxGYsXUWZ3qSDBzU1GTjMJZweHXL/JUH3pz5r0+Uh+3E3FMYjqXZGW/tJTw3jKqgmW0u++Dp2bYJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwSgGyya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AD6C4CEED;
	Wed,  3 Sep 2025 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756858209;
	bh=JifxtBI70mI0Qmk1r0YV94dWMv1pOv8RcMMbvlIHF2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hwSgGyyapOebUG/ViQbASfSiO44znUaTRz1LmyaWxeupbgZA89w6rIlmkeratVwgm
	 do6AhG+129fDBSRlpOCdnJTUS+zg9gTLBsaxszk51SFgk9cj8gflwpyHjHdBfXGk6F
	 CRM8kLAXt14uHQxCk6eS4KdRGvcnW9HD7xx+DPYvaoNqO7FcBow19XJm7V0qGza4ND
	 sPyxyEKmOoi8uIy88bj4m+ueO4dSDOJ96v7sEZ0n13HzSQ+obsn8xrhr35TN2VptA7
	 IT7AQjVSr5VrZWESOBBq3oHgaYXV3gSpT0fjn2fwruruMg+xHXj8+eH+MWfaOgaTqn
	 HYRHjpqrNPnXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF3F383BF64;
	Wed,  3 Sep 2025 00:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] vxlan: Fix NPDs when using nexthop objects
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685821474.475224.8396576644651360908.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 00:10:14 +0000
References: <20250901065035.159644-1-idosch@nvidia.com>
In-Reply-To: <20250901065035.159644-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, razor@blackwall.org, petrm@nvidia.com,
 mcremers@cloudbear.nl

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Sep 2025 09:50:32 +0300 you wrote:
> With FDB nexthop groups, VXLAN FDB entries do not necessarily point to a
> remote destination but rather to an FDB nexthop group. This means that
> first_remote_{rcu,rtnl}() can return NULL and a few places in the driver
> were not ready for that, resulting in NULL pointer dereferences.
> Patches #1-#2 fix these NPDs.
> 
> Note that vxlan_fdb_find_uc() still dereferences the remote returned by
> first_remote_rcu() without checking that it is not NULL, but this
> function is only invoked by a single driver which vetoes the creation of
> FDB nexthop groups. I will patch this in net-next to make the code less
> fragile.
> 
> [...]

Here is the summary with links:
  - [net,1/3] vxlan: Fix NPD when refreshing an FDB entry with a nexthop object
    https://git.kernel.org/netdev/net/c/6ead38147ebb
  - [net,2/3] vxlan: Fix NPD in {arp,neigh}_reduce() when using nexthop objects
    https://git.kernel.org/netdev/net/c/1f5d2fd1ca04
  - [net,3/3] selftests: net: Add a selftest for VXLAN with FDB nexthop groups
    https://git.kernel.org/netdev/net/c/2c9fb925c2cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



