Return-Path: <netdev+bounces-230618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E07FABEBF2A
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 865FA4EF6AF
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C02DC322;
	Fri, 17 Oct 2025 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi0nOEam"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE302D7803;
	Fri, 17 Oct 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760741423; cv=none; b=VNbljBm+1997wnQ53P/XNyJPL+1pJYsgzzMMROAEHBHtOr1RG0kjSfYXabihKxUeQIbIaHUSrxdDzRMgVlsHonZ8QYWd5frtB/7jg+jO7q4IGikk1SuaD9tCPRS+20xKzulH5lR5VQgDKGROd3P8jwnG9/N82pOTTtnK4xLdkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760741423; c=relaxed/simple;
	bh=GPQmksuK2+DVq7N6Av/crui8RyWbd0z+p5E8e3rCPEY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fX9rDS14XE/GxU4m5FgTx+igto3ADPayKfTeOaJIv+jpogMeeoo/PGSe92t2/eLCyuYuZoYaDAfQkBZtA1EBjugexXirVLmSj0OfLPhls9ilI/8l9INhwTU0aEuEy1ahx5Ab8MB7dof44QElXkLz4rM9kOf88Z3PCzcGmKLC2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi0nOEam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C9CC4CEE7;
	Fri, 17 Oct 2025 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760741422;
	bh=GPQmksuK2+DVq7N6Av/crui8RyWbd0z+p5E8e3rCPEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pi0nOEamyDDf7yVlfIPAL2n6W3tbMm9m0S13GtEE7qKXWY2rqBzFLL6pqjrw9TxCc
	 JpidkhrFzfDU2aBzvSIv75YcwBetyvgYf1j1P5927dEVnewwMWsVNk0qVTsThPVufa
	 nzpbdS3mx54Ni+R+7i1SJp0YvF1j7x2kb5aiMN6XkHr3Ivcc6K28jVLfQnuB/WuYxd
	 eD1HiAmfHLFk31IPxomIN8Qo43hoj5btVPBGVSV3ZwkDzh6uufpJzSYBxd46qFGsf2
	 sIjXxERObxTiHY4dtq6KObiT7ZRSXp1SmsxJWqAlUV5B5J7vGqzmLpi6WVQrSMOydg
	 bwc6k7boANLZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ECE39EFA5D;
	Fri, 17 Oct 2025 22:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hibmcge: support pci_driver.shutdown()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074140600.2812574.7675764447909082136.git-patchwork-notify@kernel.org>
Date: Fri, 17 Oct 2025 22:50:06 +0000
References: <20251014134018.1178385-1-shaojijie@huawei.com>
In-Reply-To: <20251014134018.1178385-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 21:40:18 +0800 you wrote:
> support pci_driver.shutdown() for hibmcge driver.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../net/ethernet/hisilicon/hibmcge/hbg_main.c   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Here is the summary with links:
  - [net-next] net: hibmcge: support pci_driver.shutdown()
    https://git.kernel.org/netdev/net-next/c/0746da01767e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



