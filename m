Return-Path: <netdev+bounces-175451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39FEA65FBC
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F0E18979F5
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C31F8ADF;
	Mon, 17 Mar 2025 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIqYclAp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ECB1F7916
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244607; cv=none; b=HbQoj/KG5U+A8lX51iNWytd4tqxUFzc9sCvRdMxH+syuIDmwW8+/oozPzuNNPbfXjaP8sGmb8mvYK3LRnxa5UAsOYMl6bN0C4xz7ZX2vn7mWnfvCkBwDSLKqlsn8FbX4hnPR39IGjiVw0/pVehJ15cPR8qrCr67H7eLtU926sDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244607; c=relaxed/simple;
	bh=ZzO7p0E05LqQUhj5I6ptRTxYrMDxibfEvE+IQLvcR2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ryaT8jhgpTpE7dl77qKEEo60cuCYyTQNR5YYH9nk71xT5ILCfH9NNKXQsijssuDiRfswLtWrpZT4KumbWN9V9lL98GliAmD9ojeqX2w3jsn6xkSvkAv6wxiS8E9iK6X+0yDn6b1y7xtIljpgjf5Cd8/lsayzcQfORT2rOrf5r7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIqYclAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B654C4CEE3;
	Mon, 17 Mar 2025 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742244606;
	bh=ZzO7p0E05LqQUhj5I6ptRTxYrMDxibfEvE+IQLvcR2I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WIqYclAprWpnECcYa5u9U47KpvZIh/uYc7FUI98D9SPU+XMWuYF0oHzqs98Kadm+0
	 c5gWw5vft86A+ajmHFdQSSmnV3J1R1LRlnnEUZCFmiTMkzkSmJzLokDEePHn1LkaQH
	 IqPUX7aAya8KdA1U5U6V9yTv20h1ldmReo8jxoutz3WK7IDJQvsOtHrwd5JTEFZS5k
	 4S+B8m0B7xuXCW8YElOA3R30Qo/YzYRMo5goaA3b6AhIOjv6cH5CFaS1/ABkgvnSxj
	 Z4GH0M3GPNE6WvQfVO+3cEp6xSIlDhO3eDU7Ao3RAVsZy3SSW7C3lhdvRcShLw4O6z
	 UPHsb7FWky0Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F98380DBE5;
	Mon, 17 Mar 2025 20:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: avoid unnecessary work in
 stmmac_release()/stmmac_dvr_remove()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174224464199.3909531.2901969920115907730.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 20:50:41 +0000
References: <Z87bpDd7QYYVU0ML@shell.armlinux.org.uk>
In-Reply-To: <Z87bpDd7QYYVU0ML@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Mar 2025 12:31:32 +0000 you wrote:
> Hi,
> 
> This small series is a subset of a RFC I sent earlier. These two
> patches remove code that is unnecessary and/or wrong in these paths.
> Details in each commit.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [net-next,1/2] net: stmmac: remove redundant racy tear-down in stmmac_dvr_remove()
    https://git.kernel.org/netdev/net-next/c/180fa8d0a2cb
  - [net-next,2/2] net: stmmac: remove unnecessary stmmac_mac_set() in stmmac_release()
    https://git.kernel.org/netdev/net-next/c/39b0a10d80d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



