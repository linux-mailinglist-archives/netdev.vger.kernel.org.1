Return-Path: <netdev+bounces-33913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC8D7A09A2
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6C21C20E96
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45631F5ED;
	Thu, 14 Sep 2023 15:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1F28E2F
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72FE0C433C9;
	Thu, 14 Sep 2023 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694706028;
	bh=5pHurieEGpFvVNepSGKTHuQJ5+UCJ1DQa4ysNwXQgvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hk53rtvaOdOepIJjZBvFzCiPQI4WY/31RI5bwj+R6qnvqqy4XUHZ8NME3puJUI2Nk
	 LEBnCf4GgvRC9lUHJfM0yYHy2SdthTk//S4+vXUGRRmeTms9jF+Udpad2z9jBzeNuw
	 uqhLuusK7mcxGVMLtj96tEeNpnxQsqyG24EDA9xjwZO+xjYhfmfylsG92qtMn/CSGe
	 uYYAtg+qF71YfANseM6ZQst6DyaAHnYSAwvIj1RfavxL/cxL5fPaxTBZ23z44L8fsY
	 ntmoxWl8lBbH7vvk3a8Ulnsr4Ea8vqV/wEEVzcfY9F5TV5wVGVT6qOCGpxgoc82KeD
	 U+OvStnWEJ05A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56BC7E1C280;
	Thu, 14 Sep 2023 15:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169470602834.30402.10840214972084534976.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 15:40:28 +0000
References: <20230912084039.1501984-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20230912084039.1501984-1-Ilia.Gavrilov@infotecs.ru>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Sep 2023 08:42:34 +0000 you wrote:
> The 'state->im' value will always be non-zero after
> the 'while' statement, so the check can be removed.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: igmp: Remove redundant comparison in igmp_mcf_get_next()
    https://git.kernel.org/netdev/net-next/c/a613ed1afd96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



