Return-Path: <netdev+bounces-234245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EDCC1E158
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C531934D51D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B02F361A;
	Thu, 30 Oct 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRTOC1bp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D112EBBA3
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789640; cv=none; b=h7TQoB2sAnlgH9BX3sVZs29XZFqLFxAl7DmTy+Mh4w8+SS9eoVbrvbENEKK4RIz94BVyqAxu0TpmwhTkaseod2df7BkYpac6USMPGqZGcFqa0f6A6m3wbrNJLF23MjJD3vNFujPfRLB+5pIqg5QCfQxVbi9251mUjRvEpZJAqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789640; c=relaxed/simple;
	bh=TF+xR6KkE5OxIUkvy+8hHfKZ6+KB/cpOjzBZ3NfVqqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ut3w6qRdwkfGE9E2P00OEq2qZ3g2i4IfZmBUn2byUuZzVjb7Y9g8IfoHOzsAkgu8BcfM5ni9+mvQDVcP1SeNw7VloC6GzeW4+bwgA9c/LHxx18VcY5cNL9FDPZWpyEuEqjt1YY7qdBMC623l3HB/lINZ0usFwZBXH01K97jxkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRTOC1bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9743BC4CEFD;
	Thu, 30 Oct 2025 02:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761789640;
	bh=TF+xR6KkE5OxIUkvy+8hHfKZ6+KB/cpOjzBZ3NfVqqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IRTOC1bpzA0kKLl18DqZ2dgnna/3cQnn4+WjtiR4iC1LuGUru3GrZx9p8l8KGMkZ+
	 q5A2hgO6cs8ZuchhZNhelEp5cceJPktfnyn/p1MskQDcVFnt8NDh+TR4jpgA82kHLV
	 a44FDRqic4yuZZbwVTcTJzh1hwstNCOFjJ9m16p9GsiGvnJclrPEIXxktoNbY12EcC
	 a/lGzfZ7Xka8HlEbGNsXBjdp1ZF39BwjhFficNpwajotUCJwMA01UA//eePWi1tVHu
	 NFlogkCIy53t9ZMe25+8MNhX89gz6g44JAKASaSS8Nf0CzI8Q9PYiHVAEosoAUoF+1
	 xT6250KQsYmUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CBAC43A55ED9;
	Thu, 30 Oct 2025 02:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: stmmac: mdio: fix incorrect phy address
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178961774.3282477.10436173337048887248.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 02:00:17 +0000
References: <e869999b-2d4b-4dc1-9890-c2d3d1e8d0f8@gmail.com>
In-Reply-To: <e869999b-2d4b-4dc1-9890-c2d3d1e8d0f8@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, davem@davemloft.net,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 25 Oct 2025 20:35:47 +0200 you wrote:
> max_addr is the max number of addresses, not the highest possible address,
> therefore check phydev->mdio.addr > max_addr isn't correct.
> To fix this change the semantics of max_addr, so that it represents
> the highest possible address. IMO this is also a little bit more intuitive
> wrt name max_addr.
> 
> Fixes: 4a107a0e8361 ("net: stmmac: mdio: use phy_find_first to simplify stmmac_mdio_register")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reported-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: stmmac: mdio: fix incorrect phy address check
    https://git.kernel.org/netdev/net-next/c/cf35f4347ddd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



