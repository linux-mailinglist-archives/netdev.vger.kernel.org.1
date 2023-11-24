Return-Path: <netdev+bounces-50812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C817F73A1
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E66CB2143B
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D724218;
	Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjIMYwj6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890A2420A
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09DFBC433C9;
	Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700828430;
	bh=sqn3Touu0jsrcT7nYxkOWCi4EFEBcq1dlGMiTuHM0MI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KjIMYwj6Nus/H4k8UViJDpEIZjcsB2t/MDuYKhdnAVeO9iDWACMJlI+uWN/0QhQVS
	 SucHQGuKLO/i6j5refduAZzzP44GQW4ZaSLRn4XSZlEu31fC8poH3+pwjypvZAHHGf
	 NaL/EapBv9pm3n/x3qN2Bn61fFtFXkFRVFvcl29ejquVuEx/FU0mrqq73aNmgMgTVE
	 Hznlz6KpDGzjYkcu6MRCZ7U2dxBAA9qNkbHEXfzTxetamW8QT4xfz6vT4qyKP+DQ5q
	 N55pNoIUS8HKF1vMvvNul4H30dqtRte6p/x4Xsw9+bk/ljzNVMBQdqTcw3Lca57rzl
	 dKxXf15WTynwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6B6DC395FD;
	Fri, 24 Nov 2023 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-pf: TC flower offload support for ICMP
 type and code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170082842994.28500.8914162610982777738.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 12:20:29 +0000
References: <20231122114142.11243-1-gakula@marvell.com>
In-Reply-To: <20231122114142.11243-1-gakula@marvell.com>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 17:11:42 +0530 you wrote:
> Adds tc offload support for matching on ICMP type and code.
> 
> Example usage:
> To enable adding tc ingress rules
>         tc qdisc add dev eth0 ingress
> 
> TC rule drop the ICMP echo reply:
>         tc filter add dev eth0 protocol ip parent ffff: \
>         flower ip_proto icmp type 8 code 0 skip_sw action drop
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: TC flower offload support for ICMP type and code
    https://git.kernel.org/netdev/net-next/c/a8d4879d5f1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



