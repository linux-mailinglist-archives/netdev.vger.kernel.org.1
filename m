Return-Path: <netdev+bounces-164288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B26CA2D3BE
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D213ACB56
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC36185B4C;
	Sat,  8 Feb 2025 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOK2JIyF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629429D0E
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738988410; cv=none; b=HgOZ8iviv55o4jEGoTqTzRIVUdaP1PFHduvjCFW3bWyT4S0zHtydPy4GZuDL8jN2kZrDq7SbCJ/7qk69AtqXycCrX/ukKlFCtu8WnMM/GI03g3Poz0bsB8Ne7YV+oa6aLqs6IouZWmxqyOwOhdrYcSGBMCC8HU7sFFUKnt19Y3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738988410; c=relaxed/simple;
	bh=JvvuVOaCp4hrtcYPPo2fkNjdtMkzvTwSfmsioXSb7qs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o+jO+OaiAdtHY4Xkvco3oBC7C0SYcdQVymlBTc5FdIefLVe7ApdhJUxg+PCPJsVLhvpCw/+PTduGivVN/9YAI0LXQqS0bwSHm8I1irBDn08gjxqDwx4H/cfZJSnc6jZxI35SlyiJMS+iDpNPCxxhMhhL3xg1UKmuYS96nVrvCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOK2JIyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9BEC4CED6;
	Sat,  8 Feb 2025 04:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738988409;
	bh=JvvuVOaCp4hrtcYPPo2fkNjdtMkzvTwSfmsioXSb7qs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jOK2JIyFlsKYhTUJqM/uKiDsDAxolhfIh8ssMrdZ5YMEjoqOydRDjOP6N/zEFtPye
	 phoqpOECTeKG4+Ic9Mxi1pF8V/mR7gQhIi+4ZA7qlzSPCehSxo0w+4tBLyHumjq5Le
	 Uji2bO+KBdAisILGs+ceSY1ZFiUWJQb99k3y2742L6lO3Fb34ESnstWXy3hx3Fc/Zw
	 S3FLbm5zXpyusfji6tmd6LdPJxMKFcqiTJIXtRVAgSjh5RvV6WRK1TKLNNJiUSuNbO
	 LiXEhUg+qY8NlgImG2TyuJvKGXC8Xfv8ALW3WVyw6MSlLLru6OykhyxFOaxVa8jtbU
	 +ALzHBpsdL1iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71413380AAF5;
	Sat,  8 Feb 2025 04:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "net: skb: introduce and use a single page frag
 cache"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173898843729.2488639.11493474890691107239.git-patchwork-notify@kernel.org>
Date: Sat, 08 Feb 2025 04:20:37 +0000
References: <e649212fde9f0fdee23909ca0d14158d32bb7425.1738877290.git.pabeni@redhat.com>
In-Reply-To: <e649212fde9f0fdee23909ca0d14158d32bb7425.1738877290.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch,
 alexanderduyck@fb.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Feb 2025 22:28:48 +0100 you wrote:
> This reverts commit dbae2b062824 ("net: skb: introduce and use a single
> page frag cache"). The intended goal of such change was to counter a
> performance regression introduced by commit 3226b158e67c ("net: avoid
> 32 x truesize under-estimation for tiny skbs").
> 
> Unfortunately, the blamed commit introduces another regression for the
> virtio_net driver. Such a driver calls napi_alloc_skb() with a tiny
> size, so that the whole head frag could fit a 512-byte block.
> 
> [...]

Here is the summary with links:
  - [net] Revert "net: skb: introduce and use a single page frag cache"
    https://git.kernel.org/netdev/net/c/011b03359038

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



