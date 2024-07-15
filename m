Return-Path: <netdev+bounces-111507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FCD931668
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BFB6B21FB7
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF7818E76D;
	Mon, 15 Jul 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktbuj53l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1718E76A;
	Mon, 15 Jul 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052631; cv=none; b=KdZvgy0qvl0cjAkJ6SCmWm46K09W6WjcveNHiW9SRtuK3BXTFhBp26i9Y7+atTCktqtbbnwWwOLwB3xITWEXZkbyGFy2ntRNFOZwuD0EQv4wZdHDXjr/VW2bSYsywCPwvvyBebsQMHJVUqotPvLQSqhYtUqs3MMpoksyXx4Q+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052631; c=relaxed/simple;
	bh=ht2JCIAsLHGmnyNUQgUbLpCK5RPVGRPrPxDVIVFF+lg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p7qTm4qVyzOR1icXf6dWLiv2emCexp8yfR2rGnogyRciHK4C+YoHmTEbPZGrFbl1u8eyxnyoMwEGpxZ0SQ0+hhypp7DJ8ojCKNMPxeGKVYtYB8IvZwxa5Xnopk3+spKRkjThsnWJ4qqLSsKHTj8XW9epmYr8z+rAgd0LbCWJpqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktbuj53l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4923AC32782;
	Mon, 15 Jul 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721052630;
	bh=ht2JCIAsLHGmnyNUQgUbLpCK5RPVGRPrPxDVIVFF+lg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ktbuj53lpTM6F2I8ArwOnwgjaqskCau7aFYFhJ9th35/B7sfEwgBQuM30h51CxOkV
	 /ifE1copqwKUpoO+ouGGRt2GcrGJe2AXtBhSgr1421VnfoYKn0HmcqnQ49Tn6CeS0c
	 91Q8qB724M3l5JGKAUJXe6BrHRHy/MsoCuc8XopoP8Ab1j8YMiO+uCcCSiWG3VM5yf
	 N47sXsoP6W+j/o6lGhvKrobsVocsSd6jdoaJ7kAEynC9M0WM918A8Ez4w+Thw1gJav
	 YimuaI7Sf29/E+wyaSWoA35BR2YBwPjS3HEsOYfHTUUJ/LZ9tDpOlWMZNXJOd8HtD2
	 GKmdfChydNPUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 335AEC4332C;
	Mon, 15 Jul 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ethernet: lantiq_etop: remove redundant
 device name setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172105263020.31289.15084984358464625955.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:10:30 +0000
References: <20240713170920.863171-1-olek2@wp.pl>
In-Reply-To: <20240713170920.863171-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jacob.e.keller@intel.com, horms@kernel.org,
 u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jul 2024 19:09:20 +0200 you wrote:
> The same name is set when allocating the netdevice structure in the
> alloc_etherdev_mq()->alloc_etherrdev_mqs() function. Therefore, there
> is no need to manually set it.
> 
> This fixes CheckPatch warnings:
> WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
> 	strcpy(dev->name, "eth%d");
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ethernet: lantiq_etop: remove redundant device name setup
    https://git.kernel.org/netdev/net-next/c/9283477e2891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



