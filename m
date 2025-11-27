Return-Path: <netdev+bounces-242144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070CC8CBCD
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A213ADB22
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5D212548;
	Thu, 27 Nov 2025 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbJHuCnU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA82C0282;
	Thu, 27 Nov 2025 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213445; cv=none; b=mz4hdQ/hNnlh78VIDN3oL10gF+/yuFCA8QxOcexz9EgCnTBVv2HV0gFU2HHD1BA2JMEt3umAlQwX1VG43Uh06fXbrff0R2bCRFELaiqPFZxsYWMQKwMv83ZsdNnBXqgnOaE4wNHq6B7O8GTKHZnLFXhYzUKErNDdFNTyNvsunkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213445; c=relaxed/simple;
	bh=ZRSBTqmKmpuAivUfQmnl1z+2NhLlR9/xYH+vHAQVVWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=axtUwqtN3FtaaJYDe6yCto41d6eF8F8lTG56WHgD6wGzEGK7BMygNtILFZcXgSy0Co+e5XEMKSTq7IoGygZWiEfxs97Ck/DbHDnbDF+sognyu/qtW04MTEBH4xEQt5u3lpVV0Amh5MmMGHFikkzcc6xSO5j9di40jmDCkQECC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbJHuCnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E7BC19422;
	Thu, 27 Nov 2025 03:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213445;
	bh=ZRSBTqmKmpuAivUfQmnl1z+2NhLlR9/xYH+vHAQVVWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LbJHuCnUMMieQSeAaVcv/DSxazMpaAqsEv1+bPK/PvQ4hU351cF2fV77FhoOXNf+R
	 20rdd/EEHBb2+y0dt/jh808Tffbw/sQevOjLbIm0qw5mY+Tdip8peycWfKj+Tx1QGw
	 fZoXfWrXbNorjXuTC1vHoSBOvG5tZqZgLOUcliKZY1LIYwOWVtw+fkhq6ZaKWlhpWA
	 5xYctdwmUqX4b+rVjut0s1t3lk4z+8AffjS2Jvz0X0O6PU5B4J/orLVmLLuMlzE0Ni
	 3YYhv6RZT8qngZ/dvrhKhKgk2wgIA38FHj7DTOq4GEJ48Oc7Dg+p9D73lw3Ug97sVb
	 fNjeYtwocgdVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71458380CEF8;
	Thu, 27 Nov 2025 03:16:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next 0/3] net: hibmcge: Add support for tracepoint
 and
 pagepool on hibmcge driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421340699.1916399.3126508798740910470.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 03:16:46 +0000
References: <20251122034657.3373143-1-shaojijie@huawei.com>
In-Reply-To: <20251122034657.3373143-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Nov 2025 11:46:54 +0800 you wrote:
> In this patch set:
> 1: add support for tracepoint for rx descriptor
> 2: double the rx queue depth to reduce packet drop
> 3: add support for pagepool on rx
> 
> ---
> ChangeLog:
> v1 -> v2:
>   - remove the legacy path after using pagepool, suggested by Jakub.
>   v1: https://lore.kernel.org/all/20251117174957.631e7b40@kernel.org/
> 
> [...]

Here is the summary with links:
  - [V2,net-next,1/3] net: hibmcge: add support for tracepoint to dump some fields of rx_desc
    https://git.kernel.org/netdev/net-next/c/91f3305b97fc
  - [V2,net-next,2/3] net: hibmcge: reduce packet drop under stress testing
    https://git.kernel.org/netdev/net-next/c/2e68bb2e0f77
  - [V2,net-next,3/3] net: hibmcge: add support for pagepool on rx
    https://git.kernel.org/netdev/net-next/c/c30595917585

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



