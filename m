Return-Path: <netdev+bounces-192472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E236FAC0040
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A90E9E7C99
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EC923C4F6;
	Wed, 21 May 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8hbG8Nd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2223A9BD;
	Wed, 21 May 2025 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868398; cv=none; b=tx4Sc+0LQn35NY8Qn4us6i8LW3joJtBJVOzCUawRxmWDxjmEvnd9RWIRlG2hKpXLS+rcbTcs4PDrtgzfZBMqnmNhpCxOgtOsF4RJzDwwBMOeViH9OtyLR6sFVYebvrAUnzppvr1YxFQ+P/mt7A1YPwkOCYVQIx25HExPJXj+6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868398; c=relaxed/simple;
	bh=1pDOZFHjqohmQvtcZYTUSMLO5Xu1D0EF/otyNwuG2/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iEQoodNk5urCxrJ+AezRODc06WSdraL0d5axy6OXLh2qXx7HOrzYNpWS9fnLRP6usTqH5pEQ/yrDGnslTpP0565zVCpUg5gah6F9INO6HnY379sbMGC5T68ZmNTvjObo0G2L5qJY0lza6L+uYO4KYXgYENxRmbn8a4EknfrBfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8hbG8Nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5389AC4CEE4;
	Wed, 21 May 2025 22:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747868397;
	bh=1pDOZFHjqohmQvtcZYTUSMLO5Xu1D0EF/otyNwuG2/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C8hbG8NdIYHMaQkhSt+ODkpOS3n2t34w/Noz22f873GYbvJnFARDu74/W9XAZr8ol
	 xlUB0gT66R1cMZUCYL67+fPgUldaHlsriJoDZ1Xw4VIOJ3FmgvXuoJFz3xG9LDRuJr
	 iUFBbB3F5VtsiQdTqugShRjoz8DM4udDrbXxFX7191bwijGY9RrRkH6RnV1q9eClBN
	 0xEsolnfADuTOq625aEj+dKPLxQ8KCUcVkL7vSZadm1R6hzMSXc5Mq3LmwOWyermR7
	 mYsN9RNZGvFy0quHCyXj7qrFYqKyNchkWY/QFofNJzdM8CkFuy+Vi92Lvz8iR3TjxD
	 np/teuhwwHhbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D0E380CEEF;
	Wed, 21 May 2025 23:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] There are some bugfix for hibmcge driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174786843300.2308458.2867018455441520141.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 23:00:33 +0000
References: <20250517095828.1763126-1-shaojijie@huawei.com>
In-Reply-To: <20250517095828.1763126-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 May 2025 17:58:26 +0800 you wrote:
> There are some bugfix for hibmcge driver
> 
> ---
> ChangeLog:
> v1 -> v2:
>   - Use netif_device_detach() to block netdev callbacks after reset fails, suggested by Jakub.
>   v1: https://lore.kernel.org/all/20250430093127.2400813-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: hibmcge: fix incorrect statistics update issue
    https://git.kernel.org/netdev/net/c/009970506c92
  - [v2,net,2/2] net: hibmcge: fix wrong ndo.open() after reset fail issue.
    https://git.kernel.org/netdev/net/c/1b45443b8487

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



