Return-Path: <netdev+bounces-49507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE2D7F23A9
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6A6B20E7D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A614A8F;
	Tue, 21 Nov 2023 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzpGgv/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676114281
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9271C433C8;
	Tue, 21 Nov 2023 02:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700532624;
	bh=/hK/VL+vceqryJvyt2IN0F+7ECMzkzGBBJoJ/n5Z+qs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mzpGgv/isq+SpIa+k7jCPG6bqyRHY4YLCmG5Otq3K/q/vf9VktQy2rZ38g67LCMwK
	 iItLvo1JxxPZg7r2FzgHvMFLm+X62ZFRaZ2fS6w3CvYjhibxyYm23g0zVMU5Pyl435
	 6ayS9KA7JoSlk593Y1YTzjlQLjL6USoAFFJ2v70yQdRYblO3z3vk4x1pawXnwBrvfS
	 EYZ2tZEL7S+ksD8St1zG5AdIOeSeJDcjIbbUvzCx96dMAOzcyUn726VlvSZL8+MAcz
	 pEKRuUO7EArGsJxWkPqMriF2f5z6GifNTSa2WAf3zot9494ZfIuwzwC4W3B+hYbpgw
	 ewE6OE++wzDew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACB1DEAA95F;
	Tue, 21 Nov 2023 02:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] selftests: tc-testing: more updates to tdc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170053262470.20954.16052507990664952018.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 02:10:24 +0000
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
In-Reply-To: <20231117171208.2066136-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, victor@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Nov 2023 14:12:02 -0300 you wrote:
> Address the issues making tdc timeout on downstream CIs like lkp and
> tuxsuite.
> 
> Pedro Tammela (6):
>   selftests: tc-testing: cap parallel tdc to 4 cores
>   selftests: tc-testing: move back to per test ns setup
>   selftests: tc-testing: use netns delete from pyroute2
>   selftests: tc-testing: leverage -all in suite ns teardown
>   selftests: tc-testing: timeout on unbounded loops
>   selftests: tc-testing: report number of workers in use
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] selftests: tc-testing: cap parallel tdc to 4 cores
    https://git.kernel.org/netdev/net-next/c/025de7b6a6dd
  - [net-next,2/6] selftests: tc-testing: move back to per test ns setup
    https://git.kernel.org/netdev/net-next/c/50a5988a7a54
  - [net-next,3/6] selftests: tc-testing: use netns delete from pyroute2
    https://git.kernel.org/netdev/net-next/c/3d5026fc5adb
  - [net-next,4/6] selftests: tc-testing: leverage -all in suite ns teardown
    https://git.kernel.org/netdev/net-next/c/3f2d94a4ff48
  - [net-next,5/6] selftests: tc-testing: timeout on unbounded loops
    https://git.kernel.org/netdev/net-next/c/4b480cfb1066
  - [net-next,6/6] selftests: tc-testing: report number of workers in use
    https://git.kernel.org/netdev/net-next/c/4968afa0143d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



