Return-Path: <netdev+bounces-26101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC3776CA8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 01:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E00D281E5F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8341DDFC;
	Wed,  9 Aug 2023 23:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346101D2F0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 23:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A382AC433C8;
	Wed,  9 Aug 2023 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691622627;
	bh=GBjuHFL646u1lkFK2JAMT4bXgcXxV4RlWdIPaFhWsoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UBNPRxzIdXsxTCndxX/ZUJuzq+IuL1fEZFx0Oba0f77z1jZzjnbQNUBNnhgS5q1/T
	 NFlIE2qDMh3NBa6bEfi+5FPDsdPIjLbJVzJRQ5C2F8rb/a4lYs9B/Lmidy/B1V5wHB
	 3PXiMk404NZrRDx/48hiAi5tGZ+B78QWxLaOUnQheX9g4TjURdawJWzUNM4SCjkCGy
	 W6ydK/MAFGQPe7iFmJn2xaEbvIZ2/HauMj/wyMjfeAs3EVFSp1KcyjBzpGHVEkt1vC
	 JvRjc83drygXihs70F1RfI9lO+ZvFhrjERjfUTJjMBcT9XFf4zv6kGzNVbXrdwg+S0
	 adg14QcfswWig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87E4BE3308F;
	Wed,  9 Aug 2023 23:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 00/11] Improve the taprio qdisc's relationship
 with its children
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169162262755.8257.7127331416998395436.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 23:10:27 +0000
References: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, vinicius.gomes@intel.com,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 muhammad.husaini.zulkifli@intel.com, yepeilin.cs@gmail.com,
 pctammela@mojatatu.com, richardcochran@gmail.com, shaozhengchao@huawei.com,
 glipus@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 22:33:13 +0300 you wrote:
> Changes in v4:
> - Clean up some leftovers in the ptp_mock driver.
> - Add CONFIG_PTP_1588_CLOCK_MOCK to tools/testing/selftests/tc-testing/config
> - Wait for taprio schedule to become operational in the selftests
> 
> Changes in v3:
> Fix ptp_mock compilation as module, fix small mistakes in selftests.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,01/11] net/sched: taprio: don't access q->qdiscs[] in unoffloaded mode during attach()
    https://git.kernel.org/netdev/net-next/c/09e0c3bbde90
  - [v4,net-next,02/11] net/sched: taprio: keep child Qdisc refcount elevated at 2 in offload mode
    https://git.kernel.org/netdev/net-next/c/25b0d4e4e41f
  - [v4,net-next,03/11] net/sched: taprio: try again to report q->qdiscs[] to qdisc_leaf()
    https://git.kernel.org/netdev/net-next/c/98766add2d55
  - [v4,net-next,04/11] net/sched: taprio: delete misleading comment about preallocating child qdiscs
    https://git.kernel.org/netdev/net-next/c/6e0ec800c174
  - [v4,net-next,05/11] net/sched: taprio: dump class stats for the actual q->qdiscs[]
    https://git.kernel.org/netdev/net-next/c/665338b2a7a0
  - [v4,net-next,06/11] net: ptp: create a mock-up PTP Hardware Clock driver
    https://git.kernel.org/netdev/net-next/c/40b0425f8ba1
  - [v4,net-next,07/11] net: netdevsim: use mock PHC driver
    https://git.kernel.org/netdev/net-next/c/b63e78fca889
  - [v4,net-next,08/11] net: netdevsim: mimic tc-taprio offload
    https://git.kernel.org/netdev/net-next/c/35da47fe1c47
  - [v4,net-next,09/11] selftests/tc-testing: add ptp_mock Kconfig dependency
    https://git.kernel.org/netdev/net-next/c/355adce3010b
  - [v4,net-next,10/11] selftests/tc-testing: test that taprio can only be attached as root
    https://git.kernel.org/netdev/net-next/c/1890cf08bd99
  - [v4,net-next,11/11] selftests/tc-testing: verify that a qdisc can be grafted onto a taprio class
    https://git.kernel.org/netdev/net-next/c/29c298d2bc82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



