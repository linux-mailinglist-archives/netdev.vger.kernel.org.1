Return-Path: <netdev+bounces-225763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE3FB9807E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 03:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BEB7ABDFE
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 01:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF002040B6;
	Wed, 24 Sep 2025 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tY96a/5Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A812C18A
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678610; cv=none; b=l+4lOwVxVP0Tjjb6siBbWFLCwe2iaw9C/w+WgDMv6dOFXhKlPaxAwCqoBNktl85D2jGFvrRtiFEQ1Luyh8deFsNDL6YiR65+q2SEI05lc5d9zXngkHMWdM3bB95ldWcANJ++RB/OjIuf/mYf/CVHL5WxQdwLsVpVAQ7kSAottCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678610; c=relaxed/simple;
	bh=QqwikQrkN8QBPo4cBRMKtvWlP3hZ2QVqVxzDJDyTn60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CMWj+MUr90oqCj2y8lxkAuXT8pl5OaRUgAEnSnEbtCSGGrzllxoM47fr+ZNrSX1rRBHYV1A/EpPy/9Vzya5BDC9m8dPgMCazrfurMzXzZniakns+kj49FMaZI5KSJApzMMSZsLWmxBKYG1UjB9VBspQvTp0DLJb8DycasTtfAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tY96a/5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E00CC4CEF5;
	Wed, 24 Sep 2025 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758678610;
	bh=QqwikQrkN8QBPo4cBRMKtvWlP3hZ2QVqVxzDJDyTn60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tY96a/5Q1jVaecHLbeMHiqWFBj1B/rTFZw/ucSp1PNFZo3X/gsDQwstuLNSVf8QGa
	 1ye4+EmQoPYwD+tdeT1XcymvbKjzmjn3GCVr1CDnTL9Q8cFhQnPF3gjj9ZyDRD7Z3+
	 /nqPLHuTCGRxzjn/paT0+w2ey8i9BsKSr3n+tvQ/KCQokXvz0V1U2xwHFJunxC5BmB
	 ximBtH3qlAo0PRU7rG8wnHc5RWlD/YxVDnghGD9yhEAg7c2Z/4Jzkx4KyTZl4wJbsw
	 3TOznkQPf6faV6aHlp1U/mn8Fx+xto3AJWjSFkQFSro2mzG97USTlU0onYhaRSQnkK
	 Fz+BiRqOgEnRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCE39D0C20;
	Wed, 24 Sep 2025 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] tcp: Remove stale locking comment for TFO.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867860700.1994582.15023356418215363140.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 01:50:07 +0000
References: <20250923005441.4131554-1-kuniyu@google.com>
In-Reply-To: <20250923005441.4131554-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Sep 2025 00:54:19 +0000 you wrote:
> The listener -> child locking no longer exists in the fast path
> since commit e994b2f0fb92 ("tcp: do not lock listener to process
> SYN packets").
> 
> Let's remove the stale comment for reqsk_fastopen_remove().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> 
> [...]

Here is the summary with links:
  - [v1,net-next] tcp: Remove stale locking comment for TFO.
    https://git.kernel.org/netdev/net-next/c/dc1dea796b19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



