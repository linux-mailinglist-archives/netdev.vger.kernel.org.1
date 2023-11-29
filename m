Return-Path: <netdev+bounces-52003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC77FCDD5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E0FB20E97
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCDE6FA6;
	Wed, 29 Nov 2023 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3A/DNba"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455363BA
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88D87C433CA;
	Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701231626;
	bh=lgD2jqr7ZEYJstd2skzOnk02t5Uh1Jsqy0rhdnz02Ig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i3A/DNbaRKWfsT6SiSuDTg93HFkDMiHzBEDjn9ow5LkKByw08RR+1pH6fAh55PuPw
	 NxshadOArYpUk6dA7DaT84pBf7c1BH0X5FaviHxmpFk0Q8iFJ2sAv5j2ScSRKWrjUq
	 zSDxnNSM/4MN7rRIbJtrKAZpOSFq0Hbc5ATs3AepqUjUj1tHVwASvBRdfxfJMOQwm3
	 Rs3iP6kcy/Zrl0Vv0/AGJbHpCLOvH1rpd1LhU00MVykq0DPMr1KWhPWxgf5qz5zm3t
	 4A3ziD+ZZvgnJgEYcApVPUHNFDBFmg6G4/9w2oHvGOILLrBwhjaGAqbhvDJK1265h/
	 eEJ95F984Xs4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67F0DC691EF;
	Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove multicast filter limit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170123162642.8478.15627805421426361159.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 04:20:26 +0000
References: <57076c05-3730-40d1-ab9a-5334b263e41a@gmail.com>
In-Reply-To: <57076c05-3730-40d1-ab9a-5334b263e41a@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 21:16:10 +0100 you wrote:
> Once upon a time, when r8169 was new, the multicast filter limit code
> was copied from RTL8139 driver. There the filter limit is even
> user-configurable.
> The filtering is hash-based and we don't have perfect filtering.
> Actually the mc filtering on RTL8125 still seems to be the same
> as used on 8390/NE2000. So it's not clear to me which benefit it
> should bring when switching to all-multi mode once a certain number
> of filter bits is set. More the opposite: Filtering out at least
> some unwanted mc traffic is better than no filtering.
> Also the available chip documentation doesn't mention any restriction.
> Therefore remove the filter limit.
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: remove multicast filter limit
    https://git.kernel.org/netdev/net-next/c/cd04b44bf055

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



