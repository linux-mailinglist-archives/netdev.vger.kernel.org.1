Return-Path: <netdev+bounces-215550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34577B2F2C6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D5C7BEF32
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06702EB863;
	Thu, 21 Aug 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab32gm+y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902D2641FC;
	Thu, 21 Aug 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766203; cv=none; b=GaedEey3I+x5Dvz2u2/erylHhaAa+njPIgaOkIPr4I16pRagxghVwmAnnzXGER0XPAZ1pkqc5/MpTTyXY1LW35y8TlzSkO0f9O64YMVDiinhGui4napI8CfGOojlSESA5KS7hPOW7ok1a+fU4wazHPYQ+8HOwk21p3azb1Y9HyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766203; c=relaxed/simple;
	bh=uorD+s6RTCZK6xWgBvrtaRd33UyFWBIPNmlokBD8v60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D2IwDrhLs+w5HzFrBxe57Jbo50LyPDAGLmtrdlL7WcUmYsMy+JgWPPebJv8Hchhm3q1KFFMe/DDtsrKUYkcpG7Q67AOqUQH67bNKFrPtFMRcF5ZWdyPZ6AUBRsq0VsB84MyFpirYL8SqfVDDbL80KbVhRCPYUD6XhCD8Uq9UHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab32gm+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6026C4CEEB;
	Thu, 21 Aug 2025 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766203;
	bh=uorD+s6RTCZK6xWgBvrtaRd33UyFWBIPNmlokBD8v60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ab32gm+yDbtJM/o4sXTqtD48EqvCP5OfEKo54d4wSLRdZuRmbYdQ7nZZT40dGDGRG
	 SFLFRek3Nh2nL0am9ic0Z2EC6WfogipbZWoBf46sIU1usG/q0kx1Egls+P71sNxEav
	 JcrvsfCs3XOy49HP2sn2CTWmjX39YhnmbDcopoiPrMVn/snsYK+Uv0eeLDvz82pP+2
	 8xBmVJckFKQVExJ0IlzAVxHvxhIHY4+JEeJiG+IwCSkcF27EW8KHx5a+EjaLYZWWyA
	 Z2SRTXw3T6A/C6nZ0VGmG/H5/2oarwYAwjooEhPuOolD2N4gWV4Hy3iGpJoCwyK9dX
	 lO40SSaFFTh0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C1B383BF5B;
	Thu, 21 Aug 2025 08:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/4] net: phy: micrel: Add support for lan8842
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175576621125.946325.3157798502826280312.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 08:50:11 +0000
References: <20250818075121.1298170-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250818075121.1298170-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, o.rempel@pengutronix.de, alok.a.tiwari@oracle.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Aug 2025 09:51:17 +0200 you wrote:
> Add support for LAN8842 which supports industry-standard SGMII.
> While add this the first 3 patches in the series cleans more the
> driver, they should not introduce any functional changes.
> 
> v4->v5:
> - implement inband_caps and config_inband ops
> - remove unused defines
> - use reverse x-mas tree in lan8842_get_stat function
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/4] net: phy: micrel: Start using PHY_ID_MATCH_MODEL
    https://git.kernel.org/netdev/net-next/c/54e974c71524
  - [net-next,v5,2/4] net: phy: micrel: Introduce lanphy_modify_page_reg
    https://git.kernel.org/netdev/net-next/c/a0de636ed7a2
  - [net-next,v5,3/4] net: phy: micrel: Replace hardcoded pages with defines
    https://git.kernel.org/netdev/net-next/c/d471793a9b67
  - [net-next,v5,4/4] net: phy: micrel: Add support for lan8842
    https://git.kernel.org/netdev/net-next/c/5a774b64cd6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



