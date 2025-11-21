Return-Path: <netdev+bounces-240628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D2C77115
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCB6535C648
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB182DC357;
	Fri, 21 Nov 2025 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT4bOfga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BED2DC322;
	Fri, 21 Nov 2025 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763693455; cv=none; b=WK4T8eTkJk6F5oFOsW5vg/RJc7b9unGO5Y/WQs96xbi6mCSu30L45Mj0DqAjc6BoxyK37qGayWqiKiimHGjm9tNnUYRzgB+fkM7eOg5PuAuUkNapKuPj7GJ2oq8vW1zYl/Fu50M080Uqgbx7TNbv1BeEPR0GNNGkcCPMdhafoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763693455; c=relaxed/simple;
	bh=tSa30zLKOXEBzsBQsVHHF/No4SIK2WbE9wnFY3vZY0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QR7pvT5YgKgC769EzG80JLWvNOVe/IX4SJIa4PKIeX+tYpoQMEv5/K2VYynXrVVObaTAe01BrRN2vzCXiHDGqegd7VHE/yvBin4FEEEOcs8rqfsbT8GsIh8GjN7vXJrEX/hqIGQWQNjYB/H27wkIubkRPtV0WAICq/309cw2hAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT4bOfga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309D0C4CEF1;
	Fri, 21 Nov 2025 02:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763693455;
	bh=tSa30zLKOXEBzsBQsVHHF/No4SIK2WbE9wnFY3vZY0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lT4bOfgaSFlI9rv3K8nWf0UmPb8/NshjF3F8VBCMYi5ll7PajDk7el5QKHth8HARk
	 OVGIJWegnlHwxZT1j39ebHaqKkI0+32ZFg8lcqb4DEnh3ew1KYnq0pgUviedutYJL2
	 mA/U1S/WLhc03i026GPNhgGu01kGY8jrHoPi28EVg2jIgs0UXP6xD7kV3r6EbaUZCf
	 jiY/qNBkGmQHQ+CbcLnb0YVQJuj+NPeV5c8IdNNF/DZJQtKVvLq7xceKiOwSrTJaeE
	 2W4ozazVoHpTaxYSmljMHJ39KTqoCsHiF+SonNbD6wwWYK0dTCQtrjpXiHV3HfsGse
	 aDwOILtsrJ6yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7111C3A41003;
	Fri, 21 Nov 2025 02:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/5] net: fec: do some cleanup for the driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369342000.1872917.9969026361331291521.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:50:20 +0000
References: <20251119025148.2817602-1-wei.fang@nxp.com>
In-Reply-To: <20251119025148.2817602-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 eric@nelint.com, Frank.Li@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 10:51:43 +0800 you wrote:
> This patch set removes some unnecessary or invalid code from the FEC
> driver. See each patch for details.
> 
> ---
> v3 changes:
> 1. Revert patch 2 to v1, fec_enet_register_offset_6ul still needs the
> "#ifdef" guard, otherwise, there are some build errors
> 2. Fix a typo in the commit message of patch 3
> 3. Collect Reviewed-by tag
> v2: https://lore.kernel.org/imx/20251117101921.1862427-1-wei.fang@nxp.com/
> v2 changes:
> 1. Improve the commit message
> 2. Remove the "#ifdef" guard for fec_enet_register_offset_6ul
> 3. Add a BUILD_BUG_ON() test to ensure that FEC_ENET_XDP_HEADROOM
> provides the required alignment.
> 4. Collect Reviewed-by tag
> v1: https://lore.kernel.org/imx/20251111100057.2660101-1-wei.fang@nxp.com/
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/5] net: fec: remove useless conditional preprocessor directives
    https://git.kernel.org/netdev/net-next/c/3eea593b5597
  - [v3,net-next,2/5] net: fec: simplify the conditional preprocessor directives
    https://git.kernel.org/netdev/net-next/c/eef7b786bdab
  - [v3,net-next,3/5] net: fec: remove struct fec_enet_priv_txrx_info
    https://git.kernel.org/netdev/net-next/c/63083d597ada
  - [v3,net-next,4/5] net: fec: remove rx_align from fec_enet_private
    https://git.kernel.org/netdev/net-next/c/3bb06c8a461b
  - [v3,net-next,5/5] net: fec: remove duplicate macros of the BD status
    https://git.kernel.org/netdev/net-next/c/bd31490718b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



