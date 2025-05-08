Return-Path: <netdev+bounces-188855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C9EAAF131
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777994C5B2F
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C61D8E07;
	Thu,  8 May 2025 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC/vVkwj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553C2CA9;
	Thu,  8 May 2025 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746672005; cv=none; b=FGZhQIRSkWK4IZ84P5IBtHl8UM+YYinp0TOdGmfGQldWePNns5np7b3rTB2diLjepWIi7+9VqCuKrUpYgMzSvkGb8gA1bGDQDlWHA4xhZ+reifhMWiIHiWg/6KiTWl/AtVr/lz6K7O0G4ysA+aPeIvEKxyiCd8Vt7DGkTrg5gDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746672005; c=relaxed/simple;
	bh=PPsSM14gHTW97fJBqtwnlogegPfFs55g12PqrVl+Eho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BBXh7sZiPwvLQs+UDs/UqIAaC1fdzoa4DM3c1mKFsN9tfPYfxSsq6sjCfr1xir2TzXR9q4+XxKYSychzgYUMlng2inQRmKaxpn3TXzzTf88MFzBRK+WH4u9QMI4K27GLjZzRlRG0K8Uep3q51Y1I7qwmXrrDkhQltcwm02gk5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC/vVkwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C30C4CEE2;
	Thu,  8 May 2025 02:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746672004;
	bh=PPsSM14gHTW97fJBqtwnlogegPfFs55g12PqrVl+Eho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AC/vVkwjFGcdbSI4+CeK7CpuwM5EqAyltxacJpTRwO3312wwVsCGl5zqi/POjiypU
	 LKXPYYXcnJzJb8o98Pq2+pXBByOBITWt4fWVnBwy/pwnl6utFTjh+i4seOdEbbZbZq
	 7i8KJpKVXqr1AwJiVish5Tfl4sLpzJBjL42vSrpYe45F9F0QJZuz/3aBrxHkEP/sh2
	 omW52qKiWUL0u+C1j1Hg+gX4aPlcOaJPqLTggRhNCLT+bblbUcphodLXIc2aJt1J3s
	 3wRk6B6iUKc6nDoh39PPexAtBVtCbNo136CbkzjLYzESUti4Fti3CADCw9au0KsMaH
	 vkA/8jjr9Npgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC0B380AA70;
	Thu,  8 May 2025 02:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/11] net: dsa: b53: accumulated fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174667204220.2431099.5916949487538340315.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 02:40:42 +0000
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
In-Reply-To: <20250429201710.330937-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, kurt@linutronix.de, f.fainelli@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Apr 2025 22:16:59 +0200 you wrote:
> This patchset aims at fixing most issues observed while running the
> vlan_unaware_bridge, vlan_aware_bridge and local_termination selftests.
> 
> Most tests succeed with these patches on BCM53115, connected to a
> BCM6368.
> 
> It took me a while to figure out that a lot of tests will fail if all
> ports have the same MAC address, as the switches drop any frames with
> DA == SA. Luckily BCM63XX boards often have enough MACs allocated for
> all ports, so I just needed to assign them.
> 
> [...]

Here is the summary with links:
  - [net,01/11] net: dsa: b53: allow leaky reserved multicast
    https://git.kernel.org/netdev/net/c/5f93185a757f
  - [net,02/11] net: dsa: b53: keep CPU port always tagged again
    https://git.kernel.org/netdev/net/c/425f11d4cc9b
  - [net,03/11] net: dsa: b53: fix clearing PVID of a port
    https://git.kernel.org/netdev/net/c/f48085198104
  - [net,04/11] net: dsa: b53: fix flushing old pvid VLAN on pvid change
    https://git.kernel.org/netdev/net/c/083c6b28c0cb
  - [net,05/11] net: dsa: b53: fix VLAN ID for untagged vlan on bridge leave
    https://git.kernel.org/netdev/net/c/a1c1901c5cc8
  - [net,06/11] net: dsa: b53: always rejoin default untagged VLAN on bridge leave
    https://git.kernel.org/netdev/net/c/13b152ae4049
  - [net,07/11] net: dsa: b53: do not allow to configure VLAN 0
    https://git.kernel.org/netdev/net/c/45e9d59d3950
  - [net,08/11] net: dsa: b53: do not program vlans when vlan filtering is off
    https://git.kernel.org/netdev/net/c/f089652b6b16
  - [net,09/11] net: dsa: b53: fix toggling vlan_filtering
    https://git.kernel.org/netdev/net/c/2dc2bd571115
  - [net,10/11] net: dsa: b53: fix learning on VLAN unaware bridges
    https://git.kernel.org/netdev/net/c/9f34ad89bcf0
  - [net,11/11] net: dsa: b53: do not set learning and unicast/multicast on up
    https://git.kernel.org/netdev/net/c/2e7179c628d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



