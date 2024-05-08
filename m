Return-Path: <netdev+bounces-94358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16E58BF45B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4A1284753
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C658F55;
	Wed,  8 May 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzmxZUl1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62679F9
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134230; cv=none; b=R1h1TAcfnC7cPbw8glLxfvBBXomDtL4p28cJmWMskjJMo1Pq5pOBatCHX5jKmeUkMjF7apl374LBWDjZRiwef1tPOV3j7RBf/ktVm07vpLR/2r/VvCaVwY6ouIh0jn6SncVB5UkC3em2BaL521molxeIBQpUK3KRXYLFFFuMbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134230; c=relaxed/simple;
	bh=Pd1SvDbaBpsAE62GN9BpQMbpOsXbLQXvFtsQNPcPyCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uGD+rgyCKF7sIf9DgRjuO2ngczZyc3wDNVbpefNGIPtwmu79uGiQr1oJ6Sjcg5UzSOpH+a/yMG++Qmbi6HFVAYPAz0XkPWqG+aBjKO4caylvNogNWKWRPtJXBgK/v5zBWM5nzFrRyFHLR/a55D5YXTe91e09GHZr8jAknAl6cMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzmxZUl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC1FCC4AF17;
	Wed,  8 May 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715134230;
	bh=Pd1SvDbaBpsAE62GN9BpQMbpOsXbLQXvFtsQNPcPyCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hzmxZUl1N5V9fPyM+aIqerXgDZpYoCKkP7AIr0/Q/r4zq0PWmxjU9d35Pojyw6H+J
	 w2+hQFWCukuSJ+BjNUAAilG5xcgLn7NDCLXvaxkd+qc3fJQzlZ/7rImg8/s1hoyPE/
	 uIyGO1spY27zzG+thgWXGLX55PyzswSFAiXE+42oqnZPSn9/92AlsKVB5mA3XLtFqZ
	 0MhDzg/JNpVt+jm0+3+Tq8VE9hPJqPVd9ExyKFzthk7z+WiuX2lZj0EHXpRM7ZHnNh
	 0huXzKpvKuzLdEYQQXy8Ej6Dz7pCU7PtzM699l47ZjMe/JYBcxHPBKawkqDxcLF/W9
	 w0qcXxKhWswhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF9B3C43617;
	Wed,  8 May 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: sr9700: stop lying about skb->truesize
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171513422984.3103.4897124017334773222.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 02:10:29 +0000
References: <20240506143939.3673865-1-edumazet@google.com>
In-Reply-To: <20240506143939.3673865-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 May 2024 14:39:39 +0000 you wrote:
> Some usb drivers set small skb->truesize and break
> core networking stacks.
> 
> In this patch, I removed one of the skb->truesize override.
> 
> I also replaced one skb_clone() by an allocation of a fresh
> and small skb, to get minimally sized skbs, like we did
> in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
> in rx path") and 4ce62d5b2f7a ("net: usb: ax88179_178a:
> stop lying about skb->truesize")
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: sr9700: stop lying about skb->truesize
    https://git.kernel.org/netdev/net-next/c/05417aa9c0c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



