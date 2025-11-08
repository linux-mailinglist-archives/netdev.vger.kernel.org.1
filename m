Return-Path: <netdev+bounces-236944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0108C4255F
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28BC189370C
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F832D480E;
	Sat,  8 Nov 2025 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTXQunW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36C22D3EDC;
	Sat,  8 Nov 2025 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570860; cv=none; b=B2lxUH9g5WwKPuoy0sd685K4I7TuHmMhsQlTcHb2kvqvlB8EbCFY2AfL7oCi4Cwa7F2CXcDPfkLmQZofVHaUiBeRmQxMtN4vSU7dwDgyMSKrpnHuVS+DMHxCoi65YdvzwR9OCaol1h+4mQDNPaYJyH/IO0gfL1mIqWS5ZOM8GL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570860; c=relaxed/simple;
	bh=lAyzPUG3TPMZfvydWS3IdN9XCMSpjLM646Zvz9HjArI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EAy4uS38b46kt1bF1xYhm7jw/8jHrdg+XQESBW/mUecz/TpUoIVWbE1yuvueCGeR/69a1aAZTmYIOKgmR36e67bkJd2jDf9A/wgw9VhUczsP9hX6UKnyr/6ssNrF7Mhb+fCJ2/X0ZDBrKxqg4cCL4+8HwQXBWa4rZuHrvRGFGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTXQunW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924EFC4CEF5;
	Sat,  8 Nov 2025 03:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762570859;
	bh=lAyzPUG3TPMZfvydWS3IdN9XCMSpjLM646Zvz9HjArI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MTXQunW2BI1ywfH5gldPFNQ+IThAp+Bmzxu5owdyo6xEPjKrxRDkblBGtJc5YMkX+
	 RdNis0kXb6M1wdhw0qthwwyMZ37rk1YBLpIHMRvqXvfvhg8qg9MHZ6K6Ejvxhf2IkI
	 yI/uCaY8AlI70QNhecfv1g9cq6PPlYYqRGhuu8kJxCNFGcl9h0RYK/eTo1fuYyaCP4
	 EW8jLDgpG69ZuFoX9uzDtPUdfhrSnKB/RP0/xHfpRuB11HVuJZBKb07qyDSL8ifOze
	 Kv6rSNka+mYsvN2RAH6bPjtUEiU07ONbjTfsupQyvdW9B/WYb/ijSEkN9i5W01mNJh
	 MwLG2h0pcx9Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD603A40FCA;
	Sat,  8 Nov 2025 03:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: phy: Add Open Alliance TC14
 10Base-T1S
 PHY cable diagnostic support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257083173.1232193.2524115929455028115.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:00:31 +0000
References: <20251105051213.50443-1-parthiban.veerasooran@microchip.com>
In-Reply-To: <20251105051213.50443-1-parthiban.veerasooran@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, parthiban.veerasooran@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 5 Nov 2025 10:42:11 +0530 you wrote:
> This patch series adds Open Alliance TC14 (OATC14) 10BASE-T1S cable
> diagnostic feature support to the Linux kernel PHY subsystem and enable
> this feature for Microchip LAN867x Rev.D0 PHYs. These patches provide
> standardized cable test functionality for 10BASE-T1S Ethernet PHYs,
> allowing users to perform cable diagnostics via ethtool.
> 
> Patch Summary:
> 1. add OATC14 10BASE-T1S PHY cable diagnostic support
> 	- Implements support for the OATC14 cable diagnostic feature in
> 	  Clause 45 PHYs.
> 	- Adds functions to start a cable test and retrieve its status,
> 	  mapping hardware results to ethtool codes.
> 	- Exports these functions for use by PHY drivers.
> 	- Open Alliance TC14 10BASE-T1S Advanced Diagnostic PHY Features.
> 	  https://opensig.org/wp-content/uploads/2025/06/OPEN_Alliance_10BASE-T1S_Advanced_PHY_features_for-automotive_Ethernet_V2.1b.pdf
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: phy: phy-c45: add OATC14 10BASE-T1S PHY cable diagnostic support
    https://git.kernel.org/netdev/net-next/c/b87ee13e3493
  - [net-next,v3,2/2] net: phy: microchip_t1s:: add cable diagnostic support for LAN867x Rev.D0
    https://git.kernel.org/netdev/net-next/c/f424409483d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



