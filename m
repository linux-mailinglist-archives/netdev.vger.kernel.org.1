Return-Path: <netdev+bounces-161224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A04A2016A
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CCE188053A
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858F1DD877;
	Mon, 27 Jan 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXgZ4SfV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3681DD0EF;
	Mon, 27 Jan 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019414; cv=none; b=op0K/WjIQMAGIDBXlBUSDgDGcIBLpLjRUtFW0FpZjHmedDhXRba+j4S5tdA2dD2VQmQE0relkkVo4Z8GfTEm+wgSgqHBsdjgPwm7mE79nD9XMxqcuU5tpJsatuViJhOeV4w/74nkFgXQT9P6tBrjf02EIGVbIEoiBbBhQO4I0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019414; c=relaxed/simple;
	bh=mDgQXiGRsNxUmlPS3V5RfuoevqF1jp8XRilu/ivQirM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N8dIwY1ImoHP8uARRyD2Pavvz6NPTsFDjwQHkB+Ezzprmu8zw10+jWIx5Kau8nAhUTnHvXhBbYuGCX2o5xyHJ3CI32dkEw8bmj/XNOHKG2CJXPMrZhy38vgyan8+BPbJ0GbmBHCK2Jn5Nk4hRkOqTXxobPx0NdeBPzFXDe9f2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXgZ4SfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8429C4CED2;
	Mon, 27 Jan 2025 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738019413;
	bh=mDgQXiGRsNxUmlPS3V5RfuoevqF1jp8XRilu/ivQirM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pXgZ4SfVcBD9gIcDXZYf/qMtQIX3dBq/tQG4lntDSWK2l1xPlWC+fxYKoLmJ3zss+
	 QmcS+67P5UgrL2M84KPBTCrVZAr8B8qTrRuyubi0dBt1HUv0atEflXs1hYvOgix1Qz
	 ilHJJYRM7atA7YkYXtkbunMnwGLumz9nTvMub0ZTHZjjY8HBwLMGl0iUNZ2s1cCWc6
	 /qF2Yn8WaCQhZCnUU9giPcdyZqviIzWfpyoMzNyLbFYS6/5SV2km+X6WkO0PGn2Jy/
	 0XmAWwgm+PootgzsY0t5BPsrFJV74Fox0zbQYGgNFy1lFhK4I2MXHT6TF8/LcnY07j
	 C2SKbrFOc9/sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEF21380AA63;
	Mon, 27 Jan 2025 23:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phy: c45-tjaxx: add delay between MDIO write and
 read in soft_reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801943950.3253418.6560196118515385560.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 23:10:39 +0000
References: <AM8P250MB0124D258E5A71041AF2CC322E1E32@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
In-Reply-To: <AM8P250MB0124D258E5A71041AF2CC322E1E32@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
To: Milos Reljin <milos_reljin@outlook.com>
Cc: andrei.botila@oss.nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, milos.reljin@rt-rk.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jan 2025 10:41:02 +0000 you wrote:
> In application note (AN13663) for TJA1120, on page 30, there's a figure
> with average PHY startup timing values following software reset.
> The time it takes for SMI to become operational after software reset
> ranges roughly from 500 us to 1500 us.
> 
> This commit adds 2000 us delay after MDIO write which triggers software
> reset. Without this delay, soft_reset function returns an error and
> prevents successful PHY init.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phy: c45-tjaxx: add delay between MDIO write and read in soft_reset
    https://git.kernel.org/netdev/net/c/bd1bbab71760

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



