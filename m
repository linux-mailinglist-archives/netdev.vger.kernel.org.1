Return-Path: <netdev+bounces-32365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D47879712C
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 11:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44071C20ABE
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D2E1C31;
	Thu,  7 Sep 2023 09:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C91FA3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 09:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1E5CC433B6;
	Thu,  7 Sep 2023 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694078424;
	bh=eg664JVvulepbuVjHAcVo26wcKMFi3AZs+ECL6A2lJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MdYgErh4Wt+yJh5kMNG7AQFPaLDSGy07WNqg1sC7QaBHIPXnqw7gWzJiEVVaOPBqI
	 tDs9G8mkXdWFa/zFUpzk04JmoNwW8f1bEu1EV6NnvgjVdA98bhr5zPChUmLynCGR39
	 9TIunO8NZokRxmlEGPBdU9B+oBNX7DE2s5Q7iSn5fNDnAExGSY+jVyX7O8Yy5LW+lV
	 7jS+fxb34c2LP+kOrstAqFSBDmvmfIg6HSOyarQ1/jPgGU0EJ/2jVe5o/p6w0p8XSy
	 JF02rEoYNcaAYL6wSExYS8KejoKneLtij+JNvsmknW/sQYpONyCV4CFpllPHGhgnyP
	 dHkOtIPwltsNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6344C4166F;
	Thu,  7 Sep 2023 09:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169407842467.2177.2525780122496274621.git-patchwork-notify@kernel.org>
Date: Thu, 07 Sep 2023 09:20:24 +0000
References: <20230906072018.3020671-1-shaojijie@huawei.com>
In-Reply-To: <20230906072018.3020671-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 6 Sep 2023 15:20:11 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> Hao Chen (2):
>   net: hns3: fix byte order conversion issue in hclge_dbg_fd_tcam_read()
>   net: hns3: fix debugfs concurrency issue between kfree buffer and read
> 
> Jian Shen (1):
>   net: hns3: fix tx timeout issue
> 
> [...]

Here is the summary with links:
  - [net,1/7] net: hns3: fix tx timeout issue
    https://git.kernel.org/netdev/net/c/61a1deacc3d4
  - [net,2/7] net: hns3: Support query tx timeout threshold by debugfs
    https://git.kernel.org/netdev/net/c/dd2bbc2ef69a
  - [net,3/7] net: hns3: fix byte order conversion issue in hclge_dbg_fd_tcam_read()
    https://git.kernel.org/netdev/net/c/efccf655e99b
  - [net,4/7] net: hns3: fix debugfs concurrency issue between kfree buffer and read
    https://git.kernel.org/netdev/net/c/c295160b1d95
  - [net,5/7] net: hns3: fix invalid mutex between tc qdisc and dcb ets command issue
    https://git.kernel.org/netdev/net/c/fa5564945f7d
  - [net,6/7] net: hns3: fix the port information display when sfp is absent
    https://git.kernel.org/netdev/net/c/674d9591a32d
  - [net,7/7] net: hns3: remove GSO partial feature bit
    https://git.kernel.org/netdev/net/c/60326634f6c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



