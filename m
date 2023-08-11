Return-Path: <netdev+bounces-26595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D4277849B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB8A281EC3
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 00:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D40811;
	Fri, 11 Aug 2023 00:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE8629
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93905C433CA;
	Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691714423;
	bh=jBrZsLshbErJau2UB1NGD4IiKnIwy6urCcdiFirZOLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mcth0UhJg+6X8rrZ72Wj0To8BxdrkAALQtBb0NhrySTIq/AyrBD3b3qxCmHhyrxpn
	 +IgIsey1KiOg008jvWVQC/KRLmPNWMlMsl8Ua0zg2J4xEQ6tq/weclG9PcQ0peMjC4
	 p6b5bOO1ayrE10LV8ehW3FPLHpo6cN3f4b4uuRH21ARgzr2Nnv5NcPpk7Zzoy9rxaa
	 Ds0zDNUVwyszYyw26w6Y9Y5VBgeveNoGPnAImS9iX+9r48dnas2vjytIzX/J5A38y2
	 1773Ihp+5/pYF5v5fa49Kk7MRiVEdlCplCOaypWu4f3uM//lT0H7tcBy5VWl27IQAq
	 ElN6Rl68NtOCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79C5EE1CF31;
	Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mhi: Remove redundant initialization owner in
 mhi_net_driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169171442349.25552.1558951182843628852.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 00:40:23 +0000
References: <20230808021238.2975585-1-lizetao1@huawei.com>
In-Reply-To: <20230808021238.2975585-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 10:12:38 +0800 you wrote:
> The module_mhi_driver() will set "THIS_MODULE" to driver.owner when
> register a mhi_driver driver, so it is redundant initialization to set
> driver.owner in the statement. Remove it for clean code.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/mhi_net.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: mhi: Remove redundant initialization owner in mhi_net_driver
    https://git.kernel.org/netdev/net-next/c/215c44fa69d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



