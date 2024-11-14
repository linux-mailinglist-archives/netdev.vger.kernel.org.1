Return-Path: <netdev+bounces-144667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DF09C813D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E383B21CE9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE67313A3F7;
	Thu, 14 Nov 2024 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxN/j0Xa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40EC2309A6;
	Thu, 14 Nov 2024 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553240; cv=none; b=bUUkrz3lhUqOZCU/CJPpZr3p4TRru/ZNYeDAt2eYFdZ1QYhSFhqf+uF7rAHLnvizl1zkw+JV+nqLWJQtI6ndNhlYMVr4IjMwdc5WAmmS3xcn2A/QEuzRfqOwlmfB/IQfomodtduN9Gpvxb57P8Qhf0hFa4A2B/K9iLkQa2bMYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553240; c=relaxed/simple;
	bh=gbZQqgoltqwkJ/vm5DodVYLPZVBiaTAp0vA2MvKuZCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RcyYUp2lFmunFH63ayx042O/vUAXshpD3ojuuY3wUc+KEuXS6mVMSW6qlNjMlt7XeUEGP3/jNqXoLM2mFMuBQ37gUA4vGeobSqjdv0+HoAx/drg3C/9GubQLjOad7xF2wJR2FaI6XcJYeMMC8m0bbzQpRIFJaF4S6JtjJRxsi+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxN/j0Xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7D6C4CEC3;
	Thu, 14 Nov 2024 03:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731553240;
	bh=gbZQqgoltqwkJ/vm5DodVYLPZVBiaTAp0vA2MvKuZCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gxN/j0XaazZWoNHJvyJSihstQrqhcQOZvPzddr12uATiXHq5rSBCPMVGZ4CZP3AqE
	 dL15FKoPgsUl+LaHeAJdczLcq5c72YOHYxT8W1iCGzDVlPTAv7cHGA7qhsrGYZlxwK
	 6N8FLtmcCDyIowDk2Fw90UmQ+G0u0Tn18g526479BYde1KQGWeDa8lpBXZO1D/qRTJ
	 7zmqGwtos4+10aMTth6i+GWDf+RIgChvImDR3szcWa78Dp7LMsTx9Y7U6ErbxhI49S
	 AJMqxYvNhR6T80xxPtB49SQoUAPIoxUJX2Dwe+BuNyldjPjoxlvjaC5qFYQP25ZJQN
	 5jsQWsJ+NmU5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF5F3809A80;
	Thu, 14 Nov 2024 03:00:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/9] Support external snapshots on dwmac1000
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155325074.1464897.8509953412141339085.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 03:00:50 +0000
References: <20241112170658.2388529-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20241112170658.2388529-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, daniel.machon@microchip.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 18:06:48 +0100 you wrote:
> Hi,
> 
> This is v4 on the series to support external snapshots on dwmac1000.
> 
> The main change since v3 is the move of the fifo flush wait in the
> ptp_clock_info enable() function within the mutex that protects the ptp
> registers. Thanks Jakub and Paolo for spotting this.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/9] net: stmmac: Don't modify the global ptp ops directly
    https://git.kernel.org/netdev/net-next/c/80dc1ff787a9
  - [net-next,v4,2/9] net: stmmac: Use per-hw ptp clock ops
    https://git.kernel.org/netdev/net-next/c/13e908800c0d
  - [net-next,v4,3/9] net: stmmac: Only update the auto-discovered PTP clock features
    https://git.kernel.org/netdev/net-next/c/0bfd0afc746c
  - [net-next,v4,4/9] net: stmmac: Introduce dwmac1000 ptp_clock_info and operations
    https://git.kernel.org/netdev/net-next/c/8e7620726beb
  - [net-next,v4,5/9] net: stmmac: Introduce dwmac1000 timestamping operations
    https://git.kernel.org/netdev/net-next/c/477c3e1f6363
  - [net-next,v4,6/9] net: stmmac: Enable timestamping interrupt on dwmac1000
    https://git.kernel.org/netdev/net-next/c/774f57d6562d
  - [net-next,v4,7/9] net: stmmac: Don't include dwmac4 definitions in stmmac_ptp
    https://git.kernel.org/netdev/net-next/c/85cebb7279e8
  - [net-next,v4,8/9] net: stmmac: Configure only the relevant bits for timestamping setup
    https://git.kernel.org/netdev/net-next/c/62935443214e
  - [net-next,v4,9/9] net: stmmac: dwmac_socfpga: This platform has GMAC
    https://git.kernel.org/netdev/net-next/c/b818268d9250

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



