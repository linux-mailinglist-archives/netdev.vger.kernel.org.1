Return-Path: <netdev+bounces-152786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585019F5C82
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2945A1887312
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF7780034;
	Wed, 18 Dec 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRTgamAA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AA70817
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487213; cv=none; b=A+90repF/rHtWNBISPwfHJyISTZrG7xoMQFmrCr6p1Hw1yDSCulm34EswXrTuQTXVJl+L6tKuybxrS+a8rAWSNOGp9DGwrD2xABE/ru8IHg2Yuf0KYRGLTJigGxnM7NRCFZj+4YkUuUaV4GI6tDgWzgHN6cLJz1xNRVbcTkaH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487213; c=relaxed/simple;
	bh=tE/gydBZjciTdirIvu8WUunNi8vSlMz++B86iVl8dZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YRxMCef8nvGe00q5ZzMPRRQA8XRN55BX+jmH8IKIPU4b7T7NxvLFSeXD/ST5rkNK58PgOnTPWpoPv27XzehQb2evFrn7XyCDgPTmFG+r9IXgr5JpHjd4QL3VKHK+3GHfrJWElgOpJbCuPrUaoQT6cvMyBm1YcnlAfeAnQ5TRJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRTgamAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F12C4CED3;
	Wed, 18 Dec 2024 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734487212;
	bh=tE/gydBZjciTdirIvu8WUunNi8vSlMz++B86iVl8dZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aRTgamAA97ltTNguMyUDLn6+z0BOgBkrywsUb59t5UmWKL5vJ6Hq6+DTTAI4UXLdp
	 8AhtXznouTOnrKTGuwbuswbeyWw5rw1+tF5OYW6Aw32++TzuU7Ip6N/xOSO3aP+yKJ
	 2I43tJ2Wbxdnek3vnTQb+QecTekhZykUnKWgGbTBsJOe6cGKt7aLRzdz5VP7PBXtCf
	 JgwoRBO/WZfXGnky7x8rTW6s5Lz+XVt4U1Y7PWCpcNWV3zkdMQyR0XCcfknuyuUZ9w
	 R1RCAAhFqaUD2/U0zLLs2/pX064EOiKzmix39rrKTccODDIBW0GVUGL3YWNPyLsflJ
	 Cvpq3y0HAaC/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7C3806657;
	Wed, 18 Dec 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: netdevsim: fix nsim_pp_hold_write()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173448723026.1148670.4011756065393533402.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 02:00:30 +0000
References: <20241216083703.1859921-1-edumazet@google.com>
In-Reply-To: <20241216083703.1859921-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 08:37:03 +0000 you wrote:
> nsim_pp_hold_write() has two problems:
> 
> 1) It may return with rtnl held, as found by syzbot.
> 
> 2) Its return value does not propagate an error if any.
> 
> Fixes: 1580cbcbfe77 ("net: netdevsim: add some fake page pool use")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] net: netdevsim: fix nsim_pp_hold_write()
    https://git.kernel.org/netdev/net/c/b9b8301d369b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



