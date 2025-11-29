Return-Path: <netdev+bounces-242664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB9C937F0
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 05:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 139E334312F
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF8523496F;
	Sat, 29 Nov 2025 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9zs4T6/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098C233D88;
	Sat, 29 Nov 2025 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764389609; cv=none; b=RnckWRbw+XAD2OQcxsye+yxU0K1+bZO/bYngkuuoUX4jjddHH1WM3j80t2KTJ1V+NM5+zMIwSr35h3aqjnw04/lIAScqM3Z2SZlHszUHWS8q5mSP5dVfllvg2RNJMoFJ/mktA2RHs6hALNbf4u8OuMJ3J+ExcQFZJoclmFYxCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764389609; c=relaxed/simple;
	bh=16CWBlAjMnObwnvBeLCcvrZwKLKX1E3MHiTXKgkowVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TLjfF9tyYTdoruVb79QjE/L4MFnLhbs9iGRu6KLyheamHxWE5sjPBdMDeQln7m26xz4rDmcBXf25x4bC9ZBevp4Tb1zeOjYOHKTkm5RTUVcBAeRws8XwlyYUVznwooY2FZ+GB67UMmhrZD+ITAOVCA7J113gzp41hJrRiYw9YPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9zs4T6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FF0C4CEFB;
	Sat, 29 Nov 2025 04:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764389609;
	bh=16CWBlAjMnObwnvBeLCcvrZwKLKX1E3MHiTXKgkowVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u9zs4T6/2ZR7ree9yxOE9MV/kx2v+QiYIvGzc8lI3rOt92Nc/Ip7arN6zQf11N+4F
	 UnEnEjkNIbJz4hMblezjNwgof9PTL96e6l2grFuULwuN1z/XHo9jLJ9Yyi2F9UEaAX
	 nOE5rVD/ssl8iI75mSAvM3t3ISj+f/muX3Y99FPHhbX41mpngYU29MI3rtJI1VLpPq
	 FCxpOjLS7Ugez/v8KXauwl8beXoFo8cXRPDBQER2Joeq3Iis79TVkRp8Z5tmO60rzD
	 za3wIt7jCL1MDBeWMQp5z+s/lCbD2DVcm2Gbs55Wi7+cQILNToqUIU1NBTXA39pMme
	 tCfgxDJ7mim2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 01B34380692B;
	Sat, 29 Nov 2025 04:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: broadcom: migrate to
 .get_rx_ring_count() ethtool callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176438943073.896171.9965500132545324533.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 04:10:30 +0000
References: <20251127-grxrings_broadcom-v1-0-b0b182864950@debian.org>
In-Reply-To: <20251127-grxrings_broadcom-v1-0-b0b182864950@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, opendmb@gmail.com,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Nov 2025 02:17:14 -0800 you wrote:
> This series migrates Broadcom ethernet drivers to use the new
> .get_rx_ring_count() ethtool callback introduced in commit 84eaf4359c36
> ("net: ethtool: add get_rx_ring_count callback to optimize RX ring
> queries").
> 
> This change simplifies the .get_rxnfc() implementation by
> extracting the ETHTOOL_GRXRINGS case handling into a dedicated callback,
> making the code cleaner and aligning these drivers with the updated
> ethtool API.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: bnxt: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/bba18f3ba7cc
  - [net-next,2/2] net: bcmgenet: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/335d78c6161b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



