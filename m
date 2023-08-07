Return-Path: <netdev+bounces-24808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C63771BF8
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8B21C20A08
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C7C8EA;
	Mon,  7 Aug 2023 08:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BCC2EB
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88512C43395;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691395222;
	bh=iL/+NbRVo13kAlif6VG3M8XMM1PoCo/eLEsd1u3ftRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=klPFJFlXrT5Ezu1XZJBSwuoDTAb43dB3mMQm83zUQ/ciMQ4JElaxthC3GP34YRfZE
	 8e1jMhOQX+yj7f0Yeucr2QOpvFjbI/BgttqijIpJq4WLdbhHXxNpQDDlfKV0CGCruK
	 YQH3izF5o2EpaFFziGW6qfsrgUeCFSiIVYFGwr17ePYpA/EhYpKVaKe0Feqy15bG1Y
	 6mzRX+9jie6NRYLTXw0b8d2Mdr0AJFyAM3DYEQy9J+BhPu8ZnGBPQjdXGJxQbzceI2
	 /Pf/lTunrJFAjXA228iaWe5FiVuIY5neWzP1a4m0so+2AG+eVix4dtr2FGLSdjuC8k
	 6LQZ9TQwWihzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67D9DE26D5F;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] neighbour: Remove unused function declaration
 pneigh_for_each()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169139522242.32661.14808179897278889965.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 08:00:22 +0000
References: <20230805105033.45700-1-yuehaibing@huawei.com>
In-Reply-To: <20230805105033.45700-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 5 Aug 2023 18:50:33 +0800 you wrote:
> pneigh_for_each() is never implemented since the beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/neighbour.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] neighbour: Remove unused function declaration pneigh_for_each()
    https://git.kernel.org/netdev/net-next/c/047551cd305c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



