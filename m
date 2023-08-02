Return-Path: <netdev+bounces-23768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CC976D776
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550BE1C20D6B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58E101F5;
	Wed,  2 Aug 2023 19:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA93D2E8
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CD1EC433C8;
	Wed,  2 Aug 2023 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691003422;
	bh=46PMWe3e0Io+gQooYpA8G1g0Au2bYDA8kL63f8rshnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=epEV6mxmHAP26amC1DCeKHFEhfnkdOIvng7Mr4jy2Z03x8AV+XARbZx5jV8uzKH+r
	 JWKnE0V5zagpXOcG34JsFU0ptNc8je+p2xLlX+yt2JCFUrvGe+5hcs4m5jHsBohUDE
	 wPHIkDmzILdWX1L1/iTNuBW9tHzc8b74FysohM2nugEaf/suELfO9mFrcfd4uIo/QQ
	 RbSjAQaZzDNtf3JA6dfaeEfitTeQXCiY3o9CPScfiC3SBuiLqIl/um5wol3xgr9E1I
	 7aZj7GX4BoY16W9ua31o1Q3tdoY0xCzIdfDW27CPJ/JLgtjTAGhh1Ywq//J6wl5dyv
	 eqH3KdtCSr3QA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F103E270D1;
	Wed,  2 Aug 2023 19:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] net: hisilicon: fix the return value handle and remove
 redundant netdev_err() for platform_get_irq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169100342218.23440.15408447758503116058.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 19:10:22 +0000
References: <20230731073858.3633193-1-ruanjinjie@huawei.com>
In-Reply-To: <20230731073858.3633193-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 15:38:58 +0800 you wrote:
> There is no possible for platform_get_irq() to return 0
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
> 
> And there is no need to call the netdev_err() function directly to print
> a custom message when handling an error from platform_get_irq() function as
> it is going to display an appropriate error message in case of a failure.
> 
> [...]

Here is the summary with links:
  - [-next] net: hisilicon: fix the return value handle and remove redundant netdev_err() for platform_get_irq()
    https://git.kernel.org/netdev/net-next/c/ae1d60c41e58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



