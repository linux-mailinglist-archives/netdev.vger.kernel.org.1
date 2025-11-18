Return-Path: <netdev+bounces-239587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 203EBC6A162
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B812D4F00F0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA98635F8B8;
	Tue, 18 Nov 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEQBJluO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6235A953;
	Tue, 18 Nov 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476240; cv=none; b=dplnFOdgiwYlDBk1hCPHgeVhnMSh5h4mxVpa+JWpbcUV/R8N2FHJ2sjjbrGnps0fPrpO4OSOGKJnG6lTTDq/oBvFvLFC8lxYd1maP1nSmDLLW2TzGvCx7XKlsXBbmp/HBxQlZvLIgQBSE6dMEaqitAwlQlD/lOcP9EUiqlQtXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476240; c=relaxed/simple;
	bh=5rtl1lFoB6c4PiUX5/YkCGOZTYtPreY12GSKH8a49MQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J9GHz3nJGuZpFcqCwjo1kVdu9HEwjzmSN4xoV719hzi65Bvyq8a/VexTBZ4bMl/duW1Thq5jwI+nlEI0SSAQ3kRkDrpWQXy50JnAOlFGSrfLnCrOLEYgyho37/UowONTQfIULpjbtjG/k8yuJemDMcpR1BgrLLziM/Wt+cXYypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEQBJluO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A51C4CEF1;
	Tue, 18 Nov 2025 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763476240;
	bh=5rtl1lFoB6c4PiUX5/YkCGOZTYtPreY12GSKH8a49MQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uEQBJluOR/M2PZDJWTU4wrvy2mI4Anx3DqtZ/eA7E2Wh5atwKurywv/lCWYNMbw4m
	 RX9P/kzC3q9rp3IGIwV34nw0vNz2VOmhX7GkvFnBRE2OMmPc4DU9hCu+nxKVJbKq9P
	 DqUFLgbB3vQmK19YcMpwZduJQxF7xWkLuJ11RHP69LVarNiJ7hQjSbQXsUQ9t+n+aL
	 VLbq2CbJWUhUFaBgfvnzY3wlNQg/TeoygN+wPzhnYavMHbu4ToTTxUPjlUvCCUXq5j
	 kQYlLpOTA6dL5Zit4G8a5L92dq95O55IeWO6vSsmgYr4TMJfEhY630okouINK8Uor4
	 8ai0LwcurHeyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF23809A8F;
	Tue, 18 Nov 2025 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: micrel: lan8814: Enable in-band
 auto-negotiation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176347620676.4167781.357724212992783265.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 14:30:06 +0000
References: <20251114084224.3268928-1-horatiu.vultur@microchip.com>
In-Reply-To: <20251114084224.3268928-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Nov 2025 09:42:24 +0100 you wrote:
> The lan8814 supports two interfaces towards the host (QSGMII and QUSGMII).
> Currently the lan8814 disables the auto-negotiation towards the host
> side. So, extend this to allow to configure to use in-band
> auto-negotiation.
> I have tested this only with the QSGMII interface.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: micrel: lan8814: Enable in-band auto-negotiation
    https://git.kernel.org/netdev/net-next/c/19f1d6c7230b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



