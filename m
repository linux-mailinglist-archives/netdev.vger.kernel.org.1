Return-Path: <netdev+bounces-28580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC5D77FE44
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DC51C2144B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3261AA7D;
	Thu, 17 Aug 2023 19:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F618007
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AA47C433CD;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692298825;
	bh=BgreNA8ESiGBzrso2LGXT7Q/GhMDKj/S+Vu29lBKGL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e53esiODKz6TNfZHIi7ydgAMXUnK22Vg3BYDhjvxSQ/yVYZxMdhk9/OKMyySqHxx3
	 P+8M5sHH7a9EAAUFG9FrTsxP8R6cg2W6HJOgKEFKruOMcr96qf/pAiIEp1OspOFmF5
	 C23cKwgqmD/cKqjApGzeNQpuBy39QMx0od5WvCPYrbjojG1L6xVlfS+NGgiJktS5Wc
	 HMu5BGtPffF2T4uTIzVq43QvlgGHJ/c0bziHomKeFAAqcNfVvCBcgMfZUWW0BhcCtz
	 13PoetOhIQsRz4ue3l6MGHMtEhNN3p1skRrrCmWdEjOW5ipnvHUu9rZxoyUfmJX43u
	 sXNWC4UKwDAwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36166E26D37;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] sfc: don't unregister flow_indr if it was never
 registered
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169229882521.13479.13967964098712151716.git-patchwork-notify@kernel.org>
Date: Thu, 17 Aug 2023 19:00:25 +0000
References: <a81284d7013aba74005277bd81104e4cfbea3f6f.1692114888.git.ecree.xilinx@gmail.com>
In-Reply-To: <a81284d7013aba74005277bd81104e4cfbea3f6f.1692114888.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 pieter.jansen-van-vuuren@amd.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Aug 2023 16:57:27 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> In efx_init_tc(), move the setting of efx->tc->up after the
>  flow_indr_dev_register() call, so that if it fails, efx_fini_tc()
>  won't call flow_indr_dev_unregister().
> 
> Fixes: 5b2e12d51bd8 ("sfc: bind indirect blocks for TC offload on EF100")
> Suggested-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,1/2] sfc: don't unregister flow_indr if it was never registered
    https://git.kernel.org/netdev/net/c/fa165e194997
  - [net,2/2] sfc: don't fail probe if MAE/TC setup fails
    https://git.kernel.org/netdev/net/c/54c9016eb8ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



