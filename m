Return-Path: <netdev+bounces-52372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DE97FE830
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 05:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABA2B20C3D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C09916422;
	Thu, 30 Nov 2023 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSuyBXkb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9313FF6
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6B51C433CB;
	Thu, 30 Nov 2023 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701317430;
	bh=r3xidSqvuI0+dJ3RDOxCjVb9SdHepAtx4m+M0GnP89Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TSuyBXkbXhWwCTY8S9nL1zuvnfSG99c+CCSNrA2sIdSAXJvWeauWLUN6cX8jDvamg
	 6nxdmnWnXl0Kgu7kXXgls+I7QidSlkDce/zrnWwWqHHKnv692kvWzYU3/HA8VIvPZG
	 yV6r76VVYz9qdalutNytV5gEJAmAZiGfkWgtaLFfvGWcqqEnwYT/TppqhjjDjGbUW7
	 l55BcseHfm0bNOHMVT2j+el2skdHmbuWvtuCLMOMlwaswjLmBVt6AV9LUxNNn9LrHY
	 VBbzHfe6jiQsDPFYxJb7s8t7ypzlXG3OvrXRLxCq4qSQt0/H4IZatroNZlx9ysVxzd
	 VmBPwWgFe5xSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD19EE00090;
	Thu, 30 Nov 2023 04:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: adin: allow control of Fast Link Down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131743075.26382.16499099445744319831.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 04:10:30 +0000
References: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
In-Reply-To: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: michael.hennerich@analog.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 16:31:39 +0100 you wrote:
> Add support to allow Fast Link Down (aka "Enhanced link detection") to
> be controlled via the ETHTOOL_PHY_FAST_LINK_DOWN tunable.  These PHYs
> have this feature enabled by default.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/net/phy/adin.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: adin: allow control of Fast Link Down
    https://git.kernel.org/netdev/net-next/c/cb2f01b856ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



