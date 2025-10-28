Return-Path: <netdev+bounces-233360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17169C127FB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A942424383
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4891F3BAC;
	Tue, 28 Oct 2025 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s05qiSZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E91F12E0;
	Tue, 28 Oct 2025 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761613839; cv=none; b=V3QRv3QBktR6BeR45Dkp3K5/c0SlEXkNc1srV/WhvuWjLkKUuM72wMeDdZg0N4miAE6FaDZBkdaXSb4x4c+APqc6a/6cyE/bydHDOjdr+q0/zwDtQUSvHgO+tGvTzoPV0RYlBT4f2bc0bsYGrsUWhdG+r7FKQIeASSrN6QU6nVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761613839; c=relaxed/simple;
	bh=wTV5LDI25G/qOe4mU3aDrJc1TjFLCz3MBAXCNjC/cAE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s4CKC2ZgyCSUvfd6r6BTUBoeOOXqkPza8/K0V1Eyqr0gI/MUBz55la7qc02HzNs8PPgmV8DIpOQS8ApQ2Eu/1KHmqVtKPwcrB3JYo+QjJWZVMhgs3IuKM5vT37S3tA10CjeV05KQnpYuDsyoSxhl06JpnmfiKXWUM2aClVJ9g7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s05qiSZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8D9C4CEFB;
	Tue, 28 Oct 2025 01:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761613838;
	bh=wTV5LDI25G/qOe4mU3aDrJc1TjFLCz3MBAXCNjC/cAE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s05qiSZB/DkMH1OWlzi7icdhAlLtrGroTmZMwEAVW+9VpenDhqxWhUxKGoULRL6aV
	 0kRA9MM7AbZ4vVcUFIQB+aJbkZlPisHwro0xyifuMkQxZapRk9DlWuOhvomHzu3LE0
	 IXx0j/NjlORMzmQaqEhSyJwKnhkydsW+o1valbBHS1LzqKii4Bt1eEfFkzOHBbe2LC
	 14xMHC0rk3x3NOgnEOIa65uVrTkCM+vxXlSvFS3stD2XHxYUey7SFkUgFRSKGey1/5
	 PSj+33VvlfYGMqbwUnxHflDesc6yfmW/lcwR4utaY7c28kOL7kUeUt+IW6RBRf81Vv
	 0r5EUzYixZ/Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1439D60B9;
	Tue, 28 Oct 2025 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] phy: mscc: Fix PTP for VSC8574 and
 VSC8572
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161381649.1648894.16458180647023888621.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:10:16 +0000
References: <20251023191350.190940-1-horatiu.vultur@microchip.com>
In-Reply-To: <20251023191350.190940-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vladimir.oltean@nxp.com, vadim.fedorenko@linux.dev,
 rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com, rosenp@gmail.com,
 christophe.jaillet@wanadoo.fr, steen.hegelund@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 21:13:48 +0200 you wrote:
> The first patch will update the PHYs VSC8584, VSC8582, VSC8575 and VSC856X
> to use PHY_ID_MATCH_EXACT because only rev B exists for these PHYs.
> But for the PHYs VSC8574 and VSC8572 exists rev A, B, C, D and E.
> This is just a preparation for the second patch to allow the VSC8574 and
> VSC8572 to use the function vsc8584_probe().
> 
> We want to use vsc8584_probe() for VSC8574 and VSC8572 because this
> function does the correct PTP initialization. This change is in the second
> patch.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] phy: mscc: Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575, VSC856X
    https://git.kernel.org/netdev/net-next/c/1bc80d673087
  - [net-next,v5,2/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
    https://git.kernel.org/netdev/net-next/c/ea5df88aeca1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



