Return-Path: <netdev+bounces-26051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E9776A98
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01588281D44
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9BB1C9E7;
	Wed,  9 Aug 2023 21:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E094C1CA1C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67EC6C433CA;
	Wed,  9 Aug 2023 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691614822;
	bh=IJpomf8aoVI9XmhXIcMIJpYL1Phwy4vROHgecJO2BRg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CBDdLyA57CkKw6OukwBKwWaVRCed5GXk/tXWNHwyYQiNHUq0lvMAju3+bnerdK22t
	 uNH6HCCdKJrAaaJ15e2ciZ4wTQBEayl5IwZLnbT7d9Bzwv9UHhnE6VgbrJAaUz1s8R
	 j0OzPUqbmzzksVFBqsHUkxUEO2NFtjaOjxBe5MiA7gvlYd6sCZrCukJew0EK5LzxTw
	 WdU6YgE8QaUyaQMaSvKG/C2/YBK+1GA3H+qVKUdC7b4rb+IpwFUTJm5bwQvCVxHL83
	 qwhtzUvy/znKizYlJx4WB+xxZ0GZmXyvi2lS1q6pF997jbCJ17BPtEWeuXbf3PU+3F
	 gaE7LUv1ckuXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49FE0E3308F;
	Wed,  9 Aug 2023 21:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: add missing family to tcp_set_ca_state() tracepoint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161482229.5018.5994986728149664561.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 21:00:22 +0000
References: <20230808084923.2239142-1-edumazet@google.com>
In-Reply-To: <20230808084923.2239142-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jacky_gam_2001@163.com,
 me@manjusaka.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Aug 2023 08:49:23 +0000 you wrote:
> Before this code is copied, add the missing family, as we did in
> commit 3dd344ea84e1 ("net: tracepoint: exposing sk_family in all tcp:tracepoints")
> 
> Fixes: 15fcdf6ae116 ("tcp: Add tracepoint for tcp_set_ca_state")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Ping Gan <jacky_gam_2001@163.com>
> Cc: Manjusaka <me@manjusaka.me>
> 
> [...]

Here is the summary with links:
  - [net] tcp: add missing family to tcp_set_ca_state() tracepoint
    https://git.kernel.org/netdev/net/c/8a70ed9520c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



