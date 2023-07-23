Return-Path: <netdev+bounces-20176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6B75E16F
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 12:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F7A281902
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32510FE;
	Sun, 23 Jul 2023 10:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA97F
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 10:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EC93C433C9;
	Sun, 23 Jul 2023 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690108822;
	bh=h2/d1cfHOZ62zqj3dX1qlhbMC676qqkOThcZ4MePpvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hr9gFV36IjKumo0RFvApYGSfSQKfszEPzBazK2Ayl8vS+FHi8qHlfSBw3DTRy7Re+
	 V9qLlmaZGfZgJzzlV3IrdtNNSsCIveWpNHIHk47RNynsQTF3qekHBHhkkea3VeKbqI
	 npKvByas9fLncH/Jb3HpRauhmFD9qmcBTZJlPh6H87Xx/VCu/gFkC6jKB3pRBoaY/s
	 GRLtXK2fkET7/ylWbDOkKySg/iGNcSASu0PS9GFKghmzzYSMPpHwMOKI+e64QTK41N
	 sginJB6z3UdzzmhWGqjqEKjtidpEDzmRtDRLQ+LuJanu7CJuSjauhC0xG/r/9ymwow
	 +Ll/htbcZAErg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 851ACC595C1;
	Sun, 23 Jul 2023 10:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 0/6] Process connector bug fixes & enhancements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169010882253.17686.11040484082696320491.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jul 2023 10:40:22 +0000
References: <20230719201821.495037-1-anjali.k.kulkarni@oracle.com>
In-Reply-To: <20230719201821.495037-1-anjali.k.kulkarni@oracle.com>
To: Anjali Kulkarni <Anjali.K.Kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
 david@fries.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zbr@ioremap.net, brauner@kernel.org, johannes@sipsolutions.net,
 ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
 socketcan@hartkopp.net, petrm@nvidia.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, anjali.k.kulkarni@oracle.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 19 Jul 2023 13:18:15 -0700 you wrote:
> Oracle DB is trying to solve a performance overhead problem it has been
> facing for the past 10 years and using this patch series, we can fix this
> issue.
> 
> Oracle DB runs on a large scale with 100000s of short lived processes,
> starting up and exiting quickly. A process monitoring DB daemon which
> tracks and cleans up after processes that have died without a proper exit
> needs notifications only when a process died with a non-zero exit code
> (which should be rare).
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/6] netlink: Reverse the patch which removed filtering
    https://git.kernel.org/netdev/net-next/c/a3377386b564
  - [net-next,v10,2/6] netlink: Add new netlink_release function
    https://git.kernel.org/netdev/net-next/c/a4c9a56e6a2c
  - [net-next,v10,3/6] connector/cn_proc: Add filtering to fix some bugs
    https://git.kernel.org/netdev/net-next/c/2aa1f7a1f47c
  - [net-next,v10,4/6] connector/cn_proc: Performance improvements
    https://git.kernel.org/netdev/net-next/c/743acf351bae
  - [net-next,v10,5/6] connector/cn_proc: Allow non-root users access
    https://git.kernel.org/netdev/net-next/c/bfdfdc2f3b70
  - [net-next,v10,6/6] connector/cn_proc: Selftest for proc connector
    https://git.kernel.org/netdev/net-next/c/73a29531f45f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



