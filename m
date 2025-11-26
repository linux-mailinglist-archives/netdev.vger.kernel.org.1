Return-Path: <netdev+bounces-241752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E083C87F00
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749EF3B4571
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC5930E82D;
	Wed, 26 Nov 2025 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL4Q/Lt2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F730E0F9;
	Wed, 26 Nov 2025 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127265; cv=none; b=J0RyXRnr9XywNEjexdWAWB9sXNC27WD9t94amBru7Z318lm+I05foZgvtU32Poa/Q1LwM8UST4wNOL4sPE3u8lzzmJ/J9QNPJwbr10epRv1JClQ25CLCKHlmwgMPoBOQSaFuDn7YAWjXFsDhr6PPKAQ7pqHogBQbJ/rlu7AbgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127265; c=relaxed/simple;
	bh=Lup+rFOh3UdecPgPMryRCQ3YjGIA41SXQAuFACIEIAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CEmn3rQWs/73romjcnNbbazqQnYqocFqlphHF6SEh6T0X08T4IEklvCI+hwnJ+AsqJ+iFR9pmVwhb/KXg0mIeDQ0aRGraS9jU4uly5CH3ikjAIbq8j6Q9pVUJvBBESN+VAuEofr6qDLrBBIdIirXvdYuYyv2QH6rCpPe0pdao8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL4Q/Lt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB1AC113D0;
	Wed, 26 Nov 2025 03:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764127265;
	bh=Lup+rFOh3UdecPgPMryRCQ3YjGIA41SXQAuFACIEIAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jL4Q/Lt27H4PstgIRCevptbB08QowG7WFaw0c+n27uMRYp3Gxpm2Pl4cyTxOyG3aD
	 t4Rj7qVzAE2ESWJR/8/EkMbKPgvFdjNm48osKUSOeAC7jgkNVkVD+3HUETdjW2QuK1
	 2CQUMOly+thZuxCBwVW/MNR1vWv2t+r7+hONbKU+tEfE3AnJ0t2Lyx4gnS0Nx8xs6J
	 /MDy2jEzyjT2u2RvAPSfUGNt2wXjoEVk6Io0cU/yDW24oo3GCGSd0p5JoMB2DxaJfj
	 XZhkwqC8iVJJeKnXFr0f7o7vrLQsdQf9+9DSCJJ/W6ywBZ2j6clvyo0NDQnf5HQP7/
	 iX0TEbOSLEsEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE09380AAE9;
	Wed, 26 Nov 2025 03:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: phy: mxl-gpy: add support for
 MxL86211C
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412722749.1502845.8815105383873079012.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:20:27 +0000
References: 
 <cabf3559d6511bed6b8a925f540e3162efc20f6b.1763818120.git.daniel@makrotopia.org>
In-Reply-To: 
 <cabf3559d6511bed6b8a925f540e3162efc20f6b.1763818120.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Nov 2025 13:32:15 +0000 you wrote:
> From: Chad Monroe <chad@monroe.io>
> 
> MxL86211C is a smaller and more efficient version of the GPY211C.
> Add the PHY ID and phy_driver instance to the mxl-gpy driver.
> 
> Signed-off-by: Chad Monroe <chad@monroe.io>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: mxl-gpy: add support for MxL86211C
    https://git.kernel.org/netdev/net-next/c/9d844da693d6
  - [net-next,v2,2/2] net: phy: mxl-gpy: add support for MxL86252 and MxL86282
    https://git.kernel.org/netdev/net-next/c/de1e5c9333f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



