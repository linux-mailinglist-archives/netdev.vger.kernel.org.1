Return-Path: <netdev+bounces-135980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA6E99FE45
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D3B1C234D9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DB74204D;
	Wed, 16 Oct 2024 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDTVw+3W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F74C81;
	Wed, 16 Oct 2024 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042225; cv=none; b=Ll7N5Uosvr/HcNJ3TubmFP+nX8Sj/vi/++q/cuz/sPVEGqoTT09VWbjTb26UK62UF2Bc2gCsaf9PVjlX0FBlihJpc4j6ciUnO5uC2qPMSOc7CSAq3PsRy95EUNIs1C/FZ7IP5ZW4wWmB5NO0Mt3950UJX6R1YlLyiv/eeUiBtGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042225; c=relaxed/simple;
	bh=ijlGRi12j4QC/i/oLZCV62W05SSVkdKRbD6WFDwql3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qDBoWhBSph/gZxP6+ntOAEEy/JFrHbOXq496a1cxq2x7cJUICJTi9D1tt74nZlCyqjYVyNlKckEstIIafxIJC3tywQxMwZMtyn2VhDhwwpahGpJTr56EZCJgbvdvRolMLDlpkYVWJ35x8sVGAfPQGF+b/A9h38y9fCV3ZiCZa/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDTVw+3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04ECC4CEC6;
	Wed, 16 Oct 2024 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729042224;
	bh=ijlGRi12j4QC/i/oLZCV62W05SSVkdKRbD6WFDwql3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dDTVw+3W9OcdpnVvGnlWoG9vR+31VP/SuxuekyAW/a1ZXMgvGknPMUQT81vd5t2ih
	 fAHkSra1LkkV0lCwUTGlXTx7c1/kR+lrjIJt513dVFIIR6mMxE8fjnb8XwmDHyzi5c
	 s9ACk/P2HWyHqI3ku0NTKLTMkmX1DyUO/ET27xmYj0OsoMW7rdciyphwHwDNDtviGx
	 8VybKfBHFvWxNUK/+58UxAqcuUYmVMSdJReks+/t+gePk9UlbRNxpJaNCwG1EhiLwm
	 MqSwPEZVyMeKQjBf47J5QhsBQTfRnlbCrVsqCkzB1A/+eRBPi4+vh9HuRR3K4SMxW6
	 3VOPCLfuXDJgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3448A3809A8A;
	Wed, 16 Oct 2024 01:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net: phy: mdio-bcm-unimac: Add BCM6846 variant
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904222974.1350766.8131356832857908071.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 01:30:29 +0000
References: <20241012-bcm6846-mdio-v1-0-c703ca83e962@linaro.org>
In-Reply-To: <20241012-bcm6846-mdio-v1-0-c703ca83e962@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafal@milecki.pl, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, f.fainelli@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Oct 2024 22:35:21 +0200 you wrote:
> As pointed out by Florian:
> https://lore.kernel.org/linux-devicetree/b542b2e8-115c-4234-a464-e73aa6bece5c@broadcom.com/
> 
> The BCM6846 has a few extra registers and cannot reuse the
> compatible string from other variants of the Unimac
> MDIO block: we need to be able to tell them apart.
> 
> [...]

Here is the summary with links:
  - [1/2] dt-bindings: net: brcm,unimac-mdio: Add bcm6846-mdio
    https://git.kernel.org/netdev/net/c/6ed97afd75cc
  - [2/2] net: phy: mdio-bcm-unimac: Add BCM6846 support
    https://git.kernel.org/netdev/net/c/906b77ca91c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



