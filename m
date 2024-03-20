Return-Path: <netdev+bounces-80716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A5880A0C
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 04:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37FC1F22FD5
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6210976;
	Wed, 20 Mar 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXBwi//I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA8101E8
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710904229; cv=none; b=qJ0Yz64UlA853fNNY7tVOBummC9pE3oMv7sK1glVY+OawIz4EqmRexTIfjrSyEXcdZ6eLv0kWbzL0ilvglzlffn3sXM50cMfMPL6/i4kMmF7XBcPf0serWPNyCeYgT3AY3gQCmYjg1W2UStv/x+l7D7ym1LM4Z+h5NFV/xBjxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710904229; c=relaxed/simple;
	bh=URnZAuQbJ81Dov0vNaP7Nl3UpyKSHf5yBUDBwuKLAnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FPokDttEkVeYHxR8Q6d26agW7K5d4nAEjHUXvjIBLstLjoYs1+4qNMiz1QKz8ebPDZhGsIVd0zIMJx0fKvHklps2PVSymAcItId40blqOFiYcYy3DekKeGBfIi0WXMeF6NchxJacDIF2EgLwq5WQveL9G7L2+MH9Bwk+zvxpBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXBwi//I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C344CC43394;
	Wed, 20 Mar 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710904228;
	bh=URnZAuQbJ81Dov0vNaP7Nl3UpyKSHf5yBUDBwuKLAnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jXBwi//Ip6OgBzkD5gr33j6G5xoPYsv9ebdDUAkDWwaEhGD9hjpQGyX9GvK2yGNVV
	 /xCiPseYuXLr9Ex3ll6/vo9/Gh09YWSzxL7eChUYlAzsZlO/wKWhmZoJQJpkwWFDvT
	 kJsji2vQwz1PF/G1uL/RmjgEswbycl+M/xnGG+Qisz4MJjc0G4GFrgwWAx2ROlMyMa
	 /oaOUI9ahP6kD6l3iPHy/F9tfm7oDTWLIdteNibIt2aWQXViFAbFNwpEX6VT9jasWp
	 2Saj8yOaamwEX0j+b126zVvWXHIozvMGyFmVcgOw5wjyPAsEitwT0RP5Ig0BF0Gi1p
	 Pfc6XxVxA79kQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF002D98302;
	Wed, 20 Mar 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v11] net/bnx2x: Prevent access to a freed page in page_pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171090422871.19504.16129773459568231603.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 03:10:28 +0000
References: <20240315205535.1321-1-thinhtr@linux.ibm.com>
In-Reply-To: <20240315205535.1321-1-thinhtr@linux.ibm.com>
To: Thinh Tran <thinhtr@linux.ibm.com>
Cc: jacob.e.keller@intel.com, kuba@kernel.org, netdev@vger.kernel.org,
 VENKATA.SAI.DUGGI@ibm.com, abdhalee@in.ibm.com, aelior@marvell.com,
 davem@davemloft.net, drc@linux.vnet.ibm.com, edumazet@google.com,
 manishc@marvell.com, pabeni@redhat.com, simon.horman@corigine.com,
 skalluru@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Mar 2024 15:55:35 -0500 you wrote:
> Fix race condition leading to system crash during EEH error handling
> 
> During EEH error recovery, the bnx2x driver's transmit timeout logic
> could cause a race condition when handling reset tasks. The
> bnx2x_tx_timeout() schedules reset tasks via bnx2x_sp_rtnl_task(),
> which ultimately leads to bnx2x_nic_unload(). In bnx2x_nic_unload()
> SGEs are freed using bnx2x_free_rx_sge_range(). However, this could
> overlap with the EEH driver's attempt to reset the device using
> bnx2x_io_slot_reset(), which also tries to free SGEs. This race
> condition can result in system crashes due to accessing freed memory
> locations in bnx2x_free_rx_sge()
> 
> [...]

Here is the summary with links:
  - [v11] net/bnx2x: Prevent access to a freed page in page_pool
    https://git.kernel.org/netdev/net/c/d27e2da94a42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



