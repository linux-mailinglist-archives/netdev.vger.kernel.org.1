Return-Path: <netdev+bounces-232087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B0C00AFC
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAFB3AE276
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4DC30DD17;
	Thu, 23 Oct 2025 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSQWYUo5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890B2D8781;
	Thu, 23 Oct 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218430; cv=none; b=lgOy/sOTHZnJPoSGW+CAyPqhRHWxdXh/7+7A3xkRgxcWjNv5xAE4EswYYAjUapyTaRv0rSY1rs7EAFO3WdgcRPOkDq0VyK4WozHdvxGwtoh3ntYBdUWZjzxuQFE9xfltUKfdSOxqdTQBQouARXG8s0Y6os3DlBvt7ls40Brdf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218430; c=relaxed/simple;
	bh=lxEnNfGnQfgWNlDnm2QLqOM40rMpnIu3LcDpDqs7Z0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N/Onxdlz/EAWwZVjesk2rAs6l2p4nK86uxhMI8kb6W6mY+9IbulVrOY/xCMGdd7LhobzuCybCBu88JARrgxDR0zCOZJcyZkIvh3BCs0oX6WybpHHHL45Zil3U6Hp4A7JTaUc1rt89MJdF7Lx9HlEYKo6W9gWrH5YMBETRj/NmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSQWYUo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F66C4CEE7;
	Thu, 23 Oct 2025 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761218429;
	bh=lxEnNfGnQfgWNlDnm2QLqOM40rMpnIu3LcDpDqs7Z0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TSQWYUo5eRtqK867mrGoiTiBO+Ux6QfTpY6Fx0S+Ca2/Z2wkXDaFxuE1J5ZluhkPp
	 bbzA2Q74IyDyV8G1HYUUxXR9i7OkJf8Vfc9fd1ICQfO6jIIXmwQ4TpLfy/JgzarjyX
	 k+R5a+iUBNTAe1ak21yj/F/F8Cdro8MSlpC4p60RrwIbkSinFu9/TJxRgAeoy4gOew
	 R3lWQliBrQno7POLkKTQmtIuhEUjIpkJvM9GMrl4+myvIky83UOnsqBFrQhfWD7mnR
	 eX29RygfIMtT8bZYP/T+MJ3ahmxhkxjoMccdlYMdSnV9sni1S/Su6pEEUmkADD8Qt0
	 RJ1KzufJ3CHbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D523809A31;
	Thu, 23 Oct 2025 11:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: micrel: Add support for non PTP
 SKUs
 for lan8814
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176121840999.3001126.509044902185617300.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 11:20:09 +0000
References: <20251021070726.3690685-1-horatiu.vultur@microchip.com>
In-Reply-To: <20251021070726.3690685-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, gerhard@engleder-embedded.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Oct 2025 09:07:26 +0200 you wrote:
> The lan8814 has 4 different SKUs and for 2 of these SKUs the PTP is
> disabled. All these SKUs have the same value in the register 2 and 3.
> Meaning that we can't differentiate them based on device id, therefore
> check the SKU register and based on this allow or not to create a PTP
> device.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: micrel: Add support for non PTP SKUs for lan8814
    https://git.kernel.org/netdev/net-next/c/61b7ade9ba8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



