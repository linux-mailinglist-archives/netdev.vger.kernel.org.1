Return-Path: <netdev+bounces-219164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE9CB401F3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B904834EE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D134B2FDC2C;
	Tue,  2 Sep 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWrwE5CW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E452FC86B;
	Tue,  2 Sep 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818004; cv=none; b=WQcCoFpXR+aEtWIILqPjBDQk5k66YcM8apYV/8R2cbzUTTPNfIQOTnLx2Q53aCQxo7HdsFIGgKpHh5/SIDBv11DRZKgzeg8Is4CzdLZkoUrbF+/KRivP6KH9nv07G6vw6lP48QQiY8pjJjCWkeTIuAKobIJDdbCU+9rQ95ke2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818004; c=relaxed/simple;
	bh=pWfEGB8ng6pD4FBke5r3gfm6HQrX4TKAPXhvq7ORBTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fkeMoHROdELd3E4AABzLb8GOBBAim7Q5Y1aperlGTF9OLX7qqnGbIqeKSI3BaXt3vzRgmtAv0ckYxy2g9rSI0PqhWi0F7cN59Ju6HHvUBM9/5lzi4iGtiOPI1wn5P2fYmvQGN35Eec2/RljYLFYfXm+qeWJRkBqyS98fjz7ad00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWrwE5CW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB371C4CEED;
	Tue,  2 Sep 2025 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756818003;
	bh=pWfEGB8ng6pD4FBke5r3gfm6HQrX4TKAPXhvq7ORBTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZWrwE5CWAeDa1xxMu1gbUt9wSd5g0DbRfDeziDDgrfLldlunnPPT7PcqCozyjQhHD
	 kk9kq2MwN2Z+fIXoNiLBA5vOPJ3hDww47n5EqpcqSq/kvfiH85Rekt8r1KMXbd/haJ
	 r9FWNBTQBG/UiYwRDMp/YzVuezkzLuiugKBCOUnXBn2hKYeAdAUWkVCxnGajzwUfnS
	 oPtNkBI7RPhWnaw0dAuyQA2CkJrwfC9I8mgGsi3abQnO71ROVpv4t86B8SOdYV3yic
	 qhBLm9aZKjtmcfufraO21jjeVql5q4qVUAkF+FXv80XcREi1HsoTg614rIS1FlsbwY
	 ZK5c3jeyg2FYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7297A383BF75;
	Tue,  2 Sep 2025 13:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix null pointer
 dereference for ndev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175681800727.285041.16636382479672217812.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 13:00:07 +0000
References: <20250829121051.2031832-1-c-vankar@ti.com>
In-Reply-To: <20250829121051.2031832-1-c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: mwalle@kernel.org, horms@kernel.org, rogerq@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 nm@ti.com, s-vadapalli@ti.com, danishanwar@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 29 Aug 2025 17:40:51 +0530 you wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> In the TX completion packet stage of TI SoCs with CPSW2G instance, which
> has single external ethernet port, ndev is accessed without being
> initialized if no TX packets have been processed. It results into null
> pointer dereference, causing kernel to crash. Fix this by having a check
> on the number of TX packets which have been processed.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: am65-cpsw-nuss: Fix null pointer dereference for ndev
    https://git.kernel.org/netdev/net/c/a6099f263e1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



