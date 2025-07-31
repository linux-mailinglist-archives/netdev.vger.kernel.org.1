Return-Path: <netdev+bounces-211116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F30B16A17
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3F05607D7
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2FC2AF19;
	Thu, 31 Jul 2025 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhsyZ5NW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9358A2905;
	Thu, 31 Jul 2025 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924793; cv=none; b=agMMaoH4WNxSRuID08/Ls9cj5ovwNCzWU/Sr2WzOW1z1NF9CBSCMnTb/eiFf417OQGIYRYZc6zGSzamNvs75DnJJrU9XR0BRQ3NmE+WLa4YdS7okkuyfHQdgO4G5pbsiRbB6ztWKl7jdSfexbtLJeh367MtuZUyHc8X1bnzklwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924793; c=relaxed/simple;
	bh=k7XvkeKiYXhd0cxDs3X+sMFVkqZGPKJt0md1zrZS4m4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tU2aAPpNLp6LMzdTzX05gOD3z3YCSCDnM9lA6ab6uSOJCjHZNTmB2zFR9fmr0urOBjt0ffvprZ5wWiczgCdjuaov3LdMisi7RuBOc5Og0url/9o5QSwgGX2qdMeZoyUTut8Y9s4uzjg36k9Isujm+DP8MMy8rOwqaoyjWgm9wmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhsyZ5NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1A1C4CEE7;
	Thu, 31 Jul 2025 01:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753924793;
	bh=k7XvkeKiYXhd0cxDs3X+sMFVkqZGPKJt0md1zrZS4m4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DhsyZ5NW+Eip6zvXUUfOPWl/dqFaOyR03bvnT74keWa6OYOpSmf04R2reGPO718ky
	 2G0xAeHCiaTzWTRUCeFoP/flF2RwPgg8A7va+REsslo4Wvo00Jhi889CWdHfOZCHiq
	 6h9qtEV9ThbEU1Zr0Gh3XezY/v3Kn+7lPITfv/c4+eicj8Vx3lpyJx5HvOlY0omjBN
	 X8/nSyETFnmWuqHQZXUkSB8TO9/cPYI2a8TxzUBWda1WsApYstaqz/t4wwy25drR1D
	 yB3mgTtJdOI6I9ePfY9T3ioz84cnJVCbSa9ufyrNjd53Wqk3mxc0EFUJWPXieQWLSI
	 /2Rj4omRoV1Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B15383BF5F;
	Thu, 31 Jul 2025 01:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] phy: mscc: Fix parsing of unicast frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175392480901.2568749.13694986949159868365.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 01:20:09 +0000
References: <20250726140307.3039694-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250726140307.3039694-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, viro@zeniv.linux.org.uk,
 quentin.schulz@bootlin.com, atenart@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Jul 2025 16:03:07 +0200 you wrote:
> According to the 1588 standard, it is possible to use both unicast and
> multicast frames to send the PTP information. It was noticed that if the
> frames were unicast they were not processed by the analyzer meaning that
> they were not timestamped. Therefore fix this to match also these
> unicast frames.
> 
> Fixes: ab2bf9339357 ("net: phy: mscc: 1588 block initialization")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net] phy: mscc: Fix parsing of unicast frames
    https://git.kernel.org/netdev/net/c/6fb5ff63b35b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



