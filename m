Return-Path: <netdev+bounces-20590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20057602DE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6C91C20CE3
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0512B61;
	Mon, 24 Jul 2023 23:00:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486E153A0
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1C3BC433C9;
	Mon, 24 Jul 2023 23:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690239619;
	bh=k8vSkgO1TBTEpB2mxaKhdFKuUi38ISsJ5T+Sh2InRyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L3oFtGqs3MbrrwhgOm4vla3PdzM21fe/KjYR9INA718qosZcoWjFfhOQ8S6OzoMlm
	 5xW1If5gATWH3NrnF3UAdxda0kbIY9kpE+q3nFVqpNdond4WRQn5ItBMruAZ6nBd9X
	 s7Pd8dss/ghd7OsGMGFvd4dMtUflDYu16xiiCZsNx0E/utYkTynI9hi7+oSZrSW5ys
	 LF0VmAx75FdKVzCDwlUW5uDmuzz3NE1INOXwXX5RzAy1gBHI3/B96EoZOczRPPUqL6
	 vZnjBOSccSDe4fRdcrFA6AEGwHuk8YG9RWYsP/ceLIdzC12IjwXD3MRA7su52h/F7X
	 vlfu1oN/ROtuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8698AE1F65A;
	Mon, 24 Jul 2023 23:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6 addrconf: fix bug where deleting a mngtmpaddr can
 create a new temporary address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169023961954.9367.14490573749061190250.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 23:00:19 +0000
References: <20230720160022.1887942-1-maze@google.com>
In-Reply-To: <20230720160022.1887942-1-maze@google.com>
To: =?utf-8?q?Maciej_=C5=BBenczykowski_=3Cmaze=40google=2Ecom=3E?=@codeaurora.org
Cc: zenczykowski@gmail.com, netdev@vger.kernel.org, kuba@kernel.org,
 thaller@redhat.com, edumazet@google.com, pabeni@redhat.com,
 davem@davemloft.net, dsahern@kernel.org, jiri@resnulli.us, xiaom@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jul 2023 09:00:22 -0700 you wrote:
> currently on 6.4 net/main:
> 
>   # ip link add dummy1 type dummy
>   # echo 1 > /proc/sys/net/ipv6/conf/dummy1/use_tempaddr
>   # ip link set dummy1 up
>   # ip -6 addr add 2000::1/64 mngtmpaddr dev dummy1
>   # ip -6 addr show dev dummy1
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address
    https://git.kernel.org/netdev/net/c/69172f0bcb6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



