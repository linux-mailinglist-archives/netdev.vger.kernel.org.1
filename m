Return-Path: <netdev+bounces-29032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2E7816D7
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27C9281E38
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E010FC;
	Sat, 19 Aug 2023 02:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64C807
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C374C43395;
	Sat, 19 Aug 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692413425;
	bh=0jJt8m5yFKtJxamI0Ci5sBIWPYUY9djOARET/LN3jGs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FveI6L/ct3DXIsrGYU/0IeM/in60JziOIg65M/gNf9QPvxCBrSLsBvf87Jk/mI1c7
	 y10rwADS58M7UznOEg7nYXU7WWi1q1FyAafPejmmqzCJnpewlWSqMKB/oZ3q+Izjlu
	 Ltaw/+YhMjR4kQwrCypOdRR1aUs/yM5XMiMCC1/t3+a6GSLhPfrL+ao5XW8I4SnqGn
	 aPT5s+RJsYsThmrOKtREyz/LLRVdjtYT9Tf8e4CmMALH06uIgj7CjaFexS2RUtjYk1
	 CgmGYUY2k/7Kr7VWNSTMk3CpyVyJBZehKxh67CVaNicv1Z0EsSdRWrBDYNCXrvoC2L
	 8vsmCqDy8tZ2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48DE6E1F65A;
	Sat, 19 Aug 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: freescale: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169241342529.21912.8905041170100218080.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 02:50:25 +0000
References: <20230817134159.38484-1-yuehaibing@huawei.com>
In-Reply-To: <20230817134159.38484-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: madalin.bucur@nxp.com, sean.anderson@seco.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pantelis.antoniou@gmail.com, camelia.groza@nxp.com,
 christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 21:41:59 +0800 you wrote:
> Commit 5d93cfcf7360 ("net: dpaa: Convert to phylink") removed
> fman_set_mac_active_pause()/fman_get_pause_cfg() but not declarations.
> Commit 48257c4f168e ("Add fs_enet ethernet network driver, for several
> embedded platforms.") declared but never implemented
> fs_enet_platform_init() and fs_enet_platform_cleanup().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: freescale: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/cb49ec034924

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



