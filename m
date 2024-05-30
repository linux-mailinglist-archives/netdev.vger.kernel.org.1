Return-Path: <netdev+bounces-99421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FD48D4D2F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E0E282805
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75A4186E24;
	Thu, 30 May 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe6CvzJz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC9186E20;
	Thu, 30 May 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077031; cv=none; b=Dk/eHDTNuU8tceZleTdEYoMx6rIksw/TNMAanV1puU75YXRqqlK1ZqMj5YSdD1vn93ivkvubB0cTHvjYCR9OuT3X1VpM9ZIQl3rZYRYFKi2PplSL91dQaHy74j7bWBpc8JhIpFRCkFh3J6b3JkxK7TC44OnzKZWpx1FUYqRnAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077031; c=relaxed/simple;
	bh=hGckIgNxmv6uBg9y6bc94GELhlfy4ylwodgnmLTBRYc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OvAlYpaHcCWpCCX2twzOhL6QlNAx1OlTmUk+FUIii2vsy5Bk3rv0LXwO8OAaMC/hiMk25IT6m2ickCec4GeFJjvXd1UvX6Vioffd0p5cnxSY4aWa686xOeZgz8Ziodck8dXHWcB1CeQSQKqENisNHAQ1WuRtrMcvO94ogdwVGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe6CvzJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82709C32786;
	Thu, 30 May 2024 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717077030;
	bh=hGckIgNxmv6uBg9y6bc94GELhlfy4ylwodgnmLTBRYc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pe6CvzJzWRrT23IbZT5WW0cTm02LLGRs5fC24vfCYB0xAu8LPrsJ7zT2nDQ4d1qI8
	 n3rOmW7GwjHakAIF67ZljyEQXkWdWYt8iK/xpITrOmJmop5ccpUQg5/zS29fPrtuLv
	 33HpsIVAQcyKrUc47lfaJ/OOOGz+XDR86X7xURySrnbxKLDraFpyhmklSlnV8Ze2r+
	 PPYGMnaFeXc0ZmvNpOZ1sm9+MnXAC8ruosV4OTiI+lzMSUwyd8ENIMf3OTkLWEarvY
	 YxnRwYej8W5hrnyy6AaNnFMFJfd0M7989JTbMXPvF7YyUv/gs+28mU5HIykH8kKFZv
	 CqmkiCr25+5HA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68EA0CF21F3;
	Thu, 30 May 2024 13:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] Introduce switch mode support for ICSSG
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171707703042.3699.5639569290133941055.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 13:50:30 +0000
References: <20240528113734.379422-1-danishanwar@ti.com>
In-Reply-To: <20240528113734.379422-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: dan.carpenter@linaro.org, jan.kiszka@siemens.com, horms@kernel.org,
 andrew@lunn.ch, vladimir.oltean@nxp.com, wsa+renesas@sang-engineering.com,
 schnelle@linux.ibm.com, arnd@arndb.de, diogo.ivo@siemens.com,
 rogerq@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
 vigneshr@ti.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 28 May 2024 17:07:31 +0530 you wrote:
> This series adds support for switch-mode for ICSSG driver. This series
> also introduces helper APIs to configure firmware maintained FDB
> (Forwarding Database) and VLAN tables. These APIs are later used by ICSSG
> driver in switch mode.
> 
> Now the driver will boot by default in dual EMAC mode. When first ICSSG
> interface is added to bridge driver will still be in EMAC mode. As soon as
> second ICSSG interface is added to same bridge, switch-mode will be
> enabled and switch firmwares will be loaded to PRU cores. The driver will
> remain in dual EMAC mode if ICSSG interfaces are added to two different
> bridges or if two different interfaces (One ICSSG, one other) is added to
> the same bridge. We'll only enable is_switch_mode flag when two ICSSG
> interfaces are added to same bridge.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] net: ti: icssg-prueth: Add helper functions to configure FDB
    https://git.kernel.org/netdev/net-next/c/487f7323f39a
  - [net-next,v6,2/3] net: ti: icssg-switch: Add switchdev based driver for ethernet switch support
    https://git.kernel.org/netdev/net-next/c/972383aecf43
  - [net-next,v6,3/3] net: ti: icssg-prueth: Add support for ICSSG switch firmware
    https://git.kernel.org/netdev/net-next/c/abd5576b9c57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



