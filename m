Return-Path: <netdev+bounces-47892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B37EBC7F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F031F2620D
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA510FF;
	Wed, 15 Nov 2023 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu+I2szJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4CEB8
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E41BEC433CA;
	Wed, 15 Nov 2023 04:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700020826;
	bh=AI3cBuzcruGzurx8eVipYDjvAXZDOVvOAJZRJIEet8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pu+I2szJVoKFnIiaS56XvgdXTgZZINw2OUckTsVEZUFYNMqzOnPOVYK76XmbY4rrK
	 EiIgpIPKHYsTtUVbC4KDqVufAl1fIiYC8VNn3g/YCQCMe9JHmCyA7JFiwUlouLXL2f
	 UNEg2G2RXxC4AVLKkS02UedPW8Nlirq1l2sdXsxbI0Fi+/NbmBBwSi6JaHq5zmM9p3
	 BFffo4/hfMtNMMb9f18rynxVzCo2Wlu6jkxFg6EfM+q9dS4/ns6E/lmZXTqDsHiOz5
	 OrS+YOuc2qK6xEgaa75onj8k+6VZLDubqGb3Ksn0x/r2q5uc6LxXzMQsi3Mghipd0/
	 NNT59VlPVGvvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9F86E1F672;
	Wed, 15 Nov 2023 04:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] pds_core: fix irq index bug and compiler warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170002082582.14036.798722275963326694.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 04:00:25 +0000
References: <20231113183257.71110-1-shannon.nelson@amd.com>
In-Reply-To: <20231113183257.71110-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, drivers@pensando.io,
 joao.m.martins@oracle.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Nov 2023 10:32:55 -0800 you wrote:
> The first patch fixes a bug in our interrupt masking where we used the
> wrong index.  The second patch addresses a couple of kernel test robot
> string truncation warnings.
> 
> v2: added Fixes tags to commit messages and more detail to first commit msg
> 
> Shannon Nelson (2):
>   pds_core: use correct index to mask irq
>   pds_core: fix up some format-truncation complaints
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] pds_core: use correct index to mask irq
    https://git.kernel.org/netdev/net/c/09d4c14c6c5e
  - [net,v2,2/2] pds_core: fix up some format-truncation complaints
    https://git.kernel.org/netdev/net/c/7c02f6ae676a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



