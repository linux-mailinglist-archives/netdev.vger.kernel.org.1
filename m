Return-Path: <netdev+bounces-47941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5B97EC0A2
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D481F2695C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455DFDDDD;
	Wed, 15 Nov 2023 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1HA2Iv6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28820FBF3
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5A1EC43397;
	Wed, 15 Nov 2023 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700044226;
	bh=lfqI0QHEGi9ovy99P7Gtf4D5zZ4lyJoAt75vw1rnuXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q1HA2Iv68SvxtpdgjWtPYCh8DqtCmEynX+2pwH3zWcRzbV8/rxpGxSjKBUok2kBgC
	 3Qslr8dsbu+5QEAyxvN7L6K/WNoQBAyn+hZYRkDvwT0x4IgW+0YlqOLbd476ztVcMY
	 SbjaHLB2Zg0TXOKGmQ38TceM8Yuy9ofdO+EpdjKurI5vFbMGljO878CVLjYJtK5Gy7
	 27b0pRRGoJ3SBGhl2mUGEOU8Qif/4pxRrLWYq/HjzSRLP8ahh8qxhGnPkTr/PKTGw6
	 i98BTn7/AahJKxikpYG9XNzNMs4RPuiWIo7uxgC/z4U0H7iZtE6hQaEPUgeOfXSJQK
	 iYMrZqSupEojw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98D68E1F676;
	Wed, 15 Nov 2023 10:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: don't dump stack on queue timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170004422662.6186.7329943840056680752.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 10:30:26 +0000
References: <20231114051142.1939298-1-kuba@kernel.org>
In-Reply-To: <20231114051142.1939298-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com,
 jiri@nvidia.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 00:11:42 -0500 you wrote:
> The top syzbot report for networking (#14 for the entire kernel)
> is the queue timeout splat. We kept it around for a long time,
> because in real life it provides pretty strong signal that
> something is wrong with the driver or the device.
> 
> Removing it is also likely to break monitoring for those who
> track it as a kernel warning.
> 
> [...]

Here is the summary with links:
  - [net-next] net: don't dump stack on queue timeout
    https://git.kernel.org/netdev/net-next/c/e316dd1cf135

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



