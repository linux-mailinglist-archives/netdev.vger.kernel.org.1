Return-Path: <netdev+bounces-116297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D68A949DE5
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 04:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B141B2428C
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0AC191F88;
	Wed,  7 Aug 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjggGnNk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CBD191F7B;
	Wed,  7 Aug 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998434; cv=none; b=k8majh+GOo93l1Kcs+XXq37xvQijIbkQNXMia6TU8vUodZDf64G/Sz92qvqdwFdaO+98pPr1oLlbrrbF6XdRkEFEkeXdC7Pj0EBNaLpUH5Hb4y22LBzubfxqAg1jh/NRQev7cUSPNLWIqf9pZwGKpjzQ3BqDgS9IHm7mvlVYw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998434; c=relaxed/simple;
	bh=f3Z+wCihOK5J94SSpt+IiGHbdcx/LcE1HqKkYCKaA00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mrZsFGegknrdYKSqADfq6lHyV+eSfWNmP7Grt4EZESpz7rLqYl0EdymvsWezfSK11a2TzNR0FFrRKROn2KCJJYmSyN3fg/4MpyyTqpXRbHZXiUoeWXNC/xuxrh+rRkKHLtSLay+JwUGqy8omGzX8wKnbvu2oOcAJZd4YR1ooNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjggGnNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70E9C32786;
	Wed,  7 Aug 2024 02:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722998434;
	bh=f3Z+wCihOK5J94SSpt+IiGHbdcx/LcE1HqKkYCKaA00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NjggGnNkRqRBCYYrXeyuHzTmLkMeFg9rdEJmjg1vsgZeMuzQWMH6gmbDHH0lGUQrd
	 cHoxOEXL4EW4WKE0ql2LCmOy94JR+s6guo302tVQ4kPhWLY5zAp+JavVIG1YHIAs4z
	 urU1TVvQq7CepG9Pa3EmWkLKryaKpVphChGbDmTs5Z4fNoG4QYsaKmeuRcIaDq8jdH
	 PZhntz6wKVz+CErMCfuWZksN1jnR1fxNCgOA1Ov48NbK7Dabi9g7zwIse6i0Ds+ban
	 LQ+Ohancwxd76RxkNB0BL+dQc5h0egusLTyPemlqpevtoAApZzdZ9VT5vNcqoUGjba
	 zVxCZhJH5DH1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0BF39EFA73;
	Wed,  7 Aug 2024 02:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,v4] net: phy: phy_device: fix PHY WOL enabled,
 PM failed to suspend
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172299843250.1823320.17872095401858701544.git-patchwork-notify@kernel.org>
Date: Wed, 07 Aug 2024 02:40:32 +0000
References: <20240731091537.771391-1-youwan@nfschina.com>
In-Reply-To: <20240731091537.771391-1-youwan@nfschina.com>
To: Youwan Wang <youwan@nfschina.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, wojciech.drewek@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jul 2024 17:15:37 +0800 you wrote:
> If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
> we cannot suspend the PHY. Although the WOL status has been
> checked in phy_suspend(), returning -EBUSY(-16) would cause
> the Power Management (PM) to fail to suspend. Since
> phy_suspend() is an exported symbol (EXPORT_SYMBOL),
> timely error reporting is needed. Therefore, an additional
> check is performed here. If the PHY of the mido bus is enabled
> with WOL, we skip calling phy_suspend() to avoid PM failure.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: phy: phy_device: fix PHY WOL enabled, PM failed to suspend
    https://git.kernel.org/netdev/net-next/c/4f534b7f0c8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



