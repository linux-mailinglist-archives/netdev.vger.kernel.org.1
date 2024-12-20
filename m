Return-Path: <netdev+bounces-153572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527EF9F8A9A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7DA1888D7A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7A91925AC;
	Fri, 20 Dec 2024 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4dNOESB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435818A6DE;
	Fri, 20 Dec 2024 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665421; cv=none; b=fnUBIJ4LYDocXYFKmnA3mVTT72YJNGOgl9zu3opZaAs7uXgWWzxCRC1UsRlpuSywArP1PZ4M5S71SaHGpd46Iv0OKaaq5c4M0QXOh+3MEVOZLLm+JHWLkVSOZKYLllXP3FZqcSRPE7H8EflHmGr82fyDKMsWjx9yFYGnwmgc3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665421; c=relaxed/simple;
	bh=YM6IcQzvMh0nBVLALsAQctJoSxEV75NUYhaBmFHz60s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ewNMawxGbN3+fhvG+kLHLpovY08qsEIH3ob6q7keK+1jEiMeVaTMw6H97UrFUffLhiHjTnr4r10h9pAA16QjXPo99zlLEmcaR0zASAlCu6jCQTzBXAYNsMAMHQyzwz1RQ3th45gJnygIaIp26/ijJMjpDNBSGwPUBQZIOBt6B88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4dNOESB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF1DC4CECE;
	Fri, 20 Dec 2024 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734665417;
	bh=YM6IcQzvMh0nBVLALsAQctJoSxEV75NUYhaBmFHz60s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q4dNOESBlhZ+2RJ/IQZ38XF9PvrHb4IidwHQR6RZyr1gnbyWj6mGf0AvB/FYv8Uq8
	 IfnSileWj1bYPN5X4mWBiocbLggz4X0IJ3c+pGexAl12E7XsbxvmM58dRpWv4VE0Wp
	 KOZtXG3qWIu46FRK+2rTj2YqLg2kor+7EdU3jebgWxjqdjVg04BJLK1A1h2JOODBLR
	 w+3NiloaUsLwly8dRbENkPp5gc+sv7JJQbK7ZZfyd8HUB2H5yceMm+taXiSmbj/VdW
	 exmcQj6xlGedPElRr1VuVlKA3h/xxVGEoV2Iwms0SC34kp0Ax3hSdM74iuhfPJsHPW
	 r5u8ED7b7fzlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE053806656;
	Fri, 20 Dec 2024 03:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: stmmac: Drop useless code related to ethtool
 rx-copybreak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466543521.2462446.17820764757552771854.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 03:30:35 +0000
References: <20241218083407.390509-1-0x1207@gmail.com>
In-Reply-To: <20241218083407.390509-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 xfr@outlook.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Dec 2024 16:34:07 +0800 you wrote:
> After commit 2af6106ae949 ("net: stmmac: Introducing support for Page
> Pool"), the driver always copies frames to get a better performance,
> zero-copy for RX frames is no more, then these code turned to be
> useless and users of ethtool may get confused about the unhandled
> rx-copybreak parameter.
> 
> This patch mostly reverts
> commit 22ad38381547 ("stmmac: do not perform zero-copy for rx frames")
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: stmmac: Drop useless code related to ethtool rx-copybreak
    https://git.kernel.org/netdev/net-next/c/5c98e89d96ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



