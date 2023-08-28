Return-Path: <netdev+bounces-31012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F278A8AC
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC5280DEF
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A020611E;
	Mon, 28 Aug 2023 09:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9044681
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4864DC433C7;
	Mon, 28 Aug 2023 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693214424;
	bh=lmCmRnHp5sN/qUUE4MNYbg0ju1991+Nb99EaylABA+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pNL4PJcWjPla4t7OkfMPgxyj57wntUHcKsTGFdBEF624NgJhVMKEucIOjfACs520c
	 QauS8IBO0CkGOcrHbOUBBQskWpO+B9wuOvsP+KxNhj84M9/fVnXMA+YZwAKzZSw27v
	 OQ5XxJ64+JQirNZ0aiMTOOIVdaBp+pmOFF2Y5YRlh/0NFslk3LC8WKpMwzKcDptRI5
	 G+kkY8QmIBLN1WHGck0SahligjR7eh2ItJ6VKSLZkutCKS37tBLFZlAA64qFXn4uRF
	 ywOhmPaoCoN4Aq0FwS58RD4ZiNlP4hAhD8IBvsP6cox4JGvotznT3LGYwy7+wGfdeB
	 TdBJbFBzBYrMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30F82C3959E;
	Mon, 28 Aug 2023 09:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dccp: Fix out of bounds access in DCCP error handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169321442419.7279.7733954383397054161.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 09:20:24 +0000
References: <20230825133241.3635236-1-jannh@google.com>
In-Reply-To: <20230825133241.3635236-1-jannh@google.com>
To: Jann Horn <jannh@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dccp@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 25 Aug 2023 15:32:41 +0200 you wrote:
> There was a previous attempt to fix an out-of-bounds access in the DCCP
> error handlers, but that fix assumed that the error handlers only want
> to access the first 8 bytes of the DCCP header. Actually, they also look
> at the DCCP sequence number, which is stored beyond 8 bytes, so an
> explicit pskb_may_pull() is required.
> 
> Fixes: 6706a97fec96 ("dccp: fix out of bound access in dccp_v4_err()")
> Fixes: 1aa9d1a0e7ee ("ipv6: dccp: fix out of bound access in dccp_v6_err()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> 
> [...]

Here is the summary with links:
  - [net] dccp: Fix out of bounds access in DCCP error handler
    https://git.kernel.org/netdev/net/c/977ad86c2a1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



