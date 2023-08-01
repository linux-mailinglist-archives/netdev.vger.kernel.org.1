Return-Path: <netdev+bounces-23039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE776A766
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 05:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E437E1C20E2D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701ED1874;
	Tue,  1 Aug 2023 03:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2E1107
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 03:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 598D4C433CA;
	Tue,  1 Aug 2023 03:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690860022;
	bh=A3Qh/oybzS1vCgz7bWbm1ep1Wrmp1YDvM7R9VL/4oCM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AXr3gmTThlW2mR8k6p5BWI1nZwJuFmHq7MoqARweRY7caQ4sc3Jkx/clyC+irAQmS
	 f09g1Gl3TtwEbyO0zoSDVUAg6S4S8g7L0PKrvraSKC/t1cCf7qLBzi9loP8WAYX7me
	 UDKMFzOrLBGtGDYXkY3kMjSEFBaQWgqJ6QKMW1XJFBpaDwYZliDaFaWyXOZ1ymIxxb
	 /BIiPRrL/5Y4th9usB/bOKAJYvufs2hNw4+lWAPXLdB+AqNa64c15WUNsy2yN83Trs
	 eiDL/9ECYHntvsPWvdRKSMlJ+qj2zqnUdh8ME3spqAKxNiRYTcgPq9ScShdeR5wu+p
	 iq3JvwbH6Yrag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35EC7C595C0;
	Tue,  1 Aug 2023 03:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] net/sched Bind logic fixes for cls_fw,
 cls_u32 and cls_route
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169086002221.11962.14807495918639155422.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 03:20:22 +0000
References: <20230729123202.72406-1-jhs@mojatatu.com>
In-Reply-To: <20230729123202.72406-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 netdev@vger.kernel.org, sec@valis.email, ramdhan@starlabs.sg,
 billy@starlabs.sg

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Jul 2023 08:31:59 -0400 you wrote:
> From: valis <sec@valis.email>
> 
> Three classifiers (cls_fw, cls_u32 and cls_route) always copy
> tcf_result struct into the new instance of the filter on update.
> 
> This causes a problem when updating a filter bound to a class,
> as tcf_unbind_filter() is always called on the old instance in the
> success path, decreasing filter_cnt of the still referenced class
> and allowing it to be deleted, leading to a use-after-free.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
    https://git.kernel.org/netdev/net/c/3044b16e7c6f
  - [net,v2,2/3] net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
    https://git.kernel.org/netdev/net/c/76e42ae83199
  - [net,v2,3/3] net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free
    https://git.kernel.org/netdev/net/c/b80b829e9e2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



