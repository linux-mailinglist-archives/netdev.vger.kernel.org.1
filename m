Return-Path: <netdev+bounces-235682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8431CC33B59
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 995C44F2EBD
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59C4220F38;
	Wed,  5 Nov 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVt/zPil"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA121D59C;
	Wed,  5 Nov 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307444; cv=none; b=ey108ODLn4QhwNYW1urXMvAL0/Ue3ALGzkZHAzjSNTCX1gitq7GNpJObE/cxPrjGY6ZTFGKqKB5DFrxTBQq/Y++aZup3ZpXPQMv9KIRZE3EzGf2PalozVo67Y0fn1D00e7ai3d2ppbNBg/YWBriXfI25SFkoI4OD/FRKYIsRUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307444; c=relaxed/simple;
	bh=z4oi/HpSqVyoub6+3kPyVkUQbShj7WYDX50rLQjpVR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZBUbWRC82O7Fzc2XUO+CRhyki4hRfzn9D+bXUMSnQxj1+BVe7sE8c0jUdGDX2a6LkNe1DdIvmGbus5TXt2gHeQn7KRCMLFfgVttpzJ43vfEwctRfbw31oyvfsewKHFwGwD0O8MQcE4cYCAoAIt2+pMQH4BZjGPTJGRt4NFcIV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVt/zPil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31430C19423;
	Wed,  5 Nov 2025 01:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762307444;
	bh=z4oi/HpSqVyoub6+3kPyVkUQbShj7WYDX50rLQjpVR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OVt/zPilbEHpOnsFXU39TjG0Pafmyk/uvQxpNQO0uYwgh9B8ryVaRmgPKrMe/MX/0
	 FEst6QJ9UpST/3DLbIXT0j6EXGx416JwKTf5eT+0zCy25iKdY5LiIEhp1K2gYUpeNv
	 ovTwDWgbEqni8Hj+34rHDD5MEIM+gCeGj8iG1FbFV+EW3VA2IRdTbIKt44rqAFC7zj
	 2b4iV7aL5ee4sn2yIXFP64Q+h5n58eD8fXN9fzhYknYjlgT0BJe7frNtReOf6oj9Aq
	 Zq8AvEH1NNGLleQcpnqjuW6W/p06CJH9RSjx9Io2xcui29VIb8F9eYwLxqoFQvLvTc
	 a6XzqS0Sdh0sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D67380AA54;
	Wed,  5 Nov 2025 01:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] dt-bindings: net: ethernet-phy: clarify when
 compatible must specify PHY ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230741799.3056420.3635928524240635677.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:50:17 +0000
References: 
 <64c52d1a726944a68a308355433e8ef0f82c4240.1762157515.git.buday.csaba@prolan.hu>
In-Reply-To: 
 <64c52d1a726944a68a308355433e8ef0f82c4240.1762157515.git.buday.csaba@prolan.hu>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 09:13:42 +0100 you wrote:
> Change PHY ID description in ethernet-phy.yaml to clarify that a
> PHY ID is required (may -> must) when the PHY requires special
> initialization sequence.
> 
> Link: https://lore.kernel.org/netdev/20251026212026.GA2959311-robh@kernel.org/
> Link: https://lore.kernel.org/netdev/aQIZvDt5gooZSTcp@debianbuilder/
> 
> [...]

Here is the summary with links:
  - [v2,1/1] dt-bindings: net: ethernet-phy: clarify when compatible must specify PHY ID
    https://git.kernel.org/netdev/net-next/c/e0c78fcad2bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



