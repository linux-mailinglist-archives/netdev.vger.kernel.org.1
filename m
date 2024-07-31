Return-Path: <netdev+bounces-114360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1118894245C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C017A285E40
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C3CDDD2;
	Wed, 31 Jul 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbJ81ch0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5AD51C;
	Wed, 31 Jul 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391235; cv=none; b=gH3AAmVyXEfEUPbro6rMLG3VYluUaQQAt0ylCO6mLjp6FDbZcRv6TN574wIQUiAwmlpnucMkZ24g+GMTlCLVfycrPDokp8MyBEyujpV9hryWxSD7c/JuCEvUFtj5iP7Ch5sJRnOYx72iZD3oAEcmdODY4ZXmjC86F8YrbCg6SiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391235; c=relaxed/simple;
	bh=hQKNLk6pVfLklWvXYUMjvHWyp7rpxfzzw9u84Pp9LrM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UMPo0/tuTB1iCQdv0fkOfUv58Clj1VWkg9AsXCfGjXpgivpMXKhqHyIX3To3FMf2tCxSSB0ZLX3RylKESQeD14kFcc0T3KO2yQ+BGxCpLOEtVKJom5NBDaPg9zkZvRifZuY8LGmI78Uxbn83WJ8PcViQwTt0uBM0n0utIxjy2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbJ81ch0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DC90C4AF0F;
	Wed, 31 Jul 2024 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722391234;
	bh=hQKNLk6pVfLklWvXYUMjvHWyp7rpxfzzw9u84Pp9LrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sbJ81ch04jC1ajQ1ita2WQoMUd5eZ5K2bp+ab8cWdbGddYkt0U1KN3ETU3KtVPZPa
	 0xkEmk1O7tTl2RAoU7VAexKnyGuptN4iRXLo2bExc0mf+rI9kohTgwZrhV1OEyHauq
	 cSHxkkqU1HZT25OHw0dtGNo7WVH8+7RfT5c9V5D81IF4hqxTaTiSY+WJB+qnMHlG/x
	 oXKYFrfG2ia/H5FlSZvzRs7egr65BlHWgmg45cT6vgmb1mmYGf13UncAzCRFPp6g8c
	 h1iV8l6YIitlq2ugimmjbTHSADqXaIei3tomms5+RGeVHkhaUB3zXIhl8lMOXVh4u6
	 h3JyfsfAdcB5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D926C8E8F0;
	Wed, 31 Jul 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: aquantia: only poll GLOBAL_CFG regs on
 aqr113, aqr113c and aqr115c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172239123457.15322.12268200524389526952.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 02:00:34 +0000
References: <20240729150315.65798-1-brgl@bgdev.pl>
In-Reply-To: <20240729150315.65798-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 atenart@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org, jonathanh@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jul 2024 17:03:14 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Commit 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to
> start returning real values") introduced a workaround for an issue
> observed on aqr115c. However there were never any reports of it
> happening on other models and the workaround has been reported to cause
> and issue on aqr113c (and it may cause the same on any other model not
> supporting 10M mode).
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: aquantia: only poll GLOBAL_CFG regs on aqr113, aqr113c and aqr115c
    https://git.kernel.org/netdev/net/c/a7f3abcf6357

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



