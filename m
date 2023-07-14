Return-Path: <netdev+bounces-17843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555FE75334F
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863421C21576
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE097481;
	Fri, 14 Jul 2023 07:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C4746E
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 229E4C433CB;
	Fri, 14 Jul 2023 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689320422;
	bh=ylFCBrzD3jhCckon40BQfdST+/VYjoup/bmjR+NOtjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OcPd44b5UHUoRcX6lox9u8wbX7c2+1PRbCANuO4cL2wy3CmMovv9H8+chjCpTsuyZ
	 CGvNByzPA/EgetqTOfjZUQnUzHRiriwmumz88OXXBL5G5PXkYT0WLH2pNng9ZXKV4/
	 4DJLVHQpeQPyhhM4sB9izS0I2bKtnEhZbnEf0KqBdWrTj98lVToTIXJHtyU2ZIH6b0
	 pQa397koPfXxKWZ1O0Jwh1l6+E0Xz9wp5fg0i7fmf6G7dz7sbQYNJwMyjeRbdJWZil
	 xyu99dKEE/Ul56XTLcjTvqzfSOh3Fcoyy2GbRA10OLKNI2SzusmxdNbgAjCVby/WZ3
	 gegVdq8+AfusA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CE3BE1B4D6;
	Fri, 14 Jul 2023 07:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: Mark the sk parameter of routing functions
 as 'const'.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932042204.7517.17249985303620181503.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 07:40:22 +0000
References: <cover.1689077819.git.gnault@redhat.com>
In-Reply-To: <cover.1689077819.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, paul@paul-moore.com,
 eparis@parisplace.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, dsahern@kernel.org, xeb@mail.ru

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 11 Jul 2023 15:06:00 +0200 you wrote:
> The sk_getsecid security hook prevents the use of a const sk pointer in
> several routing functions. Since this hook should only read sk data,
> make its sk argument const (patch 1), then constify the sk parameter of
> various routing functions (patches 2-4).
> 
> Build-tested with make allmodconfig.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] security: Constify sk in the sk_getsecid hook.
    https://git.kernel.org/netdev/net-next/c/5b52ad34f948
  - [net-next,2/4] ipv4: Constify the sk parameter of ip_route_output_*().
    https://git.kernel.org/netdev/net-next/c/8d6eba33a272
  - [net-next,3/4] ipv6: Constify the sk parameter of several helper functions.
    https://git.kernel.org/netdev/net-next/c/5bc67a854cb4
  - [net-next,4/4] pptp: Constify the po parameter of pptp_route_output().
    https://git.kernel.org/netdev/net-next/c/dc4c399d215d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



