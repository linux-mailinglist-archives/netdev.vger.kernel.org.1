Return-Path: <netdev+bounces-20177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A0B75E179
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 12:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D631C2093C
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB791116;
	Sun, 23 Jul 2023 10:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC11113
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 10:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6042AC433CA;
	Sun, 23 Jul 2023 10:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690109421;
	bh=drRpyC3r/p0fAndM5+ETZCPHEdellUZ5vHv+1tdmYZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ermzWyoWjTPnoUOmt4FivlRI9poKXT7wH9w3U8mWugpB+1s2NtEeD+m3ObxPfWN0+
	 3to1U0KID0F5A7XC6yiz9gGH3WgYTrBn3xV82Cu6QG8ugt2Kfc2w5/8NWvzV2uY2zS
	 rbJ4F72Tc4zcEdriL8uQ6Vc9CQ1rSHB+HbyhNnN24YOrJ/jlWGVsTu/POJ5vpg6ibL
	 LkfDLVTqLH+F3GdGwFB8GI7/ZRJV9/y3ntx7WCYr8sCHabA8VdAI0czozYQfQDmEGE
	 st4bjqL2C3HzzlN6YUNNcYkpEyolaipSF9iiqPyM+8VAV2OzINp8AYkuxCR/a3rtBl
	 nhl+jlkFs3ISw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E910C595C1;
	Sun, 23 Jul 2023 10:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dsa: remove deprecated strncpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169010942124.21900.11686032822364375294.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jul 2023 10:50:21 +0000
References: <20230718-net-dsa-strncpy-v2-1-3210463a08be@google.com>
In-Reply-To: <20230718-net-dsa-strncpy-v2-1-3210463a08be@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, keescook@chromium.org,
 ndesaulniers@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 18 Jul 2023 22:56:38 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Even call sites utilizing length-bounded destination buffers should
> switch over to using `strtomem` or `strtomem_pad`. In this case,
> however, the compiler is unable to determine the size of the `data`
> buffer which renders `strtomem` unusable. Due to this, `strscpy`
> should be used.
> 
> [...]

Here is the summary with links:
  - [v2] net: dsa: remove deprecated strncpy
    https://git.kernel.org/netdev/net-next/c/5c9f7b04aadf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



