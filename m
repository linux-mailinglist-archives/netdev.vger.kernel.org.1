Return-Path: <netdev+bounces-248344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7186D071DA
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 05:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 837BF302D2E5
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 04:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBB427B32B;
	Fri,  9 Jan 2026 04:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvAMvwpc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E726B76A
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 04:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767932616; cv=none; b=nSeDP3x2vAQJOSZ57g/0bDRjAVsuw2Pma90X2tBz6nrDgV5BUUP5h08QUd7Khgx2kUIuH5P4JBcAbIGTPo/Q15y0oQBWrRZ4Q71x1TdsGh6CEkHPv1R3cvD+T5jkRv/vNOBaWKbuYYyp22kAH71SSJJNrFAvNozLLiYrMd3I1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767932616; c=relaxed/simple;
	bh=MPM30Xaj2UlPmqdYqSJHE54pcO6P/+uICOuPgDe6LMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mMBxnfu5CmQ38vM7EV7OS8+4HbcwpHqKQRG+B0G1oABiwThWaQuE0mRiQBZWbzhYN81Gjf7ycdn7xH8wA8fDu3NFRorVrFuQyWP1NHM8Uaz0StPH5u9Liu4XzL+T24RZfKOLYcasVsOVzyE2Z1//s6ln0cSE0sSCmKObX1ygnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvAMvwpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C7CC4CEF1;
	Fri,  9 Jan 2026 04:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767932615;
	bh=MPM30Xaj2UlPmqdYqSJHE54pcO6P/+uICOuPgDe6LMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nvAMvwpc3mL9dpD3yM5yOkua13ZUtqp42QiJV90J5VlCAQ6bdNGfKBr5e5V67XotF
	 e5nKFlhlOu1/U7hlSupIzU0Wj7fURncmvUMA+UthV8LMhUR55uc+K0eZw/TAgvbiiW
	 sm82Pa6eRFe48DWbhxKwpUqOZmE58igt2o+RDLgNCSvCIutDTYoLYPO1G3hwErnLI8
	 Of3euOEzlK7AP1/TJbnC2P90iFSwMsbPy9Ss41aNLsAFB5HnXDYXWM5mHWVCddA0Lp
	 Ge9+df0LB9bTZKjHhNeMeEQXPuT3mBHkwhhqI05oUS1s0T+U3U5rcFgV/bTsav2nww
	 LBbx3ikF14RLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59123930C80;
	Fri,  9 Jan 2026 04:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] support for hwtstamp_get in phy - part 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176793241154.98179.1678070764645293160.git-patchwork-notify@kernel.org>
Date: Fri, 09 Jan 2026 04:20:11 +0000
References: <20260106160723.3925872-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20260106160723.3925872-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, linux@armlinux.org.uk, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, andrew@lunn.ch, horms@kernel.org,
 vladimir.oltean@nxp.com, jacob.e.keller@intel.com, kory.maincent@bootlin.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 16:07:19 +0000 you wrote:
> There are 2 drivers which had some inconsistency in HW timestamping
> configuration logic. Improve both of them and add hwtstamp_get()
> callback.
> 
> v2 -> v3:
> * fix the copy-paste check of rx_filter instead of tx_type
> * add tx_type check for lan8841
> link to v2: https://lore.kernel.org/netdev/f9919964-236c-4f2e-a7ec-9fe7969aaa55@linux.dev/
> v1 -> v2:
> * add checks and return error in case of unsupported TX tiemstamps
> * get function for lan8814 and lan8841 are the same - keep only one
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: phy: micrel: improve HW timestamping config logic
    https://git.kernel.org/netdev/net-next/c/88c7ed2fb071
  - [net-next,v3,2/4] net: phy: micrel: add HW timestamp configuration reporting
    https://git.kernel.org/netdev/net-next/c/32d83db3aaf6
  - [net-next,v3,3/4] net: phy: microchip_rds_ptp: improve HW ts config logic
    https://git.kernel.org/netdev/net-next/c/ffde97f8ff6a
  - [net-next,v3,4/4] net: phy: microchip_rds_ptp: add HW timestamp configuration reporting
    https://git.kernel.org/netdev/net-next/c/f529893f404b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



