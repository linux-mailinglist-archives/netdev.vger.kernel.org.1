Return-Path: <netdev+bounces-53476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7E68032AE
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 13:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB83C280FC2
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0EA156C4;
	Mon,  4 Dec 2023 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F49ToMju"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0D9241F8
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DCAFC433D9;
	Mon,  4 Dec 2023 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701693025;
	bh=wMNLLARnVn7lDO7b2Jm3vUe6MR5XrNo0+puu3FIqXZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F49ToMju1wYi191gI0vXLW1YRMglQ7odTmHpDDeo4NPRrz2uJPpmqjQaPK27hw+HF
	 6PTeRguPFNRhcObJkmdME5eLJgjFc993v/sVZgiGhCK9VqwhGJZx14LRH/8nhUFAn+
	 qcJ7JNnPeOhvEukA37eBMN10Bl+Q0x54i6+BzLEmlSiGxlP/EoO4w4AB3oJ9uGUiWE
	 7iXHE90xW30Ixv+zBWEPf54MKFo9/cDAaHw7ErjKvQec56O9UHIulErq56ttJwKUri
	 dJtc8niwr7SgHprJpBRYy3CEc6PJI3nFrKVjtEPRW6sLG6dpzn8WBlbgHwG7L/uNBc
	 W5b329P8PHaRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6804FDD4EEF;
	Mon,  4 Dec 2023 12:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v5 0/2] octeontx2: Multicast/mirror offload changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170169302542.7913.11080314543417084382.git-patchwork-notify@kernel.org>
Date: Mon, 04 Dec 2023 12:30:25 +0000
References: <20231130034324.3900445-1-sumang@marvell.com>
In-Reply-To: <20231130034324.3900445-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lcherian@marvell.com, jerinj@marvell.com,
 horms@kernel.org, wojciech.drewek@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 30 Nov 2023 09:13:22 +0530 you wrote:
> This patchset includes changes to support TC multicast/mirror offload.
> 
> Patch #1: Adds changes to support new mailbox to offload multicast/mirror
> offload.
> 
> Patch #2: Adds TC related changes which uses the newly added mailboxes to
> offload multicast/mirror rules.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] octeontx2-af: Add new mbox to support multicast/mirror offload
    https://git.kernel.org/netdev/net-next/c/51b2804c19cd
  - [net-next,v5,2/2] octeontx2-pf: TC flower offload support for mirror
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



