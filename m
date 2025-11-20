Return-Path: <netdev+bounces-240295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A704C72331
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 05:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5F99E28A98
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33262BE033;
	Thu, 20 Nov 2025 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL7rSFuJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E489285073
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763613664; cv=none; b=fUb5HL4PMEXJnxr/aer7kRapXlvpAgdv+uvYfOXz077J1NKa6bslNXk8rHB2Gokm67GCsbz0ak42++8xTAmG8YNqt9eS5c+huOx1h6aWxHJWfsOX8mbfb6TBRp8cpDZ0h7ZtFkSrPq5cvyJtn0v9BLgGTQnqxYxEMVvXKEx8CEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763613664; c=relaxed/simple;
	bh=lPWTJEJx69fNFFuaAng0InWU2CA0drfHSPxzgh/5LdA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IwlBOED8BW+Olr+lEks+lLI1tkC51VKPbmfFLvU6bjhqX6okzoKZ0INYbSDoNEpAqJgY5mGsmw1Qn0JSKP17/iKTvSLTXcOWN2wLAR8xUOtg4ET/bf+TSC/N6wZ/3rmZucS7hoz6N/sjUxCMYn98vGtECsu9FmgfLcvjlCTOZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL7rSFuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045BEC16AAE;
	Thu, 20 Nov 2025 04:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763613662;
	bh=lPWTJEJx69fNFFuaAng0InWU2CA0drfHSPxzgh/5LdA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oL7rSFuJjdw9DvXmuFAmqOfCcxFDDI6RaYwrw1WB/E2p3s3ncquWEUiB8jqvcYkJ2
	 /6efKo03TVDtEznZUaCz9nFx3Ku3+u8acHhNxDMKp5uycuv36F2wfy4K9fP5FjeiTj
	 7xT2xGKguf+d90W17sxtraSabcfcEP8vtqfQoYw75U3zSOPSwEjvkfnoLC/uXMjbKs
	 Kmvy/WLy0dG76Obw9IlbgQqMoOwVZgOVun7BPjH3yViqgLDadkN/ExAg2mHggZq2TF
	 Iu9tePr/o07tKwpcIHp+HcHFAI/OgA/oLWRAnWIymMPJ+NfTvVk6rZnECSYbei8ayn
	 W9r3hbk5gsULw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFD239EF978;
	Thu, 20 Nov 2025 04:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/6] Disable CLKOUT on RTL8211F(D)(I)-VD-CG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176361362750.1080161.3126660522965896321.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 04:40:27 +0000
References: <20251117234033.345679-1-vladimir.oltean@nxp.com>
In-Reply-To: <20251117234033.345679-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, marex@denx.de, wei.fang@nxp.com,
 xiaoning.wang@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Nov 2025 01:40:27 +0200 you wrote:
> The Realtek RTL8211F(D)(I)-VD-CG is similar to other RTL8211F models in
> that the CLKOUT signal can be turned off - a feature requested to reduce
> EMI, and implemented via "realtek,clkout-disable" as documented in
> Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml.
> 
> It is also dissimilar to said PHY models because it has no PHYCR2
> register, and disabling CLKOUT is done through some other register.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/6] net: phy: realtek: create rtl8211f_config_rgmii_delay()
    https://git.kernel.org/netdev/net-next/c/8e982441ba60
  - [v3,net-next,2/6] net: phy: realtek: eliminate priv->phycr2 variable
    https://git.kernel.org/netdev/net-next/c/27033d069177
  - [v3,net-next,3/6] net: phy: realtek: eliminate has_phycr2 variable
    https://git.kernel.org/netdev/net-next/c/910ac7bfb1af
  - [v3,net-next,4/6] net: phy: realtek: allow CLKOUT to be disabled on RTL8211F(D)(I)-VD-CG
    https://git.kernel.org/netdev/net-next/c/e1a31c41bef6
  - [v3,net-next,5/6] net: phy: realtek: eliminate priv->phycr1 variable
    https://git.kernel.org/netdev/net-next/c/bb78b71faf60
  - [v3,net-next,6/6] net: phy: realtek: create rtl8211f_config_phy_eee() helper
    https://git.kernel.org/netdev/net-next/c/4465ae435ddc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



