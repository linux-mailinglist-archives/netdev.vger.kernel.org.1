Return-Path: <netdev+bounces-54468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA9E8072A5
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA4A1C20ADB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E93D98C;
	Wed,  6 Dec 2023 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsO/6YPc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720313DBB2
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 14:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2BCEC433C9;
	Wed,  6 Dec 2023 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701873626;
	bh=IqsWmTD8TIFu3nqIHbEta8fDusosOmOU9Y+1hUJAGOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GsO/6YPc7hzuP8p4ZVytklGKd8e17+sEkZshNnKnhCIwK22ZrgFZgy5a2w1J/69dK
	 M8xJOtsE770gCwjF+ebu/rd4C+2vF2WbPfcJtaECs5mmXhV9rw+VYW57yCsxZlx2K0
	 34u+mhDQXJ1vdeSDdw4/JjCjn03h0/g0gki61ezwzjyPYxOB0heRM5f+0uPPacdtVO
	 MVsIRWZcPyjfNcl+23biGDZXP69nkrFy441j+MtKGr1/xyybxnS0e2tZ7HwgcyFfhH
	 axlFeldgwmLgHMsnfNc6hSE9NMaPjtO0dOsnK9Ne6IMpf2ycgXXiZyS5g3+BzyFs0P
	 dqHWsxHHBuAaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7996C395DC;
	Wed,  6 Dec 2023 14:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v4 PATCH 0/5] octeontx2-af: miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170187362674.19544.6907621556097072012.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 14:40:26 +0000
References: <20231205080434.27604-1-gakula@marvell.com>
In-Reply-To: <20231205080434.27604-1-gakula@marvell.com>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 5 Dec 2023 13:34:29 +0530 you wrote:
> The series of patches fixes various issues related to mcs
> and NIX link registers.
> 
> v3-v4:
>  Used FIELD_PREP macro and proper data types.
> 
> v2-v3:
>  Fixed typo error in patch 4 commit message.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/5] octeontx2-af: Adjust Tx credits when MCS external bypass is disabled
    https://git.kernel.org/netdev/net/c/dca6fa8644b8
  - [net,v4,2/5] octeontx2-af: Fix mcs sa cam entries size
    https://git.kernel.org/netdev/net/c/9723b2cca1f0
  - [net,v4,3/5] octeontx2-af: Fix mcs stats register address
    https://git.kernel.org/netdev/net/c/3ba98a8c6f8c
  - [net,v4,4/5] octeontx2-af: Add missing mcs flr handler call
    https://git.kernel.org/netdev/net/c/d431abd0a9aa
  - [net,v4,5/5] octeontx2-af: Update Tx link register range
    https://git.kernel.org/netdev/net/c/7336fc196748

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



