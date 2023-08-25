Return-Path: <netdev+bounces-30621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4217E788369
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 11:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738051C20E43
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBFFC8D1;
	Fri, 25 Aug 2023 09:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D190CC2D6
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 09:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 368E4C433C7;
	Fri, 25 Aug 2023 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692955222;
	bh=JoBgPMp4ry/a0n5+V1aSsSSLZlDhtzmE8/ZEgb/IGbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KVh/5sJc0MxBF0pUMmWLXVH3XOMPONjQQrk2G6EnSjPzShdjTCDO4WwG8ETEpCL7f
	 1CvULiyNZn4bERyiHC00zkLq5/1FSfS1QwQr41AY0x40fwWmjuGmIfHrTXDawRnKlI
	 q9Y84WBmq1hknJyGERtXIc7cuI9hy2nvEy6K6CIE2irGTQGQ8CSthRYiK3mjvaDcsD
	 9GY2vk+MdcFl1UhyEXUkE6e+c8jwjNKleQakD7KlK+4UnCncTnnzKiB+pwAxjzlP9W
	 xoJshqtTXrwFr1YrRcDW0ofR0/E6RZcBtK4csVJVzFUPT2Lt2fFophl1EX+tQ94aSJ
	 QvlbQxWerh2aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1375FE33083;
	Fri, 25 Aug 2023 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: arcnet: Do not call kfree_skb() under
 local_irq_disable()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169295522207.11125.12612771428502419291.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 09:20:22 +0000
References: <20230824064336.1889106-1-ruanjinjie@huawei.com>
In-Reply-To: <20230824064336.1889106-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, m.grzeschik@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Aug 2023 14:43:36 +0800 you wrote:
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with hardware interrupts being disabled.
> So replace kfree_skb() with dev_kfree_skb_irq() under
> local_irq_disable(). Compile tested only.
> 
> Fixes: 05fcd31cc472 ("arcnet: add err_skb package for package status feedback")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> [...]

Here is the summary with links:
  - net: arcnet: Do not call kfree_skb() under local_irq_disable()
    https://git.kernel.org/netdev/net/c/786c96e92fb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



