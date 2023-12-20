Return-Path: <netdev+bounces-59220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D671819E91
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 13:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571D01C222B1
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F39221A0C;
	Wed, 20 Dec 2023 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSws1NfP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA0219EE
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 12:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9FE0C433C9;
	Wed, 20 Dec 2023 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703073629;
	bh=oI/FUpOpUAkfao0MMBq0H1FvPvFsk7+CQxrSwZhWYgE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qSws1NfP6Sd0WMldB0sl9o7zhV+ZyszcOz2T8eIWjHEyqeftjAXlqDz0FWgomzRep
	 tvIwiCGAXp6TYHLuQ9CfvFPw6+nmbaTr39p2PNFSbkn7e5EPvCpycUqCel77cgK1JK
	 x1hN5h7wJWAkuTRAWajlT3yYMIszTYHWGNsb9gIE0sSSWiShDaBP2aVdWG49j9gB7O
	 o6GQpzp6M0gfbBPwHKxrduK7RlxbpeVVaPde4hXygaVMribu8fYvyDan1DGDsJuIEX
	 J/ma0r3Pc5A/MpAQ/jiuonnXUEPle4QSJgkbXzMl8tCyg6nYdvufaWXbyefmKG1lCn
	 BBuL2JfDlYtww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7DF1D8C983;
	Wed, 20 Dec 2023 12:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] net: sched: Make tc-related drop reason more
 flexible for remaining qdiscs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170307362888.32270.16486579306510487574.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 12:00:28 +0000
References: <20231216204436.3712716-1-victor@mojatatu.com>
In-Reply-To: <20231216204436.3712716-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@iogearbox.net, horms@kernel.org, dcaratti@redhat.com,
 netdev@vger.kernel.org, kernel@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 16 Dec 2023 17:44:33 -0300 you wrote:
> This patch builds on Daniel's patch[1] to add initial support of tc drop
> reason. The main goal is to distinguish between policy and error drops for
> the remainder of the egress qdiscs (other than clsact).
> The drop reason is set by cls_api and act_api in the tc skb cb in case
> any error occurred in the data path.
> 
> Also add new skb drop reasons that are idiosyncratic to TC.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] net: sched: Move drop_reason to struct tc_skb_cb
    https://git.kernel.org/netdev/net-next/c/fb2780721ca5
  - [net-next,v5,2/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
    https://git.kernel.org/netdev/net-next/c/b6a3c6066afc
  - [net-next,v5,3/3] net: sched: Add initial TC error skb drop reasons
    https://git.kernel.org/netdev/net-next/c/4cf24dc89340

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



