Return-Path: <netdev+bounces-46746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170B7E626C
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 03:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093882811B4
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EAE6D38;
	Thu,  9 Nov 2023 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJr19nEk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED170539B
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A29A3C433A9;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699498231;
	bh=cMahlEIfx84mrY9rTLHjh742bOULK80eka8Mbvgoqys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eJr19nEkGrStjPNcN/7OMhA4BsUitvFpo3YyohfeDcI/cEe3Xbl5fEb+rqOPUA4yW
	 zzSLVW7uLXk/2Tth86y9pUovum8lw7lmkMCA/HtFr9BS00fB6wld21J9ixFNjkMuEp
	 xh/tP3EBCdIXNpprdtdGzCUZcjpcknKuyoLwI6Smx0eHVFDDvf9u5LK/i9LqneCS91
	 vZSIDPdht0qKWJFvEhoAZ7hPxvl2oDLCofpU046a7AETzn0/g/M7/3D3NWqjKAB+3I
	 3b1vAT+QZNQReTYa/BH0XX7mO4AXkY6VW4jb7XK19kAfQekSZZraSrCMmkTIvnXP9Q
	 ZwyuNudo9IISw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D158E00095;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net_sched: sch_fq: better validate TCA_FQ_WEIGHTS and
 TCA_FQ_PRIOMAP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169949823157.3016.14301872232071326571.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 02:50:31 +0000
References: <20231107160440.1992526-1-edumazet@google.com>
In-Reply-To: <20231107160440.1992526-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 toke@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Nov 2023 16:04:40 +0000 you wrote:
> syzbot was able to trigger the following report while providing
> too small TCA_FQ_WEIGHTS attribute [1]
> 
> Fix is to use NLA_POLICY_EXACT_LEN() to ensure user space
> provided correct sizes.
> 
> Apply the same fix to TCA_FQ_PRIOMAP.
> 
> [...]

Here is the summary with links:
  - [net] net_sched: sch_fq: better validate TCA_FQ_WEIGHTS and TCA_FQ_PRIOMAP
    https://git.kernel.org/netdev/net/c/f1a3b283f852

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



