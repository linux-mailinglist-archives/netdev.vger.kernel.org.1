Return-Path: <netdev+bounces-130797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DD98B9BA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392471F23781
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DF19D88A;
	Tue,  1 Oct 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaAPQ+LK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF40185B6B;
	Tue,  1 Oct 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778627; cv=none; b=lHjZEpUIQmp9V+lC+H8PKAR7EsPHzj28IvsKM5DSReNX01yaLNzfBGz/LYqoKzm7OM9yuCU/aY/As6Z3viIO+3sXuk7fHRaUB4m6Lh3ztGdaWiAuCAIpf/bUaJEiZTAM3pDWm1c2MWYLAXTRzmGxDRkk+BlulOrfD54xBcfrpCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778627; c=relaxed/simple;
	bh=nHGqmcLHEk6oi5LeJ8nhA2+DOtq9we8Ttm4xBE0580U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fut56EfkaouKgQ87/RlolTrhs90yPGWkj8+f2u+0CyRn8hW28zXOjUyDRvAKQCtmDPYgcGyTQYuxIyO48FcbKjmF0/A8anLnSjTY8Afk1ROggfsPTTo4yxWyzOTqO3lllkarMvGHdRzzEQ0mpM++yhnPW4ymi0PL+tYre9bCHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaAPQ+LK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A57C4CECD;
	Tue,  1 Oct 2024 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727778627;
	bh=nHGqmcLHEk6oi5LeJ8nhA2+DOtq9we8Ttm4xBE0580U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DaAPQ+LKKMvDWJ8JJIdG50VnZv3yNDOLKdyfZSxZD4BnlPb/4qHzp/ynIZwHgNxmA
	 F7XNkbXtdtK9PStD3Y/xGLWEZOs1I6tBs63C35ygiD+Ib8WzV7FtbkprRRE9fMOAzd
	 wzD8KheGNlU5dil4QRqVsjZYHu30YR4BCkypnc4uF3cDfVEFyy4FWA1ZsOeERCPJk6
	 Ht92HdgCtwdlhZw4CXcMB2eXQ/XlLON6nENS/SKZoJ/acKATWS3EKBe0sqi2beGElq
	 8hQLoBCYxdhJzTM4MFxCwRz8G1glGC17sV82wWNI+JGmzqhjcOqR0jEQeIPMt9vCa7
	 bTRZlFMUZkdiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F28380DBF7;
	Tue,  1 Oct 2024 10:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] tcp: Fix spelling mistake "emtpy" -> "empty"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172777863026.301407.17090502668083389.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 10:30:30 +0000
References: <20240924080545.1324962-1-colin.i.king@gmail.com>
In-Reply-To: <20240924080545.1324962-1-colin.i.king@gmail.com>
To: Colin King (gmail) <colin.i.king@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Sep 2024 09:05:45 +0100 you wrote:
> There is a spelling mistake in a WARN_ONCE message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  include/net/tcp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] tcp: Fix spelling mistake "emtpy" -> "empty"
    https://git.kernel.org/netdev/net-next/c/44badc908f2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



