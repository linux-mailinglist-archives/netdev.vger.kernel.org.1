Return-Path: <netdev+bounces-198380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34902ADBEA2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0251892D60
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DEF1CAA62;
	Tue, 17 Jun 2025 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO1gvdGB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5E1C9EB1
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124426; cv=none; b=hjnR0rBYH8Ri45VlIJrTxvYJDxfiuk8GV3ZNLxas8P0T2fIYc9ktThaNEhUADTd1xUFHnhuv+u0LG9lG40enZVQDrXVvbdWkb1520ZuQpDst0EC0akqkKpvpWYW8zY/W7LDVSP1ZX6jkyr8jRBfUlvgdKhRGYg4vqQ5IBUJMT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124426; c=relaxed/simple;
	bh=KS6xEnS7ajgbytCVkaAEVPEZ1sHoGxSZklLmkWd+wpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rqdlCUvwFq9T3fbVIXnUSYSSXIpOEoQNazh2g2lpsbZd1W1FDBqsqG0M7hJ0WbLotTV3SBwy33wLwp1MWsJXwAhXhNQVEAAIluC6feIWWPWS2g5q1Ex5jNllZfC5ctTBabubRMw2Skzbq9/C0OsTqrpGD50iO0P/OA/+2ioDJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO1gvdGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3D1C4CEEF;
	Tue, 17 Jun 2025 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124425;
	bh=KS6xEnS7ajgbytCVkaAEVPEZ1sHoGxSZklLmkWd+wpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nO1gvdGBgnawlYWe5ts54/EnlrdbzprmdAe/VbaVL47LzF2eAQ0RMYRYIRUXJ2yq/
	 z20fI/uFj8G5xPibm3AmxVL1y9WeLxdzUT55zLJ9HAC6SGLmAF/5lLVv9sPmGaKWVC
	 rFR51AS8w09XpohyPohUwYX6+rFs8fBsmi6xljY6dyXYpSABCKVWeebu5dCCynU/tV
	 X0XlLmHp2kuCr0QwaFXEd3Hd2+CFdRJehsqMBZtxhO1qXNGlvQSamRDoECinYz2mVr
	 fyn2ORw4BgCJl0uL/bPvHcf8uU/fUIy2YoxSIvkxnmdJLFAutSoV2sqxUOqV7s05Q6
	 68nAnJfUC6axg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8038111D8;
	Tue, 17 Jun 2025 01:40:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: phy: remove phy_driver_is_genphy and
 phy_driver_is_genphy_10g
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175012445449.2579607.10051332109284065985.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 01:40:54 +0000
References: <5778e86e-dd54-4388-b824-6132729ad481@gmail.com>
In-Reply-To: <5778e86e-dd54-4388-b824-6132729ad481@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, andrew@lunn.ch,
 linux@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Jun 2025 22:29:38 +0200 you wrote:
> Replace phy_driver_is_genphy() and phy_driver_is_genphy_10g()
> with a new flag in struct phy_device.
> 
> v2:
> - fix a kdoc issue in patch 2
> 
> Heiner Kallweit (3):
>   net: phy: add flag is_genphy_driven to struct phy_device
>   net: phy: improve phy_driver_is_genphy
>   net: phy: remove phy_driver_is_genphy_10g
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: phy: add flag is_genphy_driven to struct phy_device
    https://git.kernel.org/netdev/net-next/c/2796ff1e3dca
  - [net-next,v2,2/3] net: phy: improve phy_driver_is_genphy
    https://git.kernel.org/netdev/net-next/c/59e74c92e67e
  - [net-next,v2,3/3] net: phy: remove phy_driver_is_genphy_10g
    https://git.kernel.org/netdev/net-next/c/42ed7f7e94da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



