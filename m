Return-Path: <netdev+bounces-156662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8010AA07484
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2803C3A41C4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445472165EE;
	Thu,  9 Jan 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4msATGP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A6DDDC;
	Thu,  9 Jan 2025 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421610; cv=none; b=cld9zM+1/hJGvegS/y33L3iwA/DBQ2EY52A3pOfhLD1nQDK89MBwtfwZQmDpr8znPIQCWW0yF2UysXy1Lsj4uG6uG2G2X/PEm5PtpbU7q+X/VrXYFTON0P4qtSBRD073laUP0yah2P/2xOfDlhU9Khf+rXyRlIsbVfdlGbJpBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421610; c=relaxed/simple;
	bh=1+uVbB8YTOqsluR25SXjrfcOS+SdHfqDiqn5pXsqIyQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a+JRw8SPF65mqVOtg1HfmsQJCEkcw5/NnV0H80fE2AgVED0os7sMD3orDm8k7x9i6ol7351OXHq2GrZCa5jaehxOfwRD5crAbUw89XPECTHvN6vjUYBEUiLfhUsgjOCDibnjcR2YFo4ex8OqsBU9sqbCY7JgWXhaYFjzC+7lwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4msATGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB56C4CED2;
	Thu,  9 Jan 2025 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736421609;
	bh=1+uVbB8YTOqsluR25SXjrfcOS+SdHfqDiqn5pXsqIyQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m4msATGPnS6sQKsZ9Rg60S69s3I/DfEk90I/oRZvnOP8hBuT3IJaz/6Y2P1qJXKSJ
	 3YMQhu4GdkvPwMtQ5Q1sikGMsenlOq4/XTeZevbCKRzpgO2rP+XAF5rxRjRqmjjkMM
	 QRBEYf5xph516Fn8/ycWklBIP2BAjSoWFKF+zI+kGKwkmbl0LA2zGmjoof6j3uHeqV
	 6WBL1ojwjOrF2KB5feG6vEMdnKTUwD9uMeEJslN7+MbojXLiBOQJutUMYmaxvYwtTz
	 ariwDAvwoBPcEnUThOUN2shIVBK7+U41DvVsrHw5f7BOC5LrdFjyt1D9SN1tR9pz4w
	 uTqTIHu/hTgRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D173805DB2;
	Thu,  9 Jan 2025 11:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: Unexport stmmac_rx_offset() from
 stmmac.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173642163126.1285771.10043021879258168083.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 11:20:31 +0000
References: <20250107075448.4039925-1-0x1207@gmail.com>
In-Reply-To: <20250107075448.4039925-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, xfr@outlook.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jan 2025 15:54:48 +0800 you wrote:
> stmmac_rx_offset() is referenced in stmmac_main.c only,
> let's move it to stmmac_main.c.
> 
> Drop the inline keyword by the way, it is better to let the compiler
> to decide.
> 
> Compile tested only.
> No functional change intended.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: Unexport stmmac_rx_offset() from stmmac.h
    https://git.kernel.org/netdev/net-next/c/e62de01008bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



