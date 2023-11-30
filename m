Return-Path: <netdev+bounces-52379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038447FE83F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 05:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3462818A8
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EAA17991;
	Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0I47ENz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C33171AB
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A162C43395;
	Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701318034;
	bh=WRVSttbM2fI7ulLUAoIJ+/ythff6aYAnCIYagmH69MY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o0I47ENzX4sYr9Yj/nkZ72naIeq1g82dvgq/Z9jELZElbBTQX4O6mflEVZl1VRubR
	 fYg+MqAYxJIXuioSvukQiVbm23wqGjqwlFFvfzeIdkEZbHG5uoWHqUXY2E9ZpIpNEF
	 OQkr2yaBqRIkrg5eX0gtxL5QPQeNPCtjZ59ckjRIkh+oE6FCtck8c8NlmbZBhY7EmY
	 IqyGGJjq/afCWMxpgIZvYJB1ilsTtRE1Buggrb+eFXHiS/WN7EUsYmIcK/0u7BTDRW
	 sQsJBKEPm7MyLmbT2eJy8TQP/1slhhvF4eGC4/Mb3HhFBpqaP0TSXGh1AxCieJrz3P
	 UuP4Zs5N2SOXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1699E00092;
	Thu, 30 Nov 2023 04:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: dsa: sja1105: Use units.h instead of the
 copy of a definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131803397.31156.2720750102208492898.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 04:20:33 +0000
References: <20231128175027.394754-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231128175027.394754-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, olteanv@gmail.com, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 19:50:27 +0200 you wrote:
> BYTES_PER_KBIT is defined in units.h, use that definition.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/dsa/sja1105/sja1105_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: dsa: sja1105: Use units.h instead of the copy of a definition
    https://git.kernel.org/netdev/net-next/c/4b86d7c64e8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



