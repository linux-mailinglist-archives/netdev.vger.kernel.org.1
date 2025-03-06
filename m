Return-Path: <netdev+bounces-172291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 545B3A5412B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 04:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A91816F351
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB3198A34;
	Thu,  6 Mar 2025 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN+i3tkh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B5197A8E;
	Thu,  6 Mar 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231203; cv=none; b=LVfCwHTY0yPFR/GOUhh24inyn/a4Ydli/ZeYOYjiaDG8CxUZnf0oWYupuZxU7s1W780ITFuWPIkjv5obRGIkaRGDpNEbuQunX378ETiXxaD9PkI4M8ZbqWuuFFP6WT77OgjOnLUuthy4nObnG1ulyNzVa2tRWieX/NONbikP73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231203; c=relaxed/simple;
	bh=puW1fkF16Qim9hZZEw4ModRCF3+zrl3JO6/d11Mn3Uk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rSEky42RGB1/R6X31d7J3lpY3XkHzCaE83zyBgBRML0iHON9HVhCqMxkJbJ4MxkQo91IjoduqCjZz7hdoxo+AHDSUHQVT5+xv4kC6n2Fk0Sq1Ng4Khctob1bBpBCgOEnAGNluqDiZFXegnraeswANdDl+v53SFXJi9BzEOaiC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN+i3tkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506A9C4CEE9;
	Thu,  6 Mar 2025 03:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741231202;
	bh=puW1fkF16Qim9hZZEw4ModRCF3+zrl3JO6/d11Mn3Uk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hN+i3tkhBsXNtUnRx9tV1K3ezT65JSWich6bKEtNqjEB16j4/AnXmyeLyJwFpcY+v
	 mz0SizSVVZ2G0R7l7mTgBqYv4vN97mJhSRCB6D1WrF7HKK1f6fm+pxW2lFwwie+aCe
	 aJEIFrY2Z58zuUpeiiLRTs6SOK6T0765uz+uy2YHy7BH7q0YYELaxZE7ugKGDOBS2/
	 q73tcgEuYon/1TdOyEKwMCYht45VykkNl/LHXGmEDgazQn1Iw6S/xJWWP8xiJc2NL9
	 90zXfea49B/wVQDkAYGenbtXLbc7XZl45eOwDsUxrtuWKNeKRaqaE7Q8ZA86eCVxs7
	 EFzIxwEW+ZipQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2B5380CFF3;
	Thu,  6 Mar 2025 03:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/6] Enable SGMII and 2500BASEX interface mode
 switching for Intel platforms
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174123123550.1112346.5967919465567432247.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 03:20:35 +0000
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
In-Reply-To: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: horms@kernel.org, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 david.e.box@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 irenic.rajneesh@gmail.com, david.e.box@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 richardcochran@gmail.com, fancer.lancer@gmail.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 20:15:16 +0800 you wrote:
> During the interface mode change, the 'phylink_major_config' function will
> be triggered in phylink. The modification of the following functions will
> support the switching between SGMII and 2500BASE-X interface modes for
> the Intel platform:
> 
> - xpcs_switch_interface_mode: Re-initiates clause 37 auto-negotiation for
>   the SGMII interface mode to perform auto-negotiation.
> - mac_finish: Configures the SerDes according to the interface mode.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/6] net: phylink: use pl->link_interface in phylink_expects_phy()
    https://git.kernel.org/netdev/net-next/c/b63263555eaa
  - [net-next,v9,2/6] net: pcs: xpcs: re-initiate clause 37 Auto-negotiation
    https://git.kernel.org/netdev/net-next/c/065d3cef99a1
  - [net-next,v9,3/6] arch: x86: add IPC mailbox accessor function and add SoC register access
    https://git.kernel.org/netdev/net-next/c/7e2f7e25f6ff
  - [net-next,v9,4/6] net: stmmac: configure SerDes on mac_finish
    https://git.kernel.org/netdev/net-next/c/e654cfc718d4
  - [net-next,v9,5/6] net: stmmac: configure SerDes according to the interface mode
    https://git.kernel.org/netdev/net-next/c/a42f6b3f1cc1
  - [net-next,v9,6/6] net: stmmac: interface switching support for ADL-N platform
    https://git.kernel.org/netdev/net-next/c/7598ef621a43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



