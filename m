Return-Path: <netdev+bounces-22966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167276A364
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4502816EF
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041D41EA87;
	Mon, 31 Jul 2023 21:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337991E518
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A32DCC43395;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690840222;
	bh=lFKNR/sceAlnAaw/eBi1eRE4s2qAwFbLSyPmukQH/Ho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TRsxmW/RY1aTu6X6bhQwBkFv3hlUNdJGxWywrJGbtTXNKYGr5Q+2bbT4VESKi4zUX
	 BoaSd3DocZICPmS+Ff6ejYvgscitijl0e4slZt8CWA4Si3IhBQmLTFuqczBur+yqCe
	 6uaOXwgFJW6SWQ7zGBs/TMOf+1GvUfpM6c2PWIFyeCEZuCJOi/XJ3E1Z3SiGjodzfI
	 YtPJD+aKXzs8bGD15z+7i9e9eODR0cE8akKAOzou/kuG8a5dvsoDBqsKibSJYMV9E8
	 jPnbBk2K9YnU1q9WYjmb4K/zo9bfAMiUi2MqXxWwQfH3JoHfjGuVZYMj7o5B0VGDvG
	 zoF9KoXoMzMmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8354AE96AC0;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169084022252.13504.15977220371779488988.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:50:22 +0000
References: <20230729121929.17180-1-yuehaibing@huawei.com>
In-Reply-To: <20230729121929.17180-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Jul 2023 20:19:29 +0800 you wrote:
> commit f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
> left behind smc_lgr_schedule_free_work_fast() declaration.
> And since commit 349d43127dac ("net/smc: fix kernel panic caused by race of smc_sock")
> smc_ib_modify_qp_reset() is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/smc: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/4cbc32a8a2b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



