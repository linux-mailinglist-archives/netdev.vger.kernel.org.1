Return-Path: <netdev+bounces-176228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EBAA696B2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC8619C48BF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445B91F4C88;
	Wed, 19 Mar 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mipelKeX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C91361;
	Wed, 19 Mar 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406000; cv=none; b=AqeaXxFps+8+ainW7ghcePDw/ZQ8mhEI2GfAoIK9lLfcgqvW+ABAXoG6se8odShDpAnxsRbAiEkSoke8klRpbVzR12XxJkCVE+6qdOpR348OBPnTzh8KhrKZ2Nr91hXHsSEm7cCgQsxK6uLooeFtCOXDQ6Tfs50VCK5iYJzE1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406000; c=relaxed/simple;
	bh=3iS1Nid3hVupIVK8yX+AtPOSA9VbgHfzJ6vsdb/SE9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VIEuFu5i4QNO6+XruSWZcMrZHz6+qzTXq+AZnCg+2p/kNyann4jeTGZ7dEYzjnU/bys9nh2TmGxAaoZAMc2JXTQjR1k3g1P6Iqju/yLHsGf32UVrN2Xct0aKbt/BKgCoJnPMD/M8E9/3OooZ3pp1DfY427bQaUsUp11Tnhx3tF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mipelKeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A646C4CEE4;
	Wed, 19 Mar 2025 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742405999;
	bh=3iS1Nid3hVupIVK8yX+AtPOSA9VbgHfzJ6vsdb/SE9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mipelKeXek0u7WEJJhh/0KMAGYRgGSyMkdw/pPEzcT4WMmww+U6Wd7D983rVPLsep
	 VsN1304unfrt/5jh+/bS6tMK2hi23RzOGZQCIknhXjLCr3zJOwB0hnr4yulMqd+4pt
	 bXochih0TaBQ5FF/W/J8Y9Z445F601/Qgn8hIdjUNAqlYQ4W2iW7HsT5NfubHt0JC5
	 8ipu96Wknmc0c+SFNNZqnkts6s5GgdKo3JEwgBwkcx3fd8keXDFdH+c7+JMQQOx60i
	 ckoJ9zze9a1wwZIv2gOLfDoOUXgtceqmrcEiAcUyijBICO23/HCl0HMOmSOgJlPmYg
	 6DUu/9WHFXyKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71042380CFFE;
	Wed, 19 Mar 2025 17:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next v2] net: stmmac: dwmac-rk: Provide FIFO sizes
 for DWMAC 1000
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174240603529.1129938.15321664004147428078.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 17:40:35 +0000
References: <20250312163426.2178314-1-wens@kernel.org>
In-Reply-To: <20250312163426.2178314-1-wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, heiko@sntech.de, wens@csie.org,
 hayashi.kunihiko@socionext.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Mar 2025 00:34:26 +0800 you wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The DWMAC 1000 DMA capabilities register does not provide actual
> FIFO sizes, nor does the driver really care. If they are not
> provided via some other means, the driver will work fine, only
> disallowing changing the MTU setting.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v2] net: stmmac: dwmac-rk: Provide FIFO sizes for DWMAC 1000
    https://git.kernel.org/netdev/net-next/c/d3c58b656c97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



