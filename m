Return-Path: <netdev+bounces-164194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE793A2CDE3
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24F9188E287
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F091E2310;
	Fri,  7 Feb 2025 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ideN0iak"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EC1B0103
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959015; cv=none; b=YTheeF2B8bfhDhp2eYVf7b++YFq7SGAxOwcf+tsrM6rCsOJcBrTIWvtU01FDFDgPT8zcQLwaCJWQxCPH7xraBkADI1aby5zJ8qe2IOaRG8JJyQRbkLoOCGnqxLAOLa1eQzoEelQMadXhTMe8yTsYnBP/35GLBf7QDQE8gHaf1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959015; c=relaxed/simple;
	bh=gCH9j4DYXtIGsOYKIbLUIEj0fjjkMcor6q/SzMKKpbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DQouG+FmKc2zAAuHSlRhuQgWYhYCubXGTqRQ4tyBRh6TjeWBo7WBu8EcDAssBUm6HInfvceWIemrIP6xF4rZGorCsNihCKYHPt0+hATr/chsHKDvrJf6zMj+n8tyfFduEKlO5iuAz8jK+85WRVa0GQ3B7Fe1NFAQykmp/P7uWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ideN0iak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7713C4CED1;
	Fri,  7 Feb 2025 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738959014;
	bh=gCH9j4DYXtIGsOYKIbLUIEj0fjjkMcor6q/SzMKKpbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ideN0iakTHddIceRkt1dhPV3Nqbu/0ovT0kv/3ugJ7yUYUO52I0JmAoXe8gK8tzCL
	 VgxvNupAc1C8iGUmwKRZvjIbpnoslKb4y9kH1Az+qE1SNCuAY3QQcmURPgxEow7ze3
	 98oZuK/+eVvxb9qnSkgVWcs33f+4lRsKAaaai55Be6vVD1g7lfq+xEEucqXniMKq/4
	 fXNsNG05sqUt94gjRUukx/r4B0RGDvV44XisnZSCUwzOK4+6Cji+isIgXzCgrKvhO5
	 XRE2z1mIDXWCjvcuJTzES3EFksovOFHP2PBSFjGq/y7UgSgLhuzixoM5Bmy6v8MUuj
	 M/qFWDmz3ujDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED04B380AAF4;
	Fri,  7 Feb 2025 20:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: rename
 inet_csk_{delete|reset}_keepalive_timer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173895904266.2367164.9473767909599089538.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 20:10:42 +0000
References: <20250206094605.2694118-1-edumazet@google.com>
In-Reply-To: <20250206094605.2694118-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kuniyu@amazon.com, ncardwell@google.com,
 horms@kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Feb 2025 09:46:05 +0000 you wrote:
> inet_csk_delete_keepalive_timer() and inet_csk_reset_keepalive_timer()
> are only used from core TCP, there is no need to export them.
> 
> Replace their prefix by tcp.
> 
> Move them to net/ipv4/tcp_timer.c and make tcp_delete_keepalive_timer()
> static.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: rename inet_csk_{delete|reset}_keepalive_timer()
    https://git.kernel.org/netdev/net-next/c/be258f654a6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



