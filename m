Return-Path: <netdev+bounces-236947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C47C42583
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394FE3BB37A
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C72D0610;
	Sat,  8 Nov 2025 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKizb5ZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187342C3276;
	Sat,  8 Nov 2025 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762571434; cv=none; b=qNiLtVS1M1SJoCXo4NJGsUhkVrYUTG9nfrxneXzhVzBle5m/MjK5GLjtqYOVAAWTUdBs9PlQ8Uwzf9I5aG4y8qaQe9/2Q9ObHJ2PiuIYxw7KwhgH+kCPV0Unwc3vKaKDpuGNDt2dZ+DL2/xur9cLyhMNwnU2aISzTuxF5DshCvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762571434; c=relaxed/simple;
	bh=UeGTWScneI+P66n4JLe0LPT4z7q0ke6xxv6WKIVa4D8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lt949JmZedjysEQmU8cJSaTUYXMU2e+piI6D2Tsu+gFaauWdrn3vkWMeGYUGrYk2ghrf7Rmi2NxSDpHKhP4Lzy05Eq/Aw1TweRHTx8CnxE/m33FMvU5dzSwtEwOd6mxfHDUytWggQ39t+ztDAODx1hK0jL31VcmyXwjFX33AQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKizb5ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D103C2BC87;
	Sat,  8 Nov 2025 03:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762571433;
	bh=UeGTWScneI+P66n4JLe0LPT4z7q0ke6xxv6WKIVa4D8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AKizb5ZCqv1U3/2vwbVqk05BEal0Vjicr2SCdU/BsK+GLPnRvsrMVMBl5UPsMYyfp
	 56+3Heysm1L0ilyf6EL6h6rcYb/AJa6wLM0gAeM27fl7wMy3h03jE9jjNKtOLXJ7Iz
	 zqv8jxqIQzDaONo0WGSEcoUUOnFBr96HgCNqSQ2SYrbn8pKgf1tEjxdjq7zskAyEk3
	 bkEJsdPJaKpl5SME4Jy+Ftc5K9BKxI4uKWff7wsCJekn48MxeusnAhW/RzYYD+EIKf
	 Nv5cjWHl+1Lz3P6Wkfra/KuRKWkfn70qZPYyGNIIp5uJinOM+Jv9k5phVAzXnOgNNa
	 XM9jolgczMAoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFCB3A40FCA;
	Sat,  8 Nov 2025 03:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: micrel: lan8814 fix reset of the QSGMII
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257140575.1234263.10784655616924028558.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:10:05 +0000
References: <20251106090637.2030625-1-horatiu.vultur@microchip.com>
In-Reply-To: <20251106090637.2030625-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Divya.Koppera@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 6 Nov 2025 10:06:37 +0100 you wrote:
> The lan8814 is a quad-phy and it is using QSGMII towards the MAC.
> The problem is that everytime when one of the ports is configured then
> the PCS is reseted for all the PHYs. Meaning that the other ports can
> loose traffic until the link is establish again.
> To fix this, do the reset one time for the entire PHY package.
> 
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net] net: phy: micrel: lan8814 fix reset of the QSGMII interface
    https://git.kernel.org/netdev/net/c/96a9178a29a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



