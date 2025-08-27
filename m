Return-Path: <netdev+bounces-217102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F2BB37610
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451F71BA0D0E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3C11C84AE;
	Wed, 27 Aug 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js/MMB96"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156AF7260A;
	Wed, 27 Aug 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756254008; cv=none; b=nAwO/B2YgHvLGg1j3c5aH41HJ8kAg527fY75CdQgdFb19ISvv6lxjA1/GnzHk+f0ztZ5hUne12utWqd5Y9R30Lv+80EYibV/MUgDS1Vkr1sAMP5yaxGQCeETBrhgXJSl3aTCBXaUx0+ekNYxzqNcPgDKYwu32XYl/OsSPPbYAyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756254008; c=relaxed/simple;
	bh=V7HS9LK0Rsuwjzkjgw4eNKuAKj/l7rmviKmrQhXubr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ObxTQZYs44BxaZvddj/kRCiWmHAJhEwTyS/6UaOq8lQYBqu5/uYvDExRePIQuP1Jy6927CqlMEztA4Iq16tKYhzjkkzmcP3zRje2NxpDsZQPYm+aJbkAoRJfzieXJzKBERkJXDB+gGbhYkDzL7fauICoaHnLnMQbdrWCflhk5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js/MMB96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2CCC4CEF1;
	Wed, 27 Aug 2025 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756254007;
	bh=V7HS9LK0Rsuwjzkjgw4eNKuAKj/l7rmviKmrQhXubr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Js/MMB96bi3l8feI9jeKJkphfMxUS7jyupRJyOi+XaezRKN8Vg0UEZ4ZkcUT+tYfD
	 kX7m3yIpUW3SLV4I4HWsYT3a1r6glVnxqft4C7tX4R7URF6QuLGtmey+S6AQLgQTnk
	 v96Dj/vH8XqbscIuCHf9A78OVHcrOChZ2E9q0nN3VJ40xWYXdRtz9tjA7uvV/9aKLB
	 qgT8a5WfW3YyCNjWaoKmhOc65WOe8ZJQZVkv0PCLb6NcIdF1AJbviKEBYR7ZzthoRu
	 A9u/vrrjDo0wIKrLWEpAvOazTEI/hftC/NoDIj2aaPg1rlbflz61R7VMZcl8h1PDwc
	 jBLsVjnktkYHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE09F383BF70;
	Wed, 27 Aug 2025 00:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: hns3: use kcalloc() instead of kzalloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625401549.147674.14126794394593538938.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 00:20:15 +0000
References: <20250825142753.534509-1-rongqianfeng@vivo.com>
In-Reply-To: <20250825142753.534509-1-rongqianfeng@vivo.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: shenjian15@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 22:27:52 +0800 you wrote:
> As noted in the kernel documentation [1], open-coded multiplication in
> allocator arguments is discouraged because it can lead to integer overflow.
> 
> Use devm_kcalloc() to gain built-in overflow protection, making memory
> allocation safer when calculating allocation size compared to explicit
> multiplication.
> 
> [...]

Here is the summary with links:
  - net: hns3: use kcalloc() instead of kzalloc()
    https://git.kernel.org/netdev/net-next/c/7e484a97f6d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



