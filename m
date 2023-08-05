Return-Path: <netdev+bounces-24615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C25770D25
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 03:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10B21C212CE
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DED315AE;
	Sat,  5 Aug 2023 01:40:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BA15A6
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FC58C433CA;
	Sat,  5 Aug 2023 01:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691199637;
	bh=uGQ25vJn8RVTfSmmYsP1ApOD2jCTb5GiRxm8UPH0X+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dl9v+swldP9jwg+Qftw14QXVdjUmjAd5ogo5XpgkL0h+GQlG20yupsN9m1RCWcpcY
	 5Z8IQejB3o3L5863OtwzhaOobeFej9azTHdRF6ZH1LgyXc/FKwPa9/X04SCuWAlF40
	 yUSNsuqD3g2S22GSEhwZDTBSZwqV8BpVOn1hU2p0xe3FUXYENyhKW0ggyH9P1nqhKv
	 BpPIQbM6jXpkZwkcRewGbE4bpzxJ619qK7uuMs6jp5RioiHtZGUs+PaMumq+9S0uO9
	 9weV/77iyOqxJqtd1yaiORdy/LfWt/z4l85xDVkwogHITUuN08ZrC0UyKfdkk3QdSl
	 /EFBzpskzlIPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74254C64458;
	Sat,  5 Aug 2023 01:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/2] tcp: Disable header prediction for MD5.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169119963747.24799.9044933696725374140.git-patchwork-notify@kernel.org>
Date: Sat, 05 Aug 2023 01:40:37 +0000
References: <20230803224552.69398-1-kuniyu@amazon.com>
In-Reply-To: <20230803224552.69398-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Aug 2023 15:45:50 -0700 you wrote:
> The 1st patch disable header prediction for MD5 flow and the 2nd
> patch updates the stale comment in tcp_parse_options().
> 
> 
> Changes:
>   v3:
>     * Disable header prediction instead of enabling
>     * Add the 2nd patch
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/2] tcp: Disable header prediction for MD5 flow.
    https://git.kernel.org/netdev/net-next/c/d0f2b7a9ca0a
  - [v3,net-next,2/2] tcp: Update stale comment for MD5 in tcp_parse_options().
    https://git.kernel.org/netdev/net-next/c/b20515368932

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



