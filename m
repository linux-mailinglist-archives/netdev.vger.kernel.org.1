Return-Path: <netdev+bounces-24806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4CF771BF6
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00D91C209E1
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E67C2FD;
	Mon,  7 Aug 2023 08:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87DC2E3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 733D4C433D9;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691395222;
	bh=tQoIKg6bFRw9OETRCOnRZslBnu3dvOus/7nJSrCPngA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pM87SYKDqJd4ugjI8DI7UC0KeT3U9IZAfP+sM82eyLhNMx6KjUW/3rVVRm77eB2Op
	 KbEoqBEHAtLONH9M/JHYkl63L78zlrZ6kXp8tDHBDHKclcP2AykPLKVLcUKroGouPo
	 ZuIDP1SWn2w5LOrdH6k7fB8IjtiISjbPHpza9GHm5c0/CB6uBuZjWvN7YukHyxKL8e
	 VgnJZgFwbIyaGeLUkI9RzIeqp3jYBX1LFisQd2+Nz4U8P3YfenOAVV4/Vo8ZHqK34H
	 +2Ij9BzX1Q99tSpBi1pXaQRdPWFLdd2ThP0C135ThEQa1vv/K1/OVMOIDbGWIXl3Vh
	 xpaB2vDWldJdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51185E22AE1;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pkt_cls: Remove unused inline helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169139522232.32661.6860870108106695649.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 08:00:22 +0000
References: <20230805105208.45812-1-yuehaibing@huawei.com>
In-Reply-To: <20230805105208.45812-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 5 Aug 2023 18:52:08 +0800 you wrote:
> Commit acb674428c3d ("net: sched: introduce per-block callbacks")
> implemented these but never used it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/pkt_cls.h | 13 -------------
>  1 file changed, 13 deletions(-)

Here is the summary with links:
  - [net-next] net: pkt_cls: Remove unused inline helpers
    https://git.kernel.org/netdev/net-next/c/992b47851be9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



