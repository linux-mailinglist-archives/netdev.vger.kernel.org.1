Return-Path: <netdev+bounces-200405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451C3AE4DD1
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 21:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20891189CCF8
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 19:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA292D3A65;
	Mon, 23 Jun 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMfBvUyZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6632609E4
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750708779; cv=none; b=TnPoJc7EC7iiPZ1EVyq+Fu+2Yr25Mz/eQHOO384uDc6kaDr+7ucCYagMOH7GtDb162ef8+S5cM2Hb/tFcX6AXKe6FOP5pMMLLaBMK17LomDvR0Gjid/nV8rPJFtrF97IvDEqDYNpKEWfmkshpUjAHDtUkgRvwg63z414+hYBrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750708779; c=relaxed/simple;
	bh=VZ3m66PTUnHfamACT4jCJE5I9AkGJuqWAgQW73lk4PU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n/SwV+5JkqfyEgodpqs3YQmUzNrf7dBLfR9hxQNXIdL7ALbeTym5f+pyYeZFYbMxSCP4xn2rAX9VJcL2MDnnyMMKqAOwedQ5/68ZAA5U92OxK5aCa0rcZsZkUTbKFi3xlf7IWL+YR40amcfMRWgtsoUKFpQ5WHkwC1hzkjDk+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMfBvUyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29058C4CEEA;
	Mon, 23 Jun 2025 19:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750708779;
	bh=VZ3m66PTUnHfamACT4jCJE5I9AkGJuqWAgQW73lk4PU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DMfBvUyZ1gJ59ihAbsJRkaCldcfa4DgHj1AKsy7+7ecI9YWabflDOktQ7N8EtaPH6
	 RFzjP6xo6Hda+ltWdQT7NmjK4n5H7zmqcncQk/Xbe2tJ2EpfSBnsPL3V+1JL8AbEm5
	 Xlhz4sjTR6jewDNCHL2Sf1GhWY1vGzMJTaFVdQSsCqSJbrTboh4erdZTZahlJZ2Fzk
	 SGBRQL/3BGyRwuI+YZyS9RcaL4lFVcaoNNSDdwnIFvVN7G6+UYgm0qzRz7YAXX67+o
	 LATSXASzIQp4kzOki2zTE+OuE9oCIKttZpT0wEG6sQAa5hiv9f6jar3DDQ70HMOfpu
	 44g381Kw0BK1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7336C38111DD;
	Mon, 23 Jun 2025 20:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: lpc18xx: use
 plat_dat->phy_interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175070880626.3280891.5905917830342989849.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 20:00:06 +0000
References: <E1uSBri-004fL5-FI@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uSBri-004fL5-FI@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vz@mleia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 10:47:26 +0100 you wrote:
> lpc18xx uses plat_dat->mac_interface, despite wanting to validate the
> PHY interface. Checking the DT files (arch/arm/boot/dts/nxp/lpc/), none
> of them specify mac-mode which means mac_interface and phy_interface
> will be identical.
> 
> mac_interface is only used when there is some kind of MII converter
> between the DesignWare MAC and PHY, and describes the interface mode
> that the DW MAC needs to use, whereas phy_interface describes the
> interface mode that the PHY uses.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: lpc18xx: use plat_dat->phy_interface
    https://git.kernel.org/netdev/net-next/c/9f22c3ddb8cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



