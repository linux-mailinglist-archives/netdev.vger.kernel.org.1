Return-Path: <netdev+bounces-206930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66508B04CF2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852D13A3BEE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFF51A2396;
	Tue, 15 Jul 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El5gV7Bt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26F155A4E
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539402; cv=none; b=FTXf5onmy6P9LQOYW3wCA0DK/J24ZbnlR4ioP9AulRHkVu5b1LPrnynx65zyrfiF2hydScNRvogndSuwpOtj9sWEtUsPsGEyNnuL8m2QmxdZ7Q9yMoW8b4bS8HlyAbgcRwfHUTGBBMba1FyGkcRMLA4CtEEui6fkt4gBWJR9CQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539402; c=relaxed/simple;
	bh=m0FCeCq4PWD1FQ6epbeJrVvmvzCmBv+Bw/qGN5TP2NU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dr0pfLxYIABe5/iu4FHkw/Ba/PsOVpRuLNCT30kZefIALALLH0wnSPWcOZB9RHb8NUDqAYvIsKP1IWyQfstnL2mOyGzLkmoOQd28sQTTkXWDlnCrV8AEt/6uGkzt359y7Y2zXaKoS/zSx1tzoMFbQsDXQcgcdBat9gYJzVTK1Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El5gV7Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587A9C4CEED;
	Tue, 15 Jul 2025 00:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539401;
	bh=m0FCeCq4PWD1FQ6epbeJrVvmvzCmBv+Bw/qGN5TP2NU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=El5gV7BtE/QYkx8iS5FzkO4lsDLVrLsNwOpnb11HdrZR4YbjwCIFTM6ATQHjeTsGP
	 txlxjuOj7ICjtiuXh0i86k0wsQotzI95pwrpLa8noy0P2F/m1nEhifwnLppZ456QF2
	 NQ6obxCyp6GuYLLxjIkfo6l/o7xzKgCP13sDJx8GIuCqeywkcWSgxMXPBlK7oRrJc0
	 qkiA+SmE9o4fqzCFkQlybdASZXDiIZZXTlLe4hpzNj3hT9oSn7ZZHoGeXAtq6GaNQn
	 B6JdY5wPEhhIdl97rGf0NxdwRc/sLPc0vYpf4v8KB22iktCoEBxlI4a+5zw9lzcemk
	 T67gmTuVTC+aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A96383B276;
	Tue, 15 Jul 2025 00:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: add rss_api to the Makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175253942174.4037397.5294561035148513127.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:30:21 +0000
References: <20250712012005.4010263-1-kuba@kernel.org>
In-Reply-To: <20250712012005.4010263-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Jul 2025 18:20:05 -0700 you wrote:
> I missed adding rss_api.py to the Makefile. The NIPA Makefile
> checking script was scanning for shell scripts only, so it
> didn't flag it either.
> 
> Fixes: 4d13c6c449af ("selftests: drv-net: test RSS Netlink notifications")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: add rss_api to the Makefile
    https://git.kernel.org/netdev/net-next/c/5ae3bcc20446

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



