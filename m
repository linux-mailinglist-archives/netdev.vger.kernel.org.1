Return-Path: <netdev+bounces-225734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07B4B97D70
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC9E3AE022
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63079156678;
	Wed, 24 Sep 2025 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUvYPdMX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D77C130A73
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758672024; cv=none; b=R6j8Em0Y+P5xoatiCUzXlGpjVfLBsMIrZuu8dtzA7jCzOyL4hUukTONUdQULwA8YiRdL47ZlMaH7X7lrW6WL4iXhztqmzb7Us1Z/T1tpKV3D6I+b4y7A8pEVZD4O4/9ZmkFM4QljieyQJgFFnbix7nMM8/3d06F1zZrMdLVrY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758672024; c=relaxed/simple;
	bh=hYZ0tSKOPKoEfkkmQjjRnkenZWdlbdNLY3ealb3ZND0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pe9epTFLXO1ONe/yghVoNrWETWcsTBloz7oUzLjHaRg4cr9OVkOx/MpjglusSrLJejPzkbHW46Hv0XMiH4RGyZtSbvKe2jxQTfgXeodCkoJg4Hdoap0DwJnuAbLjEHvGmvoNIHDOA/vBv95E7Q4DIEi1BkLL6PANc5C7C6n0Zco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUvYPdMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CA4C4CEF5;
	Wed, 24 Sep 2025 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758672023;
	bh=hYZ0tSKOPKoEfkkmQjjRnkenZWdlbdNLY3ealb3ZND0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uUvYPdMXN+kqAPZSq64k61sKBwbs8Po046SqTI9kLUiMnikzsBhAHYjP9bTAOBARO
	 8ZvAfvwASjbWT8NAUGt5cBhw/pDRhqbD6i2lgoMyDhEA7/dfTvBJlBryLNEWHX3301
	 tVd6auy95B/o4ifiAaRbcJGKplv6N4GO6w+W+X6J+QZadQO4o9WU8T7tuJIzQXLMDE
	 fTbd9Z7aWAgOp+Merj0A/mIo7jbUPxA8gAE9Ybq6trXFO+zhDnrcRmVgSLBtw1yawJ
	 rTUaVAdFertiqMaFl2N+DdqAh+aZbIuUkpPwX/+fvjUv2gX80WewQXGi1XoivqG6Eg
	 AQol6lIng9B7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA439D0C20;
	Wed, 24 Sep 2025 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: allow alloc_skb_with_frags() to use
 MAX_SKB_FRAGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867202049.1967235.5341414234774872189.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:00:20 +0000
References: <20250922191957.2855612-1-jbaron@akamai.com>
In-Reply-To: <20250922191957.2855612-1-jbaron@akamai.com>
To: Jason Baron <jbaron@akamai.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 15:19:57 -0400 you wrote:
> Currently, alloc_skb_with_frags() will only fill (MAX_SKB_FRAGS - 1)
> slots. I think it should use all MAX_SKB_FRAGS slots, as callers of
> alloc_skb_with_frags() will size their allocation of frags based
> on MAX_SKB_FRAGS.
> 
> This issue was discovered via a test patch that sets 'order' to 0
> in alloc_skb_with_frags(), which effectively tests/simulates high
> fragmentation. In this case sendmsg() on unix sockets will fail every
> time for large allocations. If the PAGE_SIZE is 4K, then data_len will
> request 68K or 17 pages, but alloc_skb_with_frags() can only allocate
> 64K in this case or 16 pages.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: allow alloc_skb_with_frags() to use MAX_SKB_FRAGS
    https://git.kernel.org/netdev/net/c/ca9f9cdc4de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



