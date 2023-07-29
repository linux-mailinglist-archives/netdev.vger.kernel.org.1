Return-Path: <netdev+bounces-22561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9B4768073
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B1D282311
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE5A171AA;
	Sat, 29 Jul 2023 16:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C7F4FE
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 347EDC433C9;
	Sat, 29 Jul 2023 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690646421;
	bh=L1NQaBN+VyMNym9qDiXL5U+SwrPEVXH+Ivar4V5k/QQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XWJcQzEJCmJeqQ2Z8O15bz9ACHFZ/Xy6p+VMhJCqs6QjtPQLH1sBAtktuqGFUTJDD
	 8mZNEh4QWoNlnvHEvXniKZLQ6U2KTUVurCEBhYtscXJpUozcUY0rVrWOCN5F/JGCLg
	 1X5i+GI7M/nieXNdBYDPVIGl+oWP7TsJxbqBOE/1qO9GHqCgJiuxvEXhdrPr8XoilJ
	 vCH74Lrzos/Mx2ALTmw6WDoTvd+ig+/NlYIPN3HNCiE0LENBSLxCYWW+oxjSBicSmL
	 q8nZ28ZbLQVSr7cz+2z4bghIJxqzSR1EinOwf/tl3LttGY0Au2NJC/PYZZXWVnwTRa
	 COy09ZwRHfVLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13C45E21EC9;
	Sat, 29 Jul 2023 16:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] team: Remove NULL check before dev_{put, hold}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169064642107.17949.4854420257500712245.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 16:00:21 +0000
References: <20230727005741.114069-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230727005741.114069-1-yang.lee@linux.alibaba.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, abaci@linux.alibaba.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jul 2023 08:57:41 +0800 you wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warning:
> 
> ./drivers/net/team/team.c:2325:3-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5991
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - [net-next] team: Remove NULL check before dev_{put, hold}
    https://git.kernel.org/netdev/net-next/c/64a37272fa5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



