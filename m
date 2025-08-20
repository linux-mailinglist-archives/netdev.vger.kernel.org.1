Return-Path: <netdev+bounces-215138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F65B2D267
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B86AA4E38E0
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572C22D3ED2;
	Wed, 20 Aug 2025 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv4XQRqH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE322D3ED1;
	Wed, 20 Aug 2025 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659507; cv=none; b=IYJjPITiVOJTeEBNJvbFLo4S7nTT3/Tu3Sc0F72sOrA9aA1omTJdshDQjm0ImhwQKZSL5bHL4EjMI3jiRbwySVPOHzZSslDFH9ncuLRGy4f3/UHBhTK2AmShhsKsOND9xRWY+DVGbLbVq4T2zWXeBZGkIDxKgzT8UAcWMtfpN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659507; c=relaxed/simple;
	bh=Wpuq8PHBzi6ztnD4h/ECXT0EObBnUmUFOmFgs6RT+sA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PINbrJ/rYgRRQnvVL/jrdGuxNerilURjcgB6Cg3UFYfkAe3PGjjjeALJAfMwXSicQwQOvuaecxmh3vJDj8O/cAKiUhGgOgfBMcILegTVUroWwoap42Hp8BK2QzE7JrnzQqktjoNqnLqjvUH6q7N9CPvSKSYEUuoSi9C3iCgeCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv4XQRqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B4AC4CEF1;
	Wed, 20 Aug 2025 03:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659506;
	bh=Wpuq8PHBzi6ztnD4h/ECXT0EObBnUmUFOmFgs6RT+sA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wv4XQRqHdkL+E1B9HhzQaljS8aZjmWuCj/NwvCKD4VN/EU+AeDydeQFjSNMRS62bu
	 FlW4ucfbzdblCwqE76plgLjb5cIgKIV8feLgnUKAhFi5vdtTNMQ0Mi2NTMHBTILjbl
	 ZSJrkHgUhaykcO2VOQoE+zVfeQ3D2pir2n3dE9vDZ8J5Vf2PWKpnS5A2+3DZqibDKw
	 r/G0mnKWkHoeral5qf6bKsqMBAdnOTh0XI8lO7UehJLHSp+T9PpMsSz/XS7TSgmnq/
	 5m3/r/p18aeAHK5/nSYLRM7RJaPoTW25cXbg8GwlS/wt4bkey8Vuz2rJEGFUJBwuhg
	 1M3mwYoTBrkJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE541383BF58;
	Wed, 20 Aug 2025 03:11:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/3] stmmac: stop silently dropping bad
 checksum
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565951624.3753798.940710091571028774.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:56 +0000
References: <20250818090217.2789521-1-o.rempel@pengutronix.de>
In-Reply-To: <20250818090217.2789521-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew+netdev@lunn.ch, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 rmk+kernel@armlinux.org.uk, san@skov.dk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 11:02:14 +0200 you wrote:
> Hi all,
> 
> this series reworks how stmmac handles receive checksum offload
> (CoE) errors on dwmac4.
> 
> At present, when CoE is enabled, the hardware silently discards any
> frame that fails checksum validation. These packets never reach the
> driver and are not accounted in the generic drop statistics. They are
> only visible in the stmmac-specific counters as "payload error" or
> "header error" packets, which makes it harder to debug or monitor
> network issues.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/3] net: stmmac: Correctly handle Rx checksum offload errors
    https://git.kernel.org/netdev/net-next/c/ee0aace5f844
  - [net-next,v1,2/3] net: stmmac: dwmac4: report Rx checksum errors in status
    https://git.kernel.org/netdev/net-next/c/644b8437ccef
  - [net-next,v1,3/3] net: stmmac: dwmac4: stop hardware from dropping checksum-error packets
    https://git.kernel.org/netdev/net-next/c/fe4042797651

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



