Return-Path: <netdev+bounces-250139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7E0D243F3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7555130084C4
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BE92F3621;
	Thu, 15 Jan 2026 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITmRUlkD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657C2FE067
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477415; cv=none; b=dsYRMJ0gUw9X6059GWuR+J9OjZGIk9mDVfILgkOI7M57AWjEkdG2elBDPSqCy9TVq6O8VCT9ZUGPP2WLhvNw2WIm5JomqgHoCJ9mgH5/wu3MSHECPU882WPpZAtZUE0nuv8HrFzmL7Mc245TM0KqatBj8UJFDr7lamvwM917Zcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477415; c=relaxed/simple;
	bh=7kjXyOwL0AMWwWvgtmgg/IYZLoCzTXRpld9/JxRkLUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RtXim+40EVY2h9rro4tp7edSIk/SVDYjyB8wQfK0EqC8xLY63cGf1eI41OqInHf2W+qwWB/vgLQ7uBbnK1svpU7u5CEwDsTd3vVh3eWQsKc3HAnE4t8tCPIXizGbj1ddFaxUk6lZOX3rSTaWQPvIat/UUdCbqDmkuRNlDk3yi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITmRUlkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714DAC116D0;
	Thu, 15 Jan 2026 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768477414;
	bh=7kjXyOwL0AMWwWvgtmgg/IYZLoCzTXRpld9/JxRkLUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ITmRUlkDFDVYtHI9CgKjel1ZLFa3yzzcVzQRqBDlQxxOcwq14Vdy+fuPNzJGEcBJt
	 7quVaMXSR3lwjijq9SHzupZ7Zq4KfXPE947aRRJd9nddytQvJihGTQRLz3+ADevtB8
	 jfp7fIHLTDCOY1EEBtdlALo+y2enohVKDqssd2IKB2kQ/Q7KuatSPWYyTIyk+vyNZw
	 Z9O2jGlQ5dups8RZ20JSr2LNfMEWcxuxQ6vt769QmMdjBmoRwst3I4v2RTOIpGkZ56
	 QFdSYf/n/Jxg9RqixFlEbltfUNvsMRsidRRGqeyJl7fa316smjmXMOFf2bJsFT8gr/
	 rYdtGy9A171Qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F32D93809A81;
	Thu, 15 Jan 2026 11:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: inline napi_skb_cache_get()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176847720679.3956289.12601442580224129560.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 11:40:06 +0000
References: <20260112131515.4051589-1-edumazet@google.com>
In-Reply-To: <20260112131515.4051589-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 Jan 2026 13:15:15 +0000 you wrote:
> clang is inlining it already, gcc (14.2) does not.
> 
> Small space cost (215 bytes on x86_64) but faster sk_buff allocations.
> 
> $ scripts/bloat-o-meter -t net/core/skbuff.gcc.before.o net/core/skbuff.gcc.after.o
> add/remove: 0/1 grow/shrink: 4/1 up/down: 359/-144 (215)
> Function                                     old     new   delta
> __alloc_skb                                  471     611    +140
> napi_build_skb                               245     363    +118
> napi_alloc_skb                               331     416     +85
> skb_copy_ubufs                              1869    1885     +16
> skb_shift                                   1445    1413     -32
> napi_skb_cache_get                           112       -    -112
> Total: Before=59941, After=60156, chg +0.36%
> 
> [...]

Here is the summary with links:
  - [net-next] net: inline napi_skb_cache_get()
    https://git.kernel.org/netdev/net-next/c/d4596891e72c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



