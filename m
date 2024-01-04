Return-Path: <netdev+bounces-61438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C5C823AEB
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 04:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5053E287FAE
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7574D4C9A;
	Thu,  4 Jan 2024 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7KVqZGs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42418C3D
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 03:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC776C433C9;
	Thu,  4 Jan 2024 03:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704337227;
	bh=PqMDqrYiHgLdiaozIDEGxafabp7H0tOLTeNvjkYCaz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t7KVqZGsohScD2xPbTtB3oh9gZJ95KpgCm5/IsVtDpUQrl/N1d1FAAhJPSFdQymAZ
	 3jFmsjcWwrun2uhy8YM2nYZaoAxbzSrC4VHDS6jDO0hLwpDx+mZkQx9ZEe9ZX4zdCG
	 DD/NnnacJUNbolMW6RNAuj+8nyyNj79YNgshURX5BFp2FeZ4K/ZYYgpxM6pnXOrMwc
	 jmV3hae3v5T9fgOEiuVsyqJ63yfk6JYzMmek03us5/X8F1f7Fmsdq26bWg47ALPh13
	 awJvPPPpMs6WvI1G4EJ2FUdncPctUHC1xR3GTV/JcuOW3LE1rYNGz6YZmoF5VPIjn9
	 IigVwI5Jf2Xog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D62E2C00446;
	Thu,  4 Jan 2024 03:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: sch_api: conditional netlink
 notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433722687.32402.7591315613076169807.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 03:00:26 +0000
References: <20231229132642.1489088-2-pctammela@mojatatu.com>
In-Reply-To: <20231229132642.1489088-2-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Dec 2023 10:26:42 -0300 you wrote:
> Implement conditional netlink notifications for Qdiscs and classes,
> which were missing in the initial patches that targeted tc filters and
> actions. Notifications will only be built after passing a check for
> 'rtnl_notify_needed()'.
> 
> For both Qdiscs and classes 'get' operations now call a dedicated
> notification function as it was not possible to distinguish between
> 'create' and 'get' before. This distinction is necessary because 'get'
> always send a notification.
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: sch_api: conditional netlink notifications
    https://git.kernel.org/netdev/net-next/c/530496985cea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



