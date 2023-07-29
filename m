Return-Path: <netdev+bounces-22497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CCD767B5E
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 03:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F1C1C2196B
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CB7A31;
	Sat, 29 Jul 2023 01:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC43A41
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4799FC433CD;
	Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690595421;
	bh=LMcp1a1s8qDtBGSPyAtT7+g+htivmWZE2NAPXNW3AzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nmcm3ncEXD5O3gyt0kwMCMTwlWsxxEJGGDr3EkfZsGY6DjBngP6qjFPlKxpvvNQlf
	 87kyw5GKCcj/Boccxfhbk6bhmyo3lInDurwDSRYCC1PNwlzvCGzqZiYWXz/c6cyyJt
	 fq48z2y9kFpO0ZmB2SGRpJswUAK0/xq/zjvIWUio36ZJoE1vtFYuLIWDoHFmAlxXnx
	 0QzaL/+dhdpCU17irv2O2nsIZMQu0j18D/LJmVVOdGxqLZNtZuLjBZBpMqmEgrekvL
	 OYTSwvIvaqLMVLDquUAIMQgXNvSgH0jbK8jaGc9TxvLVfhDcSuFp92F4EvkI/j6sdw
	 WiSRl+pPvZKhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16047E21EC9;
	Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] bonding: 3ad: Remove unused declaration
 bond_3ad_update_lacp_active()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169059542108.13127.13317059978744090243.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 01:50:21 +0000
References: <20230726143816.15280-1-yuehaibing@huawei.com>
In-Reply-To: <20230726143816.15280-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jon.toppins+linux@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 22:38:16 +0800 you wrote:
> This is not used since commit 3a755cd8b7c6 ("bonding: add new option lacp_active")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: fix patch prefix
> ---
>  include/net/bond_3ad.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [v2,net-next] bonding: 3ad: Remove unused declaration bond_3ad_update_lacp_active()
    https://git.kernel.org/netdev/net-next/c/61c5145317a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



