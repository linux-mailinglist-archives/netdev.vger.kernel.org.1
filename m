Return-Path: <netdev+bounces-185474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E2EA9A942
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D613F18954AA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B062036EC;
	Thu, 24 Apr 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1zDvKUJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE821FC0FA;
	Thu, 24 Apr 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488793; cv=none; b=Kf/k+rhHCp0XNWlld0LET7KgUfJs67vNleDeoUiS5eAlq59GB/sHLwwmH78k3PbHtFxrbK4+A3NrTu5RuggC95cenzsDMcRlY9RWztLNGM0ftaix5q8d0unN+qoXzNvHSgiULzhFZTDrDWZBpfD+aHPeQDinnZRPllflb7lstBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488793; c=relaxed/simple;
	bh=0tvvSnk8ULXJWC8UVXdj328qfDMVzDjjl0icK/+r8Pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MBhGKfKan20f72tEUFreK11hX0PjyTD8gx0RJO/mNZmLRTp9j82+Zo0wHj3jhMo3Vt4KALrjqSx1lu+wOicenP1TIk37U9wJ4le7Nc+r/bE6SY9J0Jl/XIBR4ICniZyP5t8LcICre79jw4Y5vx2GAx3gqi44pr2P9IGuzi1ER+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1zDvKUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926ADC4CEE3;
	Thu, 24 Apr 2025 09:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745488792;
	bh=0tvvSnk8ULXJWC8UVXdj328qfDMVzDjjl0icK/+r8Pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h1zDvKUJt1IfwS1/Fel+frXyQnAD1Gj5eHUh89C36XTplozRDivahhNeTqKdzqEPa
	 ZSjVpW6cWkBwey63ozOw7bxm/Ym/CcE0GOkIyEX4q7d/0wYugu3WDN1uu0+2hXoxN+
	 M99VZ5T2p2OAJp1oscN7ckbOZTB2TY/HcQByBv/zICFNxwPKv+kk0EooORq3+jmRdZ
	 H7e7R53US23RIlqOTCpV5xV8MOYhRTvgzVTnNPDOULdZ6BzYEaUQPlrNPv2xxyF5dT
	 TPzn3rlGq/wKOurcyXUweMyCbHcoMvLrqSw9sZxP0WiFtdSnb5jczuAZ7dyJD9Hrhk
	 n1fNf1vds2BYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC5380CFD9;
	Thu, 24 Apr 2025 10:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: stmmac: fix timestamp snapshots on
 dwmac1000
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174548883125.3289294.6660302727268151005.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 10:00:31 +0000
References: <20250423-stmmac_ts-v2-0-e2cf2bbd61b1@bootlin.com>
In-Reply-To: <20250423-stmmac_ts-v2-0-e2cf2bbd61b1@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 daniel.machon@microchip.com, maxime.chevallier@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 23 Apr 2025 09:12:08 +0200 you wrote:
> Hello,
> 
> this is the v2 of a small series containing two small fixes for the
> timestamp snapshot feature on stmmac, especially on dwmac1000 version.
> Those issues have been detected on a socfpga (Cyclone V) platform. They
> kind of follow the big rework sent by Maxime at the end of last year to
> properly split this feature support between different versions of the
> DWMAC IP.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: stmmac: fix dwmac1000 ptp timestamp status offset
    https://git.kernel.org/netdev/net/c/73fa4597bdc0
  - [net,v2,2/2] net: stmmac: fix multiplication overflow when reading timestamp
    https://git.kernel.org/netdev/net/c/7b7491372f8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



