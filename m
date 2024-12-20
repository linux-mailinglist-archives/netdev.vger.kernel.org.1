Return-Path: <netdev+bounces-153544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80589F8A03
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F73C16967C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D5134AB;
	Fri, 20 Dec 2024 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBElBz8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEE4F9EC;
	Fri, 20 Dec 2024 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734660615; cv=none; b=ZF8oZYQ7Iwf+obdnHsUvh6YDoBWSy0140N8IGhmmdW8izCRyHPLQ9jNQB+xL6sWvR6kGLuz5ZExxI3M8txWiGDf8un3UpEeSvNU3lC36u3+97YspV1MI/IH0mNuR/0B2Ct547q3YQV6mDrqWRmlAgfF/vwz0YSNDrBP/NL5rI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734660615; c=relaxed/simple;
	bh=YkVBLqkQKEF3SdpzsdqAY59bHoasxwoJLf6mM/7R4bA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pxFRan5fQuExB1er5bDGJflPcbEwmT0jrWf53ZhFoaSfApSLa+KmPRiAnKWySoghE7CpOwZbSpHsHioXZ3AmA790VcddvtW9ybEU9mkti8bBWmnld8mfinIhHVG4uJ4Cp4u/Z1admdWs9fi5FHBgZuVz/BZh/fEDxj6F/HCFEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBElBz8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9F0C4CECE;
	Fri, 20 Dec 2024 02:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734660614;
	bh=YkVBLqkQKEF3SdpzsdqAY59bHoasxwoJLf6mM/7R4bA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IBElBz8h81SavM1DO5+5bQIP0tsblA9dYVPhRhxFz73cBgatlX3Q7g4TIaJ2qSqMj
	 GE2eIIP/PV8l9kjoIpEWw+tXCoMO9A5SydgmRAsjgC+UMuYNFEpesdI/t6M4kkngYD
	 FIjyLHNsbHZLD55H7uvMkllN8l3dXNkyKWSXYBTOvCPpqZTI0MmFSwkKqeWiFih92S
	 P+QdGCuQcnOJfeT3eG9KLefx4xmOcwTGEz7LsQlsmuVs+wH62h0qKtO/HzHbEfQjwx
	 NfXK3GtoTm0QSgkmHW4fc7AYbpfonImP4/7dvh46edVsHRDNkWRXAa30lurqau9rho
	 DJQDN3SJCaMfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 956523806656;
	Fri, 20 Dec 2024 02:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: dsa: microchip: Fix set_ageing_time function for
 KSZ9477 and LAN937X switches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466063251.2449610.12849962822761975977.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 02:10:32 +0000
References: <20241218020224.70590-1-Tristram.Ha@microchip.com>
In-Reply-To: <20241218020224.70590-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, arun.ramadoss@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 18:02:22 -0800 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The aging count is not a simple number that is broken into two parts and
> programmed into 2 registers.  These patches correct the programming for
> KSZ9477 and LAN937X switches.
> 
> Tristram Ha (2):
>   net: dsa: microchip: Fix KSZ9477 set_ageing_time function
>   net: dsa: microchip: Fix LAN937X set_ageing_time function
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: dsa: microchip: Fix KSZ9477 set_ageing_time function
    https://git.kernel.org/netdev/net/c/262bfba8ab82
  - [net,2/2] net: dsa: microchip: Fix LAN937X set_ageing_time function
    https://git.kernel.org/netdev/net/c/bb9869043438

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



