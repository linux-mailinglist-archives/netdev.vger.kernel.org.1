Return-Path: <netdev+bounces-221051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BBEB49F63
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098CD4E6A03
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795D12566F2;
	Tue,  9 Sep 2025 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+7lTOww"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503432236FA;
	Tue,  9 Sep 2025 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386205; cv=none; b=jRrPCf5GsHNVRudIuv/gKthtK8wtA2elndqs5fnCDsZJm6nyI3Fj2WIpcILf0KubPVsA5EzSLd91dmlUq9MhHXh+JWzP7lBEt6YRdiDFlxd+A+i61OCn9JhNr8XPUotDRFRpUeJqDbqGpRomog1Wl8jzbP6eSC6BCPmBFf2HJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386205; c=relaxed/simple;
	bh=Nwb3CeAQ/aV6eMdBNafe/mvU2Nvi0M18POJ53oY9sNE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pX+MsgEGmCzG9Kv5FO6hzIBC1Nlfgt9Xl+UgQW2DAcj3juQubSJ/NyTKBOJRYy5bPDGK5LRvZRAJeXPZumCV75GljSfZRMYmA5cDx0ryvrTHHx4Y/ixTAS6s0vHHsYtfq5paS/19HakeBax3jrh326GRdbliAImRh6q8Az8iwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+7lTOww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E67C4CEF1;
	Tue,  9 Sep 2025 02:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757386203;
	bh=Nwb3CeAQ/aV6eMdBNafe/mvU2Nvi0M18POJ53oY9sNE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a+7lTOwwekwK6GBl2TrrGYiO7yqDhVScyiiMJa35VmYUlGgOYgF33UkIFrpcAMfA3
	 J07QDN17QAfV3sG2asL6KCWGDL6JkTGq/s4Hm+ZpJ9NDln6aA00z8cL3UFu99fRZ19
	 FnWq5gn6AhXkRHuBZyAA337nNPZcIsrXGTOzmDV2jkU6uhpOsK4BfYOrU6XBtnuGWo
	 +3QZAhdLu5Z/wHajLzlfBAUzx222M/nBXK+jAqE8yQLONmJo20GM2bHbBFc+QCAG6U
	 NlGyFoQsWi0hY9JNStbWrP8P2nXFcPdkuVAH7nBi00lo1szy/F7W0YGVUF1mTPKRoh
	 tWbCZhN6MSn/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EE8383BF69;
	Tue,  9 Sep 2025 02:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: NXP_TJA11XX: Update Kconfig with TJA1102
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175738620700.122970.16370925494884083168.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 02:50:07 +0000
References: <20250905-tja1102-kconfig-v1-1-a57e6ac4e264@pengutronix.de>
In-Reply-To: <20250905-tja1102-kconfig-v1-1-a57e6ac4e264@pengutronix.de>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 05 Sep 2025 14:20:50 +0200 you wrote:
> Update the Kconfig description to indicate support for the TJA1102.
> 
> Fixes: 8f469506de2a ("net: phy: tja11xx: add initial TJA1102 support")
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>  drivers/net/phy/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - net: phy: NXP_TJA11XX: Update Kconfig with TJA1102 support
    https://git.kernel.org/netdev/net/c/d3b28612bc55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



