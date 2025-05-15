Return-Path: <netdev+bounces-190591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A6AB7B87
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D77B63D2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092B0288C80;
	Thu, 15 May 2025 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrvzxz/3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51AB1EA7C2;
	Thu, 15 May 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747275601; cv=none; b=VuhkTLFUMFtZ+G0AD3vfftdsDXaRKRwBAJwelCpeli2vU4Ofb9EwuCFM6QyhNApBwMFg8YOFswO20a83QH8gbowp78M33U/T5bdzLqZ56bWx1F8SHIq+jS1X9Aizx2XxNWABcryw7GqAg2pw5lR///PnUdYY4HG+Mmr7MR/heuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747275601; c=relaxed/simple;
	bh=hgksmwj8UrYlGHHwWD3HsRnyJNAn2rovwNQR0Fw1FQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L4/xYgFDg3djPZm2MKZVZVltEFgBnHxT9VFZsXa6flVU2aamfEGMoT/XJZduyLerXuz7ebif782u/2RMAXWPob6t1rAakLmPls7HTCmQsZcanX7372/b5rTFyxkjNe30xIwBvTaiN8a7arzzAJ4BOdgA4sHPGM7Eiee8lnQj5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrvzxz/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427C2C4CEF1;
	Thu, 15 May 2025 02:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747275601;
	bh=hgksmwj8UrYlGHHwWD3HsRnyJNAn2rovwNQR0Fw1FQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lrvzxz/3XjJx/sSGr466s3EocUeLsmCZs/tdo6GjCR3FSVKK79V1iywvXXxJhuXtz
	 ibvZGkFlmFcslWaNjIhekccUElk/Up/9unAf7HPgNfZNVPA8RgOX2B+fPGKaisar5Z
	 abDNVwwhJg+ImpNvNRritXlYIbvfkoT6yaRSsyV844rxL7AY8Z+skDdbVzdeCSo1B2
	 3vock3KTEkXyNc/7G5MtmoxNUNxVZq6NJW4grzBxxsM8ctyal9SW+Wyd8VL4s/usRi
	 lS+6kbrs5hplxqmIJTeIKcfkikdorI9iTOzLlPY26uhGyOL6JlTV/6Nxp7ksH8Aatf
	 XtT72kyZZC5qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF8380AA66;
	Thu, 15 May 2025 02:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESUBMIT net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727563825.2582097.14870007817374073417.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:20:38 +0000
References: <27cba535-f507-4b32-84a3-0744c783a465@gmail.com>
In-Reply-To: <27cba535-f507-4b32-84a3-0744c783a465@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 claudiu.manoil@nxp.com, olteanv@gmail.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 May 2025 23:13:25 +0200 you wrote:
> MDIO_DEVRES is only set where PHYLIB/PHYLINK are set which
> select MDIO_DEVRES. So we can remove this symbol.
> 
> Note: Due to circular module dependencies we can't simply
>       make mdio_devres.c part of phylib.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [RESUBMIT,net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
    https://git.kernel.org/netdev/net-next/c/73d952840d9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



