Return-Path: <netdev+bounces-126765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07AB97265C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA891F24EF5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3227345B;
	Tue, 10 Sep 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2VT1fsF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150973459;
	Tue, 10 Sep 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929438; cv=none; b=SsQZ8YaP3jaj8qrnQ3bwU/9JOx8Wvl4Yuc1Ooatv+dT0dqOdazyVEsVlBE5ftQS9/S7P/sc0JqX2ixl+y3YlNfWdhClt+/naCkUqtyUUDyhVzHXQzUaL33e+6QQhdKj9VZSpGPV284f+AYtXBuT8xYdYquJjnQdXH+ckhPEjWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929438; c=relaxed/simple;
	bh=Qh3NgLyDCme/1y8S6EPJ+UMayrjXxL5z2hkMejHjZvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WIUzk7lC/2kExunkJqdhulXKsYbMIn3cQSr+nLvEuCU/RT+wEWpyjqlimk8cbDE4YUD6eoxUl+6F7iMx8n2QLG8/4YqimH4P7/Sr37ytfBgx4gnDRv7m4F+LnDnUKvtn7DR8q45mw6bBhr5tumxWP8GC9ex9oN8D/AP+9qgAP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2VT1fsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08190C4CEC5;
	Tue, 10 Sep 2024 00:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725929438;
	bh=Qh3NgLyDCme/1y8S6EPJ+UMayrjXxL5z2hkMejHjZvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i2VT1fsFRShsEKJFpLxTSt7qlzxu/i5TkpeTaIr0fIKmKRIxJQqQq4v6H9dAEPfhl
	 3ahYELqB1vQonvniQjollAkNH9cT2jykbdp0VJzt41I8I5WTX/wdZbWIo7ivJ7ZW2F
	 TybkZiLfhxl8PXcjXNwCe6IpwvgN+bw07MOTJfkdaNecPoYLgNQYZeXSZ1ZRSSydGF
	 uDaOR2v2kW5MQr+JIVwzVdEbHEGHPG+4+s7OKocWBtYC2Z5MxVtzyZ1Z2N+KcRe7kT
	 qXpoFC9bTWIdiUuII7tiGLeQoBkOMUwmEqUTmVk6FUKmM/39yPKuW3nuJXm3wP2xIG
	 vqXIMBmaCK6CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D653806654;
	Tue, 10 Sep 2024 00:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Make pa_stats optional
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592943907.3971140.11101129520948827881.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:50:39 +0000
References: <20240906093649.870883-1-danishanwar@ti.com>
In-Reply-To: <20240906093649.870883-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: saikrishnag@marvell.com, robh@kernel.org, jan.kiszka@siemens.com,
 dan.carpenter@linaro.org, diogo.ivo@siemens.com, kory.maincent@bootlin.com,
 hkallweit1@gmail.com, andrew@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, rogerq@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Sep 2024 15:06:49 +0530 you wrote:
> pa_stats is optional in dt bindings, make it optional in driver as well.
> Currently if pa_stats syscon regmap is not found driver returns -ENODEV.
> Fix this by not returning an error in case pa_stats is not found and
> continue generating ethtool stats without pa_stats.
> 
> Fixes: 550ee90ac61c ("net: ti: icssg-prueth: Add support for PA Stats")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ti: icssg-prueth: Make pa_stats optional
    https://git.kernel.org/netdev/net-next/c/9e70eb4a9a8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



