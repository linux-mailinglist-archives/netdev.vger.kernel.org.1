Return-Path: <netdev+bounces-26041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3437769C8
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6521C2136B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C21DDC4;
	Wed,  9 Aug 2023 20:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B719BCE
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF6D4C4339A;
	Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691612422;
	bh=97Pb1Yjjijsom7/60qUoaKMfS9wNjNeaCOqKS0Oiajw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TYDmXBI9b4VpoxxaQU8bFI++qBxMY8y8I07qTeBh9OYA98WdR8dvRwLfUEJYv1kJm
	 GM0B1Z3RUhPloUZ7Rvt4EGXK1b3nQmyKp53xfNOlFbg9VJt7kfQuR7vB5toK4gt3SM
	 hXSC5bNR43U/7pqNkSfwL5CyMp3cN2yyRh9mCg4MT12F55I+D3cLcZ6wtDB1ybCaNN
	 8RgWmpt3/Ay6Jt0nwL6DYcbgPDfxUf7ZwsF9ZqH+qiYbbHbPnTPQcwQrbcthZjyhzA
	 Lx/0hr4E/rLxXZFHAMpqTuOSz7qS7jcI02ET1fIjQbvrIdMdzXm5rPam+vVEZQs4zT
	 06BOCOvWummkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9094EE33093;
	Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: switchdev: Remove unused declaration
 switchdev_port_fwd_mark_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161242258.16318.3852777039815830996.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:20:22 +0000
References: <20230808145955.2176-1-yuehaibing@huawei.com>
In-Reply-To: <20230808145955.2176-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, petrm@nvidia.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 22:59:55 +0800 you wrote:
> Commit 6bc506b4fb06 ("bridge: switchdev: Add forward mark support for stacked devices")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/switchdev.h | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [net-next] net: switchdev: Remove unused declaration switchdev_port_fwd_mark_set()
    https://git.kernel.org/netdev/net-next/c/a76728719c85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



