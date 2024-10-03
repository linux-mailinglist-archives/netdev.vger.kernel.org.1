Return-Path: <netdev+bounces-131430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD66E98E7DF
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397BCB2341E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF72101DE;
	Thu,  3 Oct 2024 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0a0JEJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28824DF49
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916047; cv=none; b=j+aGY/EScy5MJgnR1/Dsa1WLkywfQiFzUB9IRZVASVCuyYAS7kh7HcjbwtGyKbkqOtycWScffEkBkgsjWsGYcjn4bLVqUZ4ecHcwvdTbevtLBr+ezRumi+NdfIT5h1mvMzspXoXMSlihB3Vnvivvdj4nBTaUuhFZglRO7uFsBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916047; c=relaxed/simple;
	bh=i/FMF02enEnePUBhsRhePuABn3dvoRaPyTeUzcX7aLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RrH2q/RUw8lVBDz3EqTPY/S0s7gUDh6KPbzQDIm5bL1V6ENmdzYsqaLdiAN8iWN0SPMG9BHPFNJdsz0emHRNDj7mN1vXKshORdC6EZuKGAZgsK4a4kUIGai/vFwMkWM2Wdo6XgVeFBAoGnctsb37JOPiUhP3h7aP2qMfjc/l8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0a0JEJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3B6C4CEC2;
	Thu,  3 Oct 2024 00:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916046;
	bh=i/FMF02enEnePUBhsRhePuABn3dvoRaPyTeUzcX7aLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u0a0JEJAG/opP7SPHOtwHERp/LfvG7SafcO8cSj0+oT18tUtfqa236cRLZaTWH+Th
	 pSHMFN73OPxEhfhCfo2kh9Dbtal3YpzvYhEnhIeTItgaZWJjfcR22mzbfoxd07NqW5
	 Sb6Uy+B/Jz/UwX6R9q8rnkXAioxXHR+bQVu+fcpdjLzg+ZoIA7DL6U1hKy+csR1fJp
	 QmuWyszZF9q7wr7tYmBRXIKsl0qBF63odie5pm7GosO6dIN9TstlYzYK/75cB26c/4
	 T06M2eZjVHIGvwhA4DX+aTd58RnuZCay7QSS7c0a5I47xYfcFg2yairgw0SlbpZc7N
	 28d76c5x56/JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD0380DBD1;
	Thu,  3 Oct 2024 00:40:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] net: pcs: xpcs: cleanups batch 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791604974.1387504.2549279838290764330.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:49 +0000
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
In-Reply-To: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
 kuba@kernel.org, jiawenwu@trustnetic.com, joabreu@synopsys.com,
 Jose.Abreu@synopsys.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 mengyuanlou@net-swift.com, netdev@vger.kernel.org, pabeni@redhat.com,
 olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Oct 2024 17:02:48 +0100 you wrote:
> Hi,
> 
> First, sorry for the bland series subject - this is the first in a
> number of cleanup series to the XPCS driver. This series has some
> functional changes beyond merely cleanups, notably the first patch.
> 
> This series starts off with a patch that moves the PCS reset from
> the xpcs_create*() family of calls to when phylink first configures
> the PHY. The motivation for this change is to get rid of the
> interface argument to the xpcs_create*() functions, which I see as
> unnecessary complexity. This patch should be tested on Wangxun
> and STMMAC drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net: pcs: xpcs: move PCS reset to .pcs_pre_config()
    https://git.kernel.org/netdev/net-next/c/277b339c4ba5
  - [net-next,02/10] net: pcs: xpcs: drop interface argument from internal functions
    https://git.kernel.org/netdev/net-next/c/92fb8986083a
  - [net-next,03/10] net: pcs: xpcs: get rid of xpcs_init_iface()
    https://git.kernel.org/netdev/net-next/c/a487c9e7cfc4
  - [net-next,04/10] net: pcs: xpcs: add xpcs_destroy_pcs() and xpcs_create_pcs_mdiodev()
    https://git.kernel.org/netdev/net-next/c/bedea1539acb
  - [net-next,05/10] net: wangxun: txgbe: use phylink_pcs internally
    https://git.kernel.org/netdev/net-next/c/155c499ffd1d
  - [net-next,06/10] net: dsa: sja1105: simplify static configuration reload
    https://git.kernel.org/netdev/net-next/c/a18891b55703
  - [net-next,07/10] net: dsa: sja1105: call PCS config/link_up via pcs_ops structure
    https://git.kernel.org/netdev/net-next/c/907476c66d73
  - [net-next,08/10] net: dsa: sja1105: use phylink_pcs internally
    https://git.kernel.org/netdev/net-next/c/41bf58314b17
  - [net-next,09/10] net: pcs: xpcs: drop interface argument from xpcs_create*()
    https://git.kernel.org/netdev/net-next/c/bf5a61645bb2
  - [net-next,10/10] net: pcs: xpcs: make xpcs_do_config() and xpcs_link_up() internal
    https://git.kernel.org/netdev/net-next/c/faefc9730d07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



