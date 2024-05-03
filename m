Return-Path: <netdev+bounces-93378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0CA8BB70A
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0A11F216E5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAF45CDF2;
	Fri,  3 May 2024 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWA9CpVK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D95BAC3
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774830; cv=none; b=uKaidRAb/k0py2DzR6aVun+5IkdwgQaHxc9lD+GHULJCCMePHQOSxQhT+ejatZdTmCC4atNKlAKDnsXow+ngHw6qsQ/0eYBEqd/GtWrfc5KsQor1FIYy/WE9lcGACyNhCId8xiaRYz9er9P7NeBO9ElyA1U41LBm0Qej5UZtYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774830; c=relaxed/simple;
	bh=BackpDBmPW7nqANcp1nPWLNcIiWDJ0jA5fH0ndRyNmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QmGAf+pv5ygq4zJTjE0mpmnNgweUUEfczuvvRqLuzKvt7ecBpLyxZJVOz5zca4/MYUmmA1oD17y5glKUXspThUXH4ooNQr4C5WRTIo1ulfppGmWq45GlhmiiGYZRtLzADzgr93aktsWxlsF4SsjGrjkkw2L05fDDmp2k0Q/xVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWA9CpVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EBEDC116B1;
	Fri,  3 May 2024 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714774829;
	bh=BackpDBmPW7nqANcp1nPWLNcIiWDJ0jA5fH0ndRyNmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nWA9CpVKK2n3Yk6LfuT7Zye5KT7+J6ukjyoB25jRwOMn5+yi14Wr+c2Oy7pcLBkCE
	 PP0c2cYZHlYxrPQkTQ63A0fo353OiPaG70WAaIVAXb76wDFCptueigiY1Rse8IGJB6
	 AyPx++Pt47JxIz2Av4btdZyYJEa61/Gr9lBtK5dGZrxBDfuEWN6ULCbo9XGRPKspT3
	 O4W+QaIT7Z0PApF4MfV0a2KSXsk3uBGB4Bfmcu0yk+A+tMrERNbCtR9aD6GP5m7I9l
	 AILjU9m5nLtMgEGrIzcVGaN0hNRIuoiJmQX/bOYGBqheaSs2LMYjsZ8EeJLV3uI+10
	 BU6IzYQg7XIuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73B5AC43444;
	Fri,  3 May 2024 22:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] rtnetlink: rtnl_stats_dump() changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171477482947.17287.7673990321275030735.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 22:20:29 +0000
References: <20240502113748.1622637-1-edumazet@google.com>
In-Reply-To: <20240502113748.1622637-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, idosch@nvidia.com,
 jiri@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 11:37:46 +0000 you wrote:
> Getting rid of RTNL in rtnl_stats_dump() looks challenging.
> 
> In the meantime, we can:
> 
> 1) Avoid RTNL acquisition for the final NLMSG_DONE marker.
> 
> 2) Use for_each_netdev_dump() instead of the net->dev_index_head[]
>    hash table.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] rtnetlink: change rtnl_stats_dump() return value
    https://git.kernel.org/netdev/net-next/c/136c2a9a2a87
  - [net-next,2/2] rtnetlink: use for_each_netdev_dump() in rtnl_stats_dump()
    https://git.kernel.org/netdev/net-next/c/0feb396f7428

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



