Return-Path: <netdev+bounces-26497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F04777F4B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9761C20EEB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA800214F5;
	Thu, 10 Aug 2023 17:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF51E1C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08B72C433C7;
	Thu, 10 Aug 2023 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691689221;
	bh=DgGIQxm9T3j5F5GS/tDZyHr6yrkokRMtYqyjFvotMd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qQqjUiW47BPOFQCeCERwTvIkf4E83TbWzVQC/CRQofvOEhCOo4/tYWQbCTpKzmDg6
	 oSw9fW1LGx2qMZovEja3J8zzS68C4bG1TCs2Ri9H93HNCvlVIPPvWF47AL2GW+/WUB
	 MeQW1wjxowULzaKhkpd/NJgRK+lFdrCO4rM6TjViuDGXoBNPS3p414WgwlKXlQZuWA
	 jBiOqAT/B+SOYO4Rfb+lhyjS8vVx+fSHG5DkSC9V8WBemgTaFd7XZx2/ZFt5BhSI/d
	 kzuMp3GXzJHDz6j/COgR5ewWIrx/5EnQsQLAonkbScbwyEKYrIGYkg0pu53US4dvHF
	 /QTk4NgBdwpMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE717C64459;
	Thu, 10 Aug 2023 17:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V8 net] net: mana: Fix MANA VF unload when hardware is
 unresponsive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169168922090.685.4553491279994848251.git-patchwork-notify@kernel.org>
Date: Thu, 10 Aug 2023 17:40:20 +0000
References: <1691576525-24271-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1691576525-24271-1-git-send-email-schakrabarti@linux.microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
 ssengar@linux.microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 schakrabarti@microsoft.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Aug 2023 03:22:05 -0700 you wrote:
> When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
> hardware to complete any inflight packets and set the pending send count
> to zero. But if the hardware has failed, mana_dealloc_queues()
> could wait forever.
> 
> Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
> which is a somewhat arbitrary value that is more than long enough for
> functional hardware to complete any sends.
> 
> [...]

Here is the summary with links:
  - [V8,net] net: mana: Fix MANA VF unload when hardware is unresponsive
    https://git.kernel.org/netdev/net/c/a7dfeda6fdec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



