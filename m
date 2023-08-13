Return-Path: <netdev+bounces-27110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D077A635
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 13:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58058280FB5
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 11:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB2853B5;
	Sun, 13 Aug 2023 11:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF19538D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50A6DC433C7;
	Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691926222;
	bh=jbdj++Mx2oPt1m78JJi5wWjRpFgvtCP2dY0aBpjBUEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=exe2kZhToaSUSIEVsNRdSP95Q7utjmc1ty5Yg9vjZApaylAQBTeKQQraki42xL9Ag
	 M7P5Ulx3WtiJEvLdH4Yfx9v2aVDxpXdYzQoiRAjNuMgK4nWxnp2ZOuqjaOARXxA4Ka
	 NmFWAE94vkN5oTyCUsiqItTl3lbEMs9T+A/ELY9wtNf5vRUam1OwMELt/p8sGP5HXJ
	 peVd3tENRb09hVVi7m5WqO3uQDUIlHYKM/o/6RpS9hvSULUA8uNi0wcqUXxDyS1Ltp
	 K6uMyvB2BjKbD//9jdSnvbguJANAa41NfgU5enGGsEqgf/P3aLDgUy1zudF9JFJTqV
	 kOUbPmiYtFzKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C75BC3274B;
	Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net/rds: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169192622224.28684.13322550078177356055.git-patchwork-notify@kernel.org>
Date: Sun, 13 Aug 2023 11:30:22 +0000
References: <20230811095010.8620-1-yuehaibing@huawei.com>
In-Reply-To: <20230811095010.8620-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: santosh.shilimkar@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 17:50:10 +0800 you wrote:
> Commit 39de8281791c ("RDS: Main header file") declared but never implemented
> rds_trans_init() and rds_trans_exit(), remove it.
> Commit d37c9359056f ("RDS: Move loop-only function to loop.c") removed the
> implementation rds_message_inc_free() but not the declaration.
> 
> Since commit 55b7ed0b582f ("RDS: Common RDMA transport code")
> rds_rdma_conn_connect() is never implemented and used.
> rds_tcp_map_seq() is never implemented and used since
> commit 70041088e3b9 ("RDS: Add TCP transport to RDS").
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net/rds: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/2b8893b639e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



