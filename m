Return-Path: <netdev+bounces-51639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1697FB8C1
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B9D1C20925
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882E04A9BE;
	Tue, 28 Nov 2023 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFFLS0Xz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3049F92
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 11:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5A0DC433CA;
	Tue, 28 Nov 2023 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701169226;
	bh=QOg3KVTER4epeAO54p/axbPEeNoukAl/3jVlyfyz5pA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LFFLS0Xz8X0pIlB57Xsfgt90E0QExzL9hJa7HWEiUpc/HddEdCCyjz71sgEgiJCOc
	 GOEC22grZxMqOGDRg3tSAi1xhuQgzATZwyFefdVM9ucxBp+PJ32S7suBas2iy72Z4s
	 xc4ZHLzkfPU1O/4Ru/wkKxQLcQfiKsRmpMw/XMuJlvhoxCJkbAY0rQz5dTqjsBAjFu
	 1yv3HBx0s3ZVuu1l+JePwYNYUBvmSbLZ9Q7ocrQ1nz587G+oLXJs81jaNAXEWarh23
	 eDcPkd1CnJ+Otl2VBGnqrFK5W0I663nqwFD66RQwpDnIX6dzY8+7CVxpTJbSH/czjC
	 tVT1Qxlnf1zeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C79DCC39562;
	Tue, 28 Nov 2023 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: xgmac: Disable FPE MMC interrupts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170116922581.4807.10674635347082642377.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 11:00:25 +0000
References: <20231125060126.2328690-1-0x1207@gmail.com>
In-Reply-To: <20231125060126.2328690-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: davem@davemloft.net, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, jpinto@synopsys.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com, larysa.zaremba@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Nov 2023 14:01:26 +0800 you wrote:
> Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
> by default") tries to disable MMC interrupts to avoid a storm of
> unhandled interrupts, but leaves the FPE(Frame Preemption) MMC
> interrupts enabled, FPE MMC interrupts can cause the same problem.
> Now we mask FPE TX and RX interrupts to disable all MMC interrupts.
> 
> Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: xgmac: Disable FPE MMC interrupts
    https://git.kernel.org/netdev/net/c/e54d628a2721

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



