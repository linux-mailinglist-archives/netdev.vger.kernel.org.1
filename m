Return-Path: <netdev+bounces-214797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFACB2B54F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A32196278E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997449659;
	Tue, 19 Aug 2025 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9kAvi1L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34664F507
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563396; cv=none; b=qLXCCFYf3EdkKjl6C6L1drTS/W7Gd6C1R2j2EfDNs2l0QkFXRW1azwgGnHL+KOVe3Zu8oKT+mJqrDPZu5NJos0CNOIuIf8HEkKPPEtgEvu7Oke264xO6xkmWHLM6JKx81o8VDqa2p8fyVR99ebwQDMNt5myHUMs0l2jDu0CA4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563396; c=relaxed/simple;
	bh=PDmBDJ96SwkWJ3h5auzJjDRxZMFzGBnkGw7mvXW2bR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AT+k6waqzEMjHFJpaD7pC2tFaVlSqpp7+bEcO3q7LYgs0e4Ruf2AiINDLYqcEY5AGO8u4JYIxRzsjXyS+yt9HVfDudWubsn7DmnRx/63I/QDAqoHxhqjqQHmc8eICKs/TIaKDfBUA0ivFHqQPPL8Zkgb84GUe8lLVKCpl4lFqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9kAvi1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0767C4CEEB;
	Tue, 19 Aug 2025 00:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563395;
	bh=PDmBDJ96SwkWJ3h5auzJjDRxZMFzGBnkGw7mvXW2bR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a9kAvi1LK+cG+iWpYGqlcXEICgjGMdbca6D9hx2JSyZLD0LmJ2LrNGPtS1Pbzkfoy
	 89tuT+kXQlYdasmSEHj+Z7jg9LImhkEKa9FHCHmQBz6Prcs8JnEGfCwTb0m85DWzUm
	 Cp0N2ca27WQZQ2e6RbKUgyFYSLzCz4oYrKXXe39vCyXZYuILdeFa+YUgJ0ml6oc70S
	 zkQjSemWnMtZEqYf5FqjhmyXJIprAW94vp80LCT/ChDgWb4oam7Dq9mNCLt8O6cD66
	 v+7EcZ+A3sfcfAUWHRfo4iA2o+9YiOgFymnbz+ySjJYqTiYZMKH/qHYQPQFc6ST2FD
	 mCsfC1hhu2HuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2C383BF4E;
	Tue, 19 Aug 2025 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: gso: Forbid IPv6 TSO with extensions on
 devices
 with only IPV6_CSUM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556340575.2959470.8995178513415785744.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 00:30:05 +0000
References: <20250814105119.1525687-1-jramaseu@redhat.com>
In-Reply-To: <20250814105119.1525687-1-jramaseu@redhat.com>
To: Jakub Ramaseuski <jramaseu@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, sdf@fomichev.me,
 ahmed.zaki@intel.com, aleksander.lobakin@intel.com, benoit.monin@gmx.fr,
 willemb@google.com, tizhao@redhat.com, mschmidt@redhat.com,
 willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Aug 2025 12:51:19 +0200 you wrote:
> When performing Generic Segmentation Offload (GSO) on an IPv6 packet that
> contains extension headers, the kernel incorrectly requests checksum offload
> if the egress device only advertises NETIF_F_IPV6_CSUM feature, which has
> a strict contract: it supports checksum offload only for plain TCP or UDP
> over IPv6 and explicitly does not support packets with extension headers.
> The current GSO logic violates this contract by failing to disable the feature
> for packets with extension headers, such as those used in GREoIPv6 tunnels.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: gso: Forbid IPv6 TSO with extensions on devices with only IPV6_CSUM
    https://git.kernel.org/netdev/net/c/864e3396976e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



