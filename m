Return-Path: <netdev+bounces-227273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29617BAAF1B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 04:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD8374E2049
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 02:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433EC2248B9;
	Tue, 30 Sep 2025 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCNRapFB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1B223DD6
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197628; cv=none; b=ZZM3XkHYD4dakjDFFiZHSHuSTf2i/qfO3RvZghr5NDLPgI7ntFdwEFkKKDZE3UzigSqIXaSovSL9vyPjsbXn0bGitx+oHizz+2jDVvdsBd5fi5yyty0HRrizsWmQTZcNJQunPndCsGL9Fkv+OZ07aHRAvIfZdY8XkLIUdWG18sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197628; c=relaxed/simple;
	bh=r2SHYFrcUFIZfSRfIG042SXPAw55FPb1NYT4hakUlZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HNeB9HK3Qo/aXBXuvMc0QeOmHGnwexX8YZk675up1NJ22Ut3tqvbio/et5wIUQNw4W+8YAAidV9E/MtGF4WAAPakUVlmvERyTt25cJ0ueqzGEZpDKbbEQFepi1Dzkwidu9UVmvOi+CU2NHFyiXxAH8ZmU2PpRkC/NBK0/vfbhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCNRapFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A363C4CEF4;
	Tue, 30 Sep 2025 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197627;
	bh=r2SHYFrcUFIZfSRfIG042SXPAw55FPb1NYT4hakUlZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OCNRapFBl9LNEBFYco2lY/ZCai5OeRtqIU+CdV9q7+q/U57RrnWtTQzZe0k5/iLvK
	 JthHBiZkjxrvpTGoiM9UelfcowEW9vI6xVApYbPVm1fHmWYaSwfIQK5nXP7to+0rIB
	 CcQA3LmSMKer+ySmMgfeU/TCgbFLMDuGPOKYO+nv9APIoN2yCzGLgkhdFYMxdTp6ux
	 4RbBBEwNL9FS9Noc3xOFfmlVENgsvDCr1P0lmgI0fH8rUHVAJz6WnRKL+9BGslJizS
	 8hv8vSmvBN66jGIrrcclYa1aXIbYGeQue/bEWFwuejdp62V6VU3caXCCPeo5hU7PA4
	 yjz2fLN2wpBlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3412239D0C1A;
	Tue, 30 Sep 2025 02:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: remove stmmac_hw_setup() excess
 documentation parameter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919762074.1786573.3483201535680526845.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 02:00:20 +0000
References: <E1v38Y7-00000008UCQ-3w27@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1v38Y7-00000008UCQ-3w27@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 0x1207@gmail.com, kuba@kernel.org, hayashi.kunihiko@socionext.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 08:43:55 +0100 you wrote:
> The kernel build bot reports:
> 
> Warning: drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:3438 Excess function parameter 'ptp_register' description in 'stmmac_hw_setup'
> 
> Fix it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 98d8ea566b85 ("net: stmmac: move timestamping/ptp init to stmmac_hw_setup() caller")
> Closes: https://lore.kernel.org/oe-kbuild-all/202509290927.svDd6xuw-lkp@intel.com/
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: remove stmmac_hw_setup() excess documentation parameter
    https://git.kernel.org/netdev/net-next/c/6d3728d424a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



