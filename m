Return-Path: <netdev+bounces-13016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56B1739DF0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CCD1C21088
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B478BFE;
	Thu, 22 Jun 2023 10:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D25246
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A75DC43391;
	Thu, 22 Jun 2023 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687428021;
	bh=XZlebLGYDzaKv7QBu6ro1CtVqscjkNN8/jhsW4Qd0rk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kNfIVAEQLKyLh2JC1Beb26TvE9JS+5DG6lqJJ3eYcv25Mx1oqIL3jJP9F/2AfrG3L
	 a6icll4e90ioMgAp75Fxeb8uurGAygGCITlSJkLhcCoDh+dMXbCg1wyou6dds3y0na
	 l+1G5RT4nW8wCAMlK/E0N0yG9GH1HT6l+rNhnapdxXlk4guAxLXPTzSPezKDCCj08A
	 CgOSATo3QQyGpHPLJeuWBPHBlklAYJ1GVWZUDoMG5NzYflIDSbUEGaq0Hk9vreYatc
	 Pa8/VB9coG5QxfunqYaCa31CmFYPK+qyvE9ikHNJvh6ukz6CkP6FM8yogXyWtBfClk
	 bBYICiusFUzaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E798EC691EF;
	Thu, 22 Jun 2023 10:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] revert "net: align SO_RCVMARK required privileges with
 SO_MARK"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168742802094.13102.924538048558653206.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 10:00:20 +0000
References: <20230618103130.51628-1-maze@google.com>
In-Reply-To: <20230618103130.51628-1-maze@google.com>
To: =?utf-8?q?Maciej_=C5=BBenczykowski_=3Cmaze=40google=2Ecom=3E?=@codeaurora.org
Cc: zenczykowski@gmail.com, netdev@vger.kernel.org, larysa.zaremba@intel.com,
 simon.horman@corigine.com, pabeni@redhat.com, eyal.birger@gmail.com,
 kuba@kernel.org, edumazet@google.com, prohr@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 18 Jun 2023 03:31:30 -0700 you wrote:
> This reverts commit 1f86123b9749 ("net: align SO_RCVMARK required
> privileges with SO_MARK") because the reasoning in the commit message
> is not really correct:
>   SO_RCVMARK is used for 'reading' incoming skb mark (via cmsg), as such
>   it is more equivalent to 'getsockopt(SO_MARK)' which has no priv check
>   and retrieves the socket mark, rather than 'setsockopt(SO_MARK) which
>   sets the socket mark and does require privs.
> 
> [...]

Here is the summary with links:
  - [net,v2] revert "net: align SO_RCVMARK required privileges with SO_MARK"
    https://git.kernel.org/netdev/net/c/a9628e88776e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



