Return-Path: <netdev+bounces-22140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D0766285
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC5C28261C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF1B3D8C;
	Fri, 28 Jul 2023 03:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA117EC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F83BC433C8;
	Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690515623;
	bh=j68cQbaROJUzWuEyrIA7FjWkBHFT7+vx0pq6TM5mFdA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jV7NtV4MJomK4uQuDChlFl6SS8gaqadVCPjeSQxFkkILdxMLASvGp+vr6ieXqe9h2
	 AoCUQXMrrINJcoIWILnRaeR6YZcJ4HufDazNoQLOXJgdLVZ3akxqmCFjc0nI5u0XAJ
	 rSPpADuDOJHPRwWmRazZkhcMVLGpr7qB7asej8LMTjvX5gq6zMTZ4ZKfssWON5G/we
	 3onzcCh88/gVMsHC1oOOD2jmuZXjYQZW3HcWBEW/axNBLRtM/5//RWZdHTSVD5CmUz
	 MD9fJSJL4Q/k6nJ+241n/CRXcq511JhnjYZ3en7c3qoE8VoYbV/epKx33MiE4g6k0l
	 E+0Zc4RcICwAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 354BBC691D7;
	Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: Increase clk_ptp_ref rate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169051562321.23821.5865219947273364361.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 03:40:23 +0000
References: <20230725211853.895832-2-ahalaney@redhat.com>
In-Reply-To: <20230725211853.895832-2-ahalaney@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 bhupesh.sharma@linaro.org, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
 jsuraj@qti.qualcomm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 16:04:24 -0500 you wrote:
> This series aims to increase the clk_ptp_ref rate to get the best
> possible PTP timestamping resolution possible. Some modified disclosure
> about my development/testing process from the RFC/RFT v1 follows.
> 
> Disclosure: I don't know much about PTP beyond what you can google in an
> afternoon, don't have access to documentation about the stmmac IP,
> and have only tested that (based on code comments and git commit
> history) the programming of the subsecond register (and the clock rate)
> makes more sense with these changes. Qualcomm has tested a similar
> change offlist, verifying PTP more formally as I understand it.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: stmmac: Make ptp_clk_freq_config variable type explicit
    https://git.kernel.org/netdev/net-next/c/d928d14be651
  - [net-next,v2,2/2] net: stmmac: dwmac-qcom-ethqos: Use max frequency for clk_ptp_ref
    https://git.kernel.org/netdev/net-next/c/db845b9b2040

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



