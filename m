Return-Path: <netdev+bounces-128939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C297C848
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D25B287887
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E319D082;
	Thu, 19 Sep 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyt/ZBT/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CEC19D072
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726743627; cv=none; b=oYBHesoFxd6L5BINf94FMfewjyHB9mGo+PTrUFKFuO8dnhs5hNomSZ6xe6Nb1KY21V6X+CZutxm4/nyUhk3ET0VerA1L8PATaaL46LKndRY9K7ZW/lE11P9E9+FHASO8N50GWGWC4rCORd+FfKAstJ0Q29sWbWHv88+PZj8FvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726743627; c=relaxed/simple;
	bh=s4PymhswRybnFjNmC7GVxmWXDmbDpjHN4g8qF7Jzdtw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OJfU0HmSjG9rVMRztokDJdrGFA253KQ+ewbgaDAIWH7ae6RhWN6Je7/WFyOw/iS9O9sSMzd0R2bp7xTNmwFcBR3SKzRi4tws4xSKeu4E6I9VRQP6u6JmLlHSiPm+60NbA5+0ht4z4ntGe5s1sV77VN97kSISl6vUqlxkPySOsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyt/ZBT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79CEC4CEC4;
	Thu, 19 Sep 2024 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726743626;
	bh=s4PymhswRybnFjNmC7GVxmWXDmbDpjHN4g8qF7Jzdtw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hyt/ZBT/ufhDNlrOKxch3XpFVWZ9nCo/IKOKR0z4lHxGYtXfxXkSBTIyvKuZF8p64
	 r1Go6WW9PAGUgOoWiVvzIlHbnPoB83TVdx3qu/sFPIDr++WdBZPp6RnsJ0k6WNQ7+M
	 h35YWdEzcJdMXliVYWO+dqQkqIUw74pjU8+MszBQPB+DEH23q+isZtDC1sdw1cyvue
	 NubdFvntMcxAAfuoTXjTbg0jcd7/hT7qv9Z0X1jRnviYU8kTG2J53krVUkHk/x3tRt
	 n31+Iby0VqizNK6Itfc9zR8nWj/mdyOJ4MmKXBXPbDrCK2z3aXmlZ3Mp6nudWKRYoX
	 EBojCK9eNDYng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D73809A80;
	Thu, 19 Sep 2024 11:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: aquantia: fix -ETIMEDOUT PHY probe failure when
 firmware not present
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172674362877.1509847.6220074723591714494.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 11:00:28 +0000
References: <20240913121230.2620122-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240913121230.2620122-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, bartosz.golaszewski@linaro.org, ansuelsmth@gmail.com,
 xiaoning.wang@nxp.com, jonathanh@nvidia.com, hfdevel@gmx.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Sep 2024 15:12:30 +0300 you wrote:
> The author of the blamed commit apparently did not notice something
> about aqr_wait_reset_complete(): it polls the exact same register -
> MDIO_MMD_VEND1:VEND1_GLOBAL_FW_ID - as aqr_firmware_load().
> 
> Thus, the entire logic after the introduction of aqr_wait_reset_complete() is
> now completely side-stepped, because if aqr_wait_reset_complete()
> succeeds, MDIO_MMD_VEND1:VEND1_GLOBAL_FW_ID could have only been a
> non-zero value. The handling of the case where the register reads as 0
> is dead code, due to the previous -ETIMEDOUT having stopped execution
> and returning a fatal error to the caller. We never attempt to load
> new firmware if no firmware is present.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: aquantia: fix -ETIMEDOUT PHY probe failure when firmware not present
    https://git.kernel.org/netdev/net/c/194ef9d0de90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



