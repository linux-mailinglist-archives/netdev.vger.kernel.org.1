Return-Path: <netdev+bounces-108036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2915C91DA22
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5911F21F10
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0788289C;
	Mon,  1 Jul 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toe1Vs5Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF80824BD;
	Mon,  1 Jul 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823231; cv=none; b=AeQvjWoCwegI1DMOEwl4QYBaOsp2fPOz9xj+2aPRZ2MW5n9xNoYyUq+RWZrdq1YZUhJhhipBKg63d5I/I3Qz7vUbL4SzoelbPTHaRXfuWxG5ATjqDxxq4qmgNm8jQ1XeCc2Z4UIizNaClBKhe69GF7aJlAd++K+hzObE1r27GwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823231; c=relaxed/simple;
	bh=Nr/twGdzhXXrzSzFlfX47IKIyf4UBq+m51p5pippI5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uFdfmKGl7hIrYB2Tzb7JfUlRGA1GA7EVzetIgwVNt7sRfwl5HPHiFY34NZbRhXluPVVygGGFt+cyAwhq38z/6YgL6bDDde5yqQZYIjIjYXXwktdRqz/teKZPOqcSfSseREJ/If9hpdTv0KASKS8h7ZGwXafSMOEhdLrGkN1knfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toe1Vs5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67775C4AF0E;
	Mon,  1 Jul 2024 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719823231;
	bh=Nr/twGdzhXXrzSzFlfX47IKIyf4UBq+m51p5pippI5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=toe1Vs5Q3uZo2G1uEFO1DCxMXbConGUPCiTapQWVZ32tGOUJf4QXMkdJWB5M4o2Ux
	 +Wq2oiPoEjrnkBXkpAjySbxs2ZNj8im5c6FQCybd6UzqR26uYbWZYcUuhXT/gfc8ZP
	 tmAVmb21fgjpM9pJzJSVJQZNYJ2htzP0OIWqJll2jMkpXbMRUMgZZ6+iOJSHzRAfhU
	 N2nx8MW/oTSXVSiopeAXgYPTjtbj7S+stwUEg0ud6yENj0a0znViRYUnTpe/YNqOyc
	 VnA2mqbnbN6Qnn+irc28UccMtaXzUlli+1GlnM27b9QTWQfwhUSAkI2u82U+/lFdTW
	 C31BpAM8ESgoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59830DE8E15;
	Mon,  1 Jul 2024 08:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,PATCH v2] net: phy: realtek: Add support for PHY LEDs on
 RTL8211F
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171982323136.11370.13410351217992324019.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 08:40:31 +0000
References: <20240625204221.265139-1-marex@denx.de>
In-Reply-To: <20240625204221.265139-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, andrew@lunn.ch,
 christophe.roullier@foss.st.com, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, kernel@dh-electronics.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 25 Jun 2024 22:42:17 +0200 you wrote:
> Realtek RTL8211F Ethernet PHY supports 3 LED pins which are used to
> indicate link status and activity. Add minimal LED controller driver
> supporting the most common uses with the 'netdev' trigger.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Christophe Roullier <christophe.roullier@foss.st.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: realtek: Add support for PHY LEDs on RTL8211F
    https://git.kernel.org/netdev/net-next/c/17784801d888

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



