Return-Path: <netdev+bounces-159256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBDEA14F08
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DFE3A8B2D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7AD1FE472;
	Fri, 17 Jan 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiQtpysf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30231FC7F4;
	Fri, 17 Jan 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115809; cv=none; b=e1VYWGEXWvDDUBlVCZxNytONeW4nwSnyivfOu7e9aJ4YmaqLf+mTdSfl1bWDvLB8do090qLA+bVRafrkiAZh2c29RWzabUynJd2hsXi/1qVYZWtUYbOwjUPkPj93C0jGnpqaB6QIEzsStr42aRTcx+kCDHoPCTL8+3DlOKEEeww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115809; c=relaxed/simple;
	bh=wXRh+MgE90380F+Hiedfdd0eYNHQD8GOglGk3g9OmT8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gEY1fEE+iLs8S62rS5GIZD9QhC4OpVNDc8OzoGKP156gsRhu+BbaqCfQEHQh4eOgcLqg5UPtdLdUgWn6VmA/0CEZh1aaqxcFApA2uG5U3UklOLp8OkLi542LOESMyMriAHEX0buGux4uotT+LA7xAI/nQCbJZQhqUDnxXG6mIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiQtpysf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BF4C4CEDD;
	Fri, 17 Jan 2025 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737115808;
	bh=wXRh+MgE90380F+Hiedfdd0eYNHQD8GOglGk3g9OmT8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CiQtpysfX6P8jN/75VlMxtMnm9zKYcP2YWK5zLWgpR9rIUX8s7/bEH+sm7OCpv0wn
	 NB4A9y/HmFq+AZDV4B9le4w4+4pady//Q2qYiADsVSNhw4udHLTd6cLlAfxxLh+axg
	 mG/hz/wEtuUJaj7gs4d4RVNbJXgVPnk6TeskYYBbs5N/E83/ojhXwCA5dlxzg7keNx
	 zejCPHvds2fQuJRwUeiDfxlw12Bn/KSjF6QUTDYaSixjLB7IPjNnjouH4dqZ9yKwqm
	 Z3yrB8pBuW+ft8/KKPFq3Lcf9Yz1I3EoCBv8wwB42kpHknI9r5vrdnAlkFODJiet9g
	 7LGDMMhb2AQ8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADAE380AA69;
	Fri, 17 Jan 2025 12:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net: phy: realtek: fix status when link is down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173711583181.2106602.8643521574570045802.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 12:10:31 +0000
References: <cover.1736951652.git.daniel@makrotopia.org>
In-Reply-To: <cover.1736951652.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Jan 2025 14:43:24 +0000 you wrote:
> The .read_status method for RealTek RTL822x PHYs (both C22 and C45) has
> multilpe issues which result in reporting bogus link partner advertised
> modes as well as speed and duplex while the link is down and no cable
> is plugged in.
> 
> Example: ethtool after disconnecting a 1000M/Full capable link partner,
> now with no wire plugged:
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: phy: realtek: clear 1000Base-T lpa if link is down
    https://git.kernel.org/netdev/net/c/34d5a86ff7bb
  - [net,2/3] net: phy: realtek: clear master_slave_state if link is down
    https://git.kernel.org/netdev/net/c/ea8318cb33e5
  - [net,3/3] net: phy: realtek: always clear NBase-T lpa
    https://git.kernel.org/netdev/net/c/d3eb58549842

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



