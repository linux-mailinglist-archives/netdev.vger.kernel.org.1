Return-Path: <netdev+bounces-197695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5C5AD9972
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3DF189F5E5
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D03481A3;
	Sat, 14 Jun 2025 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqtu94yf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211FC42A87
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864619; cv=none; b=svNcfo70SRI2vD92sV+t1bLHjyjO6QtoTf3Y2YbReswR+7gY2mUFfcdxXiWU/8UIh0jpJngbzq6j8LnsgY0y18qKtI2MOoOMn/ZDy/cnU8DpSLI4MA1cw2mrOXLUrnt9RdumHI0MTt8OZ5+dnPDB+MteiDnyWFTfPzh9d/3yUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864619; c=relaxed/simple;
	bh=QIV+0F7UZEbXQVCCIS9fHsBk/4g/yEoVPJWLkDhWNBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jlj/LN2GjEGN/e65/i6uPEF+MQTxdT0oK5XBnFpobotomBbw5FDlR2JJiWVc+BGz0Z7aQQOPXyhLG/t0K1EsQSn/UUpKj1hTeW3q9jofpf7h8EPe15EPjYPC4NUbpwtOSqAAWbM1hVPkBV0saVlpUqOMf+5kU+SyXOK28NKIyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqtu94yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3502AC4CEED;
	Sat, 14 Jun 2025 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864617;
	bh=QIV+0F7UZEbXQVCCIS9fHsBk/4g/yEoVPJWLkDhWNBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qqtu94yfZ2DfHot5pwD3vPDL5d2cNUN1FDRalN7UwtNAXuBHTNxbibyfZriuRde1A
	 EsW/+NPfQgMmzB6g+H0d5iOD5ahWTLUhy2eUXXJzfbhxgTj4DChuj5CY/+/MpQb2Kd
	 YSyuzt540/ABCkexn4DGgJ0mibZEmpVVnJUT2/oHhENZ8f3ULqRF6qhDzfA/CgOsI/
	 gqMmb/TQU0n/YTBBhq/nfYoXgTYD+Gs7mcM7LRxFtOCXsqcAJN8Ck8bZInSsSohsNp
	 /FAoYZkYmr1jHlkY5azzPPwvX3VuyLsfYxMj2RVIh52WuwCcyJQVARi2D5oRkrGpl8
	 N2tqyQ2apoWaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1C380AAD0;
	Sat, 14 Jun 2025 01:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: stmmac: rk: much needed cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174986464674.950968.7803319715888152554.git-patchwork-notify@kernel.org>
Date: Sat, 14 Jun 2025 01:30:46 +0000
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
In-Reply-To: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 16:40:54 +0100 you wrote:
> Hi,
> 
> This series starts attacking the reams of fairly identical duplicated
> code in dwmac-rk. Every new SoC that comes along seems to need more
> code added to this file because e.g. the way the clock is controlled
> is different in every SoC.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: stmmac: rk: add get_interfaces() implementation
    https://git.kernel.org/netdev/net-next/c/1f59e30403a7
  - [net-next,2/9] net: stmmac: rk: simplify set_*_speed()
    https://git.kernel.org/netdev/net-next/c/e6e9e837d312
  - [net-next,3/9] net: stmmac: rk: add struct for programming register based speeds
    https://git.kernel.org/netdev/net-next/c/3de607d13b6b
  - [net-next,4/9] net: stmmac: rk: combine rv1126 set_*_speed() methods
    https://git.kernel.org/netdev/net-next/c/29f0aca13914
  - [net-next,5/9] net: stmmac: rk: combine clk_mac_speed rate setting functions
    https://git.kernel.org/netdev/net-next/c/d8d6096f8161
  - [net-next,6/9] net: stmmac: rk: combine .set_*_speed() methods
    https://git.kernel.org/netdev/net-next/c/3930c2cca657
  - [net-next,7/9] net: stmmac: rk: simplify px30_set_rmii_speed()
    https://git.kernel.org/netdev/net-next/c/c5cddcdbd2af
  - [net-next,8/9] net: stmmac: rk: convert px30_set_rmii_speed() to .set_speed()
    https://git.kernel.org/netdev/net-next/c/9165487d21a4
  - [net-next,9/9] net: stmmac: rk: remove obsolete .set_*_speed() methods
    https://git.kernel.org/netdev/net-next/c/0f3a079786ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



