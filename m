Return-Path: <netdev+bounces-33751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE7B79FE98
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 10:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3307B20B2A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A581CFBA;
	Thu, 14 Sep 2023 08:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6461CFA9
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01BB5C433C9;
	Thu, 14 Sep 2023 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694680828;
	bh=TWyxM+FlzRWYPHWVXWXWboGmaY3FqTGHzKjUdWlTt7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BXg6VlEc9fXE6/8nO6eyYOEWVoXzTLGvq1SWBSsEsBDGS+5E+wTAConbglXMjKDhI
	 +DB7odFORDnqCJvUSC1T9nR5WX65nB/HTumQ9qKR1SfjN+5ndwKAIt6BmpmLIq9Vw2
	 qL83xgtJk+B9C0anBENeDH3JCL79s3jR4/WBR3Y6GXB5s7iNSwOgCDLRfv99N1osZq
	 JiO0WHsclXNtOMg3Hrg0Wql9mPAvWNZB5hQA1zSx91xxuTWLUQ45RRTn3AceUDTrQa
	 VHDp2vN3JGRrOMfB5HSq8EZiY24Cd7ecs90PLJBZ0S/kgbQtkgPxG2CoaDr7AdiCbU
	 IrZp1WuxQlAyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9107E22AF5;
	Thu, 14 Sep 2023 08:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: renesas: rswitch: Fix a lot of redundant irq
 issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169468082788.9853.13356075003474039492.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 08:40:27 +0000
References: <20230912014936.3175430-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230912014936.3175430-1-yoshihiro.shimoda.uh@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Sep 2023 10:49:34 +0900 you wrote:
> After this patch series was applied, a lot of redundant interrupts
> no longer occur.
> 
> For example: when "iperf3 -c <ipaddr> -R" on R-Car S4-8 Spider
>  Before the patches are applied: about 800,000 times happened
>  After the patches were applied: about 100,000 times happened
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: renesas: rswitch: Fix unmasking irq condition
    https://git.kernel.org/netdev/net/c/e7b1ef29420f
  - [net,2/2] net: renesas: rswitch: Add spin lock protection for irq {un}mask
    https://git.kernel.org/netdev/net/c/c4f922e86c8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



