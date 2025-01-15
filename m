Return-Path: <netdev+bounces-158668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135A0A12E9C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D31163635
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3751DDA31;
	Wed, 15 Jan 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjDkVlD+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469F1DD9AB;
	Wed, 15 Jan 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981412; cv=none; b=dcJ/vSobAyDftJJcisYcTqJNzlurzwqu8SG8J3WW2g1y+4Y+jApxzS2Jv4S+LyyIVWPwagjYZFQh1kUsw4QF6IYO4kKUHqhbqG7h9dDrcq/saIOPZJLqATya6B4nNrybnBFPEJAF0BgTF2QjNrw7AAEDz/aBzcz8T7pA1BKachg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981412; c=relaxed/simple;
	bh=V7HfILfKHrG++xGqo9/hAILN9a9av4lFR6UkNoZVYvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KJy2OwunepgB5GtDrTbEUwMLTsUolKuR9RKQxlVWC2MpKOYkdQhBOpi7utAhFBVPl1z+GJ1Ga6+T3IwWdIS3Naht7rGRwjtYr0i5ijh0xQKmNBKNCB/9nicu7YdRST26i/UeRv9otgqmP3q121L47zeupTzuOcY6ZN99f9EZ0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjDkVlD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4618BC4CEE1;
	Wed, 15 Jan 2025 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736981412;
	bh=V7HfILfKHrG++xGqo9/hAILN9a9av4lFR6UkNoZVYvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KjDkVlD+R8yfGwzqUVVKh5etq4lUwj0j/zsX9clvGrp64ZE4NYKJJvXRT3YIwYZjs
	 MZ/Z5g0/bRxMcfkap6mP112qKAWOWRDVRyCNtETDvhDWTF7uS1Zdrmumdu225oA0GP
	 XeYZWUUABWVhhxQxCvHIh2qA+IEyGZAzusXUapgw4l2iJEAOx4H+vUM3soDzSm8wfs
	 i5UkaQY4D2acsJVLgFjCMue866K8prGNANjI300Ow6G1xd9FEu/pwZnnZjarscTrYL
	 xjYVS7TM7R2ip8ZonHyVAnqpgKUUhp4hU+WO9FnShlubMf9S88giKR9pWzIEumTdvk
	 QunEwYhhBDB6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B5C380AA5F;
	Wed, 15 Jan 2025 22:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: lan969x: add FDMA support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173698143504.903583.7524014147804199820.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 22:50:35 +0000
References: <20250113-sparx5-lan969x-switch-driver-5-v2-0-c468f02fd623@microchip.com>
In-Reply-To: <20250113-sparx5-lan969x-switch-driver-5-v2-0-c468f02fd623@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com,
 jensemil.schulzostergaard@microchip.com, horatiu.vultur@microchip.com,
 jacob.e.keller@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 20:36:04 +0100 you wrote:
> == Description:
> 
> This series is the last of a multi-part series, that prepares and adds
> support for the new lan969x switch driver.
> 
> The upstreaming efforts has been split into multiple series:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: sparx5: enable FDMA on lan969x
    https://git.kernel.org/netdev/net-next/c/4a7d78c27806
  - [net-next,v2,2/5] net: sparx5: split sparx5_fdma_{start(),stop()}
    https://git.kernel.org/netdev/net-next/c/b91dcb237c69
  - [net-next,v2,3/5] net: sparx5: activate FDMA tx in start()
    https://git.kernel.org/netdev/net-next/c/cded2e0f1b0d
  - [net-next,v2,4/5] net: sparx5: ops out certain FDMA functions
    https://git.kernel.org/netdev/net-next/c/56143c52a342
  - [net-next,v2,5/5] net: lan969x: add FDMA implementation
    https://git.kernel.org/netdev/net-next/c/d84ad2c0d80c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



