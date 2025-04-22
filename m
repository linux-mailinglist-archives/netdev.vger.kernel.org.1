Return-Path: <netdev+bounces-184572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1782A963C5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9518165B3D
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4115C257453;
	Tue, 22 Apr 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTJ9QcxT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE92566C5
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313016; cv=none; b=sjhtRwHOlVS+wMkb23lPmt9+eR9X6QfYy1kdF4wXHD24O8zxZwU5HrThNOi4c88VWOAgSGFso3AeYSnR6ABDkInKnmPc+5WlJcaPsrOFI+Vm8BhXtKOCFBlBKhdY+m2/a23Y+HJCF9S7MqmFH1JNu0GjjEUgH5Qnmhw7OclWOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313016; c=relaxed/simple;
	bh=dvvqu9VLExHyZ9ZpJuxQQarkDv+LB3yDV1x4fu+Cwlc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s7hov99QPrtTwDaqYLcL/qfOIHxfu+/XCA9ownmHzP2jEe8jVXje8yyF/F/0CKRMzx3C2U8/idr1psACPLGmQXWuIuo2ECNcv/mgGAuP+gGQSrGKtGu8iN+plf9MHP0woWisFw4wH+txacfL/oDLY7fUPsf+73iTZL1/CYv3ziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTJ9QcxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F1CC4CEEB;
	Tue, 22 Apr 2025 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313015;
	bh=dvvqu9VLExHyZ9ZpJuxQQarkDv+LB3yDV1x4fu+Cwlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iTJ9QcxT0so1Db8Fy7lsZ7VDn5rmlNLNMyPTXCQhzwqnPsuEuaKlHRvtyyXrnYKrI
	 Tg3qXRKEqsZi4Pckz0IVQTEE0QGdcR+Ho/vJdrIbudtBzCezXagstworTNHwykUn6p
	 p2n74qpUWvMwrgN7dKbjaTPQ+z28jdgibIyE7/A2HW5aYddYwzX26fmqJiFWx1tB4v
	 4C5BbI5z7gdnIHLfzVGdeKeXuJh8so6HGHxzLhkIHu+nKehq8TdxtREv4IO3owMo75
	 b6CoGfNHZ4L8viOzbGn+0Lf1ge0jj9hCXP9aQHt0EuELl1P5SXzOSAEnUoA3Cu992+
	 U9AdTmBZa8NAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFF39D6546;
	Tue, 22 Apr 2025 09:10:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] net: stmmac: socfpga: fix init ordering and
 cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531305373.1477965.16027981733032970963.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:53 +0000
References: <aAE2tKlImhwKySq_@shell.armlinux.org.uk>
In-Reply-To: <aAE2tKlImhwKySq_@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 18:13:24 +0100 you wrote:
> Hi,
> 
> This series fixes the init ordering of the socfpga probe function.
> The standard rule is to do all setup before publishing any device,
> and socfpga violates that. I can see no reason for this, but these
> patches have not been tested on hardware.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] net: stmmac: socfpga: init dwmac->stmmac_rst before registration
    https://git.kernel.org/netdev/net-next/c/9276bfc2df92
  - [net-next,v3,2/5] net: stmmac: socfpga: provide init function
    https://git.kernel.org/netdev/net-next/c/0dbd4a6f57c2
  - [net-next,v3,3/5] net: stmmac: socfpga: convert to stmmac_pltfr_pm_ops
    https://git.kernel.org/netdev/net-next/c/6bf70d999aa9
  - [net-next,v3,4/5] net: stmmac: socfpga: call set_phy_mode() before registration
    https://git.kernel.org/netdev/net-next/c/91255347bba9
  - [net-next,v3,5/5] net: stmmac: socfpga: convert to devm_stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/1dbefd578d8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



