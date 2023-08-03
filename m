Return-Path: <netdev+bounces-24037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F2476E8F4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28862820F3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93461ED5F;
	Thu,  3 Aug 2023 13:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952914287
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7122C433CA;
	Thu,  3 Aug 2023 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691067622;
	bh=M9kMtuPxpwIsKqYij3FE56Dlu0b087dc5zaUWi+LflE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A9WFOKV2S85vL8bZlwzHqEGkZuAVk1PSsMQoV996iBi6XB+sZnzfKVt37E0/4zkW5
	 lbd2RTF5SvDMU2XSjwzytM+27F4r9ho6yUf5QtOe1l5jg4X9aFA0wkNmqM+FBSXaYq
	 kJ8Dk7VlbrYvuoQtNaev8g3lgIHRgGoat9pOws70ZshH/s+RgXCVApHL44wy6Q6Oxk
	 c54vXAkTgCoqTWYNZOndhf13WWsqB3goysga1OHhYpn60tqtnle6Do44+yDoGW7ZvW
	 ROYtbSsxMvNuT2KyzLWBKreP8Ix46d6Hk74/+jWWRiIhhHS/pXa1/piWcKE63MDh/9
	 Yg+EWfKSHmMVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAB9FE270CD;
	Thu,  3 Aug 2023 13:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: gemini: Do not check for 0 return after calling
 platform_get_irq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169106762182.3801.17190427914870011062.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 13:00:21 +0000
References: <20230802085216.659238-1-ruanjinjie@huawei.com>
In-Reply-To: <20230802085216.659238-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: ulli.kroll@googlemail.com, linus.walleij@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 2 Aug 2023 16:52:16 +0800 you wrote:
> It is not possible for platform_get_irq() to return 0. Use the
> return value from platform_get_irq().
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: gemini: Do not check for 0 return after calling platform_get_irq()
    https://git.kernel.org/netdev/net-next/c/6abce66ba953

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



