Return-Path: <netdev+bounces-23783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC876D819
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBD4281E57
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFDD125AC;
	Wed,  2 Aug 2023 19:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1810965
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D3A4C433CC;
	Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691005223;
	bh=ntE7x440WqEUbNY8M+ltcrdf6axTMOGTFbqhT+vRm6I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MYocrQ7LcKZSfhKRpBLmk/AaLFP2/vfTHAs+wxwDC2TlDTDcPSt5dnfb88yWo4oIp
	 w6pHePSo6Zk57nKeuzgbtSsvvQtBbEZGS6Ym2izuSCCXQ530wDizAJ39eohL/Z1gAW
	 rGQBiRVGYeaqNzRED+YHdtvwT1LuRLzvmWbskH3iN1WyHJbZBLkhXsjXQqqYiOIXWo
	 5bWk0lF26EncGvxZfNG2JXvgzKWBhWf2iwBhZ4GXIGN7umy/RFV3+MXtAliATaKNXL
	 Ioc41g2WhDGXJMX3XjQRkBZjml2dGnS7v0F2r2vnZmUZEM+WElbeidH1+HAopc/bd6
	 0a9DhoIoQ1oNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E6D1E270DD;
	Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: switchdev: Remove unused typedef
 switchdev_obj_dump_cb_t()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169100522325.7181.524191498220340231.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 19:40:23 +0000
References: <20230801144209.27512-1-yuehaibing@huawei.com>
In-Reply-To: <20230801144209.27512-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, petrm@nvidia.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Aug 2023 22:42:09 +0800 you wrote:
> Commit 29ab586c3d83 ("net: switchdev: Remove bridge bypass support from switchdev")
> leave this unused.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/switchdev.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: switchdev: Remove unused typedef switchdev_obj_dump_cb_t()
    https://git.kernel.org/netdev/net-next/c/f85b1c7da776

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



