Return-Path: <netdev+bounces-24348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA476FE4F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC93528258D
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5700EAD2F;
	Fri,  4 Aug 2023 10:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363FA92F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D185C433C9;
	Fri,  4 Aug 2023 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691144421;
	bh=XiO9OYIBDeUhezzOqsS6ma4t29J6Vz8QnKGDqYD+rK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RdF2buhQKkUpHzhbxoKGm0Z0oV7Wco1aghBT92mZd6gdkY0HV30RTONIAoqzYX9mD
	 grG6POg/wdpDe7ohX+gQjQUflMAIq5GIkros/ZxKKbrCckw+U2ZGK8F1ctFy11YTLe
	 Ma2x0d4eReJAaAAUzW/w6O4XVcf5dDUG6m+FQWdRnFPbWrLwpRzhRe1daybMrcJrQX
	 0YvVWC+rZbIYVVYhrW1T2M9Fw7sE8THXU9ovlA+Jk8ZFlYLRd6Pety1aUp761W5cnN
	 cDVM/Ko4BviV72wkc43aNhHD0OQHVxNO2tbZAUbIrbFVw9cjXuY28eh/1FEtTektZ4
	 mjoug7WRb5bfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1510EC595C3;
	Fri,  4 Aug 2023 10:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] net: lan966x: Do not check 0 for
 platform_get_irq_byname()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169114442108.10944.15597556678030975340.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 10:20:21 +0000
References: <20230803082900.14921-1-wangzhu9@huawei.com>
In-Reply-To: <20230803082900.14921-1-wangzhu9@huawei.com>
To: Zhu Wang <wangzhu9@huawei.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 3 Aug 2023 16:29:00 +0800 you wrote:
> Since platform_get_irq_byname() never returned zero, so it need not to
> check whether it returned zero, it returned -EINVAL or -ENXIO when
> failed, so we replace the return error code with the result it returned.
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [-next] net: lan966x: Do not check 0 for platform_get_irq_byname()
    https://git.kernel.org/netdev/net-next/c/86b7e033d684

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



