Return-Path: <netdev+bounces-246275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE33CE7F8C
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBE31300955E
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7B13314D0;
	Mon, 29 Dec 2025 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7jY6xSN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953A270568;
	Mon, 29 Dec 2025 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033804; cv=none; b=VeBFwSQka2oSKROx4TuwCbqFpXOcDjeDeJVomOt45/jCdKk2GOadGOj0w9p8Ig82E+8gunDou9Sm5wecogEiUmsgZOHuzAKSO5lt+H9GYdUmlqlVs5adQBL8JPt+15CSoTT6Wgfc6SlNAHVSHj4BVLKTwpPghjdNEjRGoETQke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033804; c=relaxed/simple;
	bh=N3J8/loOJ/xeMlMD0jq34WUcW6+QdtGMFue5FLFOF/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PmO3QbATU/5M0R2DSoYBo1UtuBUHIL+dDZepB8MuBi/ZrdqVekndZDSoyVipsKsqvqVff17rkeD7HztjmtbMKLlBpTDgnP1agboWY9B2xy7qakgfAhgtV87Shol51xGMJcMXP+CycUBY6KdebKI2Il0jIzmrNqOj4tMtC7cne/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7jY6xSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3162EC4CEF7;
	Mon, 29 Dec 2025 18:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767033803;
	bh=N3J8/loOJ/xeMlMD0jq34WUcW6+QdtGMFue5FLFOF/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r7jY6xSNz/bt4bdolaNeEF64E+hiBtd09S16SkCp32bOrajWRHfzb1WixS8tWMgTh
	 nfsWQEJi71wMy35ZL99v10DMwpjUUw7waa6Fb4VEYI1JSlWC94XwDMp6zOv1SnIu7g
	 RHSFVU+D1NocBU5TpvpwH3AUpUAzcY5J79R2EFeEZ8eN62Rj+fzUE4YHrpn0263/Pc
	 hr6hEiBAIVBUL/xArMnNTzH+v98KcokeIm5XB6hiUoExo3lCNqZ1hPl6bzqsnrbbWU
	 XBJICtWgvpky8P+oXlUDTl5qbGWezT/fJltYoAXxsUPCFYjlqtpgmfmkU7Lh7KN8Bd
	 /O5eVVdj6bXZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E1C2B3808200;
	Mon, 29 Dec 2025 18:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipv6: BUG() in pskb_expand_head() as part of
 calipso_skbuff_setattr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176703360579.3028177.3495525956172701388.git-patchwork-notify@kernel.org>
Date: Mon, 29 Dec 2025 18:40:05 +0000
References: <20251219173637.797418-1-whrosenb@asu.edu>
In-Reply-To: <20251219173637.797418-1-whrosenb@asu.edu>
To: Will Rosenberg <whrosenb@asu.edu>
Cc: security@kernel.org, paul@paul-moore.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, huw@codeweavers.com, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Dec 2025 10:36:37 -0700 you wrote:
> There exists a kernel oops caused by a BUG_ON(nhead < 0) at
> net/core/skbuff.c:2232 in pskb_expand_head().
> This bug is triggered as part of the calipso_skbuff_setattr()
> routine when skb_cow() is passed headroom > INT_MAX
> (i.e. (int)(skb_headroom(skb) + len_delta) < 0).
> 
> The root cause of the bug is due to an implicit integer cast in
> __skb_cow(). The check (headroom > skb_headroom(skb)) is meant to ensure
> that delta = headroom - skb_headroom(skb) is never negative, otherwise
> we will trigger a BUG_ON in pskb_expand_head(). However, if
> headroom > INT_MAX and delta <= -NET_SKB_PAD, the check passes, delta
> becomes negative, and pskb_expand_head() is passed a negative value for
> nhead.
> 
> [...]

Here is the summary with links:
  - ipv6: BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()
    https://git.kernel.org/netdev/net/c/58fc7342b529

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



