Return-Path: <netdev+bounces-27976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1771277DCE3
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C6E281835
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C526D516;
	Wed, 16 Aug 2023 09:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B378C8D3
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A046C433C8;
	Wed, 16 Aug 2023 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692176422;
	bh=+LDQn8tW2gDFtZ4c8hFHcw3D7R4SvH7G5EsfKKJyreE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FYkfdvN+d4kb8lPjT0+crdXdfZ2GZi/PG/Q8bw/5jQO5WF62ox10rwA8UIbNKq7SI
	 CLYXGvYehiBKVp6JyVbEu2XjJUxe/Riy5fihidNgNSPoKrEIFvIxqai9IR37UknzOi
	 aM+lLz5YLpGJkFJ9nThLcuViDl5+I4eUSK70L6QGL41aFT3zIa+GWcfgaHBY2xDzyj
	 YhtD6tVJvdE8BBbM2O/kgjLgN896LDWJRrGy32ggjlAIXJeFUYRN13vjPkLFDCv5aY
	 NIDNvxMK1jBSe4TdEHlYN1YhSDuumrEnwJaPWxFgnkfJUCkXURf7UYukJDexzej1VF
	 hyJyjyPq1buoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CEC1E93B34;
	Wed, 16 Aug 2023 09:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mailmap: add entries for Simon Horman
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169217642243.25260.2627988936857085942.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 09:00:22 +0000
References: <20230815-horms-mailmap-v1-1-dee307b451e0@kernel.org>
In-Reply-To: <20230815-horms-mailmap-v1-1-dee307b451e0@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 15 Aug 2023 17:27:49 +0200 you wrote:
> Retire some of my email addresses from Kernel activities.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - mailmap: add entries for Simon Horman
    https://git.kernel.org/netdev/net/c/0b70f1950e79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



