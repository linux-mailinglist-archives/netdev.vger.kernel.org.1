Return-Path: <netdev+bounces-176819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B6AA6C496
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D431B611B0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 20:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833CA231C87;
	Fri, 21 Mar 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6F1PEOK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B3231A3F
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590200; cv=none; b=elAPkdNspOihej6G2GgjINkXz9vjnES4hxJsZOgjuObqTX3Pq3ahqVqTZ4ADFZzsVpIU8UqVAIKVHto0YhQX0H2OZLwUU+4adP/L405/v7egYZQTB4aOnfL6w67ZZKiCOV+rcMBPpDDgbXphnywHeAXbro2KlQTD/B2n+mczgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590200; c=relaxed/simple;
	bh=DQpLHfQi1cWf6zI5gcc1psD3v7nQD+6SGvuVMIxnlH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cVfM0JrWX8tLUMs/y7BpalaFR9LF3ITSnM+hOT6KwK8hoZetXIkqYAt9yghgAYc1jzyrDG4lnaWS9r9PFEx+XbayGy5DabobDEl3DZtyowXSznSgqxTHqXMIG/8QTiCIsqTyjGb9uuKKxJ6jhrtBGHdfSBMwIbVradbAjDHylXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6F1PEOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FF6C4CEE7;
	Fri, 21 Mar 2025 20:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742590200;
	bh=DQpLHfQi1cWf6zI5gcc1psD3v7nQD+6SGvuVMIxnlH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s6F1PEOKtUbVET2CyM6O26WU1+UJ26mG65zqPIsX7HuIP+2LGu5nFZn3QDooE43WP
	 XiMn4QXPRT+zA3AOXBR16oC1V+taHobNrsdQXrSiLyHsGsj99oLyn64nJl2oJTsXV2
	 b7FmNrJj5XW7fTgE7mHswUhRqhhuYLU2Z9Hqy9tOn3Y6+feytcRC1t8KcToQCF/dHR
	 o5fSiszCjtBPYHdx+zVD0RltotjAdKjtXO8TQli6nSzFCCQLHJ1Flu5yKE06wujjUf
	 EQQnwHdgHQpkiJKHF8WHHK9PfLxmA+GHCG3aXaPxsefr7JEB7i6KEiUMOJbMwgtr7J
	 b8UReuWTaRnLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711E53806659;
	Fri, 21 Mar 2025 20:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fix genphy_c45_eee_is_active() for
 disabled EEE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174259023600.2618986.2107650390226882487.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 20:50:36 +0000
References: <E1ttmWN-0077Mb-Q6@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1ttmWN-0077Mb-Q6@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Mar 2025 11:51:11 +0000 you wrote:
> Commit 809265fe96fe ("net: phy: c45: remove local advertisement
> parameter from genphy_c45_eee_is_active") stopped reading the local
> advertisement from the PHY earlier in this development cycle, which
> broke "ethtool --set-eee ethX eee off".
> 
> When ethtool is used to set EEE off, genphy_c45_eee_is_active()
> indicates that EEE was active if the link partner reported an
> advertisement, which causes phylib to set phydev->enable_tx_lpi on
> link up, despite our local advertisement in hardware being empty.
> However, phydev->advertising_eee is preserved while EEE is turned off,
> which leads to genphy_c45_eee_is_active() incorrectly reporting that
> EEE is active.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: fix genphy_c45_eee_is_active() for disabled EEE
    https://git.kernel.org/netdev/net-next/c/4b9235a880f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



