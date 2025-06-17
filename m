Return-Path: <netdev+bounces-198814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF2ADDEA5
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 00:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0861189C1DA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 22:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6F8288CBE;
	Tue, 17 Jun 2025 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkbUJ8qH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07EF2F5312;
	Tue, 17 Jun 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198804; cv=none; b=EIoWodGHwCFPCjVZHSJBTZ1yLyrQRNbdq8iuN2NyVVaseZFkbqjLx8DJq1SvyzubMsRWrJFmpJEFTRjqT0LXA9+6AE7uVHwwX0PGU4fIqoYOCn0PzXRnwYuPrJp/eygKSFujBkemvT0aUXGLwDZzWmMp0K/1dyap6e46npBH4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198804; c=relaxed/simple;
	bh=9q43kaCItYpfDG1jtrjq+bni/HfVsYltE9XsXWL+axA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hLG1XzIrV9g8CJcMFqLbRF7inXtqtq0uZBqhROCsd9hbD9nJU9RFlyq9b8JshJ7Hn3MULO+1/9FA4/6AqJ+qxv/cpa44vDkndNDUnlW9Hm0lGgG2zX7rU0d267w6zX6ghd+NOueHzQDkguJ52MeG4XEEaZ4NKUVgJVT6r9GBs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkbUJ8qH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DBCC4CEE3;
	Tue, 17 Jun 2025 22:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750198804;
	bh=9q43kaCItYpfDG1jtrjq+bni/HfVsYltE9XsXWL+axA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fkbUJ8qHB8jz8HcZYyc5jtTNZA1pd37eHzDDLWC+hmJ970VScKJ+kV6O6vGKIGJ/Q
	 Z7Qs0AsorrfbgO7ed9XHteOb3z6wpE8MdrP/SamebvtK99Ivptp3RKpsaOLXZuGp0+
	 Xufc398uTR+Wcw7PYRmn0pHOaojbbf1NFcqEVh854RJsGM3UltKwv1yL4cwlcHu0G+
	 T+PWohNv5p2Lkq+NE4MRbcj6aitN8U9AAVVnMCweJQk8TC3WFbgvpYSxG7FYJb0wuN
	 PloJ1VUH9fclB5li0YOzApfHMfbsxJweAZUz8GlPAsB/Hw4bKcEukiXLqPCI7IW8o8
	 pWwMhenQs0N8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9C38111DD;
	Tue, 17 Jun 2025 22:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] vsock/test: Improve transport_uaf test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175019883300.3717086.5304057159618682213.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 22:20:33 +0000
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
In-Reply-To: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 21:56:49 +0200 you wrote:
> Increase the coverage of a test implemented in commit 301a62dfb0d0
> ("vsock/test: Add test for UAF due to socket unbinding"). Take this
> opportunity to factor out some utility code, drop a redundant sync between
> client and server, and introduce a /proc/kallsyms harvesting logic for
> auto-detecting registered vsock transports.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] vsock/test: Introduce vsock_bind_try() helper
    https://git.kernel.org/netdev/net-next/c/d56a8dbff8fe
  - [net-next,v3,2/3] vsock/test: Introduce get_transports()
    https://git.kernel.org/netdev/net-next/c/3070c05b7afd
  - [net-next,v3,3/3] vsock/test: Cover more CIDs in transport_uaf test
    https://git.kernel.org/netdev/net-next/c/0cb6db139f39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



