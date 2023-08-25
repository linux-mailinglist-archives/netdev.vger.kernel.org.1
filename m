Return-Path: <netdev+bounces-30562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B37378804A
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D2628172E
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A110117F4;
	Fri, 25 Aug 2023 06:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102A17EA
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F35EC433A9;
	Fri, 25 Aug 2023 06:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692946226;
	bh=S0MDIrw7arnKv6LCt0cOY04g9X4cuJLXfuMY24Hn5YQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s5GQDyQM9z2l043zkw9uLAVlmJYac1FkzRS4NxfHhBoAXa2fV658Srsps0xIatl9C
	 Hoye3Q3uvKKps5aourft7j0apuGM3mj0xA3WGfcPIZo8X77lP7z/xjoUYY23MhOH/Y
	 PyjxL7buku6W7jBOQkA8tI2yxIaGD1u9mJhJdzPlWZId7rRojNKTQr9zr+re9d2osr
	 rtLOyJg0llCE6515Du7tVE7AsqcCTxxoTfJmKz1TJa7duQ+TmztgRzZEU909RQG+8N
	 u3hztPbyVbVrtRcK5xoQIkpCheNyRV+H4Y31tEPv5oWFRwUd5c92+mmA1HuFvTRtWd
	 k3nEzf40JGn1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64A13E33083;
	Fri, 25 Aug 2023 06:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] support more link mode for TXGBE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169294622640.8814.15215249620595657201.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 06:50:26 +0000
References: <20230823061935.415804-1-jiawenwu@trustnetic.com>
In-Reply-To: <20230823061935.415804-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Jose.Abreu@synopsys.com, rmk+kernel@armlinux.org.uk,
 mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 23 Aug 2023 14:19:27 +0800 you wrote:
> There are three new interface mode support for Wangxun 10Gb NICs:
> 1000BASE-X, SGMII and XAUI.
> 
> Specific configurations are added to XPCS. And external PHY attaching
> is added for copper NICs.
> 
> v2 -> v3:
> - add device identifier read
> - restrict pcs soft reset
> - add firmware version warning
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] net: pcs: xpcs: add specific vendor supoprt for Wangxun 10Gb NICs
    https://git.kernel.org/netdev/net-next/c/d55595f04dcc
  - [net-next,v3,2/8] net: pcs: xpcs: support to switch mode for Wangxun NICs
    https://git.kernel.org/netdev/net-next/c/f629acc6f210
  - [net-next,v3,3/8] net: pcs: xpcs: add 1000BASE-X AN interrupt support
    https://git.kernel.org/netdev/net-next/c/2deea43f386d
  - [net-next,v3,4/8] net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
    https://git.kernel.org/netdev/net-next/c/2a22b7ae2fa3
  - [net-next,v3,5/8] net: txgbe: add FW version warning
    https://git.kernel.org/netdev/net-next/c/ab928c24e6cd
  - [net-next,v3,6/8] net: txgbe: support switching mode to 1000BASE-X and SGMII
    https://git.kernel.org/netdev/net-next/c/a4414dd13f21
  - [net-next,v3,7/8] net: txgbe: support copper NIC with external PHY
    https://git.kernel.org/netdev/net-next/c/02b2a6f91b90
  - [net-next,v3,8/8] net: ngbe: move mdio access registers to libwx
    https://git.kernel.org/netdev/net-next/c/ad63f7aa585e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



