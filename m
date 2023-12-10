Return-Path: <netdev+bounces-55643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC780BC92
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 19:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60678280CA3
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E521A5A0;
	Sun, 10 Dec 2023 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTJZ1eUm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58119BBD
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 18:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45CEDC433CA;
	Sun, 10 Dec 2023 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702234223;
	bh=a1wA9coOsT/SBm8i1cThGo7S6qPTNMtxqJh6eFfgyFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bTJZ1eUmcLWi/SF5zHGsMPMTNhTjoifDA2WmgHrz1PAPesd/Z9IWK8iHmhcKjt2Hg
	 WRImtJMeUmPvV6bJfqq+Ac1jcvhTjoSy6y9eI5K+ic1hadSAW6JWuyEBVb+uy0nojF
	 ba6O2Z3zKZmN76cTlzmg/xUCI6s9vrc0x3+TnoFP6zQe2zPAkwlAXAuzPG8wlwZgLD
	 qtoEKKkCIMiz4U24b6qbHlKdP87f0e2JDHSLlV4GwCxXEsP3zesvoVfkFYOJcirMEI
	 TBmXP/t7gqfk1HyPJQipH8spsKkyVha3Syl1vr6/2JCNHqDrK/zaNh6Ew4JkfgdF1+
	 +aKHwAVOmEa5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F0DCC595D2;
	Sun, 10 Dec 2023 18:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-af: fix a use-after-free in
 rvu_nix_register_reporters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170223422318.23610.16553324017708743625.git-patchwork-notify@kernel.org>
Date: Sun, 10 Dec 2023 18:50:23 +0000
References: <20231207094917.3338582-1-alexious@zju.edu.cn>
In-Reply-To: <20231207094917.3338582-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 george.cherian@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Dec 2023 17:49:16 +0800 you wrote:
> The rvu_dl will be freed in rvu_nix_health_reporters_destroy(rvu_dl)
> after the create_workqueue fails, and after that free, the rvu_dl will
> be translate back through the following call chain:
> 
> rvu_nix_health_reporters_destroy
>   |-> rvu_nix_health_reporters_create
>        |-> rvu_health_reporters_create
>              |-> rvu_register_dl (label err_dl_health)
> 
> [...]

Here is the summary with links:
  - octeontx2-af: fix a use-after-free in rvu_nix_register_reporters
    https://git.kernel.org/netdev/net/c/28a7cb045ab7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



