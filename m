Return-Path: <netdev+bounces-26613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96299778594
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 04:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF3B1C20EB8
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21197A3D;
	Fri, 11 Aug 2023 02:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492F36F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C939C433CB;
	Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691721622;
	bh=dlLx6L5zKOsRJgI7/v+ZzPVU4r2Gh7u9HezzxdL/GK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ew0WDR08VfoOw2mBWogc3VsHmARwr2CO8kpYeRTF7mUup2BxKW1EIB1llS19YpAbb
	 c5Pd+dKpjSGgndk6BsylUJaGGCUFFZAoQQgZdQaf6zsaErWixGd2wYxlFm+Y5ypJT2
	 v5nwMI4Guz+CXl/LbI2n5TA9FBWmHsj2pjd1t5hXrcxrPtX+SL+jtcQQHmcQSLt1eG
	 pVywyfkG/BP0fbUdO3Bk2hLg2yxOeHvH40aER7xhsjcm0CVmyZ7Cp34bmE7wAs4rdd
	 o/duRI0c4c0LuVHfObfKKvoQuWVRClDYIn16ylygNPkHvA1UvQU5GDvkhLBbsS5YAL
	 j96BI5Fs9D5nQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41076E21ECC;
	Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Remove unused declaration
 sctp_backlog_migrate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169172162226.18522.10036459431907109450.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 02:40:22 +0000
References: <20230809142323.9428-1-yuehaibing@huawei.com>
In-Reply-To: <20230809142323.9428-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Aug 2023 22:23:23 +0800 you wrote:
> Commit 61c9fed41638 ("[SCTP]: A better solution to fix the race between sctp_peeloff()
> and sctp_rcv().") removed the implementation but left declaration in place. Remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/sctp/sctp.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] sctp: Remove unused declaration sctp_backlog_migrate()
    https://git.kernel.org/netdev/net-next/c/afa2420cff54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



