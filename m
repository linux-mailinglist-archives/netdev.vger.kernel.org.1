Return-Path: <netdev+bounces-18990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4D7759430
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBD32816F2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F81314261;
	Wed, 19 Jul 2023 11:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C9134BA
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D772DC433C9;
	Wed, 19 Jul 2023 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689766220;
	bh=M5iJLknuPZWpSWzlkFS+ABilabYxFEKx/mUP8Lk3Rxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sCcOCDcJL0MtPqcS5Cz4tiulXmfoPRppL6VXR+nbugmZQ8Ev4nD0IqHab02j+z5TX
	 /LAdWVx4uOAcdNdXmV17QKyqdiITeTa59CRy+dskvZh4RE1kyQYu1XP/g5bpc9SBaG
	 oRAYR3Lt947K1cW/4cJbydPj7eonpCjJnSAt2KoKlyh/RQoPQUwri8mJISHUeoe1Oe
	 w5067IhbhvCryj95FQS5gbDgkvD/TpWkTy3jGfCaRVR5fKXCA7a7zBUtCZhUnu0Zfu
	 q3WbmBBkcEGCEjhn8JxYLzDEtwhYM+c09cPelwGhmYv7WrWt/kRenUFNlnc4nIfhCc
	 cKFTjWXia4Hag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD6E3E21EFA;
	Wed, 19 Jul 2023 11:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] ipv4: ip_gre: fix return value check in erspan_fb_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168976622077.17456.12980393954218525294.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 11:30:20 +0000
References: <20230717144902.25695-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230717144902.25695-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: dsahern@kernel.org, edumazet@google.com, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 22:49:02 +0800 you wrote:
> goto err_free_skb if an unexpected result is returned by pskb_tirm()
> in erspan_fb_xmit().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  net/ipv4/ip_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [1/1] ipv4: ip_gre: fix return value check in erspan_fb_xmit()
    https://git.kernel.org/netdev/net/c/02d84f3eb53a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



