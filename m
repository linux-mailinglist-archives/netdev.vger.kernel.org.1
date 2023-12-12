Return-Path: <netdev+bounces-56209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5312F80E2A6
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DFE8B216B4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C5C8C18;
	Tue, 12 Dec 2023 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOhqUiw+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463838835
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAFE6C433C9;
	Tue, 12 Dec 2023 03:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702351225;
	bh=xcUWuYpi+Xr+dYEylOPBmhRhJFHpRKmSnDZRNCDpfD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SOhqUiw+D9KvJdQgmsSD1W9CWVFXaTSDELYYYk4TRY1HUZUESOiI3QnQMC32KNVDN
	 RwDFref+Kd4pcw/4x4XqxJ4JdGVYVZQCpgUwGMX7jyHGCiJaGkTxKSx9iZEVVlXKux
	 gUfW1k3CHhO2LXazerq463uGJaIuTfwdnSP+PZ/wSsQhF03heVrwuzKiQ5EUdUcApK
	 8w9Nrdo69URl2ELl+lsBlz0MNU6inn1y2oqpYOPQbkkOkWthjVNHbnPlniYjOBmC/D
	 0ytp5ZIgQlSEKOw/3MZPW3+dr/tjwj6TMFToq1ZhA+ajD37l4lt144SlWHu6ffci6k
	 8zWo0fRX2ndZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7EB1DFC906;
	Tue, 12 Dec 2023 03:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] net/sched: conditional notification of events
 for cls and act
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170235122568.10568.16601661067155468388.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 03:20:25 +0000
References: <20231208192847.714940-1-pctammela@mojatatu.com>
In-Reply-To: <20231208192847.714940-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, marcelo.leitner@gmail.com,
 vladbu@nvidia.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Dec 2023 16:28:40 -0300 you wrote:
> This is an optimization we have been leveraging on P4TC but we believe
> it will benefit rtnl users in general.
> 
> It's common to allocate an skb, build a notification message and then
> broadcast an event. In the absence of any user space listeners, these
> resources (cpu and memory operations) are wasted. In cases where the subsystem
> is lockless (such as in tc-flower) this waste is more prominent. For the
> scenarios where the rtnl_lock is held it is not as prominent.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] rtnl: add helper to check if rtnl group has listeners
    https://git.kernel.org/netdev/net-next/c/c5e2a973448d
  - [net-next,v4,2/7] rtnl: add helper to check if a notification is needed
    https://git.kernel.org/netdev/net-next/c/8439109b76a3
  - [net-next,v4,3/7] rtnl: add helper to send if skb is not null
    https://git.kernel.org/netdev/net-next/c/ddb6b284bdc3
  - [net-next,v4,4/7] net/sched: act_api: don't open code max()
    https://git.kernel.org/netdev/net-next/c/c73724bfde09
  - [net-next,v4,5/7] net/sched: act_api: conditional notification of events
    https://git.kernel.org/netdev/net-next/c/8d4390f51920
  - [net-next,v4,6/7] net/sched: cls_api: remove 'unicast' argument from delete notification
    https://git.kernel.org/netdev/net-next/c/e522755520ef
  - [net-next,v4,7/7] net/sched: cls_api: conditional notification of events
    https://git.kernel.org/netdev/net-next/c/93775590b1ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



