Return-Path: <netdev+bounces-26087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32A776C5A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064A61C21334
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03C1B7EC;
	Wed,  9 Aug 2023 22:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A78100D0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F402DC433C7;
	Wed,  9 Aug 2023 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691620823;
	bh=Qa+u+HNwkJBG1WNPlROs0Ffs1y6RXzhud/JuEMuXgtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xm2Yf2Afu1iOdZAbxQ2F2kKEO3Gn4A4q1kiK7wHqOh1rxZu5XhmHIKvuhJ8XzA5SR
	 lJNGQ6q9TuK/3ApY3iB5kGmnsUTfZ5IK4tLw30IZc9WvFKjg4v1so5CHkQHpc/6BpR
	 dTNsvUQyZVx0TmQ2c496YL1+8ITPTgh1CHLIpY+UHbpO7FUm8/ktjITHY2yvpTprUC
	 SzBtOGftAl2cBikZkFW8yW0LXf+JikwXxPAuAEzqtsKrqpxSAdA0hw8Bj7p9+wikxa
	 tgf7W356JGb6i6g2Avbz+brjcR1bO79UHjTOt4ropK/IitH/F+1ThkfQS0gMuqmabx
	 tcRUgFyJh8Q4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9826C64459;
	Wed,  9 Aug 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] Remove redundant functions and use generic
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169162082288.25117.9951788837414613577.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 22:40:22 +0000
References: <20230808114504.4036008-1-lizetao1@huawei.com>
In-Reply-To: <20230808114504.4036008-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 19:45:01 +0800 you wrote:
> This patch set removes some redundant functions. In the network module,
> two generic functions are provided to convert u64 value and Ethernet
> MAC address. Using generic functions helps reduce redundant code and
> improve code readability.
> 
> Li Zetao (3):
>   octeontx2-af: Remove redundant functions mac2u64() and cfg2mac()
>   octeontx2-af: Use u64_to_ether_addr() to convert ethernet address
>   octeontx2-af: Remove redundant functions rvu_npc_exact_mac2u64()
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] octeontx2-af: Remove redundant functions mac2u64() and cfg2mac()
    https://git.kernel.org/netdev/net-next/c/7d0bc2602308
  - [net-next,2/3] octeontx2-af: Use u64_to_ether_addr() to convert ethernet address
    https://git.kernel.org/netdev/net-next/c/e62c7adfd4ac
  - [net-next,3/3] octeontx2-af: Remove redundant functions rvu_npc_exact_mac2u64()
    https://git.kernel.org/netdev/net-next/c/47f8dc0938e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



