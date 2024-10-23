Return-Path: <netdev+bounces-138198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551549AC93B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844501C211DF
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0981AAE34;
	Wed, 23 Oct 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1c/jIkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A737C1AAE08
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683623; cv=none; b=rfXhfyAl/hM/f9io/m6c0MDWZRodxEV1gvRtd7PTv8bcriUyQi45pqsDum25KImcNcoMRQYyCnHp2m77SaqRcA1KlHptbFmS8htGSVEl3kiCJVbuIDkbt/g0tgHdN0MCi6SPrpGy5jNaH+pnbK2xTWxY9agbph0UBj5vCUfimU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683623; c=relaxed/simple;
	bh=SV1wpWoTFS0nXZXSGkSzpBYdMJXYXsNL1hRE7NbbCgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LaclZ94728QAK/mnwUo6gGQutTDu/5zgyVr8uo5TFJUAWl/Yfl5p4Zi8gzZlXVyYAATmlVMx7ElD7JfIonEhngnJ50TrUJMoccZGnjB0MjcmhxMBoyR96dqJQAwIyE/BnRmZRk8oCmRmCozuprJv9CXxMapu8kZs7oaXsrLmaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1c/jIkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5ABC4CEC6;
	Wed, 23 Oct 2024 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729683623;
	bh=SV1wpWoTFS0nXZXSGkSzpBYdMJXYXsNL1hRE7NbbCgs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l1c/jIkc6Un7MpvdjRiI3R1kgSGxlvaq5DugeM+3Trvkk/8uohz+nZfrfr3GrCQkl
	 U9+YGFxQP9ysb4k4hvtWKtOHSh0kOBqhhXz3/vokfhBzSlyR0fy6AoLMVW6JK9TVXw
	 eLph12DuVLrI876+B6gPVq7Qh09GBPZFjPcxeIxiDL0BxMrq+cXCpfn26dp5rrGPEi
	 nbptDtPgR8uSXAgvHnAXcpQFuAFL2kjPg0Yc7lbrML4qLy5p6GE/iknSwsD0gNNBxV
	 e10gMTt4WWY1BS8Pr0sEzZeZ3q7ZqFCQ2bjmNy8wVng+aD+qGiL9hZVXwrUDhFr+Rp
	 2FzwyXzLUPPow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3A73809A8A;
	Wed, 23 Oct 2024 11:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netpoll: remove ndo_netpoll_setup() second argument
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172968362951.1572492.17031788056848220711.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 11:40:29 +0000
References: <20241018052108.2610827-1-edumazet@google.com>
In-Reply-To: <20241018052108.2610827-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Oct 2024 05:21:08 +0000 you wrote:
> npinfo is not used in any of the ndo_netpoll_setup() methods.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/bonding/bond_main.c | 2 +-
>  drivers/net/macvlan.c           | 2 +-
>  drivers/net/team/team_core.c    | 3 +--
>  include/linux/netdevice.h       | 3 +--
>  net/8021q/vlan_dev.c            | 2 +-
>  net/bridge/br_device.c          | 2 +-
>  net/core/netpoll.c              | 2 +-
>  net/dsa/user.c                  | 3 +--
>  8 files changed, 8 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net-next] netpoll: remove ndo_netpoll_setup() second argument
    https://git.kernel.org/netdev/net-next/c/e44ef3f66c54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



