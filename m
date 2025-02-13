Return-Path: <netdev+bounces-165786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D77A3363D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9853A664C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C618D205E2E;
	Thu, 13 Feb 2025 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1cQn/FO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2E205E23
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418008; cv=none; b=LJScxFIFoBt+2yPCW+2NvF51f+j1YPo2NVCCDC7Z7DEHKE49317My1GINT+zsuaxOrpaH3GF1OjhggfV5INgJJku5PRHOukXZ0b9vBMphFd0iQLvLmnKpYaeIv5ZHXVRbgtl4Du0218c4ZWoayBfeEQAs9PWseuPCDACW5/kIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418008; c=relaxed/simple;
	bh=47fkl5jB1AePFTNmClf5l/q5foDDtpswoxq6Q/otrc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VzVaaJyvLTL3hRAJLgnQwTeg8BefMmwOQrLX30IyvgMk0wyvE2CHVllG4MNlgi3HBoXFNEgvoF4Cs7DlWYhujRjYIBVEAyf3fuRaHzXM7REHOHm/r2H/Joljb45qHssWTCUS3zaNszW/wpoRFvgiqgNHDv7Yen6MNMC9Ti3xa8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1cQn/FO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254F7C4CED1;
	Thu, 13 Feb 2025 03:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739418008;
	bh=47fkl5jB1AePFTNmClf5l/q5foDDtpswoxq6Q/otrc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H1cQn/FO9QH+VL/WqtME+3CVl2UP5uFlPui9cpd4GYkKTMu8lPVuYCCuh+AAONBWV
	 lzxa4XngmGbqckwJV/HvRbC8gKSOo++sl/g+kcMhUOmOEUiX/aU2AdAcYXVn3Motgg
	 16xvq2LrlMBwrk3xCdbKYnZ/p0xpHl5lDy33E7ezJ7SVp5HvRDbMdvNSfE898jdXzr
	 LbXzUqjt4FRYWpHfivayoSJ/ygdfRepiHqoFYKELy4KqviiKPkRwMBoySBZA9ekxur
	 5yOH0EBOo1ZmGWLtyjYt8Xq7LNsmPYH+NM/Rv81e3TcuQhZfI6Y6my8VML5YOxXW75
	 HzCyBB5XzGc2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F8B380CEDC;
	Thu, 13 Feb 2025 03:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/3] net: phylink: provide
 phylink_mac_implements_lpi()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173941803725.748910.14257112590472895910.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 03:40:37 +0000
References: <E1thR9g-003vX6-4s@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1thR9g-003vX6-4s@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, davem@davemloft.net, dqfext@gmail.com,
 edumazet@google.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, sean.wang@mediatek.com,
 horms@kernel.org, olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 10:36:44 +0000 you wrote:
> Provide a helper to determine whether the MAC operations structure
> implements the LPI operations, which will be used by both phylink and
> DSA.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c |  3 +--
>  include/linux/phylink.h   | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next,v3,1/3] net: phylink: provide phylink_mac_implements_lpi()
    https://git.kernel.org/netdev/net-next/c/2001d21592e5
  - [net-next,v3,2/3] net: dsa: allow use of phylink managed EEE support
    https://git.kernel.org/netdev/net-next/c/b8927bd44f78
  - [net-next,v3,3/3] net: dsa: mt7530: convert to phylink managed EEE
    https://git.kernel.org/netdev/net-next/c/9cf21773f535

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



