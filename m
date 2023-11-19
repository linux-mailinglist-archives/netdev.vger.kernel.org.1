Return-Path: <netdev+bounces-48981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407C87F043B
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 04:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0D3280E06
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 03:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD61442E;
	Sun, 19 Nov 2023 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDVdvV4Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF4D4408
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 03:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49E0DC433C9;
	Sun, 19 Nov 2023 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700365224;
	bh=imQRc3mCXanxHYgLcaOzxpbSG4kdm4/ChhcV9XmapbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oDVdvV4ZSDiN2r8LruGXmJsxIBR0prfnNmYwdlErZbaKSDVm4C69CM63Q4tJ07JgK
	 4meEZkkQS//9pPBch79vI4IruheaDg5qLd8plmoNkXwgYadGrONReMm1JDQPtpfgUz
	 b6LD6wUcwZ72uhjjCZo5J4JQrYpSCTR6d0CGFZVGgS4d0/w/jfmnkSxtew+y3LiqhJ
	 DE9zNtLrdNOoTWcn6lPYJ89eMvuMigmSER3iEtdr3XeieMrmTVgfQJ3Sj3un752dyt
	 IQYe1ovEEwVDQQ9slx4IgxyGIFNjq1QTF04PzZi52VQn8Rc1mvWGQMbn60vTvQOYiY
	 z0T5qiR5vWcuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22FF9EA6304;
	Sun, 19 Nov 2023 03:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net/sched: cls_u32: use proper refcounts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170036522413.4292.13827284359107060078.git-patchwork-notify@kernel.org>
Date: Sun, 19 Nov 2023 03:40:24 +0000
References: <20231114141856.974326-1-pctammela@mojatatu.com>
In-Reply-To: <20231114141856.974326-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, victor@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Nov 2023 11:18:54 -0300 you wrote:
> In u32 we are open coding refcounts of hashtables with integers which is
> far from ideal. Update those with proper refcount and add a couple of
> tests to tdc that exercise the refcounts explicitly.
> 
> Pedro Tammela (2):
>   net/sched: cls_u32: replace int refcounts with proper refcounts
>   selftests/tc-testing: add hashtable tests for u32
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/sched: cls_u32: replace int refcounts with proper refcounts
    https://git.kernel.org/netdev/net-next/c/6b78debe1c07
  - [net-next,2/2] selftests/tc-testing: add hashtable tests for u32
    https://git.kernel.org/netdev/net-next/c/54293e4d6a62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



