Return-Path: <netdev+bounces-38313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8B67BA5AF
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id CD0FDB2094B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1969934CE0;
	Thu,  5 Oct 2023 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXq+cjtv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3ED30F93
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50B2CC433CA;
	Thu,  5 Oct 2023 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696522827;
	bh=21g5xz0Da1JHH17XeEyv4z7OGB8N7Nj5S+gSzpgTHOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LXq+cjtvUMugPEboV5qjiew9XatnLE7f6uzYJBL1B3YjdJci5FVlkwxg/Lx9tudZZ
	 4KIfEjN41jjrD10U4dX79BzOHjBz55HPbAYgci97wiZnD3DrmMocqPXv6fyPNl6NjK
	 F8cVegL9C/UkJvg641Dwc988SqupZAe24rOEDlwqYXo76fHzlN1HqmnZcoDg0gOjBW
	 cfJj2uIH6nUezZp21jRocrI+ciHe+iP8c4LVjiJDZr6mrhN4FNYPRtZy5lLkC35/FJ
	 NJjPPhVsBq7rE/1J7qPhQiHYjEA8AxvAYmj986OtwBcCsjzNy+euhUDF20LlALxZ6A
	 hgw1olFUhogBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 346CDE11F50;
	Thu,  5 Oct 2023 16:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: lan743x: also select PHYLIB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169652282721.14786.14487988434819506172.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 16:20:27 +0000
References: <20231002193544.14529-1-rdunlap@infradead.org>
In-Reply-To: <20231002193544.14529-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, lkp@intel.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 horms@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Oct 2023 12:35:44 -0700 you wrote:
> Since FIXED_PHY depends on PHYLIB, PHYLIB needs to be set to avoid
> a kconfig warning:
> 
> WARNING: unmet direct dependencies detected for FIXED_PHY
>   Depends on [n]: NETDEVICES [=y] && PHYLIB [=n]
>   Selected by [y]:
>   - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]
> 
> [...]

Here is the summary with links:
  - [v2] net: lan743x: also select PHYLIB
    https://git.kernel.org/netdev/net/c/566aeed6871a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



