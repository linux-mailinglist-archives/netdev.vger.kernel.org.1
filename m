Return-Path: <netdev+bounces-60920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D54C821DA7
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC1D1C220EB
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6848471;
	Tue,  2 Jan 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7X7U06h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5294011733
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E333CC43395;
	Tue,  2 Jan 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704205830;
	bh=OIWW2es9ToV/5VZjcAGwJaA1GW+fGsvrJ0y679Epvks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G7X7U06hr8F1SWU7qM772UORbLE6AcBUmlhlrjVpyJCfrtsiE1xjGjyl567uMRaFG
	 UzSqFgNMwmryTIDzAVYpRJInlQ6xhmayqmnVEBRwO9Grn74yhlHyAXI0891Jo4RCh8
	 FQOYkgCJMZemvNsFRoYdBttcVn0GL79U9nv9OPpnr3px8Uhuv/NtWiieJmYTyCEi49
	 On5D0cXMUtMHW6WN3yBNMKhIUgtW5Yo+idHQHCf3YSKoRAWlEcYTVUuxyFHwdMF1ht
	 sYn/gcsWPG0n7APk27BUzsq4QaXUi3owqV/mXhf0vKQmWR18svdVInLSpPsv+lZ5lx
	 pJHkGLz59hZZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAE86DCB6D0;
	Tue,  2 Jan 2024 14:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net/sched: Remove UAPI support for retired TC
 qdiscs and classifiers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420582982.19051.4039294495486636536.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 14:30:29 +0000
References: <20231223140154.1319084-1-jhs@mojatatu.com>
In-Reply-To: <20231223140154.1319084-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 pctammela@mojatatu.com, victor@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 23 Dec 2023 09:01:49 -0500 you wrote:
> Classifiers RSVP and tcindex as well as qdiscs dsmark, CBQ and ATM have already
> been deleted. This patchset removes their UAPI support.
> 
> User space - with a focus on iproute2 - typically copies these UAPI headers for
> different kernels.
> These deletion patches are coordinated with the iproute2 maintainers to make
> sure that they delete any user space code referencing removed objects at their
> leisure.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/sched: Remove uapi support for rsvp classifier
    https://git.kernel.org/netdev/net-next/c/41bc3e8fc1f7
  - [net-next,2/5] net/sched: Remove uapi support for tcindex classifier
    https://git.kernel.org/netdev/net-next/c/82b2545ed9a4
  - [net-next,3/5] net/sched: Remove uapi support for dsmark qdisc
    https://git.kernel.org/netdev/net-next/c/fe3b739a5472
  - [net-next,4/5] net/sched: Remove uapi support for ATM qdisc
    https://git.kernel.org/netdev/net-next/c/26cc8714fc7f
  - [net-next,5/5] net/sched: Remove uapi support for CBQ qdisc
    https://git.kernel.org/netdev/net-next/c/33241dca4862

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



