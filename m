Return-Path: <netdev+bounces-21812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79941764E1A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C888281F9A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35588D516;
	Thu, 27 Jul 2023 08:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8DAD301
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98B8BC433CA;
	Thu, 27 Jul 2023 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690447821;
	bh=ipAFE1PedARgTISrY20Q3M/AMYk5COsb1aBJHF2CSHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k/5GhiFzHz8iKWC48SfmcAgXcztZIUqer7lrh4SSTVxJrQDZ+DKpeSM+nPq4m5Oo9
	 vU5gYNXij8W+wO2VbSqGRZsny6DKz+kKVxHMr/x4BidO3PjqQqou3EyAfFpIwGQvaN
	 mCPf0CBYpPgEjYDhr4bs+sGHI3Ocb9x3Ob4anE8q3uJktSgET4gFopQItbhA/vF2AV
	 5onbVr9fIbMluImONBTBGNSP6qpMQtm1G/gFE9/Iu5ZHXCOwlp5/OqBJcHQJWkspNU
	 SvoGl0/yuvZhh9U/W+Fzu2vChtX7L4LhOHq6GhhYt58oNcFYT18QNUuQDYhZSXOKPb
	 KQ56Tt8xsHJCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F8D6C41672;
	Thu, 27 Jul 2023 08:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] tipc: check return value of pskb_trim()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169044782151.5847.14421459356429788068.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 08:50:21 +0000
References: <20230725064810.5820-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230725064810.5820-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: kuniyu@amazon.com, jmaloy@redhat.com, netdev@vger.kernel.org,
 ying.xue@windriver.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Jul 2023 14:48:10 +0800 you wrote:
> goto free_skb if an unexpected result is returned by pskb_tirm()
> in tipc_crypto_rcv_complete().
> 
> Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  net/tipc/crypto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [v2,1/1] tipc: check return value of pskb_trim()
    https://git.kernel.org/netdev/net/c/e46e06ffc6d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



