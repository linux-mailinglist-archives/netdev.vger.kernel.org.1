Return-Path: <netdev+bounces-85766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F7689C09E
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E1B1C219F3
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE937317D;
	Mon,  8 Apr 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQd0QZKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D743F6FE1A;
	Mon,  8 Apr 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581829; cv=none; b=rys/pTlNoazwiCrQb5/HzG7gktT/Isksgp3ixFsMHGEhiw21+r5C4Dxhem8ZUa6nktrn4uHdQMhc+tCvXYV8Np8gapLqynvNkkXlvcKyauEMlH6GX6H+nQ5SV77kLtNyemxWa9L0FkbMypmfDHNdrDR61kWN3l48LvtXs5u2Kgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581829; c=relaxed/simple;
	bh=v5Ep9zo6Dq8585fgTSkLPNkf+pZeh7PxQArIvet9I7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PHPJWWKbXvWrVPag2jqT6TpjniBwyKaCHIHckbbFKOwxwwNSUesLIAFnkEjp7PldJDSxkDAW5TiClcQDLNkuEpSVbHJi9JJ6IoY2Jg/wU98en8StZbpp1PXrB12NJIWZeXmxwweeErO1ksB8e3JwCli/7poRCIT5StjFIfUOEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQd0QZKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98E38C43399;
	Mon,  8 Apr 2024 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712581829;
	bh=v5Ep9zo6Dq8585fgTSkLPNkf+pZeh7PxQArIvet9I7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KQd0QZKHsNVrKSIhP7SDlx5MmQKUe6lxIg8uioQsD6vwN3ZuBSKsNRNih49sE4X3i
	 5oZ7u3V+xPJnz99zFDjkLJZdWx4sn6h+fLdk4e+1tbXOxcmWVdw1hpv7Yj0+43s8MT
	 SsiTANLH0fv5VH73Fxo1N+XL1H7eIPrbvEbr3JlS3tDoFmZe0xlK5cC22s57HCMxpF
	 ylxXtMvU2wlPSYVC2V7ugqVE4Rmc+K09sUp90K7OZ1NLYlUB/kRnN6X3GLjrJI5q6A
	 Uzev5/ydYSQztAxjX1eThMXsUlOSVYj9vnOao4+dJG8zsaH7z+nYqHFb5KfLZs0JRu
	 tsnSGQfOSdpwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85EFED72A01;
	Mon,  8 Apr 2024 13:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: Clean up some EEE code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171258182953.9669.9318679186074931102.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 13:10:29 +0000
References: <20240406-lan78xx-eee-v1-0-2993b14b849c@lunn.ch>
In-Reply-To: <20240406-lan78xx-eee-v1-0-2993b14b849c@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bryan.whitehead@microchip.com, hkallweit1@gmail.com, o.rempel@pengutronix.de,
 rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 06 Apr 2024 15:15:58 -0500 you wrote:
> Previous patches have reworked the API between phylib and MAC drivers
> with respect to EEE, pushing most of the work into phylib. These two
> patches rework two drivers to make use of the new API, and fix their
> EEE implementation, so that EEE is configured in the MAC based on what
> is actually negotiated during autoneg.
> 
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: usb: lan78xx: Fixup EEE
    https://git.kernel.org/netdev/net-next/c/a00bbd15a5af
  - [net-next,2/2] net: lan743x: Fixup EEE
    https://git.kernel.org/netdev/net-next/c/ef460a8986fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



