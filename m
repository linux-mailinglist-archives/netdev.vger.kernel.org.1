Return-Path: <netdev+bounces-178922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A035A79911
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BDD17291C
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE31F9F51;
	Wed,  2 Apr 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjqa7y2t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797561F8670;
	Wed,  2 Apr 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637202; cv=none; b=ditfgVPw9l5RT4+b0BOCbTa1fMyQxZ6uz4gE4E3BqECk9EkOaspwuHoH+Uyum3JWiSfoUZzPINnRA4Q9f2YHTTzYmYrYCGVCR3QK5CfHNaDC4Pp7FXfGButwFmKCU1gZHSlRV4Kb9kWsFSPRJI3/y/EX0+41A7DsLtrsMQ9t2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637202; c=relaxed/simple;
	bh=eZXamGcUFJf3JGdwncfEXWIL6WpV0YiWQeC2ZjusWE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IW5y6wKhfuebkQ4ninITVvLfPDnup1BJL49B7rKN2sQCr0yaFF9Trc44cPePEzUd4n5/MBPQ66fw0AKMYy/gYyz0KESC/PCMBp3aqgBjat5Et5aTJCCB4zkICeuv5dovGRStaCKx0scduByUFcbs7IgMzPI8Qtgi+JdmopE+bpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjqa7y2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C05C4CEE7;
	Wed,  2 Apr 2025 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743637202;
	bh=eZXamGcUFJf3JGdwncfEXWIL6WpV0YiWQeC2ZjusWE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kjqa7y2tpyv/zYp5Y7Q88FZgSsgr3TKgHJpi+hgfontj2x9rkchFqiatbtnhCnXNg
	 fhRAbBNxx3MC4TRH10VM2F29JGD2kRmkg0Cl/9LgTDsgG6u7qvHeCfil5hxdOXEIul
	 Btayg8Mhx/vqGhfgD/LBP1NL6XFcHqV6GkWMzFSewtlvuM+PBcwBK+CZJm1lItuWqN
	 7b8InAWs2JxTS88HYB5uBrnPh9YX16b2GATwk7VRfWcgeQ5Frg4jW48d1ULERvcsuH
	 /iIo2C2OReU6lsgiG16ECXzbhyDr+E8VQW3h4sFzS4tYdMvEAALVzKyQrFpSJcDi6E
	 /VMbnRvpNC2jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC00B380CEE3;
	Wed,  2 Apr 2025 23:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] eth: mlx4: select PAGE_POOL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174363723874.1716091.9449335720888818915.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 23:40:38 +0000
References: <20250401015315.2306092-1-gthelen@google.com>
In-Reply-To: <20250401015315.2306092-1-gthelen@google.com>
To: Greg Thelen <gthelen@google.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Mar 2025 18:53:15 -0700 you wrote:
> With commit 8533b14b3d65 ("eth: mlx4: create a page pool for Rx") mlx4
> started using functions guarded by PAGE_POOL. This change introduced
> build errors when CONFIG_MLX4_EN is set but CONFIG_PAGE_POOL is not:
> 
>   ld: vmlinux.o: in function `mlx4_en_alloc_frags':
>   en_rx.c:(.text+0xa5eaf9): undefined reference to `page_pool_alloc_pages'
>   ld: vmlinux.o: in function `mlx4_en_create_rx_ring':
>   (.text+0xa5ee91): undefined reference to `page_pool_create'
> 
> [...]

Here is the summary with links:
  - eth: mlx4: select PAGE_POOL
    https://git.kernel.org/netdev/net/c/d3210dabda8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



