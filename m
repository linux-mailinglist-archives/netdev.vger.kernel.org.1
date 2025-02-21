Return-Path: <netdev+bounces-168356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DAEA3EA3E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24D019C2116
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872E71B2182;
	Fri, 21 Feb 2025 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSQD7W1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B691876;
	Fri, 21 Feb 2025 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102013; cv=none; b=RQ6p/T7a8SUfSQqtR2YlwM+V3+YAxcgKL+hFXpbkvPaRWztvQ4pykHOG23JgoZuOhsYQQK6K56LZXMT+wWFDrJq9M7UbfbahZKeToyvtUkdEQgXFUqsL3V/hueFssgyqNAa3St5tacoG8/WxqwcCwV0o2n2eixxmh0mx8n7EMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102013; c=relaxed/simple;
	bh=rZgkdRO50hyQJJcu3JT98HTVpPlkY042buLy1A9xd6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kCsUK093s+Fj0RtTkEEibG6IYJc+2Hyv/av2cke1P0+PNqi3uGEiu1/UUBjU4NX7++JOwBdUuX2bWetOUvDbveGsc3ElMlv7w9Wh1NYu4BS3vNgthUqQ3RMdY8GjambciaLQLz2MNMW8R+NAT0dboZy1BGUfSp/dWw0cG4BCR4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSQD7W1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6292C4CEE4;
	Fri, 21 Feb 2025 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740102012;
	bh=rZgkdRO50hyQJJcu3JT98HTVpPlkY042buLy1A9xd6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PSQD7W1Qf6V6HJ2WyCJ4nJ8M//2toDZL9rVbHg9SC0AU+oJQzWassrWh9SNLAwGXN
	 Y+g0BRZU3okJf9mluAhqB7ZJj8YO5f298RxZYtRncIVhZmLbAgCRUAcbpOSvSAGYqH
	 XY7irqKuUb634DobJfu1pznGWo0N3Sdj3fY3FAOnyAYkwrMGKxl8NepX7OSdKm+7C5
	 eLnrS6ljXWcceLAKk8/0XFXRM2EpAjF6K95xTKUrWvr9xZ+3HIajR2eBfYPssNmmBh
	 EM2dM9LKTafc7j2ArTKyC71ZB5Y70Dv5c8fLFtAu7h5YR51QXUBQUbhL+dibCL0bkj
	 s32gzh0aBmlww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF49380CEE2;
	Fri, 21 Feb 2025 01:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] neighbour: Replace kvzalloc() with kzalloc() when
 GFP_ATOMIC is specified
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010204326.1539943.669802709586927809.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 01:40:43 +0000
References: <20250219102227.72488-1-enjuk@amazon.com>
In-Reply-To: <20250219102227.72488-1-enjuk@amazon.com>
To: Kohei Enju <enjuk@amazon.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@amazon.com, gnaaman@drivenets.com, joel.granados@kernel.org,
 lizetao1@huawei.com, cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, kohei.enju@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 19:22:27 +0900 you wrote:
> kzalloc() uses page allocator when size is larger than
> KMALLOC_MAX_CACHE_SIZE, so the intention of commit ab101c553bc1
> ("neighbour: use kvzalloc()/kvfree()") can be achieved by using kzalloc().
> 
> When using GFP_ATOMIC, kvzalloc() only tries the kmalloc path,
> since the vmalloc path does not support the flag.
> In this case, kvzalloc() is equivalent to kzalloc() in that neither try
> the vmalloc path, so this replacement brings no functional change.
> This is primarily a cleanup change, as the original code functions
> correctly.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] neighbour: Replace kvzalloc() with kzalloc() when GFP_ATOMIC is specified
    https://git.kernel.org/netdev/net-next/c/ef75d8343bc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



