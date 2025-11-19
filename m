Return-Path: <netdev+bounces-239767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D21C6C468
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7263A35D413
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032DF23D2A1;
	Wed, 19 Nov 2025 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTSaKNDV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7501C84DE;
	Wed, 19 Nov 2025 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763516441; cv=none; b=unzBu3mBRWwwAuWiZq6aj4+2n6Dqt28xwOEB1X/IeREJyuu7Q9Wl5/W7M+rvmDkop1pIGfCkiVN4PJbMUc0y0MJJiDmOhntWZZ6yhtU0OAMymx4C6YpCrroYTHpvlrDd3js/zrfosDJs0qZFtA0RcP3Gndp6iZzaX9BHSHMoZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763516441; c=relaxed/simple;
	bh=clmeMhDzQ9LftnI88GNIJBk6KdFHfFHOZenk3l9jL5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cvskvgPlk9onkEaRXQ9RKhaZ9Jx5p8A/9ZXnSI+aUGPqKUhcT1IC1eL1gZN2zjiWfnXG1biCjtTEsBhPg5uDyDvAhb3bBSwP/he8BuUh4dvf9yWZN04XhlG9zbZb3ZMDTlW46mXQZHDE8LknBTx+IWLNqIUcEBSLC7AYYe6WHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTSaKNDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A1BC19421;
	Wed, 19 Nov 2025 01:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763516441;
	bh=clmeMhDzQ9LftnI88GNIJBk6KdFHfFHOZenk3l9jL5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NTSaKNDV8ogVdNfRCMC58yyPuf2BFpFcYNTyT2yE9qlA2zmg4bcUvRg6krV318u09
	 JRJSRQa37etZHjzjVSM2OxvV4CcO9FpJ7OtT+5/JGqweXMOJNJG4z6Fetwpam3DkZx
	 dpdoyq5HWHpCqSeARakxC7bmWrJljHeySpRK3fvNewcezZwakLH0LTP4L5vHZaofS4
	 ky4XZgCMhzGmIrUFW4p6QTDrgGvkAVF5Y5D5QvJ5rvpVAvqToDcid5sYRliH2IkjSO
	 a6BfOMhgEEYkGbY/QGDVTE3SI7a77ZF3DwpyNIUUUWaCWIlolh564to7wsWtmFGBVp
	 OGieMyPDBTNpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE138380A94B;
	Wed, 19 Nov 2025 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] devlink: rate: Unset parent pointer in
 devl_rate_nodes_destroy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176351640651.175561.13138336561714985948.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 01:40:06 +0000
References: <1763381149-1234377-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1763381149-1234377-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mbloch@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, cratiu@nvidia.com, moshe@nvidia.com,
 jiri@nvidia.com, cjubran@nvidia.com, shayd@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Nov 2025 14:05:49 +0200 you wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> The function devl_rate_nodes_destroy is documented to "Unset parent for
> all rate objects". However, it was only calling the driver-specific
> `rate_leaf_parent_set` or `rate_node_parent_set` ops and decrementing
> the parent's refcount, without actually setting the
> `devlink_rate->parent` pointer to NULL.
> 
> [...]

Here is the summary with links:
  - [net,V2] devlink: rate: Unset parent pointer in devl_rate_nodes_destroy
    https://git.kernel.org/netdev/net/c/f94c1a114ac2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



