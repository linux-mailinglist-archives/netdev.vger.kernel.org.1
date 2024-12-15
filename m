Return-Path: <netdev+bounces-152041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF0E9F269F
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5DC1649AA
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB38C1C07C0;
	Sun, 15 Dec 2024 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh6QKerd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176C1E502;
	Sun, 15 Dec 2024 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302413; cv=none; b=Qbbmp8mjXLtjN2/f/fAoq5tNc2J1pn0FoqYVk4vJ96VS4Rn5mSnZ0M9PoKaFq7+6qozeA7jg2XZBTWjz+/mzxWmpKu0Qo4z2cKq1rlM7Z185yfPqna2YsF71Ih0JxE3y3znGtUVPafu74PgBG/YVv6xWXjzU3RpbLfLF8Dtl+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302413; c=relaxed/simple;
	bh=WfRQO+5tKU8KmCaXLq8NrKO4qYsjqbeYm/W9l7MGvQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y/fB6tlSfZidCc9mtOXVRDscUaLLTaSoKERNhMrLhSQJS8qKgYWjdAz+Ub7kRx+/ELSDUd89nvzdi/h7eQO65t+Y1XX37qhThntXXMt/0Tehqn8QBb5RSiqHWeQNLSWc17T0yx3Rk8u2y+hN5IP0Ndza00JgNwUZ3AEIvVNZVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh6QKerd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B96C4CECE;
	Sun, 15 Dec 2024 22:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734302413;
	bh=WfRQO+5tKU8KmCaXLq8NrKO4qYsjqbeYm/W9l7MGvQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sh6QKerdVhd4S1ruysVMhktLo3B1poA2coaH2dkFVm12tfM+UvfRy5cDktBGs5EqU
	 1fmRLmvbbiFvM/Q3I+QJmMe9geLycNsexlbEEafPha3BDcjGSDlxP7OXwtfReRd7cx
	 3c8VkOMSEymJoMXjswC4egjT/5hLMtA7vkkgdZlbxIUjSqh5Ku8ta0pPDp3xxL2eB9
	 72Lwzs+vMe4qfus8zk4UTqvM8EqR2SstO9oPdlS6AeUDw3pFXov52NXE6yGtN3JV1O
	 /wYTdiLnnLu1xHv/uu8GqMiGzzBrcc82N1bEAjuc1GuuMnn5NOa9pUr/O8L/Fzm+r7
	 O5gKJ8ikpvOag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342CC3806656;
	Sun, 15 Dec 2024 22:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] mptcp: pm: userspace: misc cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173430243000.3595979.4122680352068648129.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 22:40:30 +0000
References: <20241213-net-next-mptcp-pm-misc-cleanup-v1-0-ddb6d00109a8@kernel.org>
In-Reply-To: <20241213-net-next-mptcp-pm-misc-cleanup-v1-0-ddb6d00109a8@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 20:52:51 +0100 you wrote:
> These cleanups lead the way to the unification of the path-manager
> interfaces, and allow future extensions. The following patches are not
> linked to each others, but are all related to the userspace
> path-manager.
> 
> - Patch 1: add a new helper to reduce duplicated code.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] mptcp: add mptcp_userspace_pm_lookup_addr helper
    https://git.kernel.org/netdev/net-next/c/e7b4083b90b7
  - [net-next,2/7] mptcp: add mptcp_for_each_userspace_pm_addr macro
    https://git.kernel.org/netdev/net-next/c/a28717d8414e
  - [net-next,3/7] mptcp: add mptcp_userspace_pm_get_sock helper
    https://git.kernel.org/netdev/net-next/c/6a389c8ceeb7
  - [net-next,4/7] mptcp: move mptcp_pm_remove_addrs into pm_userspace
    https://git.kernel.org/netdev/net-next/c/8008e77e0741
  - [net-next,5/7] mptcp: drop free_list for deleting entries
    https://git.kernel.org/netdev/net-next/c/88d097316371
  - [net-next,6/7] mptcp: change local addr type of subflow_destroy
    https://git.kernel.org/netdev/net-next/c/1c670b39cec7
  - [net-next,7/7] mptcp: drop useless "err = 0" in subflow_destroy
    https://git.kernel.org/netdev/net-next/c/5409fd6fec68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



