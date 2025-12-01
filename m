Return-Path: <netdev+bounces-243106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF16C998C9
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 00:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8C514E1677
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 23:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02224299AB3;
	Mon,  1 Dec 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD6kdJyL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1C298CDC;
	Mon,  1 Dec 2025 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630808; cv=none; b=WNh+ER36wEsC4daDaAdLQsM6Q0LPsCWG+Tez0NVyBw8bVXuhMz084kOJVfYlStcs+YzTLRZnBAJzqu0AnYxzZ7w7EXt6Lydm/e8Mhe/bAzreBb1CMfF+SUsgCRDWbdR0V+8mEY+9CH/I99yRfR5/QVIcK1r/dTE9Zg148xbin0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630808; c=relaxed/simple;
	bh=iwv3mbINFrEjgjVUGI5WTAXbysofSGgS7brGNSgNFS8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P0F+YXtGhNSyox7f563oyDyyDOrCJ/tZKgJL+Tn4eb6WBjYzKh52e6kFoAKqQJS3bTLmuc9Kg6/KNHN4w7g2lOxweZZU97t14yFBSJSwmcGfPcDIaxI+gMt769amWHwuEO6jNW4qRjAxP89Vl+vx8n8pjyNassboqcDv8d+7x4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD6kdJyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDD9C4CEF1;
	Mon,  1 Dec 2025 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764630808;
	bh=iwv3mbINFrEjgjVUGI5WTAXbysofSGgS7brGNSgNFS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YD6kdJyL4X3vbHEBSypoAMXn43h1i67fQmTthzMUGyS9FNMIqasbdVC+J4b/ZffRI
	 yz/d+Kye8IjsSjWjpFAVONXEWRghVvE6x80F2MAkRhLq23YZU4N8oLLMtgPtGyZPXy
	 h84faDltjspEt7qiVcMb7QAYYORrCkMxtQ/tTlQparwe2kEKupIDUzTxYBYJGNvo3u
	 2QVjOHWYMIPc5rC2Fy64jgvKrD64c05dxJxeCMqumX8Zhe7M6TNgJetZAZzYRcPRZ8
	 vI6MSTP2GYrP9QPYoXZAUmi1oQsdzcpd3HoWWDG7H8DOMA0k7V++Fo5ZIRTg28IK0r
	 m00Nl9pZoAf0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78F5D381196A;
	Mon,  1 Dec 2025 23:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] net: dsa: yt921x: Add STP/MST support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176463062827.2589368.5614176232655657667.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 23:10:28 +0000
References: <20251201094232.3155105-1-mmyangfl@gmail.com>
In-Reply-To: <20251201094232.3155105-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Dec 2025 17:42:27 +0800 you wrote:
> Support for these features was deferred from the initial submission of the
> driver.
> 
> v3: https://lore.kernel.org/r/20251126093240.2853294-1-mmyangfl@gmail.com
>   - fix type in commit message
>   - remove HSR in favor of simple HSR
>   - remove LAG for the moment
> v2: https://lore.kernel.org/r/20251025170606.1937327-1-mmyangfl@gmail.com
>   - reverse christmas-tree
> v1: https://lore.kernel.org/r/20251024033237.1336249-1-mmyangfl@gmail.com
>   - use *_ULL bitfield macros for VLAN_CTRL
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: dsa: yt921x: Use *_ULL bitfield macros for VLAN_CTRL
    https://git.kernel.org/netdev/net-next/c/d973ac83ad0d
  - [net-next,v4,2/2] net: dsa: yt921x: Add STP/MST support
    https://git.kernel.org/netdev/net-next/c/633b1d010ce8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



