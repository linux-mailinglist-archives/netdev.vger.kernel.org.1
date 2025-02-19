Return-Path: <netdev+bounces-167585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8AA3AF89
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A317609F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E8D1A3170;
	Wed, 19 Feb 2025 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NstBYLgZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F71A23A0;
	Wed, 19 Feb 2025 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931616; cv=none; b=R9ClFMAdseLam8mQ5oq/R22+1VXxY4zCy6+g36jQSO5T+eG+EwQ7owS9Shcqt+kwGrSi9tR1pGd7bM5yID1Dq+Hu38GKSVrdJqHUKwP1T5Jk8UjuL4lStXRHkqiQFS87lchmBsB+CJSimGHsXS7ivNYxCTLSXbwwLai2KIUZ+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931616; c=relaxed/simple;
	bh=36fSqNoXHViUn9M7IfTQ2kRb7ezzr4z4u2aoyveHKbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f1lNhouh3HyWF2mHSymFtgYNHPZAQACh9X55EfVTmirzvCI/hFBdIMjZ+KJRKeb1MUsj3L9HRVH61B9lF6QdWAhpAutACsnyJIRwKEXkqj+9HmmgoEv/AKJ9b2kSKeFfkiMBO/z8Qp0ZzVCC75P1jJFY1UeJPQpIMDNDlw/GjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NstBYLgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175E3C4CEE9;
	Wed, 19 Feb 2025 02:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931616;
	bh=36fSqNoXHViUn9M7IfTQ2kRb7ezzr4z4u2aoyveHKbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NstBYLgZCkuIb206Lk5omf9/JBNDGQbJ+hI9KZ3X7mXOTJSEvU/KV2EQlI8cgnlbm
	 M/uDAXsTCJVg4qjRuC6YMvNYMAj8jM9AL+xBsNwZcD4uA1hMU7oGOZmDCCS20UvcYO
	 p/W9OhettggVA8U+8XuA8FIkt6Z8At6kHMYnaBcyMgcXSgRovFExbZCZ0GYTFbhGGq
	 dA3rjedPja33aKyexQ1ZP79hw4EwHjn5cWyVlQsKyge2sz01wOnnYwam8dOO1NJjgu
	 bpdYHIaiFTjlBpg19A41U/LZDqPUT6GhzexjQcdjZpsQj37FaaucOybYFJQZos1TpB
	 BSCez5FjUrnmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF24380AAE9;
	Wed, 19 Feb 2025 02:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: Remove redundant variable declaration in
 __dev_change_flags()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993164649.106119.12528129240098678219.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:20:46 +0000
References: <20250217-old_flags-v2-1-4cda3b43a35f@debian.org>
In-Reply-To: <20250217-old_flags-v2-1-4cda3b43a35f@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, nicolas.dichtel@6wind.com,
 andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mateusz.polchlopek@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 07:48:13 -0800 you wrote:
> The old_flags variable is declared twice in __dev_change_flags(),
> causing a shadow variable warning. This patch fixes the issue by
> removing the redundant declaration, reusing the existing old_flags
> variable instead.
> 
> 	net/core/dev.c:9225:16: warning: declaration shadows a local variable [-Wshadow]
> 	9225 |                 unsigned int old_flags = dev->flags;
> 	|                              ^
> 	net/core/dev.c:9185:15: note: previous declaration is here
> 	9185 |         unsigned int old_flags = dev->flags;
> 	|                      ^
> 	1 warning generated.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: Remove redundant variable declaration in __dev_change_flags()
    https://git.kernel.org/netdev/net-next/c/8f02c48f8f62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



