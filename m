Return-Path: <netdev+bounces-26596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EC377849C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934961C2115A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D0371;
	Fri, 11 Aug 2023 00:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7A7E9
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E8FEC433CB;
	Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691714423;
	bh=AxES2D/fGndvMKLCPqObZNt8VvTIG5vKlDN8rPWTa6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l5bQZVqBIkDaOzsFj1Z1Pr04+rjgxWr3xp3QsCCajgXwQmyE4ATLyNnxUcsy5Eo6t
	 dbaf+n/PE3VgpRATvBmBitfK07n04kN8614vR53uMGlq3i0Amuf8X/FQ5g++rkiScs
	 w8g0E7oGFqFxycTVfIqQTCwFO+lh1M2fTPDhc/OycMi7NxV/+EWNQa0FZyqFyF4Iml
	 OplgTCINlaH+3E+Vqnhi+PlsYEDuDFcjON7CApuaDrCAlaUUyzQO0ITEmKM7yVuSop
	 yEBUma0jYChxu1nYA+69NT/csznpXPFafST/P48G9HnhaWmDHyWIhaH7qTdTU+jvyO
	 5YJiGYG0piN4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84FB3C595D0;
	Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/1] net: stmmac: xgmac: RX queue routing
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169171442354.25552.8986058252469165360.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 00:40:23 +0000
References: <20230809020238.1136732-1-0x1207@gmail.com>
In-Reply-To: <20230809020238.1136732-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: davem@davemloft.net, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, jpinto@synopsys.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Aug 2023 10:02:38 +0800 you wrote:
> Commit abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
> introduced RX queue routing to DWMAC4 core.
> This patch extend the support to XGMAC2 core.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v3:
>   - Clean unused defines
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/1] net: stmmac: xgmac: RX queue routing configuration
    https://git.kernel.org/netdev/net-next/c/0c2910ae7fa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



