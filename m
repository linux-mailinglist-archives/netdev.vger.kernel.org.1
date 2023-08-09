Return-Path: <netdev+bounces-26088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD6776C5B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52750281EA9
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF91DDD6;
	Wed,  9 Aug 2023 22:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A3C24509
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5900C433C9;
	Wed,  9 Aug 2023 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691620823;
	bh=rcvq9ZfUzQqUzaZZnVWFWQkgUQFQeGIim2paJLyhXZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ENBgbJPJ2LwkzoUUGp9lR7aQdLo/6K/bnwJ40UKcrlvLVXTF/ZMLAOndblui2V5bY
	 0WB208vthFzwHEqm4dkf/eVjFkMugQfZTiu1bdH3ncUKnJygJ74SvUEnL5paokvloG
	 90t6QSshpkGqF9ao7RPMx1snjEGJECo5QO/tgZNOoWQnBdUeB9YQVdm5Vtd5CIDezS
	 rGoClhw7S/uj6A9TQukOmgFLZXyA1mwosGoQXYOjVJGXfCuTsSAqt+j+ZExlRzdNBQ
	 FBdG5W5c/mRZj72PlSo7GKC9tAPAteyR6ZZcd1WppV38Subr9AtOgAvEBoFOwbV2FP
	 LJClkzpuclB3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFF7BE3308F;
	Wed,  9 Aug 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethernet: s2io: Use ether_addr_to_u64() to convert
 ethernet address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169162082284.25117.3151233494635304762.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 22:40:22 +0000
References: <20230808113849.4033657-1-lizetao1@huawei.com>
In-Reply-To: <20230808113849.4033657-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: jdmason@kudzu.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 19:38:49 +0800 you wrote:
> Use ether_addr_to_u64() to convert an Ethernet address into a u64 value,
> instead of directly calculating, as this is exactly what
> this function does.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/ethernet/neterion/s2io.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] ethernet: s2io: Use ether_addr_to_u64() to convert ethernet address
    https://git.kernel.org/netdev/net-next/c/b77049f04ed1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



