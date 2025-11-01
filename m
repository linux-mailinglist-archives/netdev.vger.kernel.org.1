Return-Path: <netdev+bounces-234794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F028C2744D
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 01:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9971B25A1C
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6F153BE9;
	Sat,  1 Nov 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjvcSdNs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AEADF71;
	Sat,  1 Nov 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761957036; cv=none; b=WBtFNBPFH37WkpQ3dIo3zEYzf/nJdetohB1IgFDVCEGo3tD8nAh/xHwsdByWlQDYWbP0PReHBIZSIUyh7DXYp2lFMPEAL+kpVZ49WC0S3XYNhT/cAnA7VY0YDpufVH1AoGJI4xEivcqubrIpCA+YSvIWP9XRgE+8dsdzK/TmCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761957036; c=relaxed/simple;
	bh=3D1UESgTqHZnhM16CIB57unnVwzLMrttNmVgCFprGQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=USDF7xcFyaS2zW/pvBS0dcVNcDe37XqbqllhWpFFZjxMspGzJpNQ3h3rmBJr/Nq9FEsgIiBNuEwWaUyGp6mmqdb7HAwVCRfYHh+DwlGBV6SPFNHpScq/Gm2uI4/Sen8n8RnDEe2DlU/s8i7vSqrlFoepM/7Ziu/tSoA3z/jFq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjvcSdNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3646DC4CEE7;
	Sat,  1 Nov 2025 00:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761957036;
	bh=3D1UESgTqHZnhM16CIB57unnVwzLMrttNmVgCFprGQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mjvcSdNsOFFjFMGK009AEzMfnjWVKT5K69jQD8K4ckIskxYZq4ZJpYR9H/EuHsDZS
	 Nqm4Vys0SRx9buLtxFteKVBHEnTsjFGsIDY23mGRc/y0UXrz+Twm9dvyR1jVgyhLKA
	 rrOneDww9Bw8OvtTFWw2BgU64iQXmpxRf87maX4YwPVUHurZnqJA722MQy16WhUe3c
	 SclvCpeDkGbSOLqJeEyuzT0K1lMEBcvYqwF6Jr6Jp+3RZpPoptcKbGF4SSNjzIkFch
	 Wo80s9AubfBbAhlbLZHteGkMH4PoKWmDPO/+lDTEWSD6Wc+wXJOFExO/1XT5KZLbo6
	 KvzKRmWBIEROA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B9F3809A00;
	Sat,  1 Nov 2025 00:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: phy: microchip_t1s: Add support for
 LAN867x
 Rev.D0 PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195701225.678724.16997119905008637524.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 00:30:12 +0000
References: <20251030102258.180061-1-parthiban.veerasooran@microchip.com>
In-Reply-To: <20251030102258.180061-1-parthiban.veerasooran@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 parthiban.veerasooran@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 15:52:56 +0530 you wrote:
> This patch series adds support for the latest Microchip LAN8670/1/2 Rev.D0
> 10BASE-T1S PHYs to the microchip_t1s driver.
> 
> The new Rev.D0 silicon introduces updated initialization requirements and
> link status handling behavior compared to earlier revisions (Rev.C2 and
> below). These updates are necessary for full compliance with the OPEN
> Alliance 10BASE-T1S specification and are documented in Microchip
> Application Note AN1699 Revision G (DS60001699G – October 2025).
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: phy: microchip_t1s: add support for Microchip LAN867X Rev.D0 PHY
    https://git.kernel.org/netdev/net-next/c/e7e756779afa
  - [net-next,2/2] net: phy: microchip_t1s: configure link status control for LAN867x Rev.D0
    https://git.kernel.org/netdev/net-next/c/07f5765f26c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



