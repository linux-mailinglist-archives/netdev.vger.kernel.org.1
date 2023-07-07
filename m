Return-Path: <netdev+bounces-15988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33DA74ACB0
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7712816DC
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF1A925;
	Fri,  7 Jul 2023 08:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224E8836
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 08:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3F3EC433CA;
	Fri,  7 Jul 2023 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688718020;
	bh=dcFwVT6awVtN3kz0ZqEErQqasS4zVzfMUWn04fZgPTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DL9K3X6IKXpDAlUHzYKUzv0IcFTupBd/YUpTLKDAgyf3acXFBQiShxYdjyIceFimE
	 WwPKjrZPrPOshnRwGuy1H/EoZpjfn8mZl5SN7Gx2S6gaSy/3PD5UQgKD32zrD0u/DB
	 ZDBGtGPNzlwTsHSplmD8CZSHpZZy6ps6Y5TMoaUC391/OTBHraEPiKIMqIK8uSQ9DF
	 ION3SE+uzpAVKk61wa9vcudR4myItxbMA4iPRhK6G/YRnh/zaVfGZ7cB3qbDTaY7if
	 CbH6dOZrsd6QIIS7WqNusvVYKcYPHrnc4pv4Rn+G8hfWPbf3lzL9n0WvN6EcR4PerN
	 kERQjtIPekYAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3F8FC4167B;
	Fri,  7 Jul 2023 08:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] udp6: add a missing call into udp_fail_queue_rcv_skb
 tracepoint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168871802073.22009.17793808873391205698.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 08:20:20 +0000
References: <20230707043923.35578-1-ivan@cloudflare.com>
In-Reply-To: <20230707043923.35578-1-ivan@cloudflare.com>
To: Ivan Babrou <ivan@cloudflare.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
 dsahern@kernel.org, peilin.ye@bytedance.com, rostedt@goodmis.org,
 petrm@nvidia.com, nhorman@tuxdriver.com, satoru.moriya@hds.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  6 Jul 2023 21:39:20 -0700 you wrote:
> The tracepoint has existed for 12 years, but it only covered udp
> over the legacy IPv4 protocol. Having it enabled for udp6 removes
> the unnecessary difference in error visibility.
> 
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")
> 
> [...]

Here is the summary with links:
  - [v2] udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint
    https://git.kernel.org/netdev/net/c/8139dccd464a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



