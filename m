Return-Path: <netdev+bounces-199626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E7AE0FF7
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 01:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2811BC5010
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC39128FAB3;
	Thu, 19 Jun 2025 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS+kh5pW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1520E711;
	Thu, 19 Jun 2025 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375199; cv=none; b=sVp3oRuxzD8gCQ4QGFbaTcvmMUQx7qXEN42i0M0SrI+JBHjSEWurf4WoXq5IV6YMreq26RzSoOLbHSfLL/Vrj7BrvZBvAfXNKiMPJZlO7+9CUqDHqGh6qX0+Kn94zhRLndehWppibRzJGsT3TEbmLz728atrM+z7a657lMgjDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375199; c=relaxed/simple;
	bh=4Bdy9C5PuSX9JTAQNrp2VbCcmafGKAL2q+RH456Z+VE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I1dogBDi+7A/1fjajLffzJ7z0xZGRg+BqI7+r6lhK7VgUOa2VRntUbe6OcakgP0eom1lAL8ycm05mUR4Rrnd2vuHYhDu+NprRkPx2A6uN79XRwi7sfTWD+EvvJtkjv1Aar19czZRMLvDoKzVa9ThCtZV0vCij9Hz2Zaz/SICgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS+kh5pW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3611AC4CEEF;
	Thu, 19 Jun 2025 23:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750375199;
	bh=4Bdy9C5PuSX9JTAQNrp2VbCcmafGKAL2q+RH456Z+VE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bS+kh5pWl9k4kl46mn9V9Q+n6++HToBv1G0Y7ZvjegOw8vUPW3bXLPuXX2LdBV4K7
	 DHKh3qsawVnZccwIARoXKmIzrHqpen+Ma/5k8yTXQ/XeQU5ldNpftgwdjsCtbO5QNV
	 ExP20C3g/TEDhe2/Ukv487b5MDMlFDZcoOYap3tsGm/ZyF6AL1jYLiy+IAFPL6SUW9
	 M+gqKtPZ/dP1IAx3TUbTq7s+/VfUI2bnJfvsqOxOMUHLsmsjGSZAAdFYRQtxyhjc7+
	 yfpG+761kS2Q2IvKof2Waeb7C5OVrKgrY9CXCFcaeFjtlOo37OCtT/w7xTlp5gys9s
	 /UIvio5ES825w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AB438111DD;
	Thu, 19 Jun 2025 23:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] netpoll: Code organization improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037522723.1016629.14491510127149155566.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 23:20:27 +0000
References: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
In-Reply-To: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jv@jvosburgh.ne, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gustavold@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 02:32:44 -0700 you wrote:
> The netpoll_setup() function has grown complex over time, mixing
> different error handling and concerns like carrier waiting, IPv4 address
> retrieval, and IPv6 address retrieval all within a single function,
> which is huge (127 LoC).
> 
> This patch series refactors the netpoll_setup() function to improve code
> organization and readability by extracting logical blocks into dedicated
> helper functions. netpoll_setup() length is reduced to 72 LoC.
> 
> [...]

Here is the summary with links:
  - [1/3] netpoll: Extract carrier wait function
    https://git.kernel.org/netdev/net-next/c/76d30b51e818
  - [2/3] netpoll: extract IPv4 address retrieval into helper function
    https://git.kernel.org/netdev/net-next/c/3699f992e8c2
  - [3/3] netpoll: Extract IPv6 address retrieval function
    https://git.kernel.org/netdev/net-next/c/6ad7969a361c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



