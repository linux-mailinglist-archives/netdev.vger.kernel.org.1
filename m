Return-Path: <netdev+bounces-32002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24987920B1
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 09:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471D8280ED8
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 07:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84302A5D;
	Tue,  5 Sep 2023 07:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33617A38
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 07:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96758C433C8;
	Tue,  5 Sep 2023 07:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693898546;
	bh=Qn0ZuiuZ584j+M27My7PDHOjHFp7OTTOs/3NCqIxlbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dei12qf4+JrNPGPZS3K8KRqumt6gbk7OwejxKI4S8KOfB6DqAfqNyYxJvTfUocjju
	 b/5H/eC4xjvyjzd4wJOGTsNqgA4ZeV8jOwp9XR1XY28IGX/FsR4VcBMbQJEiypC32F
	 8faVFQbqRSlM/yrOr1QTjDOohCUQ11t1wb65Vf1JogL0H1ExTMY+KAx1p9xdLyi8Le
	 4uRs73zjeBCkXyv+XG/U8W8MgQP/qpeOi66feCvtK/TgLmrwg9v8DK0UhmNs11HP0a
	 PVGwoDHm3QNbK7O3ntM9cDcmMt+ulyycIJVhw41wGLYqcsNZ0D5wrwNG/GTyMKAOa/
	 /Z9PU8AF8TWJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F208C595C5;
	Tue,  5 Sep 2023 07:22:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: sched: sch_qfq: Fix UAF in qfq_dequeue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169389854651.13349.10095337484077645366.git-patchwork-notify@kernel.org>
Date: Tue, 05 Sep 2023 07:22:26 +0000
References: <20230901162237.11525-1-jhs@mojatatu.com>
In-Reply-To: <20230901162237.11525-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 netdev@vger.kernel.org, sec@valis.email, paolo.valente@unimore.it

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  1 Sep 2023 12:22:37 -0400 you wrote:
> From: valis <sec@valis.email>
> 
> When the plug qdisc is used as a class of the qfq qdisc it could trigger a
> UAF. This issue can be reproduced with following commands:
> 
>   tc qdisc add dev lo root handle 1: qfq
>   tc class add dev lo parent 1: classid 1:1 qfq weight 1 maxpkt 512
>   tc qdisc add dev lo parent 1:1 handle 2: plug
>   tc filter add dev lo parent 1: basic classid 1:1
>   ping -c1 127.0.0.1
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: sched: sch_qfq: Fix UAF in qfq_dequeue()
    https://git.kernel.org/netdev/net/c/8fc134fee27f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



