Return-Path: <netdev+bounces-92138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB08B58C1
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD44E1C230DE
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDB02E40C;
	Mon, 29 Apr 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtIdUevM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29523175A9;
	Mon, 29 Apr 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394430; cv=none; b=dmRSwnPl/FBeKx0uUYrKtxOpK0ippaggHoy8Sv2xCgGrBcoi9qLKo7ruBDS3QlcFRWs+BdS/fmrcngGm1g5moFIz4gYgc8NCeojpKuHhMJtq0bdk9oaFdFbRNktVO3TbmEj9PJsxHkjR+vf8Sxflec7WSrcNRjjtzqlxqf5ZDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394430; c=relaxed/simple;
	bh=N/pDbubcb96Eoq5WYA7HE5yOLnbvmyrDS5LQr2R/dRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XxRLlcmhBX97QqAklNJCQAaseupZvNyRO/J/n42hIeQEqwtT248AuRQkRSuPHO1Mvy2YDDms6cs36jIn/yuksFMK2G2iPu2OMe+NyuO4X6t9TEWdAQdyBjyIBjTam8P8QgN3FFkRyXzde4A7Wl6gWopYyx5dkmiERa8nVTW5Qq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtIdUevM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4C0DC116B1;
	Mon, 29 Apr 2024 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714394429;
	bh=N/pDbubcb96Eoq5WYA7HE5yOLnbvmyrDS5LQr2R/dRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NtIdUevMzKpV5ixlZjItwC1hV0YLMNwUQNf2RnygZaDBjL5o6B260+yzgAPKpfyJZ
	 YDcuEcECExxcLmd2NPIp5QOwI7ae+8e9k+oxUqX2a16/rbeB/c1iwhIzgEAlQEHgdX
	 lah3S+ks08kI46B7DeWhnzza0UJGxvqhQE5uaTaE1eya+ns5+2KIKvWspO//Gski1P
	 +3eqBifnIZEBm88qIm7gbixfQJb0UyCjxNzRaC/AG//J6/cYcPDSgrexvD0Y8im8A4
	 wwwhyfpD0vboZ2lD47aWTSSoVJQCfZG24g39kh7l4usvtJAoyF5gSbN1mJ8Ra+b1gM
	 KBbYC51TIrKlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AF8CC54BAA;
	Mon, 29 Apr 2024 12:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: micrel: Add support for PTP_PF_EXTTS
 for lan8814
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171439442963.25762.9015343289021127616.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 12:40:29 +0000
References: <20240426140224.2201919-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240426140224.2201919-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Apr 2024 16:02:24 +0200 you wrote:
> Extend the PTP programmable gpios to implement also PTP_PF_EXTTS
> function. The pins can be configured to capture both of rising
> and falling edge. Once the event is seen, then an interrupt is
> generated and the LTC is saved in the registers.
> On lan8814 only GPIO 3 can be configured for this.
> 
> This was tested using:
> ts2phc -m -l 7 -s generic -f ts2phc.cfg
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: micrel: Add support for PTP_PF_EXTTS for lan8814
    https://git.kernel.org/netdev/net-next/c/b3f1a08fcf0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



