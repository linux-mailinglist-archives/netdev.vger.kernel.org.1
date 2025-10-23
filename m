Return-Path: <netdev+bounces-231968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD1BFF0B4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 05:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AB919C10CF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89402E7623;
	Thu, 23 Oct 2025 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aovxd7c+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC972E7178;
	Thu, 23 Oct 2025 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761191197; cv=none; b=gMg3ktKolM2dM0iRXdYa9CX1nWUF3Usg6r8Mm+4t0sY3FilCdYY/rEqJXrlOzk3hc1NLBi1vMUDc7ZkyWYVoBdIrs5J5IwfT3Z618lniV+mmv5aFxRv8yvCFqCqAXGbjsEnPCNDaffhTBU7lVzbcYVX7ujpqYjiitMvGN8iFjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761191197; c=relaxed/simple;
	bh=S5nq9k5QQTCvi4edbviNu3JsShOWgvRf9oPWOteO+hY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p7VbABRrlLFVqZxM3iyoAelV7h1NjqsB0zg/frK5cp6LGwCCnRN5dyyGYnAeODp37AGp6qqusDqnredvrzjcNw2tffhAl2VbgyvlLH5K+1pU8FA5/Q/CNQGDuw/O8/Z2GOGCl5yhorRb8eSa8pxUupfHgSR9JjUIs4ai7wy2Qo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aovxd7c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B9FC4CEE7;
	Thu, 23 Oct 2025 03:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761191197;
	bh=S5nq9k5QQTCvi4edbviNu3JsShOWgvRf9oPWOteO+hY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aovxd7c+O5QHJrm2lAE7rz5L0Xg261/UJ4rQjpPRmwmHHlfDLLIhJbejzQ+TASkza
	 CS3Gxt7jpk6c55lzrJQLKW8GCZGmPjPQqKbbm/dX7WcXUeRaF7eeWlItrSGTKK7mlo
	 1+zDrfBDdmP7A7396lgw6PV0lVKwb2K2W66Xdpcc0U2bxvrkREQKmjR/DHrZ3Aq6i3
	 8Q+YbA3iyiHokS1uI0B3+fBf2RTL4Np+hIYFslmTuWUO2Bs3zJzkKJGNHMUCyovxwP
	 X8A9T2AzOy860YMidZvS0q1Ke5HrBtXCCn33hdocX1nusgg724CkozTaH4635g7mVP
	 NqJlPsNSlZwXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7F2063809A04;
	Thu, 23 Oct 2025 03:46:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: Remove unused inline helper
 qdisc_from_priv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176119117824.2145463.1631804906122880287.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 03:46:18 +0000
References: <20251021114626.3148894-1-yuehaibing@huawei.com>
In-Reply-To: <20251021114626.3148894-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, xmei5@asu.edu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Oct 2025 19:46:26 +0800 you wrote:
> Since commit fb38306ceb9e ("net/sched: Retire ATM qdisc"), this is
> not used and can be removed.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/pkt_sched.h | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [net-next] net/sched: Remove unused inline helper qdisc_from_priv()
    https://git.kernel.org/netdev/net-next/c/114573962a68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



