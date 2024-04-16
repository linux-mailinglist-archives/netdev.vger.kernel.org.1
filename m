Return-Path: <netdev+bounces-88236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB28A669B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130FD2834C7
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B5D84D23;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+amS6Lk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5B84D09
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258029; cv=none; b=I/iFH8rnwKAyLFrB+uwY8SoKKslfW8WvtORhqZqj2xti4B/gxvuHcVCKh1kPZrXQxwDXkEHNO/DeXjv3JXSv/nY0w23eZx+uTNdAdK3R9g3oW99ylxB4Q+MGE8vF8b/+AihOOQAUO1MW+oQbtYOl7uMBkixqWPuPI6anZ23F4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258029; c=relaxed/simple;
	bh=JT2kl89B7YEZauTYwcGBd4POvEKs049v9Yc67561Z58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O58JN3zMYAHKez6tlFgbhBQH9a+B4tGCzQAV06ROcO+0x+uR/6xcgrYELuGm7uW1rcgq7q8oqE7t1Ovnq2dTJcYGd4fvxgmptL3zC9FCRuvobrPb0rUWHqS1m5gxk9lkfPeZobHvgBqZQXk88Fr/ap4TKzgka4hLnkNs8nBcl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+amS6Lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EBFFC3277B;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713258029;
	bh=JT2kl89B7YEZauTYwcGBd4POvEKs049v9Yc67561Z58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s+amS6Lkj8L+Kzw29S2vu8mSIur2HxKy7pmhXUe5ypdj4SYCp2PPgBQf8rU9RDOEd
	 xVuDk20VEwFyQ+KQKDBIjDhe3/VS65xvy4+ib5k+M1B0diuVoXWKMxPrzn/G0LPP2b
	 GdOxZybNAykkOaxHWkUdu+QszE2GfI/tLjAClzo7FLDsGoPr0LnRqRGXjTcZ1SxnrY
	 GnJyBnlByniRM0nHlknuo7/u+zcPSNllOgZPwUS/4vUsViqC18YJWSEwAIL6urBo2G
	 G+5JGVEIT6WRJaLMI820oDyPa6JVyvjRWNNz+jMPCc1vHFRsK63WuCgAt96aPoLqDp
	 WNNTJvmD27yTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C5F5C395F3;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mt7530: provide own phylink MAC operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171325802904.5697.14592728708310075025.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 09:00:29 +0000
References: <E1rvIco-006bQu-Fq@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rvIco-006bQu-Fq@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, olteanv@gmail.com, arinc.unal@arinc9.com,
 daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 12 Apr 2024 16:15:34 +0100 you wrote:
> Convert mt753x to provide its own phylink MAC operations, thus avoiding
> the shim layer in DSA's port.c
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/mt7530.c | 46 +++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: mt7530: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/62d6d91db98a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



