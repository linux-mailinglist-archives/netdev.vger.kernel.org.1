Return-Path: <netdev+bounces-197694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D3EAD9970
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C37D189F554
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A41804A;
	Sat, 14 Jun 2025 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgVuJ7n2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE428F6E
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864616; cv=none; b=RXaymW/sQC54F3K5G1sdhjJd2w2QK+Kg4E+qt9t6/VeJGBIB7HAqZC7VgdzumYD1gmzhWHmyiGpANfalAOfSZeaQLmBWvHE9tsZC4taEn9854cUcRbgYbv5Sa40wcB4VdNw7DMcf/pn0KLRnevMRIyM0HeD659JPiIm+QBHMHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864616; c=relaxed/simple;
	bh=IpEiRYgc9LKV8Z1ziQUlfI4E1VV+WgxlOCcgZoh2KBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hCr3fjGmo7tLKo5jDHxaIc6JyJPUbqH28uDkqKFM/Mr44kifO7u9CB5P0GZIe/47PMcae7w3asQMuG846yuWyg6OkU/6otVsXo1eNRqKt4/B4mHgEb4m5UHNoO1633e2G51lNR91zGqxkvo+kWpW+aA+UX8Ma48+FPaLRjFw+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgVuJ7n2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8697C4CEE3;
	Sat, 14 Jun 2025 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864616;
	bh=IpEiRYgc9LKV8Z1ziQUlfI4E1VV+WgxlOCcgZoh2KBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FgVuJ7n2LYhSWOVu/G6MkUV9r2o2F9qZzsaF4iw3FsgyGkqtiNaqI+2nEBDLibZvX
	 DZEP7l2xkroSQauSLSJCYnys0yUR4V4JRCbSDryZo23wQfB+QmHcS5+BdSf0yiNpWe
	 E9sJWrIXCQA+1losiRK0nyqK/wbLD/s3EChAC+uU5RlLjgBObgJilcfjXFkBtUnKWt
	 DMYMqNOE22f5MC3+vP+Ux08CKRm6gL/02oyMGLbcIjgtkpY1EdtnNcLY37Mi7ZXhfG
	 EC2ZolxZ4IoDd0F4JdEkvUEiicnSvLuC0uvW1lXCMCz6v5SblnIS2sJT03e4O/V1l6
	 hnUTkU8xwkrHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4F380AAD0;
	Sat, 14 Jun 2025 01:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: improve .set_clk_tx_rate() method
 error
 message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174986464550.950968.6157080480528979172.git-patchwork-notify@kernel.org>
Date: Sat, 14 Jun 2025 01:30:45 +0000
References: <E1uPjjx-0049r5-NN@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uPjjx-0049r5-NN@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 16:21:17 +0100 you wrote:
> Improve the .set_clk_tx_rate() method error message to include the
> PHY interface mode along with the speed, which will be helpful to
> the RK implementations.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: improve .set_clk_tx_rate() method error message
    https://git.kernel.org/netdev/net-next/c/bd1d76a6f18f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



