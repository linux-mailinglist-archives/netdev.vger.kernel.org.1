Return-Path: <netdev+bounces-103759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9462C90958F
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 04:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449481F2301F
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1EB6AA7;
	Sat, 15 Jun 2024 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcTPhopF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9863D60
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417434; cv=none; b=giKKXSfQ46Yig2b9lxzvZHoP29SAq6Sp1bE5kz/fmD4xi6VgbMIEygxhpLQ9mJoJA1O3cai+eSw6e28uaMpSAPI6NLoJ6AzNBjYValih2boeh66kUpD0sB8+EcWT9MGbVk05bs7TLf0+Wh5lsU1/iQrllYjYS0gBuX/hrgGXntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417434; c=relaxed/simple;
	bh=ABXjdcbS3NQ2+UpYbp/Hs7qp5NUgC7y0vU0VzCOGkUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mw81NP0b5AErUyt+zp9GILyIkFBQpYv+IT84U66arx7ctT2BtZHOe2mJxDLvZ9QhLEjJDVGeJJyj3ThQIeD0NogPO0wS3Uu1E6uguPgaL3mKvazdAu0CZpVqAaFX5n1WcGMp/BtbMhccSfmmh+JU89sQVryzL0DsLl/ET6XLbWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcTPhopF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80EF8C4AF1D;
	Sat, 15 Jun 2024 02:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718417434;
	bh=ABXjdcbS3NQ2+UpYbp/Hs7qp5NUgC7y0vU0VzCOGkUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CcTPhopFoogpANsQX5ImGKtl/YBnsBn4KzDWplUdB7l/K+z2XjYS3LI1VblF83pYH
	 /WZEoqa+LvMZ7GNJur8ZWEftJPitsu5aAL6eaaWLuxv36WAibN/0Qq9qIYEEQW2SHH
	 +AIMsBsKAC/xjy50XgFhIqI8hfDxH5E6NkFUUScN61G5XIakDy+6VZcxqwbpLGXdT6
	 zjtnAVa8gNENsD//CN5EYZkMLi5NO/NioWeRf4UMQx7NaXA7DwEJrrk8igLfEDxvS2
	 Ba8re8odbnmr32SlLTgJosZbpcnSPDmSqB37TgoYJxvtAlLtvhXNDCmxYNOesnpWFR
	 L/TP1KJx04xPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64F29C43619;
	Sat, 15 Jun 2024 02:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: stmmac: provide platform select_pcs
 method
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171841743440.11975.7851912921042282735.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jun 2024 02:10:34 +0000
References: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
In-Reply-To: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: fancer.lancer@gmail.com, alexandre.torgue@foss.st.com,
 ahalaney@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, joabreu@synopsys.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, romain.gantois@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jun 2024 11:35:25 +0100 you wrote:
> Hi,
> 
> This series adds a select_pcs() method to the stmmac platform data to
> allow platforms that need to provide their own PCSes to do so, moving
> the decision making into platform code.
> 
> This avoids questions such as "what should the priority of XPCS vs
> some other platform PCS be?" and when we provide a PCS for the
> internal PCS, how that interacts with both the XPCS and platform
> provided PCS.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: stmmac: add select_pcs() platform method
    https://git.kernel.org/netdev/net-next/c/6c3282a6b296
  - [net-next,v2,2/5] net: stmmac: dwmac-intel: provide a select_pcs() implementation
    https://git.kernel.org/netdev/net-next/c/135553da844c
  - [net-next,v2,3/5] net: stmmac: dwmac-rzn1: provide select_pcs() implementation
    https://git.kernel.org/netdev/net-next/c/804c9866e078
  - [net-next,v2,4/5] net: stmmac: dwmac-socfpga: provide select_pcs() implementation
    https://git.kernel.org/netdev/net-next/c/98a6d9f192d3
  - [net-next,v2,5/5] net: stmmac: clean up stmmac_mac_select_pcs()
    https://git.kernel.org/netdev/net-next/c/93f84152e4ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



