Return-Path: <netdev+bounces-104859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2609B90EAEA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D339D1F24D86
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324A143757;
	Wed, 19 Jun 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhUB9kh6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB214373C;
	Wed, 19 Jun 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799629; cv=none; b=d78OLdCZyvO9FD3hi2YGpRLEPl5Jh0LUq9Gv9bMRx1/do1q62g46snYJau/pFqP0cXoR50UZmA8wHVHhIcsJ0EtjVPqqHM96ZBTQQ8kheHgMV9lXzUBab9d3rc8qcvwl+KWqKztTxSolJ2QNIjsTz84wNUHBdWOutk+KKWsoNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799629; c=relaxed/simple;
	bh=4GBBm4WNPljSNrgz6eD06a7GENpvd4uQxJij5l6zFIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kqGHYu5Gn0hTyXvITYyWry85jVmy36ECCWshTMqRyCZ57H/ebRTJ9UAMUatZYHppqMCTctjuZMUsvL9vvvkbFMX4XpFhMzm4hahsM603r3T6JJK8Iq7ZddWV6qVR6XP3sNjLnaXNdUIoq4xiSFJOrO6BLdDL8nmi4MuyE4gMd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhUB9kh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9ED9C2BBFC;
	Wed, 19 Jun 2024 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718799628;
	bh=4GBBm4WNPljSNrgz6eD06a7GENpvd4uQxJij5l6zFIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UhUB9kh6ttUPx7czD1D6jwLnx8NLqHADgrv3ZvoItRGMi3a2BAFZ2WTDDgUOcmclO
	 gsiiYwqZ7Rxw67eFPtreWsZBYkiBFy/I8cyonvHHBwCKBBDPff4fdvobey9gIB7Kwt
	 9vghKIMwsJVdht3iLwKXC7xrfd6Q9VMMA/X6FGZDcydSYEMbLgEgHAiiVp0oyP3zll
	 /arlulQwTwqGcq5MJYtt0NKLDGQ8SxWcUf+5oMiwl2x5BGHlfnvssxDpcRX0OHW4aH
	 FahI8N8P9ijOS3U3+AayySrBM8raeU+R+CVZpTiCCLCCvKxiQahqvuSHgZdI/4nC1F
	 yVK0sSmM00cpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE0D2C4361A;
	Wed, 19 Jun 2024 12:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/2] net: dsa: mt7530: factor out bridge
 join/leave logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171879962883.21133.13473416587347020687.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 12:20:28 +0000
References: <15c28e5ed5fa02ca7904c71540e254617d571eb8.1718694181.git.mschiffer@universe-factory.net>
In-Reply-To: <15c28e5ed5fa02ca7904c71540e254617d571eb8.1718694181.git.mschiffer@universe-factory.net>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: arinc.unal@arinc9.com, daniel@makrotopia.org, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 18 Jun 2024 09:17:12 +0200 you wrote:
> As preparation for implementing bridge port isolation, move the logic to
> add and remove bits in the port matrix into a new helper
> mt7530_update_port_member(), which is called from
> mt7530_port_bridge_join() and mt7530_port_bridge_leave().
> 
> Another part of the preparation is using dsa_port_offloads_bridge_dev()
> instead of dsa_port_offloads_bridge() to check for bridge membership, as
> we don't have a struct dsa_bridge in mt7530_port_bridge_flags().
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: dsa: mt7530: factor out bridge join/leave logic
    https://git.kernel.org/netdev/net-next/c/c25c961fc7f3
  - [net-next,v3,2/2] net: dsa: mt7530: add support for bridge port isolation
    https://git.kernel.org/netdev/net-next/c/3d49ee2127c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



