Return-Path: <netdev+bounces-248060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAC7D02E04
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77D0C30F8DFA
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55F43CEC5;
	Thu,  8 Jan 2026 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npg7NrrP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D963ECBF7;
	Thu,  8 Jan 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874421; cv=none; b=YEzCPgiuoHZdpMS7SMOTNuSK7HkP6UaVfLdCjk1Fun38I6+BKV2TgeYfbPRAj9kgs5yv6TyVhbHmTWloByYzTabDV7Oaw8FPG7QVDLMRJ1SV/vHQie4XAnOYj1KMNQArZw7LOT3g0vbSHesT1svOUaOX5yD52+KwAjtDA/3vQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874421; c=relaxed/simple;
	bh=QX2pHvLWaI9I6erHYoTw77OHTkZYe+7AuH/zYkt0H7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aG68i/rEfmrDzGzXHpM9I7frgNm5zWpzDZewOO80lcWUaaUjEcmWzRywBRD1PGNTLXAn2KhCgsSZuZyErr6quEIwEdpFK3j+UqhkQytEDVk2dFA3/4JiQ7cw5oZrh8s/jX5Wl9BumCPIiNFtR4VnK1BvdoBrDRARtU9xt0W08tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npg7NrrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAEAC116C6;
	Thu,  8 Jan 2026 12:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767874420;
	bh=QX2pHvLWaI9I6erHYoTw77OHTkZYe+7AuH/zYkt0H7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=npg7NrrPAlFAH2w49LRX31RwvL1r/SPr57lXlwFGR3ius9c9BFUBCeqFe+p3J4SBy
	 ndGGOsjYFJyF8YXYZoensz30fy3Vv1zC24HKeYjYOA/hRFxaLoyCy3Tav7s/fo7cVr
	 djKvbP7YSFNqyPRfTD2jPYdOzSv+mR4eDx0gkD8dpMwDpONeGnpxflGfY1/z5Z3xUn
	 FKNaP8taZwlnTzA9+zh1U3bwhRUEx5jh30H1CGwNQT1XGYfB4FEbBr/MEa7bkTSOLI
	 esHIeF10/9X27mbST4t+Uu1mcaKMrCspmmOG3UkSDI2nAD40peeZyH/uGW94SgTcYn
	 7Aq6PDm+cwrEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78AC53A82570;
	Thu,  8 Jan 2026 12:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: dsa: microchip: Adjust PTP handling to
 ease KSZ8463 integration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176787421729.3607489.3400677976333078540.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 12:10:17 +0000
References: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
In-Reply-To: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
To: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 05 Jan 2026 14:07:59 +0100 you wrote:
> Hi all,
> 
> This series aims to make the PTP handling a bit more generic to ease the
> addition of PTP support for the KSZ8463 in an upcoming series. It is not
> intented to change any behaviour in the driver here.
> 
> Patches 1 & 2 focus on IRQ handling.
> Patches 3 to 9 focus on register access.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: dsa: microchip: Initialize IRQ's mask outside common_setup()
    https://git.kernel.org/netdev/net-next/c/813feab1ac52
  - [net-next,2/9] net: dsa: microchip: Use dynamic irq offset
    https://git.kernel.org/netdev/net-next/c/22bde912e800
  - [net-next,3/9] net: dsa: microchip: Use regs[] to access REG_PTP_CLK_CTRL
    https://git.kernel.org/netdev/net-next/c/62382d6ffe59
  - [net-next,4/9] net: dsa: microchip: Use regs[] to access REG_PTP_RTC_NANOSEC
    https://git.kernel.org/netdev/net-next/c/0ee0566fc234
  - [net-next,5/9] net: dsa: microchip: Use regs[] to access REG_PTP_RTC_SEC
    https://git.kernel.org/netdev/net-next/c/776ad30de04e
  - [net-next,6/9] net: dsa: microchip: Use regs[] to access REG_PTP_RTC_SUB_NANOSEC
    https://git.kernel.org/netdev/net-next/c/5b1fe74facc2
  - [net-next,7/9] net: dsa: microchip: Use regs[] to access REG_PTP_SUBNANOSEC_RATE
    https://git.kernel.org/netdev/net-next/c/d99c1a01ac8d
  - [net-next,8/9] net: dsa: microchip: Use regs[] to access REG_PTP_MSG_CONF1
    https://git.kernel.org/netdev/net-next/c/b4df828dfc29
  - [net-next,9/9] net: dsa: microchip: Wrap timestamp reading in a function
    https://git.kernel.org/netdev/net-next/c/3adff276e751

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



