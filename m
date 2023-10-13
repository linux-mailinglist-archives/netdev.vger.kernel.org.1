Return-Path: <netdev+bounces-40897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7EC7C9161
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27281C20B19
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441392C87B;
	Fri, 13 Oct 2023 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RThRKjwZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C32C869
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 23:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B35BC433CA;
	Fri, 13 Oct 2023 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697240422;
	bh=cIBbBEoDCeemOYg/TWHSK7glFjjTNw/tuJCkQesJoJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RThRKjwZw5oTrzj/ehWUT0wrcYF9YDgeDYlt7Ac9gf7wQAnFTVja2U8pu0jlPfo0g
	 GC++w7mmab/QkQk2e7TIHrzG6EqsNls+A5LyoEVEHO8Z91VjSk3l1+xbJegLq6shXM
	 Af+uPR/fIwOQFj1RGtDDGYQiH/XJ0MbD9d1ZtS2OEryRTjbouc1rONBLricMSPP1jk
	 zgQ4Bqcp/2QtTGHc5RQlch+ntEryt0zzmSlsK6lWMS2mTeuNoz/tCsChfwTkgVb1b4
	 68yPHDwGam4NKAqYWqQ73Z7VIBqzShMeK533jLJmQx1CIjqFKb2TuToBxjfrewryJv
	 WVGxYtcwn6ZIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71BAEE1F666;
	Fri, 13 Oct 2023 23:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: dsa: bcm_sf2: Fix possible memory leak in
 bcm_sf2_mdio_register()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724042246.991.1362342921975065108.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 23:40:22 +0000
References: <20231011032419.2423290-1-ruanjinjie@huawei.com>
In-Reply-To: <20231011032419.2423290-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 11:24:19 +0800 you wrote:
> In bcm_sf2_mdio_register(), the class_find_device() will call get_device()
> to increment reference count for priv->master_mii_bus->dev if
> of_mdio_find_bus() succeeds. If mdiobus_alloc() or mdiobus_register()
> fails, it will call get_device() twice without decrement reference count
> for the device. And it is the same if bcm_sf2_mdio_register() succeeds but
> fails in bcm_sf2_sw_probe(), or if bcm_sf2_sw_probe() succeeds. If the
> reference count has not decremented to zero, the dev related resource will
> not be freed.
> 
> [...]

Here is the summary with links:
  - [v3] net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register()
    https://git.kernel.org/netdev/net/c/61b40cefe51a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



