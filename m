Return-Path: <netdev+bounces-151300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9169F9EDE92
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0ACF282854
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40558166308;
	Thu, 12 Dec 2024 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0OPpF6J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961B165EE8
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978424; cv=none; b=spB+viP0QmAAOhH7/AUOTX8pCjeFbQ498Akmjt+sG8Cvjate64agp02v7dI91Ef6TTGSKBfblTB4DSJ60UU5z62K+P8UYJ+qA3e7WoEn3vPbsKq0eNyDjG+yubCehLi3g3N+l05jqHwd1ofc0gUjsOUPtnhlN72SyaVX4TU/n4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978424; c=relaxed/simple;
	bh=OhmCN48ULBLuuzKg8+AywTK0ty+kB4kqBPF6I6N80sw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fo+LbdZ21l4rV+a4UBMTcj7TNVknTX/y5WxlLt3iGOm53Kkpdn/mKKk9kyLNOp/qyVQqfpvxYeDBGW2ZcK06qfY2decLclh/p5oW1P1jmUbzg/XqpjFVVEpST88Y2MB0jqRti2Q7oKPyATkopFbNZD/boqQWtIqRcYxizlXLlt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0OPpF6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95C6C4CECE;
	Thu, 12 Dec 2024 04:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733978423;
	bh=OhmCN48ULBLuuzKg8+AywTK0ty+kB4kqBPF6I6N80sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t0OPpF6JmKJTeR7LpTw9iqmJ5glyjRuw0YZU0YldMfSEThlO3/UkcRrruST+7qg1O
	 WGPzuRdpQ1Vlh77YfA0yFWXXq5Db40WVngtSY4mlYtu7Mj5AD3mw/tAm/HOATG2ovG
	 9kz21Sr2ZMiD1HRBdlDJ5rEUq4s8tGVo1QZZXvrZhMAnfQvyqdA0oAiBTrj4cAGDzZ
	 eCsD1IAn72uCIn9fyz4I+aHPQRBNYt5K0YyXYoY4V9bf14f//8i10pIkq/ZDcSIZvI
	 QEnvyENMu35C8Y4+tBgzS9VvB5ECKqy8eRx4qhykI5IBOOaUdmxXk8D/l7Uu7J8XDS
	 lf3Qotb0CxEKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342A6380A959;
	Thu, 12 Dec 2024 04:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: dsa: cleanup EEE (part 1)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397843974.1849456.11438174584563074655.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:40:39 +0000
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
In-Reply-To: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
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

On Tue, 10 Dec 2024 14:17:52 +0000 you wrote:
> Hi,
> 
> First part of DSA EEE cleanups.
> 
> Patch 1 removes a useless test that is always false. dp->pl will always
> be set for user ports, so !dp->pl in the EEE methods will always be
> false.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: dsa: remove check for dp->pl in EEE methods
    https://git.kernel.org/netdev/net-next/c/66c366392e55
  - [net-next,2/9] net: dsa: add hook to determine whether EEE is supported
    https://git.kernel.org/netdev/net-next/c/9723a77318b7
  - [net-next,3/9] net: dsa: provide implementation of .support_eee()
    https://git.kernel.org/netdev/net-next/c/99379f587278
  - [net-next,4/9] net: dsa: b53/bcm_sf2: implement .support_eee() method
    https://git.kernel.org/netdev/net-next/c/c86692fc2cb7
  - [net-next,5/9] net: dsa: mt753x: implement .support_eee() method
    https://git.kernel.org/netdev/net-next/c/7eb4f3d9fe17
  - [net-next,6/9] net: dsa: qca8k: implement .support_eee() method
    https://git.kernel.org/netdev/net-next/c/fe3ef44385b2
  - [net-next,7/9] net: dsa: mv88e6xxx: implement .support_eee() method
    https://git.kernel.org/netdev/net-next/c/eb3126e720e7
  - [net-next,8/9] net: dsa: ksz: implement .support_eee() method
    https://git.kernel.org/netdev/net-next/c/801fd546c1ca
  - [net-next,9/9] net: dsa: require .support_eee() method to be implemented
    https://git.kernel.org/netdev/net-next/c/88325a291a0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



