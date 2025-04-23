Return-Path: <netdev+bounces-185308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DE5A99BDF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511313BE91C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06621F8908;
	Wed, 23 Apr 2025 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv/8ndts"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9518A6AD
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450083; cv=none; b=MP7cANEJgpLYFvepJTg8m8Ho2ps5faIw/2GCoEuyjnBXQi2iZggvW7F5Vc62k5McldfY7SmTP7Utd88Lt+2CoHi2BMY3x2yCQYI0F9sFv7dWi1ulXWgX+EJfucjxVuZvpYfQRcJKr3eUtYn+aqhr21EUhAQIC5UMk9EKn2RW+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450083; c=relaxed/simple;
	bh=NwPdaUZJAZ+ANYSzIVj7rk7f0HACGHmAdYi8K/KSyN4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=es1vxSTj4caHA5lVKRFQQ705pN+f2s/vi6ctffab1E7Bue4yfS+w9fM9AgxlJooroqCbQxxP0gZbeivzBQ9RSPmoM37tqF3vQr87OynHPx0FmT9GlYcwl99/Edf7uBIPZbS0qImwbX+sj7HtH+uGfrpET715BdSzYuIVasobLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv/8ndts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECF0C4CEE2;
	Wed, 23 Apr 2025 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745450083;
	bh=NwPdaUZJAZ+ANYSzIVj7rk7f0HACGHmAdYi8K/KSyN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qv/8ndts6AWpsTgPCu6Jakxn7NPuQaBNcVpasq4/qTXXHgOztPsHznio1aG6RTyu8
	 RMvihSJ6Fq7WoxvWIBVKu0WpJhChmGHvBFBAYP4VfvQQmicQrB9PHiDSdhknXcrt2g
	 UrYbiS48yUDw6HqP0KKOQSP+WjFwZpTe5yjZ6YYk9RvAiv3nh/HaCO6f1pydRKvtRb
	 MrnWYM4NqWimy7zxCACmzj02FJXdtTsCO7qPwb+/rsKC5ZIqGPXb1LxEIVAAogKRim
	 kSywYzYlmcViwf38b11U2+DmxJTF/ecq3c63JXjUb2YzAg/WhkpQB8tJT8Rgvzoq5d
	 hwsz4st979i6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD63380CED9;
	Wed, 23 Apr 2025 23:15:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: calibrate tegra with mdio bus
 idle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545012150.2793299.8349789230420012979.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 23:15:21 +0000
References: <E1u7EYR-001ZAS-Cr@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u7EYR-001ZAS-Cr@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, treding@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Apr 2025 15:24:55 +0100 you wrote:
> Thierry states that there are prerequists for Tegra's calibration
> that should be met before starting calibration - both the RGMII and
> MDIO interfaces should be idle.
> 
> This commit adds the necessary MII bus locking to ensure that the MDIO
> interface is idle during calibration.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: dwc-qos: calibrate tegra with mdio bus idle
    https://git.kernel.org/netdev/net-next/c/87f43e6f06a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



