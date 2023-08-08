Return-Path: <netdev+bounces-25624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40974774EFE
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BC11C2102C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AAB1BB43;
	Tue,  8 Aug 2023 23:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195A18038
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 853DAC433CA;
	Tue,  8 Aug 2023 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691536220;
	bh=ltFdRQeANiooNwH2IbC51lN2cDN0BhtSkfUaqRTqkmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pQd6hP6MVbe2B68s4NAPxGn9gRPKxdZ9goKm8V1Y6+wuQcoqZ/8p8xaB7pz8CYXE5
	 UP4HdQjp7Wys7ELGDfCCH0t4pcBZ0+KkL/8y45eUxVQt7MtVZCw1SXba2DmVMEx1Dz
	 e0Y/7NSgSNTUtKDEUKgOz2N+ZQgzQNt+baQgSu6O3QU+jlMG6NQEm5O4ZWGvTpKc7g
	 otE3xpI6wT7QXXCAid/3OvZ9twMZKsA4iQfVT00dAktIv+MRONIZvmHcL+9/FWbepM
	 lpPbpcasMrDPipnRPC9f5sY7GhqXk8TC4GJbK3NWKqI4ZMe9IijE+QpU58fYGUGHQa
	 iWQqlDCrXXc/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69730C64459;
	Tue,  8 Aug 2023 23:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] devlink: Remove unused
 devlink_dpipe_table_resource_set() declaration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153622042.13310.2731949077058666639.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:10:20 +0000
References: <20230807143214.46648-1-yuehaibing@huawei.com>
In-Reply-To: <20230807143214.46648-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Aug 2023 22:32:14 +0800 you wrote:
> Commit f6b19b354d50 ("net: devlink: select NET_DEVLINK from drivers")
> removed this but leave the declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/devlink.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] devlink: Remove unused devlink_dpipe_table_resource_set() declaration
    https://git.kernel.org/netdev/net-next/c/b876b71a6ac2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



