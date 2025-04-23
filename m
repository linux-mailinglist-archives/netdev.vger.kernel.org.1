Return-Path: <netdev+bounces-184940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B291A97C1A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B2B17E2A8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D438125D53E;
	Wed, 23 Apr 2025 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNHgy3Ai"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAABD1A23BE;
	Wed, 23 Apr 2025 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745371791; cv=none; b=Je0rhwcyiBrqLEIqyzZr9yQstXSoRhZseN4QUw8j38TO32gdMDAhjjZDFWjR7jqLB2Hincd01NH8JL9y3PC9UDgj5bWtEzDeTuXIPNCbnwDNbG9WDstIylgPNhANcaXEcY8huhHpcDVGq5Yrd9k2KxnCD2VbbFxcJcBeiTcpP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745371791; c=relaxed/simple;
	bh=Gevgh82HxT5cgQiOLTNIo9KgIKveEH4Cs3+gRb6Ds1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R/Tz4dzvddyn9TueZ1fyVjsBdRdEsV4yF+gb1b1XigEuckXMRFyWLCRzlilbe5S1uUJyZbuTtNYoyFDx8iVpQyycu8reJ9h29YSOrPXrpfT2ArJcmPypVvKt291QaTtyE0kcTmAnx/HXI12S5zmo79WJpBGl+eADYB40baFxTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNHgy3Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED77FC4CEE9;
	Wed, 23 Apr 2025 01:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745371791;
	bh=Gevgh82HxT5cgQiOLTNIo9KgIKveEH4Cs3+gRb6Ds1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nNHgy3AiKbv8wcZPEZW3KBW/5mPh8iihtY9t9bC5gBx0CzxrpCdqDkrHq1xBOw7z0
	 tJvF8t0N9DITn+HJsXvkBRcBi887jrBfzewRxaWjrhxasBeWm6RN6ocHzEtGQSpEGr
	 WzIhGCaV5xYq1EBZu6EJBn7bT69zHw4Sn4rgZqgIqNUu2DxezIXuIDc3tTutkMZZg4
	 4kMpKYgMyOXCiwP/I261BeOyWkso45Y6zn2mY/qR+KWuTnWy31X/uoul8cQGFHYzkr
	 EcT+tB20BjT1Z4m58Td0ScGM35z27uEARVHeThDTxA8uP8RF5g2JPRUwmDT3xD8y4Z
	 pxDlOH7/Cwkig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4F380CEF4;
	Wed, 23 Apr 2025 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: leds: fix memory leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537182950.2107432.13440582690052227566.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 01:30:29 +0000
References: <20250417032557.2929427-1-dqfext@gmail.com>
In-Reply-To: <20250417032557.2929427-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mail@maciej.szmigiero.name, nathan.sullivan@ni.com, josh.cartwright@ni.com,
 zach.brown@ni.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gch981213@gmail.com, qingfang.deng@siflower.com.cn, hao.guan@siflower.com.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 11:25:56 +0800 you wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> A network restart test on a router led to an out-of-memory condition,
> which was traced to a memory leak in the PHY LED trigger code.
> 
> The root cause is misuse of the devm API. The registration function
> (phy_led_triggers_register) is called from phy_attach_direct, not
> phy_probe, and the unregister function (phy_led_triggers_unregister)
> is called from phy_detach, not phy_remove. This means the register and
> unregister functions can be called multiple times for the same PHY
> device, but devm-allocated memory is not freed until the driver is
> unbound.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: leds: fix memory leak
    https://git.kernel.org/netdev/net/c/b7f0ee992adf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



