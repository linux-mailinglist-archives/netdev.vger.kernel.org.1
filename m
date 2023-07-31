Return-Path: <netdev+bounces-22735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB72768FEF
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246EC281670
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44219134BE;
	Mon, 31 Jul 2023 08:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482E11C91
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22D23C433C8;
	Mon, 31 Jul 2023 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690791623;
	bh=2sVnY35lLQHDR+tlRooFOYPWwGAYQ4BrafOiY2JfMEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r5n0TRhQFKe1c1Fun1kXZJ4V8NoYrubu4rgdEmbUuhm2ewMZJuCyp7nOQCuSe5FU3
	 6MrMfINd8BoYunUPGPq0mxxD7z2XVpJw/dHQ1efDULoEv7A/nfEOfs/NPjkfbbsOm2
	 CV7xxcNt7EE/3HGQso6LiWNK3J3wQVaqzWOzW4yDu2uinAaIHPUNRFASVJu7/FrTJJ
	 J6Cl/csJdIYlLwERfth/uc30Fo2paPJFKXRtK5029xOM1oY02OfSgFDsp2q03MAlZ+
	 TFejAldR/beCBLa3+S439KHep3BjKL1C6Wo6VVOya+qRg/fMPHuXVsCkU7q8wQbaTH
	 dg2Scs9r1amnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F48BE96AD7;
	Mon, 31 Jul 2023 08:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: Use sockaddr_storage for
 getsockopt(SO_PEERNAME).
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169079162305.10005.8227870028384979603.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 08:20:23 +0000
References: <20230729004813.41405-1-kuniyu@amazon.com>
In-Reply-To: <20230729004813.41405-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, leitao@debian.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 28 Jul 2023 17:48:13 -0700 you wrote:
> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") started
> applying strict rules to standard string functions.
> 
> It does not work well with conventional socket code around each protocol-
> specific sockaddr_XXX struct, which is cast from sockaddr_storage and has
> a bigger size than fortified functions expect.  See these commits:
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: Use sockaddr_storage for getsockopt(SO_PEERNAME).
    https://git.kernel.org/netdev/net-next/c/8936bf53a091

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



