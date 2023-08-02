Return-Path: <netdev+bounces-23607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD2E76CB43
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D101C21287
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5863CE;
	Wed,  2 Aug 2023 10:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0661872
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D881C433C8;
	Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690973422;
	bh=CI4rvaJsbN5bi27vTr4u15Rf7ef4sPYVyJp8S9FsDg4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s+yH5OsRPt+FXgZnqi1yN6KaivFjX1mpHA2cH9e3ma7Ohi0HtISQ+IIgEJfKagc6D
	 yfrI/0UjQGX+sYfzJ3KqIEVJedU58VouaDiOkOivf2YCdO8h3xhBqfCiNvs9eKXPGN
	 Gm6v8BCman8avktO/knvyzZk2tqGvZv6DGPeBqtudsNSQHNBoXuibabGHl6s4BcHbr
	 zXr3x9a8juo6AXb+PN4eyDfvW4EgBm3mBW2qEz8OIqCbwYdWlfIws8lKM/0JcNXQ92
	 jxiSsrwRo3shz4azZosUvgMT74EkqjGA7fsVErP5RIkjYy5iPoTIWZ4MeTmSmU3Glq
	 YHDkx6d6GdQ9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5322EC6445A;
	Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove duplicated include in mac.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169097342233.23292.18242368083223703063.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 10:50:22 +0000
References: <20230801005041.74111-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230801005041.74111-1-yang.lee@linux.alibaba.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: madalin.bucur@nxp.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, sean.anderson@seco.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, abaci@linux.alibaba.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  1 Aug 2023 08:50:41 +0800 you wrote:
> ./drivers/net/ethernet/freescale/fman/mac.c: linux/of_platform.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6039
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/net/ethernet/freescale/fman/mac.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: Remove duplicated include in mac.c
    https://git.kernel.org/netdev/net-next/c/34093c9fa05d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



