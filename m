Return-Path: <netdev+bounces-166644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC7A36BCE
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 04:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6523B2D5C
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 03:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C14199249;
	Sat, 15 Feb 2025 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX+DnA15"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34EC19884C
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591405; cv=none; b=RAHpSBwZyLKCPGX/PHTaU2ova3TqUOgmDktbGXY3p4EwFY6VE5qsujPSVNdE+/fZCiplEn3UeN1XqZGIADDt3OGLbH0hn5bwxvsN+0EZ+XIJ6IO+Pd6rLM5yrnFtaUeQ1n2T56ngi9ZYMcz2YOHj46o9ZFC0Ixkj9sgZIAvOv5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591405; c=relaxed/simple;
	bh=0y2ngeoATrw6Vjwkzovg4e5BL1QI74WGkeRWj3SITrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I3hhWq+XYeW9W1SpphUZ7MPc1RZ672zYT48nkHbWi0ySnknJ6C42i/Wa1hTYptQi7dNnIxyb8cSzsb+3h59H3mfKZCAuY60w1h9GJoQ6TM2qeLIs2sMsMscDHfn9fLxFrsTIiw/d5kaCz7lNh5MoSgjAerkxqcjk6YeN3nJMfQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX+DnA15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66211C4CEEA;
	Sat, 15 Feb 2025 03:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739591404;
	bh=0y2ngeoATrw6Vjwkzovg4e5BL1QI74WGkeRWj3SITrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LX+DnA15rXzKeO/h46AVmBsrDuaVvOH+BwnAYWBwpjJMlaCnxjKw4LamB8obDiKQt
	 EXy1qvX4KDdrU53Yll/t5vbbwS973yUcE2gCxcYf8bSzMyGb0P2UcySBEfR8o+OUDh
	 el5Xzuzp0PlZIdfA/OKgOVwuXTHx2qcY/aIG1d14bHMwYGst6a/OOqi48IhhB6a4ul
	 u9DhG8ZeutPMZm5QvM6ycfPe2wjy/WNNnh2s9OCJEo8q8A+/Rwgrf0faDQycoD41kg
	 seB3Efb97a/WyiAWjlg5mbTurqGf/P9+aCoFC7M0lmniGSzZGCqXCLGpywv09ZGNGM
	 2huvP4C6wRZHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34161380CEE9;
	Sat, 15 Feb 2025 03:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: c45: improve handling of disabled EEE
 modes in generic ethtool functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173959143400.2183234.13182790949584887592.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 03:50:34 +0000
References: <5187c86d-9a5a-482c-974f-cc103ce9738c@gmail.com>
In-Reply-To: <5187c86d-9a5a-482c-974f-cc103ce9738c@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 21:01:42 +0100 you wrote:
> Currently disabled EEE modes are shown as supported in ethtool.
> Change this by filtering them out when populating data->supported
> in genphy_c45_ethtool_get_eee.
> Disabled EEE modes are silently filtered out by genphy_c45_write_eee_adv.
> This is planned to be removed, therefore ensure in
> genphy_c45_ethtool_set_eee that disabled EEE modes are removed from the
> user space provided EEE advertisement. For now keep the current behavior
> to do this silently.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: c45: improve handling of disabled EEE modes in generic ethtool functions
    https://git.kernel.org/netdev/net-next/c/0025fa45253c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



