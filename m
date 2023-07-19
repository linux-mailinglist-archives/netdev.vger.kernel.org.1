Return-Path: <netdev+bounces-18992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C42B759433
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5C51C20DC8
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F63E14285;
	Wed, 19 Jul 2023 11:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507FA134BC
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0224AC433CC;
	Wed, 19 Jul 2023 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689766221;
	bh=rhMvnY8+CtifwIUt2YMoq7ZsE033uyh5MFZsqdlfrGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oV+zMmaMtZtb4cRPp8xlx2rJGaPBAsGdcsKrEGQa4+8/DW8fxDYwNP70PDzP/7EHz
	 4c0hu/tozStAJsF1YZUgrEWTthjE3AkUlNOMXqWyXVK1vLU0yrl0Py/nNWAqq6NDm8
	 dqvwJUnwAmUBIrGRPWveJ2cRDAfXTQF5266ihU//VlYsHmn+SipTd12rPT6v8y9o6z
	 hVXSy7Js99btUUBgkmSdHK7R+43OaOGwjUrKLNL5zw8Flu7wLLfcg6m46X5df05gs7
	 xtw9mOsKruZxh4ZokdFXpEtbmT7yUrEOMl6jqKtSDW/hosSdkHPY98BLA1v5m9CLvb
	 JYgXBd/yzH6NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6394E22AEB;
	Wed, 19 Jul 2023 11:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] ipv4: ip_gre: fix return value check in erspan_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168976622087.17456.4802009678913641456.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 11:30:20 +0000
References: <20230717144918.25961-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230717144918.25961-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: dsahern@kernel.org, edumazet@google.com, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 22:49:18 +0800 you wrote:
> goto free_skb if an unexpected result is returned by pskb_tirm()
> in erspan_xmit().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  net/ipv4/ip_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [1/1] ipv4: ip_gre: fix return value check in erspan_xmit()
    https://git.kernel.org/netdev/net/c/aa7cb3789b42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



