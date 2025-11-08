Return-Path: <netdev+bounces-236951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E75C425AA
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D62394E1536
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA51F2D0C78;
	Sat,  8 Nov 2025 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5QfO/Mi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4E2C2364
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762572064; cv=none; b=l1+r8CHhXXBLd59OwLqSQGHL75GAK9B10NkUcP7qV6kc9LxWaG19GQWz2jw3JhUMftDgYvCnJNlu6ZViPmwNdbvm91PLVJ50+RjYtOrakImRGiajYE5CVLA24wUjqBtAbT/1KhDZ+Tq32ZuHkY+2xrrxvAPgRlpa9h0jQnJkgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762572064; c=relaxed/simple;
	bh=DP08fxj1Pdwkhh9oz9l/d6OztIyIzUnB15JwEWi8VFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cUmiieWdrePzDMTuVLBYuxmv/pSt7Or+XDeBPLT+iJAHkgKPdeSEzqXEGkxNkNy66hV1QW8O05rM654YnETfMdCbkI9E+dq17LRDtdMYsBWrl2IqTU0LLCwJWIVeHaEUUCHqz9FmPgOiEXjNe/Fg1MUjT+8u2FTMzOuYIfeyqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5QfO/Mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC16C4CEF7;
	Sat,  8 Nov 2025 03:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762572063;
	bh=DP08fxj1Pdwkhh9oz9l/d6OztIyIzUnB15JwEWi8VFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G5QfO/MiUu27w75C/ZLOlvWMwACK1YXcNog7YMeLC7VyzhKmEW66mj5ZB3oL4uOeY
	 ho19rE0+re+c9qvvkIkyQtvUfs384GH25HqlPKY3E+eSYKtG50678DWyAcJh8Gw2ec
	 fXvI8j7y7S+0tpTlKuphx1hXd9Ghfy2Ytoo3Oa/f6+bctPWzyZiNcq22YxFwpB6UzW
	 IyaIZF33P9q+LbpQO9QlRUjBYbo3qrD4SRPs9e+K1oHUTVi+yrZNp6PAuPLdFWq5/t
	 oQ7VToqP0EhYpAKWLzCV48bpcXtGoH2cHUCEo/uCw/opFVhvOipzQfGJNsFQBo2xIc
	 dN0oZxWgRZr5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716DC3A40FCA;
	Sat,  8 Nov 2025 03:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: stmmac: lpc18xx and sti: convert to
 set_phy_intf_sel()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257203525.1236021.18202260388195244751.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:20:35 +0000
References: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
In-Reply-To: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vz@mleia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 6 Nov 2025 11:21:23 +0000 you wrote:
> This series converts lpc18xx and sti to use the new .set_phy_intf_sel()
> method.
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    | 42 ++++++++++--------
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    | 50 ++++++++--------------
>  2 files changed, 42 insertions(+), 50 deletions(-)

Here is the summary with links:
  - [net-next,1/9] net: stmmac: lpc18xx: convert to PHY_INTF_SEL_x
    https://git.kernel.org/netdev/net-next/c/5636fcdb0211
  - [net-next,2/9] net: stmmac: lpc18xx: use PHY_INTF_SEL_x directly
    https://git.kernel.org/netdev/net-next/c/eb0533c7e63b
  - [net-next,3/9] net: stmmac: lpc18xx: use stmmac_get_phy_intf_sel()
    https://git.kernel.org/netdev/net-next/c/9882f1219408
  - [net-next,4/9] net: stmmac: lpc18xx: validate phy_intf_sel
    https://git.kernel.org/netdev/net-next/c/4bad4219249f
  - [net-next,5/9] net: stmmac: lpc18xx: use ->set_phy_intf_sel()
    https://git.kernel.org/netdev/net-next/c/7fe0e06a7364
  - [net-next,6/9] net: stmmac: sti: use PHY_INTF_SEL_x to select PHY interface
    https://git.kernel.org/netdev/net-next/c/9cd23c02ac57
  - [net-next,7/9] net: stmmac: sti: use PHY_INTF_SEL_x directly
    https://git.kernel.org/netdev/net-next/c/bd5a68159259
  - [net-next,8/9] net: stmmac: sti: use stmmac_get_phy_intf_sel()
    https://git.kernel.org/netdev/net-next/c/ef5e870be90f
  - [net-next,9/9] net: stmmac: sti: use ->set_phy_intf_sel()
    https://git.kernel.org/netdev/net-next/c/e3c8f25cf2aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



