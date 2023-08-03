Return-Path: <netdev+bounces-24036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FCC76E8F2
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9131C2151E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD81EA72;
	Thu,  3 Aug 2023 13:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0FB15AC7
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD7E4C433C7;
	Thu,  3 Aug 2023 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691067622;
	bh=qee0L07NQXO46JN7ItvmxT+dkUH+JHAgABHZE8qWKP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R0KzniUtxaH6Gm4Ogv1umBjHB0l4HeCArjzlR2X2553HkxdW5iZQdxXUmrMcqLBWa
	 Yw+jNTsHVeFQvB9g8aMwN4ILrucad5h/Bj/rl2T/xeCulaD8KQvHU3SsNjKSENBrqX
	 cnp9zmy9YqNlrh1drAkJ5IgHmrPd7tbO7/M1UzlhSixlIe2y14pt3QOpGEjEiITfsk
	 2bEYWT9JkrjvGjY6LFvqrymYPyNu3V44J1lEVrzFGrxBf8xVZueiy9ZqQ/tEf4f9uq
	 hM1KRxJwzkKV+8CED8nM4TQ7D684ONAJ1RoopRDcGoqDaMv+ZWaqnVB1R2CWKpaNV5
	 c7m2Bi/bGY81Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0A3EC3274D;
	Thu,  3 Aug 2023 13:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] drivers: net: xgene: Do not check for 0 return after
 calling platform_get_irq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169106762178.3801.7881883856927565943.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 13:00:21 +0000
References: <20230802090657.969923-1-ruanjinjie@huawei.com>
In-Reply-To: <20230802090657.969923-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 2 Aug 2023 17:06:57 +0800 you wrote:
> It is not possible for platform_get_irq() to return 0. Use the
> return value from platform_get_irq().
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] drivers: net: xgene: Do not check for 0 return after calling platform_get_irq()
    https://git.kernel.org/netdev/net-next/c/c1e9e5e0b9cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



