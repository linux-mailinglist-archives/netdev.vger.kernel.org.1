Return-Path: <netdev+bounces-120770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497FE95A8FF
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F284D284163
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2D05684;
	Thu, 22 Aug 2024 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLncRyUE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951B1101E2;
	Thu, 22 Aug 2024 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287238; cv=none; b=LdkGcFNF2HU+7M1Ee7BPnpvye3ion4/VN0Jy16KxhkcYiBxWKE7RAAG2XPp4Z+iMGh4Ik75Jpy7bDrvRsggFWUkQ5+PeOkGhswbINKI9T1ri9HvX8SfdavBCxWTAL1sqeEnQVsSjNmIywG0TyrkB+8Vu6KrikKkB685ryn8CV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287238; c=relaxed/simple;
	bh=22s5hdA760B1zZTA4ie8B6ytn3zDxLtniGVKvxzPjZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rpkprNAnwEL3aVLJK0FZyzdHNmUshCTSJQ7G8oyCSUr0pl6uwWZi7P21f7YBNIDFeOwoVjo4mPE3TMgMFqHc7/OphZm6545LbUsyEk6j7yXhlinDmAYzVLn5oEMB0x+/JA/kJLxDpw+hxDPnuuGj7C7lE46D22uB0Npl6J2bShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLncRyUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21508C32781;
	Thu, 22 Aug 2024 00:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724287238;
	bh=22s5hdA760B1zZTA4ie8B6ytn3zDxLtniGVKvxzPjZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JLncRyUEAgPwse+n4HkdvUkrkx6zu5IdIbYAAdPdm26jvG3FudmgMXmc15+1ic3ln
	 dytjTTLbGVRW+9C9DUUOYmtxED5Hv86y/7NiEl2v+CU5RWqSMxUvkuQMKNOASupOnQ
	 mGBy/3ADuz5mDpPbXjUy8IcF1or6pp6zFytiBd++pe9WBuX1tqLmPvx+QllMoPHJgX
	 69j7XHSl50l4k+Z0dtkK6/Cx7UO3SCYNkTj1K/CFah9OUZNYw+H/K+679OS8ytjj+P
	 Tzvih5aWw598E94QQ/YTImKjtOF3sxVQX81SZB39afd0zinEDVDihlWIH1TaGTtRnA
	 KbxIGmHfHErDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8F3804CAB;
	Thu, 22 Aug 2024 00:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipv6: remove redundant check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428723773.1872412.3417555253186546832.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:40:37 +0000
References: <20240820115442.49366-1-xuiagnh@gmail.com>
In-Reply-To: <20240820115442.49366-1-xuiagnh@gmail.com>
To: Xi Huang <xuiagnh@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 19:54:42 +0800 you wrote:
> err varibale will be set everytime,like -ENOBUFS and in if (err < 0),
>  when code gets into this path. This check will just slowdown
> the execution and that's all.
> 
> Signed-off-by: Xi Huang <xuiagnh@gmail.com>
> ---
>  net/ipv6/addrconf.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Here is the summary with links:
  - ipv6: remove redundant check
    https://git.kernel.org/netdev/net-next/c/d35a3a8f1b7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



