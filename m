Return-Path: <netdev+bounces-208284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE73B0ACD1
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 02:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239E21C28B0E
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0AD1A285;
	Sat, 19 Jul 2025 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrbALF+X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4C3FE4;
	Sat, 19 Jul 2025 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752884991; cv=none; b=ouKlEy+TxVZXfnuZf2R6f8iQAN6RNTeuWBmfFGIeit3+uiX3nTQ8zjLuA5ALBBJg3QcETO+pQ6WvTiG0x9vBQAYBLCY+yvcx9YMK9FmoMIo029X8LJf8EywHnB7lDqW3Akg2UZJU+jy4SYnKFX12DIgWT+Ry+GPDK12yDbZell4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752884991; c=relaxed/simple;
	bh=3NtI+tm0xwC9/dNzcuRiJPt3DrDQFLrF8QqUA7Fw5VI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HJXCYz2wxMZmB34XX6FYDsDNtmZ5tOuVyE2zU5CF5bSfHv7Zrtd15Qvnzin/H7EZefi/CPv0675tKLuMmufSOVp+d+BMYhS6zGunEoahAnp2iJymkmJqggRBnoSLvtm1WTGvogYbiAp+emT917FwzdcugnAojGtrXOCvajxrp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrbALF+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64556C4CEEB;
	Sat, 19 Jul 2025 00:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752884991;
	bh=3NtI+tm0xwC9/dNzcuRiJPt3DrDQFLrF8QqUA7Fw5VI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RrbALF+X3XwZT6OeGnLZmr7Cf1263uC0Or4RBhE5ZKbAUblsgGUr1LS8MUyLZfpeG
	 2HGhMmXhpJTkt1fm3yxjjxufxOn+4sF61a455HHjMM70I+mdr/SoBZYqdIAtLdCY8k
	 hs/dtBW+MlwdmfiXeBqMXx+WBM2YTjb+MtP3dSTORcdYKdcMcHhKVpnBdhCigRWKyN
	 0w4FysTmEbrqrPWMvkywrv++yzAw09kmZEmNew/jsJWUREJvnB0pdM+2uA/4RG/jj3
	 7eUGPxTUfJAb6Wl92mb7G1/j6sxvQFRIIgWolFyipBZJOBPewWvHTBCtJ3y3pKHtDz
	 ogTjIYtFMa8Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C66383BA3C;
	Sat, 19 Jul 2025 00:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/1] net: selftests: add PHY-loopback test for
 bad
 TCP checksums
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288501074.2835800.11383603142834046961.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:30:10 +0000
References: <20250717083524.1645069-1-o.rempel@pengutronix.de>
In-Reply-To: <20250717083524.1645069-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 maxime.chevallier@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 10:35:24 +0200 you wrote:
> Detect NICs and drivers that either drop frames with a corrupted TCP
> checksum or, worse, pass them up as valid.  The test flips one bit in
> the checksum, transmits the packet in internal loopback, and fails when
> the driver reports CHECKSUM_UNNECESSARY.
> 
> Discussed at:
> https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/1] net: selftests: add PHY-loopback test for bad TCP checksums
    https://git.kernel.org/netdev/net-next/c/e7ce59d9205e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



