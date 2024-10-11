Return-Path: <netdev+bounces-134730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F17B799AF0F
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9BA1F2288A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4339B1E47BE;
	Fri, 11 Oct 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoMduaAi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E581E3786;
	Fri, 11 Oct 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688235; cv=none; b=qblaiPBgt7fmw+OUaSkP1s5tDaZPuLQtwWUylEW0srZDbEtlq4uSQ+c/faiwjOkP+t06nC/QZNByj4y1pQ1eGA5A5cXW4y53pzUHfQLP9oFlR9DMmFYkm5h6zbTWL1Gm624IYGvA8m/TLy07ScnuNUCjlOOUFdngnPT03EOK+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688235; c=relaxed/simple;
	bh=j9zN59cx19FqHur0YFxPqcYCl41LyYMRbn8YHI5JBEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QakUmjPCET1A4ziwnI3FN2CyaCGLj+eeQX5spskBb7uxr0C+IFCua3rT1PVYvZmNJLaTUnXPNzZ6o9K6lFd4CVKeBQjwRGUUYXUPtiHz3BaCks4c0wXELT48PYS0ZAWFLE9uEqtaKAOORidCA9ZduVDilm6x9r34TWkbgEYuKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoMduaAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B0DC4CED1;
	Fri, 11 Oct 2024 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728688234;
	bh=j9zN59cx19FqHur0YFxPqcYCl41LyYMRbn8YHI5JBEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RoMduaAiMX6S4iYv5OrR+rbr3LkHYnraMaDuM87829C4yLLkAj96hM5tV7FScZL0A
	 dMj8hfjjW96pUYJvZNKlOAfeHVCbpuBWDM72wTBoL2KxwBbBElPVm8UB5/XuwqjA7I
	 ko6D1NqicyukZ5BVP+mw9LjQIfDKuKX8vX8SmekQvDZ2p+IFrAtDF4xxTHCVmWmrB5
	 eABUMixMU2TDrdVdcnTB/ZbAY1b6CwCjWUwH4J7bGSywFUHkt+5AUZGcF9Kbk/tQcJ
	 Ok5DjOi4mRTz23S73oDkaER4Lqi9C+BApjxRFd301A6pHrWjzAtNP0K46cf2INofe+
	 XJqniueg4fSdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7119438363CB;
	Fri, 11 Oct 2024 23:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: add missing static descriptor and inline
 keyword
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868823925.3022673.11344630026816990350.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 23:10:39 +0000
References: <20241011030103.392362-1-wei.fang@nxp.com>
In-Reply-To: <20241011030103.392362-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Oct 2024 11:01:03 +0800 you wrote:
> Fix the build warnings when CONFIG_FSL_ENETC_MDIO is not enabled.
> The detailed warnings are shown as follows.
> 
> include/linux/fsl/enetc_mdio.h:62:18: warning: no previous prototype for function 'enetc_hw_alloc' [-Wmissing-prototypes]
>       62 | struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
>          |                  ^
> include/linux/fsl/enetc_mdio.h:62:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>       62 | struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
>          | ^
>          | static
> 8 warnings generated.
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: add missing static descriptor and inline keyword
    https://git.kernel.org/netdev/net/c/1d7b2ce43d2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



