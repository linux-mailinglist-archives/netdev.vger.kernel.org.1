Return-Path: <netdev+bounces-241741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B9C87E54
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FE034EB5F6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA2830C371;
	Wed, 26 Nov 2025 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioAC2aqK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0F30C35E;
	Wed, 26 Nov 2025 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126059; cv=none; b=gZ57NtLys1ujV2tWfhK2pEHQ7WPjWoYIOEA6jqrzFfEX+lzoi9+daZSqm+cVNozLAaKbgmANUwlImEn6qR1hFpikiyoCovTPxB8AjGiYQiW5E4GKZNgn7b07Pj7+etuxgCAmPqI4lJCkRnVTLDav3xCXuvamzaZjROzhMZrpsbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126059; c=relaxed/simple;
	bh=Eju94wzsvqzAIpyMYCKbT/q/O5MdhFF3OXDgCGUm3oc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Har3tNswZwNtUOYQi8WBNd56Pesn45PPG4OPz9oybBTibH3nmlgQGRaSOwf+RL9gyCDjz8FYLGj7qvUjuAK4AkZh/qYflkFXjzUWZlybHL8H9pQjg6fyMSptnBYRq3ESvu3PNvebQx6wUOnWZlwJL19MbbA5I1nbNHrR0/S/Wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioAC2aqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBB7C4CEF1;
	Wed, 26 Nov 2025 03:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764126059;
	bh=Eju94wzsvqzAIpyMYCKbT/q/O5MdhFF3OXDgCGUm3oc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ioAC2aqKYuz8z66u+3sRwBTqq54l1jhqX2OtRmdkQTvnxBWK6uFtmHUWfJDVWXTzd
	 d4E2V+WmD5tlpyaSESIgM5RkKtEMOApG+ebhN1TIrzLPS3+f7v5iyDDK9qaD4PkPp7
	 DmNyJ49JSUe45YAgWUQpHxdg8+qFpE5ucrqgvnwSg8neFe8ScFPKLU9/JLw4g0cQ5o
	 l3+1GpvL5CnDRRcZ/5+AOUygxlYVD15NnidaDts1GxhwUu6B0kRk+8I15LDSZXopsn
	 k1POlI5GAzroyTshWocfq+ucnfhc19h/aOQ0S2L8BNzFECrZ3hMN6bszg9SSb/2mF8
	 QMcVjUJzS5QmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE531380AAE9;
	Wed, 26 Nov 2025 03:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/3] net: enetc: add port MDIO support for
 both
 i.MX94 and i.MX95
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412602124.975105.6622601514745827189.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:00:21 +0000
References: <20251119102557.1041881-1-wei.fang@nxp.com>
In-Reply-To: <20251119102557.1041881-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aziz.sellami@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 18:25:54 +0800 you wrote:
> The NETC IP has one external master MDIO interface (eMDIO) for managing
> external PHYs, all ENETC ports share this eMDIO. The EMDIO function and
> the ENETC port MDIO are the virtual ports of this eMDIO, ENETC can use
> these virtual ports to access their PHYs. The difference is that EMDIO
> function is a 'global port', it can access all the PHYs on the eMDIO, so
> it provides a means for different software modules to share a single set
> of MDIO signals to access their PHYs.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/3] net: enetc: set the external PHY address in IERB for port MDIO usage
    https://git.kernel.org/netdev/net-next/c/6633df05f3ad
  - [v3,net-next,2/3] net: enetc: set external PHY address in IERB for i.MX94 ENETC
    https://git.kernel.org/netdev/net-next/c/50bfd9c06f0f
  - [v3,net-next,3/3] net: enetc: update the base address of port MDIO registers for ENETC v4
    https://git.kernel.org/netdev/net-next/c/10ba23a7f6cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



