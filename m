Return-Path: <netdev+bounces-29914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB078530C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1D11C20BF1
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3488A92F;
	Wed, 23 Aug 2023 08:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FA20F00
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0429AC433C7;
	Wed, 23 Aug 2023 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692780622;
	bh=pxRRnBzDZ/2vYB1cFW0TTmq3bLH+DeXMv2KfeXWwJf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VmAvzXFhpwawFU4vjFJQSFafE84E+weJiH5qvP6zdxyjDYHwQWSvPZZY/UojBZUDO
	 NfjsNa6Ctlo6frS61P++kCCwofa+7BDrdTl7iDbuP4vvf2auxHpklSxCgXkt07ESaX
	 ZQ7kmyjNCUuQZAw8h9NVCfyCsoggqRaDqWfN7POjN2DEWxe/sbzUHumBX+jY3XlC0p
	 rC+OP3tjI05wBVpTZhg7IgKyZdyH16gYG2Nfbt41o+x50dSACfH9lpN8PoYsdXsIZU
	 SyBjfQ/s2etOJizTvM2jb8kAZOhIhpu6Aip754WjckMyTKgXhIH3tbysa/YWoTxbhc
	 ZZFeFKOT+m81Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA54AE21ED3;
	Wed, 23 Aug 2023 08:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net/sched: fix a qdisc modification with ambiguous
 command request
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169278062189.13745.3034926060241116473.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 08:50:21 +0000
References: <20230822101231.74388-1-jhs@mojatatu.com>
In-Reply-To: <20230822101231.74388-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 xiyou.wangcong@gmail.com, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, shaozhengchao@huawei.com,
 syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com,
 vladimir.oltean@nxp.com, victor@mojatatu.com, pctammela@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 22 Aug 2023 06:12:31 -0400 you wrote:
> When replacing an existing root qdisc, with one that is of the same kind, the
> request boils down to essentially a parameterization change  i.e not one that
> requires allocation and grafting of a new qdisc. syzbot was able to create a
> scenario which resulted in a taprio qdisc replacing an existing taprio qdisc
> with a combination of NLM_F_CREATE, NLM_F_REPLACE and NLM_F_EXCL leading to
> create and graft scenario.
> The fix ensures that only when the qdisc kinds are different that we should
> allow a create and graft, otherwise it goes into the "change" codepath.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net/sched: fix a qdisc modification with ambiguous command request
    https://git.kernel.org/netdev/net/c/da71714e359b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



