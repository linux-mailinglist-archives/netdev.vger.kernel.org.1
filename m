Return-Path: <netdev+bounces-14697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647E67432AE
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 04:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924B91C20941
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7D17D4;
	Fri, 30 Jun 2023 02:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84315AE
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 02:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54BCAC433C9;
	Fri, 30 Jun 2023 02:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688091621;
	bh=dvQBHiFA4TSI4SsqY60yDO7lk7x5Ntblmj0QU5mJqCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BZcvXQYM6V29xtpOs8WsfueZcMjlna7yDMs3Lq/ccR8uWXnFpQnCSO4OTEVVccomY
	 dSvJXe1RcG4XbqGvO6kYM7jJAFl+IYHze+M1/GxwOWeUf4i6UZLuLY5V1xxDVhZRkf
	 Cv+v6wFir9mR0X0xVk0D2PffUeNVnkhyx6AmELy+bPHTTarPERMrxy/e30V8pqkS2m
	 WjTO3yMbAHKxD+Ik1jsItkj0/ciWBy1MF2Y9XtsOcCMKoCZomwD/caFPGhnmicW4BK
	 PvjCCLw4S4SDoRCwVjykBXx6m/SFEILmoXLm+TmQFdi3ADnYf/iG0KelqnBhYNdEkJ
	 qc3GVAB0bRH0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A116C64457;
	Fri, 30 Jun 2023 02:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND,net,v2] mlxsw: minimal: fix potential memory leak in
 mlxsw_m_linecards_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168809162123.14964.15651131891886422894.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jun 2023 02:20:21 +0000
References: <20230630012647.1078002-1-shaozhengchao@huawei.com>
In-Reply-To: <20230630012647.1078002-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, petrm@nvidia.com,
 jiri@resnulli.us, vadimp@nvidia.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jun 2023 09:26:47 +0800 you wrote:
> The line cards array is not freed in the error path of
> mlxsw_m_linecards_init(), which can lead to a memory leak. Fix by
> freeing the array in the error path, thereby making the error path
> identical to mlxsw_m_linecards_fini().
> 
> Fixes: 01328e23a476 ("mlxsw: minimal: Extend module to port mapping with slot index")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,net,v2] mlxsw: minimal: fix potential memory leak in mlxsw_m_linecards_init
    https://git.kernel.org/netdev/net/c/08fc75735fda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



