Return-Path: <netdev+bounces-159129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D4A1479E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0118188DFDC
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567092D613;
	Fri, 17 Jan 2025 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4Lwg1q0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9B27456
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737078010; cv=none; b=MNDU07iC8WNYV+I/dO4uXjG7C5PAIPc9Y0PBvXhtWj0+rmac07rRwDYuCOSneV3LayPYzqYZdK4FjfVg83nrrKZJoI3lAY/fwqy74ANKX/TO9+DZcC8T9b9UR56n7USEr+SchwGsdqiXzeT95zXiBugJ3T0InfV9swtWCHLFV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737078010; c=relaxed/simple;
	bh=nUDkxS+SGF5HsEiC9K3lpphe6D0MmMbjsns/C57QoOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f3lnraHgcgClwBPIRdfykrmdAAjsg4PzfQQSvX/ZNr8wAKPEMKzuYv2mDb6QyF4I4Ex9NygqAkBfHLauEfnwTTAGcINha+FnShMMrE6P5NTGn/HOB0rUhw0Io8vAJRKy0wIgJ0ozVad3pVaAlN3OtuE+8FdS6sGYe4NEXrskbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4Lwg1q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079B4C4CED6;
	Fri, 17 Jan 2025 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737078010;
	bh=nUDkxS+SGF5HsEiC9K3lpphe6D0MmMbjsns/C57QoOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t4Lwg1q08IwDzcCM3K+0chPwYs1wTXYjeypEtV2YcfEhdETnhRlSAmurTALOmHnBS
	 R77blJDNzrHegRhLVCCDuoXUqeAq2csQt0xx/kEj5Ovn7RALPe6M5NLpZqUBdgXr9G
	 lapL2Vb6+Zw28lAGQxO60RFgsPhQ/a6d1haPXSxWiuBoyVjRkMA6rDMcC6qOADFbUF
	 19usKybJhWNMosmDHStEWxsrWO4j5nVS/ueGSaogdMOXdquT/BHnsm6qLPYalct3UQ
	 i0Dz4bhHKy6UZpJAvVPPRgNrCoWLZ3cYTRcX3BzBXe//jBSfdVxm3RjyYAKjvYqxIH
	 HOK00wjfH06Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E66380AA63;
	Fri, 17 Jan 2025 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: add phylink managed EEE support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173707803298.1652211.8068749856450177077.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 01:40:32 +0000
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
In-Reply-To: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, bryan.whitehead@microchip.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, marcin.s.wojtas@gmail.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jan 2025 20:42:28 +0000 you wrote:
> Hi,
> 
> Adding managed EEE support to phylink has been on the cards ever since
> the idea in phylib was mooted. This overly large series attempts to do
> so. I've included all the patches as it's important to get the driver
> patches out there.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: mdio: add definition for clock stop capable bit
    https://git.kernel.org/netdev/net-next/c/3ba0262a8fed
  - [net-next,2/9] net: phy: add support for querying PHY clock stop capability
    https://git.kernel.org/netdev/net-next/c/a00e0d34c036
  - [net-next,3/9] net: phylink: add phylink_link_is_up() helper
    https://git.kernel.org/netdev/net-next/c/a17ceec62f81
  - [net-next,4/9] net: phylink: add EEE management
    https://git.kernel.org/netdev/net-next/c/03abf2a7c654
  - [net-next,5/9] net: mvneta: convert to phylink EEE implementation
    https://git.kernel.org/netdev/net-next/c/ac79927dc84f
  - [net-next,6/9] net: mvpp2: add EEE implementation
    https://git.kernel.org/netdev/net-next/c/b53b14786ed8
  - [net-next,7/9] net: lan743x: use netdev in lan743x_phylink_mac_link_down()
    https://git.kernel.org/netdev/net-next/c/a66447966f03
  - [net-next,8/9] net: lan743x: convert to phylink managed EEE
    https://git.kernel.org/netdev/net-next/c/bd691d5ca918
  - [net-next,9/9] net: stmmac: convert to phylink managed EEE support
    https://git.kernel.org/netdev/net-next/c/4218647d4556

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



