Return-Path: <netdev+bounces-62257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E99826597
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB4128153F
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4013FE0;
	Sun,  7 Jan 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnv83bqt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129914013
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 18:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6DB7C433C9;
	Sun,  7 Jan 2024 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704652226;
	bh=mbu49iNHANpODldcH+CHaxguBh+szgQ+5CrukgqIWf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qnv83bqtWD3rlhR4pKjikDrP7svassbyUUnA3VFtbMWBB9Zio5/aHqBupWCSWO+3U
	 CynRIVIiMDAm6l6HTt7ZTj61GQvp4P6UptmSg4TsM0D/BQRUEP36nXYA7YCjY/MA6m
	 mZ1kq/pbBvBcOdPjbsyy6c3bQmWFuPw4bbNWNmu2XGYWrR4805RJ2fZrKREpvssmky
	 varkFfPOfqR9lCa1xkzQDOCpUrA6mg5HJvObGAqbhrOlCpuXaWa5owKg3bG/Esnm0b
	 90WSCE3ymX26XYH5YqMqphi0vwatzJCRGI3RTKKuF+qBgypbgtjxocqg3nCQClaefw
	 smndZOaXLIEfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9DB5C4167F;
	Sun,  7 Jan 2024 18:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] net/sched: Remove ipt action tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170465222669.3273.6915829415111487125.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 18:30:26 +0000
References: <20240106131128.1420186-1-jhs@mojatatu.com>
In-Reply-To: <20240106131128.1420186-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  6 Jan 2024 08:11:28 -0500 you wrote:
> Commit ba24ea129126 ("net/sched: Retire ipt action") removed the ipt action
> but not the testcases. This patch removes the outstanding tdc tests.
> 
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  .../tc-testing/tc-tests/actions/xt.json       | 243 ------------------
>  1 file changed, 243 deletions(-)
>  delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/xt.json

Here is the summary with links:
  - [net-next,1/1] net/sched: Remove ipt action tests
    https://git.kernel.org/netdev/net-next/c/2ffca83aa39c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



