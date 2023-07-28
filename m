Return-Path: <netdev+bounces-22357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1233767264
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB2B2823D9
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D4E15481;
	Fri, 28 Jul 2023 16:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92B14A8B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 16:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83619C433CA;
	Fri, 28 Jul 2023 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690563022;
	bh=u8YAQhjY0n1UsivAjiPnctHY0TfRsVMW4A3rDEmEYEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jvuuafCCLnMW5BfCKTExrC7EZoAnY4HpJA1iy5ztxqESGmwY4LL52RqOcAB1GjLWR
	 WigjwV3KD813KJ1SAknRsEZwEuvaxUy/7qS2L8JiMQWM0g+xV8wtdC7ZTPluXrtRr/
	 WbEK7Kcl8hsJOGrrl3tQkOnZyq+lSg6+YhoeoexayrtayG1Io63J915eLk6mNYdett
	 pD9CbtRuBjSRwXWusgEKpa55Loog7m8+iQJUGUnGyHx/43rTpgqSYuyP2TnqjGSgxu
	 q/iR7GLVpbBi8ELve5ErFT3UNAnCasjFaiwwDw96YX21gdvVpYxRvA9ElR0S2HSbxh
	 e7L4pdoD5nNKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E597C4166F;
	Fri, 28 Jul 2023 16:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] ynl: couple of unrelated fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169056302244.15046.814627510999268373.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 16:50:22 +0000
References: <20230727163001.3952878-1-sdf@google.com>
In-Reply-To: <20230727163001.3952878-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 09:29:57 -0700 you wrote:
> - spelling of xdp-features
> - s/xdp_zc_max_segs/xdp-zc-max-segs/
> - expose xdp-zc-max-segs
> - add /* private: */
> - regenerate headers
> - print xdp_zc_max_segs from sample
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] ynl: expose xdp-zc-max-segs
    https://git.kernel.org/netdev/net-next/c/e5c157f081ab
  - [net-next,v2,2/4] ynl: mark max/mask as private for kdoc
    https://git.kernel.org/netdev/net-next/c/37844828d290
  - [net-next,v2,3/4] ynl: regenerate all headers
    https://git.kernel.org/netdev/net-next/c/25b5a2a1905f
  - [net-next,v2,4/4] ynl: print xdp-zc-max-segs in the sample
    https://git.kernel.org/netdev/net-next/c/26fdb67e8b4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



