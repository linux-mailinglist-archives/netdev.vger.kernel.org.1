Return-Path: <netdev+bounces-249696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D68FD1C339
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97631301701E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839C3328B52;
	Wed, 14 Jan 2026 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIvtRMo8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C732860E
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359852; cv=none; b=uWdLiPSL/iD+XiglB+SpSoW6gsGbZeeHJxS8e0tvP6krYWfsuJW49SOUtxhk+ZeO1y1wiUAGaCfBTHq+8CdiNZQ/5gaB7ZPOAt5re5ETLJLj8bmd6prHhawnomEy6vOQdqXuFbetSPV0C3W4QGcGZHF2dVWNoqsM9iM/zmYNb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359852; c=relaxed/simple;
	bh=Kbg2UfBZe+Dnuhcv+TSuqXSdHx7AwCP0+RqI1vauAEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FnrxkK+sRG26ne7LHXK0M/Q10Qp/iqKoqFD6wh1KflpVY37POuc0bsZxFoXroVRjyf1tQlEhfxuIRygpLdNeBG2TClggKU++iys8GIeal3ATFjlpa/Khu08cfmNLD7Y2solklkNLYKNEnc8Xjow4fSo4oEFo2b68aPll58uGMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIvtRMo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA3BC116C6;
	Wed, 14 Jan 2026 03:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768359852;
	bh=Kbg2UfBZe+Dnuhcv+TSuqXSdHx7AwCP0+RqI1vauAEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CIvtRMo8x0Y2S0dSyi9Jyla2PVx7HQLiIhyvHIdQS0P4uNkDIoWnyk+iPXSqd/wP9
	 w7TiFStmiWZmQVaKVSQjeWelp7hFh6npezmjrWAHniuT0+JflSFGm6ZOh/XRTRH9Pu
	 HhVhMyIu6nwN6Qd+rhs2XbKsc90aYlO5JehHwYdJdeeaXONOqxMcci8cCxdClZIWQq
	 Zky5JtCfAI+lPMY+vx0sMQNCQbUPXqQhsVRGbGUAe71tW0mvtEtf3VgGpq/10Nf6JD
	 l1CSTwk/j9RWZn7bElNYln4mNcwGuY21qlYAEk1Yl7nr6O49i3QxsiCMjDJQQi27aK
	 5ll0EnbsyESUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7893F3808200;
	Wed, 14 Jan 2026 03:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: phy: fixed_phy: replace list of
 fixed
 PHYs with static array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176835964527.2565069.11980457625816390405.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:00:45 +0000
References: <110f676d-727c-4575-abe4-e383f98fc38f@gmail.com>
In-Reply-To: <110f676d-727c-4575-abe4-e383f98fc38f@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Jan 2026 13:40:30 +0100 you wrote:
> Due to max 32 PHY addresses being available per mii bus, using a list
> can't support more fixed PHY's. And there's no known use case for as
> much as 32 fixed PHY's on a system. 8 should be plenty of fixed PHY's,
> so use an array of that size instead of a list. This allows to
> significantly reduce the code size and complexity.
> In addition replace heavy-weight IDA with a simple bitmap.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: fixed_phy: replace list of fixed PHYs with static array
    https://git.kernel.org/netdev/net-next/c/511cb4526022
  - [net-next,v2,2/2] net: phy: fixed_phy: replace IDA with a bitmap
    https://git.kernel.org/netdev/net-next/c/ca8934f80c4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



