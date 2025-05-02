Return-Path: <netdev+bounces-187353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B069AA6815
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 03:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A8E3BE864
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12613BAF1;
	Fri,  2 May 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVmqGC3j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938E5674E;
	Fri,  2 May 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746147612; cv=none; b=U941dq9x3NTWXkJtXx4vcphm0Zi1UkR4hg1QM3ozrbX3KJalTE5W7aIpS6BYdre4YcYZpzt3J7dRXy7T6iO6idJMQHhG8UB1LIlXGd/0eOM11AlNLWtydR7qFS6q9Wkxl3+wQ1rL94HgTqn8ow8UJoDH4fAASzQqu1phSlGEG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746147612; c=relaxed/simple;
	bh=HMPgr40VH5mX1QcwLj1gZeZsZHk8igfKOvu5EQAD8sU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W+nldaggyHieeBMvmDKS5sEvgZYxghgD+796e4zW0MZmZRv0LuabJqIym5MA+KOR1R7wEWdVKaTU0l5qh6PhkcgRFNsFLSEljOHw5jV+4S4jG5O4kocRrfu+YydQVzCWnvwC1qkcLniqxhzfySzl2kXW+Z3BXcZLrsC+fBqjSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVmqGC3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63442C4CEED;
	Fri,  2 May 2025 01:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746147611;
	bh=HMPgr40VH5mX1QcwLj1gZeZsZHk8igfKOvu5EQAD8sU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KVmqGC3jBsRdqt844cN3DDUqVStk3m7giI8iDRrHZmF41qMsk2Z4hCdRCdFV8zriU
	 nnu37wTENDZP57E2me7MprbRbFSVazZokTRdlDbR3xgi4JZ7sR8ieHCFP3TSSL7Wor
	 qKh+KBapyx3Gb4gYrydpEnYy2RvCjnfoGSniPh/upBYOkZooPhY25j60oRWHebgMrt
	 XbqO1n/cgXjWMxFGNUgx0gIbkNB85IiMo3c81nCdY+Sl7HvVSFnrirn51BXHPJxT7E
	 BjWXMdM6WPlVFHyuZSVqpaX2um39kVVwPzSqgcpr36Rx578U4BtCD+Y+lyMhIM72gY
	 5ttmDumUIy9gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE693822D59;
	Fri,  2 May 2025 01:00:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/5] allwinner: Add EMAC0 support to A523 variant SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174614765024.3121766.5842492946410657006.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 01:00:50 +0000
References: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
In-Reply-To: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, mripard@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andre.przywara@arm.com,
 clabbe.montjoie@gmail.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 krzysztof.kozlowski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 13:32:02 +0800 you wrote:
> This patch series is trying to add EMAC0 ethernet MAC support
> to the A523 variant SoCs, including A523, A527/T527 chips.
> 
> This MAC0 is compatible to previous A64 SoC, so introduce a new DT
> compatible but make it as a fallback to A64's compatible.
> 
> In this version, the PHYRSTB pin which routed to external phy
> has not been populated in DT. It's kind of optional for now,
> but we probably should handle it well later.
> 
> [...]

Here is the summary with links:
  - [v3,1/5] dt-bindings: sram: sunxi-sram: Add A523 compatible
    (no matching commit)
  - [v3,2/5] dt-bindings: net: sun8i-emac: Add A523 EMAC0 compatible
    https://git.kernel.org/netdev/net-next/c/0454b9057e98
  - [v3,3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
    (no matching commit)
  - [v3,4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board
    (no matching commit)
  - [v3,5/5] arm64: dts: allwinner: t527: add EMAC0 to Avaota-A1 board
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



