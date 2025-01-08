Return-Path: <netdev+bounces-156123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C7A05087
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A9816129A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2514F104;
	Wed,  8 Jan 2025 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy8rG13J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53B645
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302816; cv=none; b=n4szIIotPatfXelnv5ik0+AgiK50QXiknKUmITbhmOdYK8HUSzMHZJFI1teP9rUnnRQqiU/0TtJ9dt807sHp0fKdryNr2D7Rs1Z0GUTvUzcgoHHwX2I1qvK5zS1MiI/6FKE3D/sxYR9sFdZLB4pNnKHlacGoD7S2s+vIilgijzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302816; c=relaxed/simple;
	bh=0VJ0VlDz5rspAVWwLkjGAzUZE+UkfAyNmv+7kf4MH+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UID29a6tK/bsih3IsT/eXxLz8GczoxTHtdvrEPdhgS5rjXbE5aqcScx91cE9S/YOaAX0aDtdczDIB4UXQxnSwFfdgYvJpXIe+wDfZRGWXJIzzOKMTSAvzonqjpb0/9VHfKj0zMNSPwdnx3HtVgKsBDbG2CztR0sElIP1pj6RI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy8rG13J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51431C4CED6;
	Wed,  8 Jan 2025 02:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302816;
	bh=0VJ0VlDz5rspAVWwLkjGAzUZE+UkfAyNmv+7kf4MH+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fy8rG13JaDo9O8wxpSpf55sdRUibKpahbJy65TFwz9NGrJCIJEofGD0msoymIQsty
	 dLtgm6vKbtZ9bdv9mLabILuGCi9qx15m8gkhSwPBlleJFz+AyR3mv43yX7Hvk07cQB
	 IdUbw4DeUDmsdHHZlpXnOHII7bZdO6LAyOf6jhBo7OZzoFsjpohQmlQLnRq0oh5dNb
	 1B9vgxDGcgJDHdG+RYE407KZo0c5dBJqMPRWFxM/QpcjKNsjLs7zoBtcaH1h9PhFSf
	 dlXfoQV5TSrIL13qb6nwW+mNydev+k/VigZnpEMOqTjFdCDy1AsKBHo6B7MI6o1kNw
	 N5Ry83WakCVug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFFA380A97E;
	Wed,  8 Jan 2025 02:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: dsa: cleanup EEE (part 2)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173630283748.168808.8376692486322535765.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 02:20:37 +0000
References: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
In-Reply-To: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com,
 angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
 daniel@makrotopia.org, davem@davemloft.net, dqfext@gmail.com,
 edumazet@google.com, florian.fainelli@broadcom.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 sean.wang@mediatek.com, horms@kernel.org, UNGLinuxDriver@microchip.com,
 olteanv@gmail.com, woojung.huh@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 6 Jan 2025 11:51:31 +0000 you wrote:
> This is part 2 of the DSA EEE cleanups, removing what has become dead
> code as a result of the EEE management phylib now does.
> 
> Patch 1 removes the useless setting of tx_lpi parameters in the
> ksz driver.
> 
> Patch 2 does the same for mt753x.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: dsa: ksz: remove setting of tx_lpi parameters
    https://git.kernel.org/netdev/net-next/c/0945a7b44220
  - [net-next,2/9] net: dsa: mt753x: remove setting of tx_lpi parameters
    https://git.kernel.org/netdev/net-next/c/22cedc609759
  - [net-next,3/9] net: dsa: no longer call ds->ops->get_mac_eee()
    https://git.kernel.org/netdev/net-next/c/60c6e3a59299
  - [net-next,4/9] net: dsa: b53/bcm_sf2: remove b53_get_mac_eee()
    https://git.kernel.org/netdev/net-next/c/08cef9e1b083
  - [net-next,5/9] net: dsa: ksz: remove ksz_get_mac_eee()
    https://git.kernel.org/netdev/net-next/c/e2d1b8090b69
  - [net-next,6/9] net: dsa: mt753x: remove ksz_get_mac_eee()
    https://git.kernel.org/netdev/net-next/c/9e66e8ebe7a9
  - [net-next,7/9] net: dsa: mv88e6xxx: remove mv88e6xxx_get_mac_eee()
    https://git.kernel.org/netdev/net-next/c/d3889a3d1351
  - [net-next,8/9] net: dsa: qca: remove qca8k_get_mac_eee()
    https://git.kernel.org/netdev/net-next/c/d19be79a67b3
  - [net-next,9/9] net: dsa: remove get_mac_eee() method
    https://git.kernel.org/netdev/net-next/c/2fa8b4383d24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



