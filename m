Return-Path: <netdev+bounces-221036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4050B49EB6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259FB3B406D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0CC217F27;
	Tue,  9 Sep 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2LmF253"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91BE211499
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381433; cv=none; b=LA6iuzPEWXYHYl9vFbfcZe0MOYRRbsW7FbwyOEiu3MAX5vmyjMU7OPqZJrolY3t0DIosLSFcq8xNrov41vgZ7hn6v/YRqrnYIbjwn1x/8z6smGOc9/OmKQMy1J217+651LrG9olL0bnbtNTlpyg1D0H15e5Hvb6UlZ4vPZj5jCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381433; c=relaxed/simple;
	bh=LW/aTIf77jl0JmfF2/xesj80TUgUyZIZrteGn5xgTdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RIRJPamCZ5iL1JWf0pd586J+762T4yObNVe2PFrtV5tY9BzlOAkdxsbWJLMKmFAl2SvxAtdcAA7x9UWA3drTvAIOXE9DFj/ktDzLJIZPljWMNYwPpzha/KCe1rBUi1oyfkdIXV/xMTlgIUks+GpenwDcod33pxPNmqE9bVmYhaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2LmF253; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBE7C4CEF1;
	Tue,  9 Sep 2025 01:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757381433;
	bh=LW/aTIf77jl0JmfF2/xesj80TUgUyZIZrteGn5xgTdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N2LmF253IP2fFjntS60H1EYz6n0oEhQ5SgNReZZZmm3iqr6QI3hTSvNSk5bBn87IN
	 Nm7e6KWeH/dJMvr3InUPJE5nIKSenKb2OPVhh1h7OHDKEoKGmVWSJZcdEbfSic/Frt
	 fbCSclpBOXPLrO/ExMrE8fSwyZTVCbcGgWh2j/15/JOz934kzuyl9l0jBRAi/8MdNN
	 nb6Twcs4Ic29o2KgYjuNrkaWHbPQu7nNRzfJu7c4lmFYu/3MCnaBPME07q1IqL/c+A
	 +90B59i+nRriO0ExgWvZJpS3ql/ZedNtYlLNoswTgajTIPSPz+i4G/p9OGTKjaRu7d
	 15DhRXbwi0YiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C8F383BF69;
	Tue,  9 Sep 2025 01:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/11] net: stmmac: mdio cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175738143698.108077.11508219910437568266.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 01:30:36 +0000
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
In-Reply-To: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Sep 2025 13:10:42 +0100 you wrote:
> On Wed, Sep 03, 2025 at 01:38:57PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> Clean up the stmmac MDIO code:
> - provide an address register formatter to avoid repeated code
> - provide a common function to wait for the busy bit to clear
> - pre-compute the CR field (mdio clock divider)
> - move address formatter into read/write functions
> - combine the read/write functions into a common accessor function
> - move runtime PM handling into common accessor function
> - rename register constants to better reflect manufacturer names
> - move stmmac_clk_csr_set() into stmmac_mdio
> - make stmmac_clk_csr_set() return the CR field value and remove
>   priv->clk_csr
> - clean up if() range tests in stmmac_clk_csr_set()
> - use STMMAC_CSR_xxx definitions in initialisers
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] net: stmmac: mdio: provide address register formatter
    https://git.kernel.org/netdev/net-next/c/16e03235d51b
  - [net-next,v2,02/11] net: stmmac: mdio: provide stmmac_mdio_wait()
    https://git.kernel.org/netdev/net-next/c/9eb633ad1d69
  - [net-next,v2,03/11] net: stmmac: mdio: provide priv->gmii_address_bus_config
    https://git.kernel.org/netdev/net-next/c/6717746f33ab
  - [net-next,v2,04/11] net: stmmac: mdio: move stmmac_mdio_format_addr() into read/write
    https://git.kernel.org/netdev/net-next/c/6cb3d67ad624
  - [net-next,v2,05/11] net: stmmac: mdio: merge stmmac_mdio_read() and stmmac_mdio_write()
    https://git.kernel.org/netdev/net-next/c/9b0ed33a4256
  - [net-next,v2,06/11] net: stmmac: mdio: move runtime PM into stmmac_mdio_access()
    https://git.kernel.org/netdev/net-next/c/9b88194a3b68
  - [net-next,v2,07/11] net: stmmac: mdio: improve mdio register field definitions
    https://git.kernel.org/netdev/net-next/c/3581acbb789a
  - [net-next,v2,08/11] net: stmmac: mdio: move initialisation of priv->clk_csr to stmmac_mdio
    https://git.kernel.org/netdev/net-next/c/661a868937a1
  - [net-next,v2,09/11] net: stmmac: mdio: return clk_csr value from stmmac_clk_csr_set()
    https://git.kernel.org/netdev/net-next/c/231e2b016fb2
  - [net-next,v2,10/11] net: stmmac: mdio: remove redundant clock rate tests
    https://git.kernel.org/netdev/net-next/c/78c91bec8fb9
  - [net-next,v2,11/11] net: stmmac: use STMMAC_CSR_xxx definitions in platform glue
    https://git.kernel.org/netdev/net-next/c/fc8f62c827ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



