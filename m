Return-Path: <netdev+bounces-17351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4050751572
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37F71C20FEB
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24D9368;
	Thu, 13 Jul 2023 00:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0347C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A97E4C433CA;
	Thu, 13 Jul 2023 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689208822;
	bh=MKVDwMvsaB/7qukJAVscIEMm08I8b8A2RhUMORjA8ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EQ0yx5gVpMKY2u7ulNqdrViPYDQ6L1kgiJiL3AiWq9XMdAt5cZJzpuDWeTD9mXjB9
	 tmYY7DCTOXdloeBZD5kCtEVSfG1P1+Lx154H97QPB/iO3pHO7JfaDMr4EJKNUNw3u3
	 Fznm6UoL06yOEx/DwOpIsdSfKS/4C/jCA+kGecbvBXERBChaL7cZiWMBAfNDD+JgBG
	 9K3aGQ+dsgGfpLUmknGvgzO9bzmPwXq1J2M/PnwjF6uQnDeJdPQ0nmZYJ7nabtaEgn
	 YBNMwDvkVZjPCmayuSd57QQ9DOTrWommtFHvLKTCCRJOeBb7j0cAjT9mEcobmfcXyD
	 de6vLXCM7ypEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90971E29F44;
	Thu, 13 Jul 2023 00:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: t7xx: Add AP CLDMA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168920882258.29480.12412613673820050231.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jul 2023 00:40:22 +0000
References: <20230711062817.6108-1-jtornosm@redhat.com>
In-Reply-To: <20230711062817.6108-1-jtornosm@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jinjian.song@fibocom.com,
 haijun.liu@mediatek.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jul 2023 08:28:13 +0200 you wrote:
> At this moment with the current status, t7xx is not functional due to
> problems like this after connection, if there is no activity:
> [   57.370534] mtk_t7xx 0000:72:00.0: [PM] SAP suspend error: -110
> [   57.370581] mtk_t7xx 0000:72:00.0: can't suspend
>     (t7xx_pci_pm_runtime_suspend [mtk_t7xx] returned -110)
> because after this, the traffic no longer works.
> 
> [...]

Here is the summary with links:
  - net: wwan: t7xx: Add AP CLDMA
    https://git.kernel.org/netdev/net-next/c/ba2274dcfda8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



