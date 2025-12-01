Return-Path: <netdev+bounces-243107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF0AC998D2
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 00:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1E604E2628
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 23:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E93B29D26E;
	Mon,  1 Dec 2025 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY2+KhjV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488B29C321;
	Mon,  1 Dec 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630810; cv=none; b=flqD28zbMudmpQUl/H0ecpngiei56IP+6vRmJqLBxzAvJS6tjUeeSqgVIk4kye0NQhr1aw6KNz0Jj1oCLcs59CLdYmcuC/cW9YofhkiqlyH5DQVmvukI8xb0spPR+a4fYC2aZ4jYSvJhAcED5+yNkRcG0PJy0YEc0Mk2Nxo4+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630810; c=relaxed/simple;
	bh=gh1rDfe5C9bi2gSM4WNm6x339cJh8oQ36cSLEwQ6Row=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o4MDuFErYAvTjf4+9eSs7vzTHEdk5asxtzv3P+8FZfMPcQKGIKq4j1llktk1zF+sC29j6Xni4pQySj1SXWTRZo58EwUferZjAsl9t3JW1IcXbzEEBZ/25lmvs09e3Nui9gmu0jZtgRBakSMNr3i+Yzb8EQ9ud7fEsRlnrDP+pFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY2+KhjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946C1C4CEF1;
	Mon,  1 Dec 2025 23:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764630809;
	bh=gh1rDfe5C9bi2gSM4WNm6x339cJh8oQ36cSLEwQ6Row=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LY2+KhjV8uVeWVX2ggVZFgNVyXbWgfa4OCCC5M5Pb4IyjWlk+b3Dqrr1TZuOUoeHB
	 Zjn1MvOBXFuC6HoyntQ+FhpAsbWVRZ8X4+8s5mHScnutpaOhufj7BxcRDmjyBgTMHi
	 Z11NVvpLM20nyxlrkOfC4nGIGdBVMlKowH7U4vAXpjDPBX9tEqKBpGvKT+tK+eZK4f
	 f5Wr8HgiR9+BCeaZbUCfaVL0Ys6wfwLREsBeJ3duAPujnh/tQDUVDWryljDu6sr0HB
	 U0BLmXw9pwpe8uJbdG3SH1/oqe5cJVCsno/4U8pYhkLIkgSlU+urPhgK02vG/b4Wpl
	 rZe5cu9hu5jUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5946381196A;
	Mon,  1 Dec 2025 23:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] Add SQI and SQI+ support for OATC14
 10Base-T1S PHYs and Microchip T1S driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176463062952.2589368.13509263665154937851.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 23:10:29 +0000
References: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
In-Reply-To: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, parthiban.veerasooran@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Dec 2025 08:53:44 +0530 you wrote:
> This patch series adds Signal Quality Indicator (SQI) and enhanced SQI+
> support for OATC14 10Base-T1S PHYs, along with integration into the
> Microchip T1S PHY driver. This enables ethtool to report the SQI value for
> OATC14 10Base-T1S PHYs.
> 
> Patch Summary:
> 1. add SQI and SQI+ support for OATC14 10Base-T1S PHYs
>    - Introduces MDIO register definitions for DCQ_SQI and DCQ_SQIPLUS.
>    - Adds genphy_c45_oatc14_get_sqi_max() to report the maximum SQI/SQI+
>      level.
>    - Adds genphy_c45_oatc14_get_sqi() to return the current SQI or SQI+
>      value.
>    - Updates include/linux/phy.h to expose the new APIs.
>    - SQI+ capability is read from the Advanced Diagnostic Features
>      Capability register (ADFCAP). If unsupported, the driver falls back
>      to basic SQI (0–7 levels).
>    - If SQI+ capability is supported, the function returns the extended
>      SQI+ value; otherwise, it returns the basic SQI value.
>    - Open Alliance TC14 10BASE-T1S Advanced Diagnostic PHY Features.
>      https://opensig.org/wp-content/uploads/2025/06/OPEN_Alliance_10BASE-T1S_Advanced_PHY_features_for-automotive_Ethernet_V2.1b.pdf
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
    https://git.kernel.org/netdev/net-next/c/5e1bf5ae5e3b
  - [net-next,v4,2/2] net: phy: microchip_t1s: add SQI support for LAN867x Rev.D0 PHYs
    https://git.kernel.org/netdev/net-next/c/16416c835287

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



