Return-Path: <netdev+bounces-24809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED2771BF9
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF30F281208
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77019C2EB;
	Mon,  7 Aug 2023 08:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338CC2EF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B0A1C4339A;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691395222;
	bh=5go6K6i0/ofiZw8SCk4nM6l8tONh6BKZUaYKOnm6rL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ji5Clbu1rzx99fJ1icVOL4vBlBWJfIUgK0NauP0EtO2xVGSQ7R+JCPpqInbkG3d4y
	 Wg1keF5G38MmcllkO1Ar8h+BeW3AJmGfuYW8RGim7f/fKuJ7wbdQi6SCxcSfr6pEUN
	 CHoYn+trOozTJhYbri/XcmdZbb11lNaf3Ka8fIvGLagdS3lwU6r+rtD9eSdhgpcf4O
	 1dsVAT/Vgyry8eoUWLr8aYn89XLQTw/3aqDmt+63/LR/Wyj3s1CEawnbMWkEd22MWw
	 di5AEUxtFMTfRtQc5PeR10OV53rdVUIRqqlrueSxnz9MfZoc8UxJAS6c6Ka/ilmL1y
	 sII8n9eB8nZ0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74E7BE26D5E;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp/udplite: Remove unused function declarations
 udp{,lite}_get_port()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169139522246.32661.9205792645120495038.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 08:00:22 +0000
References: <20230805110009.44560-1-yuehaibing@huawei.com>
In-Reply-To: <20230805110009.44560-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@amazon.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 5 Aug 2023 19:00:09 +0800 you wrote:
> Commit 6ba5a3c52da0 ("[UDP]: Make full use of proto.h.udp_hash innovation.")
> removed these implementations but leave declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/udp.h     | 3 ---
>  include/net/udplite.h | 2 --
>  2 files changed, 5 deletions(-)

Here is the summary with links:
  - [net-next] udp/udplite: Remove unused function declarations udp{,lite}_get_port()
    https://git.kernel.org/netdev/net-next/c/cc97777c80fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



