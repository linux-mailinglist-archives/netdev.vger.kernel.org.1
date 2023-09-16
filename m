Return-Path: <netdev+bounces-34256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7117A7A2EEA
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9061C209BC
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98611731;
	Sat, 16 Sep 2023 09:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713EEC0
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 09:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1CD7C433C9;
	Sat, 16 Sep 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694855422;
	bh=Boip7jngg3adnA13fCgikFWnF/1HYESev3529ASlxhA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ABIi1M2ThcZn3OC8Bo3WSqHt2kWQpiIiTodDZGl/JHFqpWfNlua/LENpebgJp61EW
	 7CR//fdQr6FW/hixNabSR+TCp7r6tShTgcxjeJPnvLgdA9npa4QDoMMub6ShH1QSgW
	 CEtEtgVOeoGGtOonMkQ969HXoQ0jAOoyl5/fRSPLDoR6yf64FUzdOLRXPoSQq4fIpK
	 AJ7FQ4x/1ZtaxleVzuKJn4hvIfq8fTZD1+/6RRCYnsBm7m7VgJO8EGiuxJuot5xunF
	 okN4XFzYkM3rb4oiw5b+uk0CJp9voEToejCpmc0WI9s/OMK6iIWECEDJDP8Q3ncVYw
	 N5zSzgNgRaiXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7220E26882;
	Sat, 16 Sep 2023 09:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: use indirect call helpers for
 sk->sk_prot->release_cb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169485542281.21841.18435392261405859325.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 09:10:22 +0000
References: <20230913125835.3445264-1-edumazet@google.com>
In-Reply-To: <20230913125835.3445264-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 12:58:35 +0000 you wrote:
> When adding sk->sk_prot->release_cb() call from __sk_flush_backlog()
> Paolo suggested using indirect call helpers to take care of
> CONFIG_RETPOLINE=y case.
> 
> It turns out Google had such mitigation for years in release_sock(),
> it is time to make this public :)
> 
> [...]

Here is the summary with links:
  - [net-next] net: use indirect call helpers for sk->sk_prot->release_cb()
    https://git.kernel.org/netdev/net-next/c/41862d12e77f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



