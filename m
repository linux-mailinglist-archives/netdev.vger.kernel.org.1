Return-Path: <netdev+bounces-24707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41077150B
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 14:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8651C209C1
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3493FDD;
	Sun,  6 Aug 2023 12:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2054B28EF
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 12:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A824EC433D9;
	Sun,  6 Aug 2023 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691325021;
	bh=R93Ubr+gjX+YRhjz8vW6m0dgiIW/PVKKW12zitEIQXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RL7pmR/IGKhSN3IYOmLUxJ3CbrlfEx62+wiwYMrAA9MZ+v0iY4tFJoHhm/voF0AXz
	 Kyi0IfTBr6i5Y7dZp3ovesOgu4DMhaP4kqOT5HjMum99ALS5We1sSd1jcLIM/Oue0F
	 m5WKhL9S1ZBUEbXbhtSo0XtX3Z0FUAQWqzseHmfaFTBIOctVj+LMrMVdXeDMuLdSLE
	 VUD46VX7pya56fIHFEq4DbB+d1A7Ju/j/IY1nQwoaJJrqsLWSVXzLZFp0s4EdNksPd
	 eIaNnfv2uoqMbvPIX1BFRfS3iUI/4Wu5NDA+TxUHlIiGbWmWr485zgs2XMLHjAZ6dW
	 s9eGwgfTCnYig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AB1DC395F3;
	Sun,  6 Aug 2023 12:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] ibmvnic: remove unused rc variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169132502156.16904.13610919607621719422.git-patchwork-notify@kernel.org>
Date: Sun, 06 Aug 2023 12:30:21 +0000
References: <20230804092143.1356733-1-liaoyu15@huawei.com>
In-Reply-To: <20230804092143.1356733-1-liaoyu15@huawei.com>
To: Yu Liao <liaoyu15@huawei.com>
Cc: netdev@vger.kernel.org, liwei391@huawei.com, nnac123@linux.ibm.com,
 davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 4 Aug 2023 17:21:43 +0800 you wrote:
> gcc with W=1 reports
> drivers/net/ethernet/ibm/ibmvnic.c:194:13: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
>                                             ^
> This variable is not used so remove it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308040609.zQsSXWXI-lkp@intel.com/
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> 
> [...]

Here is the summary with links:
  - [-next] ibmvnic: remove unused rc variable
    https://git.kernel.org/netdev/net-next/c/813f3662c240

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



