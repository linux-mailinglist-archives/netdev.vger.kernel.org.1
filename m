Return-Path: <netdev+bounces-98356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5114A8D10C2
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824DA1C219AA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5809623;
	Tue, 28 May 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxI4BYyo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1FF173;
	Tue, 28 May 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716855028; cv=none; b=aTsX/EgZPfyMH8W7EiRFPDwJxJAqNBUc7X2em5dOrdyjVHYMTqKp1O9JTWjvxcNNhTU5ErYtg+jOApuy5za3Y97LcRGKqkE9j4/3KA4hQXWHhHi88WLG3XICPa9uxKDCTRFJ4ttSAf7CAhS610Ndrk69yzEFqONsO9i+d7RkxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716855028; c=relaxed/simple;
	bh=zqCQMb/5/zaLMgTKGUA2fzUjXj58vovEe5sP4RrPq0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l6TwrkI8JlB1IBpwYEgiVr0Os+JuEC+MIdn6nUIL2ddvVjhEiKGtWkAltyb8euNXkPRypHL97scU46ErYYnjTxuTCxKcPbctgU7u75XOoBKYod/frVyZv76PsqGn2pRyq2fP2bOtptoCpihesGDebdX3HcLMUSRcWsr5nd+T1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxI4BYyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16AA7C32781;
	Tue, 28 May 2024 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716855028;
	bh=zqCQMb/5/zaLMgTKGUA2fzUjXj58vovEe5sP4RrPq0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hxI4BYyoljCelInixMvrJKUUAm7QRubpoRdbx4ge0C6cFVPnH697k8VmPsNbmWykf
	 xRXTj9lfFlBeEG8wvUJqsQx9VkqUp3pCzJgY6qizcBimuFxoYu6w9gQs1Q5SArRFMa
	 lcgv+4sykZcaLmv3mxBN6zzY6JZaaCKFXxmFiFvZNPRZKEy6XIaHrxr6en36xV/neZ
	 cB5qmeBhMATYbUWQGIRw+4pR/XcQet3lraozsvbGXYfxL9kUfPmrYuZvuQ1MkyC8WH
	 9WeVeIClI6i1klCeGW7Q4O0gktSst253FvnMXj8ijqfUp07NQjqAAdYEpC43akLyUV
	 1c5KWukbxNxxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07CD7CF21F7;
	Tue, 28 May 2024 00:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: micrel: Fix lan8841_config_intr after getting out
 of sleep mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685502802.31992.3882528971800266097.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:10:28 +0000
References: <20240524085350.359812-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240524085350.359812-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sumang@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 May 2024 10:53:50 +0200 you wrote:
> When the interrupt is enabled, the function lan8841_config_intr tries to
> clear any pending interrupts by reading the interrupt status, then
> checks the return value for errors and then continue to enable the
> interrupt. It has been seen that once the system gets out of sleep mode,
> the interrupt status has the value 0x400 meaning that the PHY detected
> that the link was in low power. That is correct value but the problem is
> that the check is wrong.  We try to check for errors but we return an
> error also in this case which is not an error. Therefore fix this by
> returning only when there is an error.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: micrel: Fix lan8841_config_intr after getting out of sleep mode
    https://git.kernel.org/netdev/net/c/4fb679040d9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



