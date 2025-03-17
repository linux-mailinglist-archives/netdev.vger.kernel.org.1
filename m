Return-Path: <netdev+bounces-175453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBFBA65FBD
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D091899210
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139DB1FCCF2;
	Mon, 17 Mar 2025 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evwhXm+W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4C1FECA7
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244610; cv=none; b=QA4+11tCbxdnoNaJH1X1LYJz11khVSjnhQyPLwUl92IiOFOnXbLjYf6oJTQ0qHFnujiqAjGt65L5D7C6z/R6WTu4S3V3F1lSWBFMqQ7v8aGL4JOHYapp3R1GhcFJX7pKn8UcQ5oBimqTpyI7ibCeX7ITwvgFc36yCKkskOokrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244610; c=relaxed/simple;
	bh=g5BnAzf+nzvDJc0dMya1wqEXNwCWDunoySbSq2E3yaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J9NtW3x+SjF6M+yt/TEStRwOdL6NEK+cBg6Qz0XCOgaO1YAgxeNUTMVwgeNidZwPO7jv2yRaZ9GBVkJDnrzQDWtQ+Vea43UzjUy5xSNoKsiawb/mGPxGXcvY61uF9s//CVO4T0g16hgGcxz5IgNO2WDs6OXJenAd0c+hGztEz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evwhXm+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3F0C4CEED;
	Mon, 17 Mar 2025 20:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742244609;
	bh=g5BnAzf+nzvDJc0dMya1wqEXNwCWDunoySbSq2E3yaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=evwhXm+W6f8RC1uQr9NEiKqGsGMx5X/WEWoBAPLZwpPx1BjaZs9g7JwLomPn/9Ffp
	 39eZ/Sqc7c9Nz7a8wCFxSCVHFtfGBAmsIW8SzP0yqg/Kb+2rqX+6QmNwdhDlSLm5TE
	 hClVXZghMRvZdV8j8pc58EBueIBHGJKwgvQ8Vu5dQGcTY/NIMi9VkaIHClCJ+BmKWb
	 mWnwx/KhADiyejjosvuL/kcRbvRddDNlhKlqu7VMNz4A7b4t06BLffTPfKAWLrIctc
	 POhOdIyWtcffhv6m0cyeGnEw1PYFeTRAqPCdN9AZ67z5tPFHDNcLta8gLUL8Of9u1R
	 AJo3ImIFrgT3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEDF380DBE5;
	Mon, 17 Mar 2025 20:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: remove redundant racy tear-down in
 stmmac_dvr_remove()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174224464449.3909531.16032949444811656672.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 20:50:44 +0000
References: <E1tt9Ml-006xIA-EF@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tt9Ml-006xIA-EF@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 18:02:39 +0000 you wrote:
> While the network device is registered, it is published to userspace,
> and thus userspace can change its state. This means calling
> functions such as stmmac_stop_all_dma() and stmmac_mac_set() are
> racy.
> 
> Moreover, unregister_netdev() will unpublish the network device, and
> then if appropriate call the .ndo_stop() method, which is
> stmmac_release(). This will first call phylink_stop() which will
> synchronously take the link down, resulting in stmmac_mac_link_down()
> and stmmac_mac_set(, false) being called.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: remove redundant racy tear-down in stmmac_dvr_remove()
    https://git.kernel.org/netdev/net-next/c/180fa8d0a2cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



