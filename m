Return-Path: <netdev+bounces-237407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0C0C4B012
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D97188223A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777F344041;
	Tue, 11 Nov 2025 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej5vH736"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BF332ED0
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825258; cv=none; b=s3pp3+5sJJ/Iv4kTrBc2zDBoWoCAcUW+0nPcPdEYuWoh620gVByiLihRBKqwT7+7sfvtZ3534JST+b9PfpmpsRQ35Haa9HWH8V0+fu4X+calf4ENDaDFk3p4dBn5ygiFR7qaBTgyCXV5M7K/DOdyRfGirdLNS2jGbC4BXHo2k9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825258; c=relaxed/simple;
	bh=5fszHu+0NCe/j4FS6aCuGypK1jI8uEB60+HhsE1RoDM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SJ/phYtWM5kClbmfjNscpLIOG+FYl5QGv6ysN4vdESaMhpJbyglH7UteSal/Zruicm4hpB9gcp3UD5i7/kBUHsHYYKMcma5Uik/oMHZNpfGcndRZO5DrICrua8t04khF6nRohSifxdw85tJQcfHd/6p93G2xVZ6+fRD5WNND2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej5vH736; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760D7C4CEFB;
	Tue, 11 Nov 2025 01:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762825257;
	bh=5fszHu+0NCe/j4FS6aCuGypK1jI8uEB60+HhsE1RoDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ej5vH736g5NaLrNiPp3r8PZLRcIYOfQLNlEfvnPDfkI9IJSISWOA2ekr+xdlF31Zi
	 9q5eoncrecK2zUGqVCWk3wVGtGHpnT4Vip7PtoPpWJe5wAHbbCk7XA7X1ZfQyADUxa
	 3P851l+s5FAlKV4VLYc5MOgQ5AfQM8jvPiX9mpw3dyetXLvzToiApKSzGPIDDpNwaL
	 l4h8BrAH8vSWPg3038O2LY0Nh49YFze0jWmJnaS5M/DnfFt1QpIMtUNfTEQSCavqab
	 7IiuRqTmE/WO5aA3+vtoLgRRzMdfREkNVy6vR7+LkyHxW3WQQxVBRDwOfn15DF17h1
	 FbvZ2F3a1dqmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2E380CFD7;
	Tue, 11 Nov 2025 01:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/11] net: stmmac: ingenic: convert to
 set_phy_intf_sel()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282522801.2843765.16848615144063968700.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 01:40:28 +0000
References: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
In-Reply-To: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Nov 2025 08:27:44 +0000 you wrote:
> Convert ingenic to use the new ->set_phy_intf_sel() method that was
> recently introduced in net-next.
> 
> This is the largest of the conversions, as there is scope for cleanups
> along with the conversion.
> 
> v2: fix build warnings in patch 9 by rearranging the code
> v3: fix smatch warning in patch 11, added Maxime's r-b.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/11] net: stmmac: ingenic: move ingenic_mac_init()
    https://git.kernel.org/netdev/net-next/c/2dd63c364534
  - [net-next,v3,02/11] net: stmmac: ingenic: simplify jz4775 mac_set_mode()
    https://git.kernel.org/netdev/net-next/c/307a575775fd
  - [net-next,v3,03/11] net: stmmac: ingenic: use PHY_INTF_SEL_x to select PHY interface
    https://git.kernel.org/netdev/net-next/c/da6e9fd1046f
  - [net-next,v3,04/11] net: stmmac: ingenic: use PHY_INTF_SEL_x directly
    https://git.kernel.org/netdev/net-next/c/dbf99dc7d166
  - [net-next,v3,05/11] net: stmmac: ingenic: prep PHY_INTF_SEL_x field after switch()
    https://git.kernel.org/netdev/net-next/c/14497aaa5eb6
  - [net-next,v3,06/11] net: stmmac: ingenic: use stmmac_get_phy_intf_sel()
    https://git.kernel.org/netdev/net-next/c/0e2fa91c55c0
  - [net-next,v3,07/11] net: stmmac: ingenic: move "MAC PHY control register" debug
    https://git.kernel.org/netdev/net-next/c/35147b5c9e41
  - [net-next,v3,08/11] net: stmmac: ingenic: simplify mac_set_mode() methods
    https://git.kernel.org/netdev/net-next/c/608975d4d791
  - [net-next,v3,09/11] net: stmmac: ingenic: simplify x2000 mac_set_mode()
    https://git.kernel.org/netdev/net-next/c/2284cca0bced
  - [net-next,v3,10/11] net: stmmac: ingenic: pass ingenic_mac struct rather than plat_dat
    https://git.kernel.org/netdev/net-next/c/9352f74fd13d
  - [net-next,v3,11/11] net: stmmac: ingenic: use ->set_phy_intf_sel()
    https://git.kernel.org/netdev/net-next/c/34bf68a69122

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



