Return-Path: <netdev+bounces-40868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36527C8F11
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BA91C209E9
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ACC262B4;
	Fri, 13 Oct 2023 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+nq7WSM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8786D241FF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 21:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D44CCC433C9;
	Fri, 13 Oct 2023 21:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697232624;
	bh=UAzCHiah2qPL0Neg4e6fxsRo9jszDtYfURHBZ/VLdqY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l+nq7WSMsXqbYvz75q9EKYhA5xWPbRmfDR6s9wCZLMhf4sLWwRCkUbby12zKVWZq8
	 zvZL+S/MZSo79gd6qJ+p3an4RRstNks6Ha7B31L1cWyh4KtcTGSsp9EDUqhC1Joebp
	 BtLecNgHlWFnca74K1rc0d+tV6mjwhaXTrA1GjLblX1kGDqTjx6lsWamG0DdWkTPrl
	 5Jby9T8gn+LNl2dkMDeSm2GD+7AGxklZ6kbAgZDr6qJK5MJBIhtEFAI94G2H9KOF3y
	 pAYexKfK+0dYQDlKfhCJoilL3GK44pcWO7cd2Q0X5c5uLZALiiHG+cQCMUx9881wW3
	 yetDuiFuXjU3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7ACCE1F669;
	Fri, 13 Oct 2023 21:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] selftests: fib_tests: Fixes for multipath list
 receive tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169723262474.31515.9358093209675351150.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 21:30:24 +0000
References: <20231010132113.3014691-1-idosch@nvidia.com>
In-Reply-To: <20231010132113.3014691-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@gmail.com,
 sriram.yagnaraman@est.tech, oliver.sang@intel.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 16:21:11 +0300 you wrote:
> Fix two issues in recently added FIB multipath list receive tests.
> 
> Ido Schimmel (2):
>   selftests: fib_tests: Disable RP filter in multipath list receive test
>   selftests: fib_tests: Count all trace point invocations
> 
>  tools/testing/selftests/net/fib_tests.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net,1/2] selftests: fib_tests: Disable RP filter in multipath list receive test
    https://git.kernel.org/netdev/net/c/dbb13378ba30
  - [net,2/2] selftests: fib_tests: Count all trace point invocations
    https://git.kernel.org/netdev/net/c/aa13e5241a8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



