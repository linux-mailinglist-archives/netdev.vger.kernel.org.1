Return-Path: <netdev+bounces-217101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CECB3760C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773E92A7E01
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFCB13AD3F;
	Wed, 27 Aug 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGJavzY8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AC22F01;
	Wed, 27 Aug 2025 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756254002; cv=none; b=Q5fovoKbPsEugnqiMWwxcPN/0bZTslbanri4cYFIpRDbx5ipQXeQwKGnnmPzzXQQUa/GCBxIxJr5D4p4ECd1/EpjXpi7IvgH0WdCAKZcdN9FnuGe8Kda0MpEKJkgLnvO3PcJk2Ldj8Zywu/it0RHkKPUrwRkZuV8mtw1x6WyQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756254002; c=relaxed/simple;
	bh=J1bzsFa9Jwl7+CCxqKUMFXa6jzXKbK1HESdYY399i2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Joza2wUTSM0jBgJzS0JPTrAy0oIuEYRn7RrqCjh1bksFNtMBigp4onLjNXlLGkwT2gBsSQeULSK2scNhvWnfPSiLHSBs/mOe2c30LRlpCApQ45VSJed0cDTDw/nLzOkGUj0vSgsF1Yy5F+Kcm3UAKEvEOllA7zjv+AQbtj+sz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGJavzY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A7FC4CEF4;
	Wed, 27 Aug 2025 00:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756254001;
	bh=J1bzsFa9Jwl7+CCxqKUMFXa6jzXKbK1HESdYY399i2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bGJavzY85V2M5qgEAWUwkiJxhruLxoJaDUTsAKZI/i+xAheSBCiEFY/b++EX8Hced
	 IIeOq/gMAUEm5l5u9QsjDp7tQLG+AsMfoRt/oFrNWVtVArriib9WnjMUOsFpsHh8Qw
	 WJBeMpfkRnqS9w2LS6JQCKVUFCxr7Bk7bGm2hsjXj5xbkPgwALEmeziOakHSFmM2fH
	 UP4hPlv23Xsp0XHwJ+DmdV5Rm9ys4k8vUeX875XEfEcLNYwHnd2tKuRcoYFRSSuaZF
	 FxvrPx7Tg3GCqknUe7qwUWfneEFjcg/BYoLKMxI234QRi3ExDhZ5pMRS5I7FKlrme1
	 kZKWBVFdMFGcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FFC383BF70;
	Wed, 27 Aug 2025 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] phy: mscc: Fix when PTP clock is register and
 unregister
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625400900.147674.5714913094529726557.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 00:20:09 +0000
References: <20250825065543.2916334-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250825065543.2916334-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vladimir.oltean@nxp.com,
 rmk+kernel@armlinux.org.uk, vadim.fedorenko@linux.dev,
 christophe.jaillet@wanadoo.fr, rosenp@gmail.com, viro@zeniv.linux.org.uk,
 atenart@kernel.org, quentin.schulz@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 08:55:43 +0200 you wrote:
> It looks like that every time when the interface was set down and up the
> driver was creating a new ptp clock. On top of this the function
> ptp_clock_unregister was never called.
> Therefore fix this by calling ptp_clock_register and initialize the
> mii_ts struct inside the probe function and call ptp_clock_unregister when
> driver is removed.
> 
> [...]

Here is the summary with links:
  - [net,v2] phy: mscc: Fix when PTP clock is register and unregister
    https://git.kernel.org/netdev/net/c/882e57cbc720

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



