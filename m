Return-Path: <netdev+bounces-242145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CADC4C8CBC4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8C8434922E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93082C21DF;
	Thu, 27 Nov 2025 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl8o45BC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845DD28D83D
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213447; cv=none; b=ukMjVwo+4x1CfKC5d+Nj/kgMTiXncj9Ofjhe60wfrW46a1I6ek1sJeIY0DmsPjW9Xgik3Xspb2u9qD54XoH3fyYV83L9cOB9Uv0xri4//g7cm42WzplgYTejJyppahn0djlWv7KQUfHXW2McS/bqtJTZ3keENi30NeRhq+hWbqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213447; c=relaxed/simple;
	bh=vMXYjrTYYguhg1jhviJ59uVBv3xB417FrFbbs34X1gU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HB0/hw62HgUdDkN/stB2b1X/07lEp+Gpm9Cp3MlPitnnd/LcujjhEy5gOI7DAf8ZhAZCPyrG+YPN5Oiuq2kVbflS4hwjLrvGUhfcAEkHWuYK+A9FPizExN7AoTXRJBBM8LeFPnLLNJVOmymSI6fUYpbDvKne6E7aK7l124YsUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl8o45BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11575C4CEF8;
	Thu, 27 Nov 2025 03:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213447;
	bh=vMXYjrTYYguhg1jhviJ59uVBv3xB417FrFbbs34X1gU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sl8o45BCPiloROJ8MD/OWX4VoSQfFGXHa6DXsejLWxMulxZVV1xGzUZqNu2DT0L9e
	 ApFOqcMFjy01jmcSVBg2dsXVz8F+2JjyA+uuVqPo7Lz6jl3IkU+NiPz6TwmFvCD5Au
	 ZPI1c+1h2J6duYWcHYZ149vWqQ39blEIe250d2VtdK0fPRWBS0Y4iDKjsGuM2t14W7
	 SxYO+zdNLicAIGKccHuOHNSKVl+OFujYpEHE9ekrdtU/l/JJN1VR9DDDUzsDThxGYP
	 q0geB+Fn+E6l/+jNWmO7aOQtcB5g4hetyeWRcBXu6Z5kMt5oRHa7dETqQ1YtNRKgbF
	 iozX0NtAlcVXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEEA380CEF8;
	Thu, 27 Nov 2025 03:16:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] amd-xgbe: let the MAC manage PHY PM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421340850.1916399.10823527911929795737.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 03:16:48 +0000
References: <20251123163721.442162-1-Raju.Rangoju@amd.com>
In-Reply-To: <20251123163721.442162-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 Shyam-sundar.S-k@amd.com, maxime.chevallier@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 23 Nov 2025 22:07:21 +0530 you wrote:
> Use the MAC managed PM flag to indicate that MAC driver takes care of
> suspending/resuming the PHY, and reset it when the device is brought up.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> Changes since v1:
>  - remove the first call to xgbe_phy_reset() in .ndo_open
> 
> [...]

Here is the summary with links:
  - [net-next,v2] amd-xgbe: let the MAC manage PHY PM
    https://git.kernel.org/netdev/net-next/c/f93505f35745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



