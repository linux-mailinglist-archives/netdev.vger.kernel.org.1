Return-Path: <netdev+bounces-42479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CC97CED77
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F613B21232
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B67659;
	Thu, 19 Oct 2023 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P58/zLHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEB396
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD95CC433C7;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697678424;
	bh=HTCjJhlFszvmvCqEYsW59oZr5ScGqJa+2J5YY7HxwCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P58/zLHMKQ2rye7/v3GTxbk/WSsMMA9rz7KhIJrKbOu4cWEpBZ3MBQfZXdT8qHwJC
	 6BzL5NsHr7u4LhfAtwNyyBXifpvOOqIYxiDVDDIwKHNka+PAU7aXAd/Yiy29+gqoEE
	 f4hdAv4dBbQ8EfVnZUz0kBIXDdvWk/rurm2nH/BtlTWzKQAnGZUXQsisemMqCntjMu
	 zqJ8CFGYUHiKR33PE5eAhlI5ONKtpqq5pGgygMUtyjbKNIUxqC+YkoTcSgYFDXIZIF
	 2UTc+B9J61cQcU8KfItssh0Te4Qc2Q/cuCaRS57cVhuSfmz0/+vs25R471Mul3a1Cl
	 qekvmogsliuBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0082C04E27;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it
 becomes a inner curve
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767842465.18183.14052204345631097399.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:20:24 +0000
References: <20231017143602.3191556-1-pctammela@mojatatu.com>
In-Reply-To: <20231017143602.3191556-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ct@flyingcircus.io, markovicbudimir@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 11:36:02 -0300 you wrote:
> Christian Theune says:
>    I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic shaping script,
>    leaving me with a non-functional uplink on a remote router.
> 
> A 'rt' curve cannot be used as a inner curve (parent class), but we were
> allowing such configurations since the qdisc was introduced. Such
> configurations would trigger a UAF as Budimir explains:
>    The parent will have vttree_insert() called on it in init_vf(),
>    but will not have vttree_remove() called on it in update_vf()
>    because it does not have the HFSC_FSC flag set.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve
    https://git.kernel.org/netdev/net/c/a13b67c9a015

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



