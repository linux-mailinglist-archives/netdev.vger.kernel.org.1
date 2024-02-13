Return-Path: <netdev+bounces-71141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ED2852708
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC1F1C25096
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4971DDD7;
	Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CweQf6me"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F0021364
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707788426; cv=none; b=sXHLhd1kOadFDgH6iIOY7wrJpnFRcwwoXqPyjRrnl5TL2Re5oRo7JALXr3t0BJ7+g5Vl+7R6e/iLAz3AFf72GN8kFlMylr8MtgGcfo8XCkSkRjPlwyD1g3oBGvo6pSDWTc+CPxveuRehTix/dKWdAJ99PSkxP2KI0mbdkzaoKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707788426; c=relaxed/simple;
	bh=C7XIxg2//9H9lNyyL4lVnFIE3rkFS9Y7qI8j3SBXhMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d4bPtaUrAOBVG+cE1UZV6dgQPUprTDTTidbzM9bh/HKLjudpR9EPUAD6jxnM48jc9oKdq0usTAdu0mJ74ud6QyorISEunDaqFFYUnihB6kmT4ijZx+tVLrJ1ZNHd6Wc6OT2qPdDK3PD8oaAkpWMGbqw1svTbiADEbZs+bjynwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CweQf6me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31713C433C7;
	Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707788426;
	bh=C7XIxg2//9H9lNyyL4lVnFIE3rkFS9Y7qI8j3SBXhMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CweQf6meCbweoJAM0Jm8E32JxjtvvfbRFeSGess8IGVjuSH/MWw5bTo+Nd/wams88
	 ek/Mb8hL8gnhB92iQAg3F8GPwXy046WZ6FIJoffiKQ4Xei4EGm0MuiwaEKKAZFA98T
	 Cr9pH7x0gwOEFOe0Mp9jz3Pky6uTDTZqprDDeXwtOT9GOTbQXBKTwty3gNbvrMTLmY
	 83ZT4Z7PXJEcXz+rPfyrUBlX/kBhO0LnZ4rs6d1OdUdj2vRsru8kBX6ikPMMNZdVmW
	 Un+hZbI886lyEOlyMS9W1LRuOBTC0jUKnlnUCfmY88guD7CvsZznKUqvrTFm9qSm9U
	 0lt7L9c/WLUKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17A84D84BC6;
	Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: xgmac: use #define for string constants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170778842609.15795.7467205079881432963.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 01:40:26 +0000
References: <20240208-xgmac-const-v1-1-e69a1eeabfc8@kernel.org>
In-Reply-To: <20240208-xgmac-const-v1-1-e69a1eeabfc8@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, fancer.lancer@gmail.com, 0x1207@gmail.com,
 jonathanh@nvidia.com, lkp@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 08 Feb 2024 09:48:27 +0000 you wrote:
> The cited commit introduces and uses the string constants dpp_tx_err and
> dpp_rx_err. These are assigned to constant fields of the array
> dwxgmac3_error_desc.
> 
> It has been reported that on GCC 6 and 7.5.0 this results in warnings
> such as:
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: xgmac: use #define for string constants
    https://git.kernel.org/netdev/net/c/1692b9775e74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



