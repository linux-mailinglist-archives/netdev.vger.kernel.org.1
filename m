Return-Path: <netdev+bounces-44354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9545C7D7A30
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 03:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892871C20D85
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFB5393;
	Thu, 26 Oct 2023 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmkwHlu4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19545384
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63172C433CC;
	Thu, 26 Oct 2023 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698283826;
	bh=Mxqoy7VbEPVqYJWHfQcfM/NiT0fr4Rx4jffMyiPPZ4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jmkwHlu4OHVwd32KGJ9qJIL90u7ALF2LdBrm71ouPTkR/iqlTJ17udfHMonli8vxe
	 D+bGEqVSN9a+CtFqUv/8V4FTAFlM17Xa9ZII0LbZgRxPfq2ACb6OmAt7PKFir4ibcc
	 scM1tvOWrnwpPSgjcd+ZV6d7aJarxOOTYMM3+lg73V2MFU1cE09fU2vakO5Dbu5LL6
	 7HBvNZkJEeKOcF0/gBToo8zOBsdgumzk9eAz5vVHN5nFvjmfK1wAYFeEvDaawkJUy+
	 1lV4gmA3zrpUTuj2+TbUlInNRRkMZ+1ZfOrXcURrw6Dw3DTL5MBhgwxbD/eA3UPMlm
	 vfnlq1vvN+cHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48835E4CC0F;
	Thu, 26 Oct 2023 01:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 0/3] ipv6: avoid atomic fragment on GSO output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169828382629.14693.2027988602080029983.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 01:30:26 +0000
References: <cover.1698156966.git.yan@cloudflare.com>
In-Reply-To: <cover.1698156966.git.yan@cloudflare.com>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ayal@nvidia.com,
 tariqt@nvidia.com, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
 fw@strlen.de, willemdebruijn.kernel@gmail.com, alexander.duyck@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Oct 2023 07:26:28 -0700 you wrote:
> When the ipv6 stack output a GSO packet, if its gso_size is larger than
> dst MTU, then all segments would be fragmented. However, it is possible
> for a GSO packet to have a trailing segment with smaller actual size
> than both gso_size as well as the MTU, which leads to an "atomic
> fragment". Atomic fragments are considered harmful in RFC-8021. An
> Existing report from APNIC also shows that atomic fragments are more
> likely to be dropped even it is equivalent to a no-op [1].
> 
> [...]

Here is the summary with links:
  - [v5,net-next,1/3] ipv6: drop feature RTAX_FEATURE_ALLFRAG
    https://git.kernel.org/netdev/net-next/c/e57a34478586
  - [v5,net-next,2/3] ipv6: refactor ip6_finish_output for GSO handling
    https://git.kernel.org/netdev/net-next/c/1f7ec1b3721d
  - [v5,net-next,3/3] ipv6: avoid atomic fragment on GSO packets
    https://git.kernel.org/netdev/net-next/c/03d6c848bfb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



