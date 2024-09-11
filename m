Return-Path: <netdev+bounces-127173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B009974767
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88C21F26602
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504D43D7A;
	Wed, 11 Sep 2024 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON8K0b48"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5D182D2;
	Wed, 11 Sep 2024 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014666; cv=none; b=QslJCLHviJI3yMFqYWNhw2aon1nu5M8Fx6VsQl0lDP2oZza2cZ3TxcaCSzoSb3p8NEIZzpj09O0BflYeBH22k4hBIBTa0CE3AYkPULMYzaZoF2lMC35CJIZkYfh/e2ex2m9QD95rv6qFiHoYwm/n/0RMJWOhMtnTbhkZOBeZGs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014666; c=relaxed/simple;
	bh=3kW1RB4QEC2GKwjIBHKcaFVhGmcWAsqzYdeAByh20BU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dOOrZNDgIGex7UNEWvR3LCDgf1OkenRBrOJM21DfnBAf50LPASO6jG2X8u+MhPgxBF0BbR62F0ofDDDR+SgPH+FOvJ0GvK8p2achw8y8E0qmfuuXPAMeaPYc7qWF5gUil1zhJvSVdtxVFMhsVmO+1jtQwmdP5G/pG5s6OLGuI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON8K0b48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5914C4CECC;
	Wed, 11 Sep 2024 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726014665;
	bh=3kW1RB4QEC2GKwjIBHKcaFVhGmcWAsqzYdeAByh20BU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ON8K0b48Q34PsbhEeiBYmky2O5j8KG4JSP3PTxoFvTHlGEYVuhSymcE2oPzLZrLkd
	 ZbNLlH4bgcj8EPPCQ34rfbCa6hdu2KpsVX+1QxaicEIjXxXJtwqyqdcsDfyoJVJTmK
	 YZM0/PdhND1fIKmunpnOHTBkkXAgKC5Kc8llC2eEVKwO/NZ3N9BB4EoI039EIVPIwP
	 b8ayn58ZKRdqgSMDXWAUb18Ca6MjYn1d1KkbcRFW6Ryc58oHh//8e4WDOPXDXDL+Uc
	 3qcpaPZh4VUNXLmVBfZLg7DVkAzhYg/Xgp/5mmeNg9/aCfKi9bpdq8uhh9QWky4Fqh
	 n2Rj4OFq1puwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E533822FA4;
	Wed, 11 Sep 2024 00:31:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] dt-bindings: net: tja11xx: fix the broken binding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172601466675.440312.6346971513083505539.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 00:31:06 +0000
References: <20240909012152.431647-1-wei.fang@nxp.com>
In-Reply-To: <20240909012152.431647-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Sep 2024 09:21:52 +0800 you wrote:
> As Rob pointed in another mail thread [1], the binding of tja11xx PHY
> is completely broken, the schema cannot catch the error in the DTS. A
> compatiable string must be needed if we want to add a custom propety.
> So extract known PHY IDs from the tja11xx PHY drivers and convert them
> into supported compatible string list to fix the broken binding issue.
> 
> [1]: https://lore.kernel.org/netdev/31058f49-bac5-49a9-a422-c43b121bf049@kernel.org/T/
> 
> [...]

Here is the summary with links:
  - [v2,net] dt-bindings: net: tja11xx: fix the broken binding
    https://git.kernel.org/netdev/net/c/2f9caba9b2f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



