Return-Path: <netdev+bounces-22429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7307D76776F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 23:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDD92826EF
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 21:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9551DA3A;
	Fri, 28 Jul 2023 21:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810541CA0D
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 21:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAE2EC433C9;
	Fri, 28 Jul 2023 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690578622;
	bh=WvnojnhByd5MPjscaGN7NHKXbrcQE2TCxRtsyx4JNR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZZk/LApQug7PbtqOE8zuYyu6A+5a9/WhinnCPxMy3fSekbFKYaTXU2+1EKsetn1S+
	 O6bVIqvdTjxKiepcrr/a5ZW90yH26W8nZdeogTzRf0UEHB6C/rwIzRRYBFt1GuSJN3
	 xr4PZcGp++BNSLqaN8XwpSG/2rGWdNOdLKZ4egV/zhUjwTTOmFqr4sspSFLi07rcBF
	 W2uEaWEj41hMY/rbjw8qlTk5gb80b/EofZxLKzCPRqmk81M4SZG7sYcEJWz2sGMTrq
	 LA5wwAoGeXa/RMzPNouolJU6L5nj+u2LF1aaFgeUDHOjCBgJHAO5OyGbr+jXLXiygc
	 fyk8aXcV8ubtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD103C64459;
	Fri, 28 Jul 2023 21:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Initialize 'cntr_val' to fix
 uninitialized symbol error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169057862183.4237.8725721177562844360.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 21:10:21 +0000
References: <20230727163101.2793453-1-sumang@marvell.com>
In-Reply-To: <20230727163101.2793453-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lcherian@marvell.com, jerinj@marvell.com,
 dan.carpenter@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 22:01:01 +0530 you wrote:
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:860
> otx2_tc_update_mcam_table_del_req()
> error: uninitialized symbol 'cntr_val'.
> 
> Fixes: ec87f05402f5 ("octeontx2-af: Install TC filter rules in hardware based on priority")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Initialize 'cntr_val' to fix uninitialized symbol error
    https://git.kernel.org/netdev/net-next/c/222a6c42e9ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



