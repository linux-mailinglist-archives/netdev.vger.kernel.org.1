Return-Path: <netdev+bounces-154860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897DA00240
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B303A39B6
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48269148FE6;
	Fri,  3 Jan 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDQWv85O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D88C1F
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735867212; cv=none; b=XoGgWywV1vF2O2Y0UD0URqwwwxNDDH09dzvco+1hZTSqE1y3kFtXpE+feKOXt9fqRR3mITzfcqPbH89wxVMgpU71Qx2gSeLetHGVSm8tXWI6ixB25w37vPoGEBZTtmLTwPCaQvZP4mlWG6MksLwgaV/HicTy273zi42LBRrUZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735867212; c=relaxed/simple;
	bh=uFedELEKZq5wXRSuI3axgZyhefJELKAwP33Cwn3N1qY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ebC/KUFUJdHbKgk/7koWLTaNDktyuHxXTJP2NXfSW4s2sNawMKEzNDek+1iKX1jpA83TOOc7JPeHrLphAsnzubK4PZRfXdwphUBQwZT+lGFvNRW67VDPZmyTxB5Ncx8TjkwHyW/uG2mRSbiAk6ebFn0KiaglKsbQ3TPfiXy5vT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDQWv85O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93492C4CED0;
	Fri,  3 Jan 2025 01:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735867211;
	bh=uFedELEKZq5wXRSuI3axgZyhefJELKAwP33Cwn3N1qY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CDQWv85Ok+Eh7TgNe78UADPOFySv7dJh1JkZDoeRG0htafSyPkEPKf36Iz8Ie3Xoa
	 N2TiqSe+uMYdARfEzoAnE45XJdvHhLEXGJw9lS30I3hFbV0SRObFJJuBEmBHFlF2WN
	 AO6jP1fYu/makcY5GdOccLiBPdKm7KTIBZER8s903VRpHUO2BLoFShz9S9M9Frg3a0
	 HU8WDYkWvXfY9J/vndTbwlUiGRW2V2zoO3AolJi/0ElcXBQWTDNdmMewr+DNZgbOcP
	 uCWeuMKqNybWyJWzXbV4LzXwzzKAiEBa9SkwE8yV+olTa6BtGlkU6yDRcJgsZwpAYF
	 67VmRSQg5aEfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C92380A964;
	Fri,  3 Jan 2025 01:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fix phy_disable_eee
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173586723213.2076853.2920328850119953603.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 01:20:32 +0000
References: <57e2ae5f-4319-413c-b5c4-ebc8d049bc23@gmail.com>
In-Reply-To: <57e2ae5f-4319-413c-b5c4-ebc8d049bc23@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Dec 2024 23:02:06 +0100 you wrote:
> genphy_c45_write_eee_adv() becomes a no-op if phydev->supported_eee
> is cleared. That's not what we want because this function is still
> needed to clear the EEE advertisement register(s).
> Fill phydev->eee_broken_modes instead to ensure that userspace
> can't re-enable EEE advertising.
> 
> Fixes: b55498ff14bd ("net: phy: add phy_disable_eee")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: fix phy_disable_eee
    https://git.kernel.org/netdev/net-next/c/c83ca5a4df7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



