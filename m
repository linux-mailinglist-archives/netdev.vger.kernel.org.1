Return-Path: <netdev+bounces-115456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D722E946674
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 02:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A5A1F220A8
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65F1C3E;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGiaxZcM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47B7196;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722645034; cv=none; b=pFd36yVaVX9gt59yXS6cjdvi933vedpT/vkFxpFlGJcDs2YbQ44+IvKEhuhYwO8tKdDK0AV0SNtLH6sZaJmrq2ShQR1KY/tsIOP/rKSo1vpnH7ILLwggTA1whAPpRyatJQCfxfNco7Z/HsrOoWsDKPEr+Cev5D5l8A2GibtFTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722645034; c=relaxed/simple;
	bh=0FTcKkMRva5cseVVnTNdCCSx8cksJLLo12AO1GBLEqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rd5rPzJh3BObuNqvC+RNnFmfKhKiCoiKgOxwb17o5yCH5nw6FpyOLQYm/TfeVboH0yuB17T1YFoXZJlxvwJVb0ME9JRiua1h+UovH6/whuKcGz4d5MPkBxrZVHvDmCKUhuyUDHMLLh0bSLZR41xQfC/vgO7ijwrAQ/8S2UZBqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGiaxZcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D9B5C4AF09;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722645034;
	bh=0FTcKkMRva5cseVVnTNdCCSx8cksJLLo12AO1GBLEqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pGiaxZcMLNtqXPraq09Bk9cGRtTG//KwnimlTom9eIKK6ybQHGr/zLbvZLYOU/2Cj
	 F6M4CFZZPQrLNaUp+mde0NkTxtvUi9gD/tWSsXaZvgdvINXEh1iydiI5yevuFNAlxi
	 sQc72O8ANb8VGbGjp7PCCZYRdzeaOnUP3j5ajqPAsZLGoYRb3DG195hbMvyrqJxRCh
	 aHSP7RHFG4jAlyuWa/92AqrXvZp+dMDI9G5gONq7I0jVu2z4l092+eYrqpN1IBz2Ul
	 /Q2cmGfby3BuEv75c1vBGtWGbfPmb/lYTdIg46+W5rKEdJ/rQkuw4vby/ODIML6mLH
	 0bj9z2itqH/RQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33BA1C433F2;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] rxrpc: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264503420.23714.13289570089059223174.git-patchwork-notify@kernel.org>
Date: Sat, 03 Aug 2024 00:30:34 +0000
References: <20240731100815.1277894-1-yuehaibing@huawei.com>
In-Reply-To: <20240731100815.1277894-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jul 2024 18:08:15 +0800 you wrote:
> commit 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")
> left behind rxrpc_put_client_conn().
> And commit 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
> removed rxrpc_accept_incoming_calls() but left declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] rxrpc: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/7e51d21ee010

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



