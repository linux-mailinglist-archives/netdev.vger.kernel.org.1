Return-Path: <netdev+bounces-206931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA3B04CEE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E118F7B0D32
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D31B043C;
	Tue, 15 Jul 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3yOWIG+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A011A841C;
	Tue, 15 Jul 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539403; cv=none; b=Lfvmj5k6Wo7hUDshhRCJ20ZkySoDOM6sQ/5KkIUbA9uGxC0JjH4Wgt/Q0HP9arpYjICU2f17Qa/GUzS7Jh6q1Lg3J4bywHLCWMJ6Mlu3S/6qcrfIw7OC/AjA0WxzUV1JX/21V8ChMKWzE0zh/VKa7PgnSSHPl67U80JlKVwazpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539403; c=relaxed/simple;
	bh=jfr0aCXpNAPEk5ma9rqFiWVdB9x5Qej8sh/szT8piFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GW59+9NPxeRm7GxtJcgxLX9jYyHdxUTOJZMCfb/XnfNqDUymHzLPMNn+m4Stp1Sis1GuhzHjAKtIYDICiH8P/asMpnLCOkzwt9owS39XT/pJobmqWjbzFDnhI0In2Yz1J0NBopnX0Za7WEI9R15OJ7TxWlX6+ej3OuULm5ubaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3yOWIG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26C8C4CEF0;
	Tue, 15 Jul 2025 00:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539402;
	bh=jfr0aCXpNAPEk5ma9rqFiWVdB9x5Qej8sh/szT8piFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W3yOWIG+bbyChARR5NLBK9RJBqOEOqamnj/LgBgJ1vPHSvSkDfNMc2j2Ayi1uajqz
	 l5mcLUBNACdK7Xrt1Qra4hwE6k03Dg/hH2UiJ+O0QllASvAtmAYj8QACUFYJiR6/3e
	 WCxYIfwsZtObqqdShxUKoi8Fd+lgnOdyxh3YCVy7ye/NYOzZKSenQdTQ9GlDaEmJbg
	 yPuhUJRkd8qQFS3U1tMoKKG2HYTwhZJJ3iXAQESku91oUmlyTJA22O1CR85LCS2NX5
	 WtXtr37rQPEAseF+gT74YWdcNS+E4TQn8oBr2kJKFvbkKmW7ZL30kPlcqrADpH3F87
	 Q3HGGONm+GPOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2B383B276;
	Tue, 15 Jul 2025 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: fec: add some optimizations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175253942324.4037397.15787459442923826410.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:30:23 +0000
References: <20250711091639.1374411-1-wei.fang@nxp.com>
In-Reply-To: <20250711091639.1374411-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Jul 2025 17:16:36 +0800 you wrote:
> Add some optimizations to the fec driver, see each patch for details.
> 
> ---
> v1 Link: https://lore.kernel.org/imx/20250710090902.1171180-1-wei.fang@nxp.com/
> v2 changes:
> 1. Patch 3: Change the implementation of fec_set_hw_mac_addr() to make
> it more readable.
> 2. Collect Reviewed-by tags.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] net: fec: use phy_interface_mode_is_rgmii() to check RGMII mode
    https://git.kernel.org/netdev/net-next/c/893bb0beed4d
  - [v2,net-next,2/3] net: fec: add more macros for bits of FEC_ECR
    https://git.kernel.org/netdev/net-next/c/2d33dc605815
  - [v2,net-next,3/3] net: fec: add fec_set_hw_mac_addr() helper function
    https://git.kernel.org/netdev/net-next/c/d39e1342d045

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



