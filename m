Return-Path: <netdev+bounces-16220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442EF74BDD8
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 16:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7187C1C20928
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C501079D0;
	Sat,  8 Jul 2023 14:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092D846E
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 14:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4EB2C433C9;
	Sat,  8 Jul 2023 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688826620;
	bh=GuWeaULB/LP1wT1AeOJxKW0WhPsaPqAQCqaSYSHu23A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gdth+zD5UuONIY6awFe6PY8KN3MYuvPInXVxcdQlsuEyck0LermHks8BwGZ88UsaY
	 sVDYs83ioTulOvXXHzUaOVYQEvQx93FG+Gu8HMS1ltv5hpNhGK/5sqgPXOLd3pY4Cu
	 O43+egyzaMCFrXyqadsQfn8PU1+6Go/RX4KleHspqKzHzuv3ZzGT7w+yA6xo/zQt4x
	 pDRDZuGx2EICytbgSFh7ktYEF0ITFYIcNdgyjo68BVEBuieXHUS4hEa9vKXFChf1gK
	 Clwo/+dXXcxg+YzKhBV3DBhCsaIEkQllzogLhjU/kFk5gJMNj6WYsilpTy7xMqeZuE
	 /JFGdE56EC4nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8037AE53808;
	Sat,  8 Jul 2023 14:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] udp6: fix udp6_ehashfn() typo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168882662052.13309.2961925482933308793.git-patchwork-notify@kernel.org>
Date: Sat, 08 Jul 2023 14:30:20 +0000
References: <20230708082958.1597850-1-edumazet@google.com>
In-Reply-To: <20230708082958.1597850-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, aksecurity@gmail.com,
 w@1wt.eu, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 hannes@stressinduktion.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  8 Jul 2023 08:29:58 +0000 you wrote:
> Amit Klein reported that udp6_ehash_secret was initialized but never used.
> 
> Fixes: 1bbdceef1e53 ("inet: convert inet_ehash_secret and ipv6_hash_secret to net_get_random_once")
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
> 
> [...]

Here is the summary with links:
  - [net] udp6: fix udp6_ehashfn() typo
    https://git.kernel.org/netdev/net/c/51d03e2f2203

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



