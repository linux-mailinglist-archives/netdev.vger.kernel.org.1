Return-Path: <netdev+bounces-73526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F685CE53
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216C12833B0
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FE8282F9;
	Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPen+YDP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09072574F
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483829; cv=none; b=s0Q8r8Oatrjtk7zoH5F52PeOP810cVUGVN4elTMUcp1Qa5kKTw/p6dbfl+bIkGMQgqq44s8lrro+a5tiFRnxMpzedQQrOUrkWde+40Q1Iepjz1JlriTpg/gxpYTEroAArVVbIiVq9wCqLUgPC9tghy5Olzw1d68Qh14HQuZPlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483829; c=relaxed/simple;
	bh=97hbL+sHp1gWDEwTeQvp0HHisqDm0QhjhCUEmxDgdIM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oUVsgUqsQCd3ZO8rdgY3eCzTNfcgHWGvCYpwo4j2La/YChpqgmMZ6UpFcGuV1GdPL5pwMFiBOVwN/5RW5jU+1uYMHbluq5yWDam3UZ3b49XjiKXqIWS8O8+GX3ZeyFxNEFoYPddPWslHF+dDDOEqwSESWC2wZROocHJ+PxRi0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPen+YDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D6A7C433F1;
	Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708483829;
	bh=97hbL+sHp1gWDEwTeQvp0HHisqDm0QhjhCUEmxDgdIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qPen+YDPFGHZiD8NZtF62qtvwEuB+YJOOagIUK0KcQITVi6FRvq8lpUXeR2Sr3GUR
	 b5nO+LjNQQOKyQ2pCW/+vJVhwHu4TX4eM6vuMUbUp+cJwQTEzOKkQJWcA7gYYTOgdn
	 FrL3BgWSB0vMQMMmDph6wiuhccQHEiQtQvy9OJUU5HgfZA8Q8yGh8KMcMQ8Xep0elU
	 V61B/5GnyIdu8MhX7lzigZMlA0PCRJEScFF0mWVB+GW8cm22HWDHplXbbpwjjdJhh6
	 O/f7Gb2fxUmQx0FSzr3CnlqQ/5AaIbKEjfuZWTcbEXYS1p6hpla0dcU7OTik2FC445
	 B3USe1AjMvadg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35AE8D84BC2;
	Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fix pointer check in skb_pp_cow_data routine
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170848382921.20526.10796605628218817877.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 02:50:29 +0000
References: <25512af3e09befa9dcb2cf3632bdc45b807cf330.1708167716.git.lorenzo@kernel.org>
In-Reply-To: <25512af3e09befa9dcb2cf3632bdc45b807cf330.1708167716.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, linyunsheng@huawei.com, toke@redhat.com,
 jwiedmann.dev@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Feb 2024 12:12:14 +0100 you wrote:
> Properly check page pointer returned by page_pool_dev_alloc routine in
> skb_pp_cow_data() for non-linear part of the original skb.
> 
> Reported-by: Julian Wiedmann <jwiedmann.dev@gmail.com>
> Closes: https://lore.kernel.org/netdev/cover.1707729884.git.lorenzo@kernel.org/T/#m7d189b0015a7281ed9221903902490c03ed19a7a
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: fix pointer check in skb_pp_cow_data routine
    https://git.kernel.org/netdev/net-next/c/c6a28acb1a27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



