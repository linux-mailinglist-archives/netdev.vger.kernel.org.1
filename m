Return-Path: <netdev+bounces-186449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5E2A9F25A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CD8166D14
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F932686AA;
	Mon, 28 Apr 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD7QBfDg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975B1A072A;
	Mon, 28 Apr 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846994; cv=none; b=tRBudqP2nXs8TqXCNzlKkwe6xffNrX18c01airQ8kprz5vpfrd0jY51ZgyLdXVtOF7ie4hoXA2bKIOl8y4j+KyaSGs+Q6lsINedmRTufsVH82Z+iY2fngDiPkUhpOVUPoNgOz6LrJxkqQeg3N6Zj0nBFhx0XE/aqIdaAIL2uqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846994; c=relaxed/simple;
	bh=elk4Zqa+3hCtmUiNsAt9MfBksCuGpsquiK6zsRxydTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WSx3OxkujX7yIn/vX3F894RxHrYsErfeNiyZAILdcFqKHvdX+5PzlvoRGbvZdGEW37B977NgXYcZbIACdnmkohZwjrzPZUHDunSWs6FaXBLnyFAtDzsNCvaXCC8FbA7iOjLCPRkn9Bv1AJK9yVrgxSsQBTnZH29akHCrmyQWYO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD7QBfDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0EBC4CEE4;
	Mon, 28 Apr 2025 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745846993;
	bh=elk4Zqa+3hCtmUiNsAt9MfBksCuGpsquiK6zsRxydTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TD7QBfDg6kXdOzjRs6gtAIizZopWFFNqcvzVQOUhE4adYd3tKK9ZWRiOnvUE6xSVd
	 jqwrYMQ8+CvdekMObGo0NgaCNDmpuD0w0cXxKLSIz47iIeS/A+QYeABeLViatbJfgl
	 WYuFL3DJJsVzqm0ssKDEWQxyOqyy4bbuIUxmpfwxhdut/618sWFo6Maqz94oacg6/C
	 PFGArhwz0OFSGUVyUCsQRZIPi4wGKLvIrlI/LJUOfHZ/1qnX4nKj5+7grom/3aVSVM
	 0hcg7j0y6Ieg1gwWvMRkF6+1AoV5y9QGkFI2DE13pzJZ78Bj3EwkJ7EatPc+D16aoT
	 QizlVzaNHtOoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF93822D43;
	Mon, 28 Apr 2025 13:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: socfpga: 1000BaseX support and
 cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174584703225.917720.8866587140005702000.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 13:30:32 +0000
References: <20250424071223.221239-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20250424071223.221239-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, linux@armlinux.org.uk,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, horms@kernel.org, alexis.lothore@bootlin.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 09:12:19 +0200 you wrote:
> Hi everyone,
> 
> This V3 is simply a re-send of V2, targeting net-next instead of net as
> the V2 did by mistake.
> 
> No other changes besides a rebase on net-next were made.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: stmmac: socfpga: Enable internal GMII when using 1000BaseX
    https://git.kernel.org/netdev/net-next/c/6fba40e7f610
  - [net-next,v3,2/3] net: stmmac: socfpga: Don't check for phy to enable the SGMII adapter
    https://git.kernel.org/netdev/net-next/c/3bf19459da62
  - [net-next,v3,3/3] net: stmmac: socfpga: Remove unused pcs-mdiodev field
    https://git.kernel.org/netdev/net-next/c/8fb33581bb8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



