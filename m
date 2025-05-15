Return-Path: <netdev+bounces-190670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27DAAB8428
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC0A27B496F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10D522540A;
	Thu, 15 May 2025 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY4OiPzX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B71CAA98;
	Thu, 15 May 2025 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747305592; cv=none; b=c2I5oN2Tx+r+XSJBHwXy2LWKb4kvT8u9F/FINEolSuMEnJfJhjfRl670caJ3koYF7M8FBman4fxlVDd5FRpH7F/0PpFUkLgVXw1GjTm4lPjYgw3yEiB8UU9g/562+40keRplDzko4oZjTxb5Krn9/V+YhFStxUNtQKywBhMGLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747305592; c=relaxed/simple;
	bh=nMCx/mXgH/BQ6Zv86Lf/IXBEHhHVXu6pt6p783d412k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kLaV+j/7aIC/UQsSjIso6Kf4dPORJo7DWdUgQYI97gmVdadSPSvllYsfB9G+fLvm4ZBGTg1seOBmzLgV/FTA1vI+wp67OnOnEETnFrORNvq0mruHvy/q9PEVSryJ7Er7D8e4+YrNGXbWTL4KKicJgjpkqMavjoBI8MeWDNzXlx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY4OiPzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A6CC4CEE7;
	Thu, 15 May 2025 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747305592;
	bh=nMCx/mXgH/BQ6Zv86Lf/IXBEHhHVXu6pt6p783d412k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fY4OiPzXM0ZAAYC51dhDyR31b/W3hzTA0ga8nxi5bKUgw2TR5VYDsmoulHjzfVwxC
	 o6VdC8eYTsQRnqgvj/uneH/zqU8qRwDYtXLJ3vckXhcSumGma6hoQGmohEWLdd1kwK
	 Gp90CjlFIjlxHqs40UEBLRk3o/67jRP2Fa9KDvknS/F/Ug16V1zMmz+NEKNnrbqlyE
	 btbHwwziarrm3lLuGTdvz5D9u3/socmGatTkhEavvkT7vbseaijIuIgW3eNbLsyUas
	 4e6Wb2YBjHfIa0gJhkm1z2hkCFalCIzSXxAA87Sx4QF4Y3iHvZvdH9dqZP39/kKFM0
	 1e7iz+ays5oNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F713806659;
	Thu, 15 May 2025 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: phy: marvell-88q2xxx: Enable temperature
 measurement in probe again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174730562926.3056934.652350809389040245.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 10:40:29 +0000
References: <20250512-marvell-88q2xxx-hwmon-enable-at-probe-v4-1-9256a5c8f603@gmail.com>
In-Reply-To: <20250512-marvell-88q2xxx-hwmon-enable-at-probe-v4-1-9256a5c8f603@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 niklas.soderlund+renesas@ragnatech.se, gregor.herburger@ew.tq-group.com,
 eichest@gmail.com, geert@linux-m68k.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 May 2025 14:03:42 +0200 you wrote:
> Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
> mv88q222x_config_init with the consequence that the sensor is only
> usable when the PHY is configured. Enable the sensor in
> mv88q2xxx_hwmon_probe as well to fix this.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: phy: marvell-88q2xxx: Enable temperature measurement in probe again
    https://git.kernel.org/netdev/net-next/c/10465365f3b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



