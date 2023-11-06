Return-Path: <netdev+bounces-46164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AB7E1CDC
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 10:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40027281218
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AA4156DE;
	Mon,  6 Nov 2023 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukyaJ0Vd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA39AAD35
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79D68C433C9;
	Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699261225;
	bh=Up+hNTtGqlrp1wUhOL/YPno33Uhywp1UAoejVaX+SCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ukyaJ0VdSXjh9tamf/BnSlAk0ovbukHAsLFhMOotZeLUzEIwokS5+/DO0BPNLNRKF
	 nwj9aJbjG7J2/busc1FitNFSIFx+7HAPIgsH9OF8ws62X+7jb4NOuDCGH+6Pn2HMes
	 hClL5MkOr9QR+vFuGAcQ4GjcPDJDTzgcvuJyj0RFvusNZIJGS5G38e3AXFSy+SXUNF
	 mK1KTw2GgHRtYOA2KfYylvTXSaOgDEAtha7L0wPqPeawF/tLfSd9c9+qvYaZ9KLnDS
	 ZKoPI9E6Y9I9Q/z7EE2/bs1x07xBTu8fZ6R5bue1XNEwSXebi8B3lcYo0S0d0f1q1N
	 NzZaC+GOBHCDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65886C00446;
	Mon,  6 Nov 2023 09:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net,
 sched: Fix SKB_NOT_DROPPED_YET splat under debug config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169926122541.1218.11002789889026553154.git-patchwork-notify@kernel.org>
Date: Mon, 06 Nov 2023 09:00:25 +0000
References: <20231028171610.28596-1-jhs@mojatatu.com>
In-Reply-To: <20231028171610.28596-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 daniel@iogearbox.net, idosch@idosch.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 28 Oct 2023 13:16:10 -0400 you wrote:
> Getting the following splat [1] with CONFIG_DEBUG_NET=y and this
> reproducer [2]. Problem seems to be that classifiers clear 'struct
> tcf_result::drop_reason', thereby triggering the warning in
> __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0).
> 
> Fixed by disambiguating a legit error from a verdict with a bogus drop_reason
> 
> [...]

Here is the summary with links:
  - [net,1/1] net, sched: Fix SKB_NOT_DROPPED_YET splat under debug config
    https://git.kernel.org/netdev/net/c/40cb2fdfed34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



