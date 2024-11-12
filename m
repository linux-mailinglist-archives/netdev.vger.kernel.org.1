Return-Path: <netdev+bounces-143903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7379C4B6A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3735A1F25836
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555D7204029;
	Tue, 12 Nov 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD3ihzeY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D2D2038C3;
	Tue, 12 Nov 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373223; cv=none; b=l7eQy1g4wdsoMDNBUP0nhqkKuBNoMOI1Bkbz56DvethrDZx85ekdhuvG3tSjNnQ2ciunTtVXPyQYaJd8iS+uJLB5SobXTOYBqPtWE1entd4KHVDWkGfwMfLJFcHG/+rdRDD0BDjiBnNZEele0d/h7kpFzwVH+XLk6nPwBpyXX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373223; c=relaxed/simple;
	bh=5Ly3KTlyGxLxMdfFr4jX9+4qFB8MuIzcMl8Y+2r08GU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OTXP9BB4L2Mm1PobhSa5D9NEHpU5EX538cPNq57PXQwB0qb2YtmqJJtguv/WGQPa0cPPRM6B8RBGbJYydZbnPECIUU2kkrlAfFvN9VG1cXP6k63kfWjDtVt6i1pyNUpdKwPeM0mFIyJ4RVjPjOOS/9bzD1I/C2euxYQfen7Pqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD3ihzeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5969C4CECF;
	Tue, 12 Nov 2024 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731373222;
	bh=5Ly3KTlyGxLxMdfFr4jX9+4qFB8MuIzcMl8Y+2r08GU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jD3ihzeYm/MAbIy4isBJM1MmRNUzcwsucpzXgKO/fNR0HDtN1wk4pit0UyrV3natq
	 /4l9xghiGQ3os6R24qcWqKOXYqTqveKbsecGFt8G2a5wsRjQMSYpPQpcnO/iENk/Jk
	 kkU9SxNhZE3DottWuaBvCA2f27+GozRRTJZODg//cuszNdt56uvFr4Xf69QZgKt/gc
	 noNUpVGAMH2jvRBxMWbE6ph65wfYL3L0oTYS8x1SNga/iTN9VArWKbfGCh7k3AKZ6k
	 WMJW7eMXjsMJJaQcPBwAI4Ad/E+q3VJR3ASKI3KM5W1prIBt5UnMqTDweM0YLfAImx
	 EwZQ5zUn/Ac5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0853809A80;
	Tue, 12 Nov 2024 01:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: dwmac4: Fixes issues in dwmac4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137323274.33228.17724047786767970520.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 01:00:32 +0000
References: <20241107063637.2122726-1-leyfoon.tan@starfivetech.com>
In-Reply-To: <20241107063637.2122726-1-leyfoon.tan@starfivetech.com>
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lftan.linux@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 14:36:33 +0800 you wrote:
> This patch series fixes issues in the dwmac4 driver. These three patches
> don't cause any user-visible issues, so they are targeted for net-next.
> 
> Patch #1:
> Corrects the masking logic in the MTL Operation Mode RTC mask and shift
> macros. The current code lacks the use of the ~ operator, which is
> necessary to clear the bits properly.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
    https://git.kernel.org/netdev/net-next/c/6d4a34fe429f
  - [net-next,v3,2/3] net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
    https://git.kernel.org/netdev/net-next/c/3fccba8fdc1b
  - [net-next,v3,3/3] net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal interrupt summary
    https://git.kernel.org/netdev/net-next/c/671672977012

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



