Return-Path: <netdev+bounces-169669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C620A452FF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9173A773D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359FB218E85;
	Wed, 26 Feb 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjZPXewj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3681A9B24;
	Wed, 26 Feb 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536400; cv=none; b=Q7KyGKzwH/i/zh+OHapDAa+HnUy4tYyMIwahSS+64oI9xNCROThiW/cXSS2XApgmDF2/Id3U4Kvtp8uWZh0lBViKLcmaQTqFwDYOoIbxO70P7VGE2AYfNTumZn57ZQK038J/wlnCiFzYS1iYekdvWNQKzLz7VNRP9Y1Ym+5z7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536400; c=relaxed/simple;
	bh=/rOqXd62XCneerpG6V2yH0b0pC4F+Bc1elCnpXs1+OE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hArR2fkVeegvibq/LOJg0oGnaGMAKgMO7ZiuKn2ZqHKqXdIsncKnrZNmOv8sp0i9LOc8lIhGIMkQzc6CB1tK9ghQrQ1Tpxth7zdlMT3t2hBjmB2Y68M7YD1bRE14r9M+WmDkvcwAUmRnaySARS0Kow6qiIpElIpL/i7YAs4nST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjZPXewj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85553C4CEDD;
	Wed, 26 Feb 2025 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740536399;
	bh=/rOqXd62XCneerpG6V2yH0b0pC4F+Bc1elCnpXs1+OE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BjZPXewjekEYf6gsnJCUWCIix88BvU+Y35ZcP/YEFuDxWsswqP2hbp8xEpK6dqTcE
	 uQdhBLJiSKmixFDqWjbqc3qftpyeN8fFr/8pfQrqImr9Ecb28ziNOmpITTqB64HWdJ
	 2sELW5oaQZo+Ncb4sl7DAdx7U1Ke84jSeFLn+7lhhy6d97gp+/DRdIjYbTsLeUdug4
	 deD5qHCXCmftfp+1VVomPl4qPx9F89nzFWskUA1qhjxD6qXmp3+uZYtSV1ySPjLJ0a
	 dFk9fkIkrYfMHz+xETJp14R5rIwlEo6Y4NEpmbzLj91UL5Jteil/IOvoLGdcOTYuXf
	 LofVhEiV65Sjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71590380CFDD;
	Wed, 26 Feb 2025 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw: select PAGE_POOL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174053643129.203661.15821794782135886083.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 02:20:31 +0000
References: <20250224-net-am654-nuss-kconfig-v2-1-c124f4915c92@pengutronix.de>
In-Reply-To: <20250224-net-am654-nuss-kconfig-v2-1-c124f4915c92@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 06:17:16 +0100 you wrote:
> am65-cpsw uses page_pool_dev_alloc_pages(), thus needs PAGE_POOL
> selected to avoid linker errors. This is missing since the driver
> started to use page_pool helpers in 8acacc40f733 ("net: ethernet:
> ti: am65-cpsw: Add minimal XDP support")
> 
> Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [v2] net: ethernet: ti: am65-cpsw: select PAGE_POOL
    https://git.kernel.org/netdev/net/c/bab3a6e9ffd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



