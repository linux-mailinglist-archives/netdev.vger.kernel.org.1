Return-Path: <netdev+bounces-24172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4FD76F17C
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8210D282209
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E422590A;
	Thu,  3 Aug 2023 18:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362B18B17
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31075C433C9;
	Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691086228;
	bh=dT6lA5WXEKQHuA+50AX70sihSIdNAuX+ncVR3OXOWbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GqO2S+1+9+tRUnBRGByo5wxZGqlfZvhLwYI0A2MZyOt17ZWMsg9AywD2ryExqf4YO
	 SInKMOBxArnhrPnvcSc+vF0+pyeBQ+0zrLCU21c9mO1rQInVhy0NQ34jObISra5/WL
	 WxICe63aBN83JSXuZ8eRBdmurJod4957RlnzMO3JwwrzOQKp0V3AiA+lWzu1RkZzL6
	 a0FOwjIDbzwvjpn2E6Ub2HruEupvLP9r3jmv5G1FtCdWtEMWUm4tk5Lyl/n2IjfVJP
	 IJn4zTz4l3vFINSC9Pi82XSNiSabEKmjbDTXeAS9iqkXJGi6V1zcMaLDPf61vzu61w
	 1Zp9INUNtzUIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04DC7C595C1;
	Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] tcp_metrics: series of fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169108622801.23543.2612432757380166324.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 18:10:28 +0000
References: <20230802131500.1478140-1-edumazet@google.com>
In-Reply-To: <20230802131500.1478140-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, dsahern@kernel.org,
 kuniyu@amazon.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Aug 2023 13:14:54 +0000 you wrote:
> This series contains a fix for addr_same() and various
> data-race annotations.
> 
> We still have to address races over tm->tcpm_saddr and
> tm->tcpm_daddr later.
> 
> Eric Dumazet (6):
>   tcp_metrics: fix addr_same() helper
>   tcp_metrics: annotate data-races around tm->tcpm_stamp
>   tcp_metrics: annotate data-races around tm->tcpm_lock
>   tcp_metrics: annotate data-races around tm->tcpm_vals[]
>   tcp_metrics: annotate data-races around tm->tcpm_net
>   tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen
> 
> [...]

Here is the summary with links:
  - [net,1/6] tcp_metrics: fix addr_same() helper
    https://git.kernel.org/netdev/net/c/e6638094d7af
  - [net,2/6] tcp_metrics: annotate data-races around tm->tcpm_stamp
    https://git.kernel.org/netdev/net/c/949ad62a5d53
  - [net,3/6] tcp_metrics: annotate data-races around tm->tcpm_lock
    https://git.kernel.org/netdev/net/c/285ce119a3c6
  - [net,4/6] tcp_metrics: annotate data-races around tm->tcpm_vals[]
    https://git.kernel.org/netdev/net/c/8c4d04f6b443
  - [net,5/6] tcp_metrics: annotate data-races around tm->tcpm_net
    https://git.kernel.org/netdev/net/c/d5d986ce42c7
  - [net,6/6] tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen
    https://git.kernel.org/netdev/net/c/ddf251fa2bc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



