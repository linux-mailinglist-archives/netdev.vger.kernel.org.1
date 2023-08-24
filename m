Return-Path: <netdev+bounces-30462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 448177877D6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452031C20EDF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D96CA66;
	Thu, 24 Aug 2023 18:30:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C715AC8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1037C433C9;
	Thu, 24 Aug 2023 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692901850;
	bh=G3RcQiUB9lHpBqJhoBbZJZf0Ka589h2+a5VPcsmD+eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RbCnAWvkrE6iYQ+t57JiGbSFO31Ub5OjvVMSQyKVjY0Lq0sXWPd/mPCOAhkl9vJdy
	 kRLBCisC9ebg+wMsWGO6V0DJvrGjQfe8yTmsbiI13j0tHy5tZXvUIesGx3pSW76xQH
	 5+G6PBPxRVY81SxcFLJks9jPy14AxtFOoHt+s0ErNpEsX5UQaCc05dGJoV81bc5+Lc
	 lELhLcbiu/uTHRO7rJTeulbU1Pht7JRydOmuR7tx6mrjl137/B99Lzi75cnfVC2iDu
	 hLqYTw2NuzDg2s1+5PmB510LkgTOq667JxsegDJe7S3qECtr1QLVePJUiVLyiytF32
	 0HYniTkWgnroQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7DDDE33093;
	Thu, 24 Aug 2023 18:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: netdev: recommend against --in-reply-to
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169290185081.21414.1483462058903221585.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 18:30:50 +0000
References: <20230823154922.1162644-1-kuba@kernel.org>
In-Reply-To: <20230823154922.1162644-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Aug 2023 08:49:22 -0700 you wrote:
> It's somewhat unfortunate but with (my?) the current tooling
> if people post new versions of a set in reply to an old version
> managing the review queue gets difficult. So recommend against it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/process/maintainer-netdev.rst | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [net-next] docs: netdev: recommend against --in-reply-to
    https://git.kernel.org/netdev/net-next/c/35b4b6d0c53a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



