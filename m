Return-Path: <netdev+bounces-17852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530CA753473
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD1281E56
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A5748D;
	Fri, 14 Jul 2023 08:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01D7485
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2349AC433CB;
	Fri, 14 Jul 2023 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689321623;
	bh=3L4dficg1XpxI6I9oVcETUQzYBmSnqL7G/ZAG4fHi5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GN27g4FWiacWpcUmSlQGigv0FnbPl6hjSDjpW6f5pstLoeodz+f/zHFX4OsHcFqc9
	 Mb3kH4yvIEjdFwgQgO2v8Q8Bcus4e42EETfyT109A8ZgOHdMx4QxP0YqytcWNOm27B
	 pvkP5y8uExuOWv0RKqyNJochhcsFCuF23K/uSWjNMxZxPujdhToEMYwbEEUiM2+c8h
	 og5ztdtio99Xe7gAq8EZsFgeEdJfv5plqF/MN+hp+Bwjd3+vVqCpA4xJiawohflIJq
	 HgFpRxwStdCHgNeYh9YlGd9TGDZQj1LaBDgWddlQDY3ZKvvkRRYaqybpQtAEzMy1KB
	 ToyUvKEgmZ/dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EC21E4508F;
	Fri, 14 Jul 2023 08:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] Convert mv88e6xxx to phylink_pcs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932162305.21677.4150891719279129759.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 08:00:23 +0000
References: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
In-Reply-To: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 09:41:24 +0100 you wrote:
> Hi,
> 
> This series (previously posted with further patches on the 26 June as
> RFC) converts mv88e6xxx to phylink_pcs, and thus moves it from being
> a pre-March 2020 legacy driver.
> 
> The first four patches lay the ground-work for the conversion by
> adding four new methods to the phylink_pcs operations structure:
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] net: phylink: add pcs_enable()/pcs_disable() methods
    https://git.kernel.org/netdev/net-next/c/90ef0a7b0622
  - [net-next,02/11] net: phylink: add pcs_pre_config()/pcs_post_config() methods
    https://git.kernel.org/netdev/net-next/c/aee6098822ed
  - [net-next,03/11] net: phylink: add support for PCS link change notifications
    https://git.kernel.org/netdev/net-next/c/24699cc1ff3e
  - [net-next,04/11] net: mdio: add unlocked mdiobus and mdiodev bus accessors
    https://git.kernel.org/netdev/net-next/c/e6a45700e7e1
  - [net-next,05/11] net: dsa: mv88e6xxx: remove handling for DSA and CPU ports
    https://git.kernel.org/netdev/net-next/c/40da0c32c3fc
  - [net-next,06/11] net: dsa: mv88e6xxx: add infrastructure for phylink_pcs
    https://git.kernel.org/netdev/net-next/c/b92143d4420f
  - [net-next,07/11] net: dsa: mv88e6xxx: export mv88e6xxx_pcs_decode_state()
    https://git.kernel.org/netdev/net-next/c/05407b0ebc39
  - [net-next,08/11] net: dsa: mv88e6xxx: convert 88e6185 to phylink_pcs
    https://git.kernel.org/netdev/net-next/c/4aabe35c385c
  - [net-next,09/11] net: dsa: mv88e6xxx: convert 88e6352 to phylink_pcs
    https://git.kernel.org/netdev/net-next/c/85764555442f
  - [net-next,10/11] net: dsa: mv88e6xxx: convert 88e639x to phylink_pcs
    https://git.kernel.org/netdev/net-next/c/e5b732a275f5
  - [net-next,11/11] net: dsa: mv88e6xxx: cleanup after phylink_pcs conversion
    https://git.kernel.org/netdev/net-next/c/d20acfdd3f88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



