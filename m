Return-Path: <netdev+bounces-96208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56358C4A65
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8133F2845EB
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943EC365;
	Tue, 14 May 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB3j1u5R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC8191;
	Tue, 14 May 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715646029; cv=none; b=YXEqqTd2UC5mGZZYhKxwFD/6nKS2xVVV1sJyiJcJlzSUdIEs7HlXQNa+2H6jX8Zl+/Hokj0kaVvvmK6QTwZVz1eI2SLv2N6gh0C767gKj/8NJT4Fz4ruv9e7F/SAQwtI251IwAWZcLjbc9UcbSm8Qj0EupYKrOYb7LpUTzJUCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715646029; c=relaxed/simple;
	bh=kEv2P8VEAhzSpPP4oNzBwxUgCk18mS9kUZsVlSL24S8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ddroGpfqWHpz+OnU9guxVsmb2/Dne3gnp8nStXDDIWv8DHk+d/bngoSN3UxgiLfU/+JTN+6JzlsD8wc7AJvQo4Jz6yO+/YRMPOW4VY0IkkXO1ETAjHK23cfRbqGEAnmnOyr5F/RVmxAKGIHs5dwMrbqGMOMV1vYcZGxptMjLSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB3j1u5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC133C32781;
	Tue, 14 May 2024 00:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715646028;
	bh=kEv2P8VEAhzSpPP4oNzBwxUgCk18mS9kUZsVlSL24S8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QB3j1u5RZ2mK2m5yQQzvxT3C7T9gm3KyfXKDT9LpG7/do85GuaIIFK5tjFtVQiLUr
	 HyqttZMBGHPAHwntuM/kQJ3xyf8+PndFqef7Jt9sqkx8AsXbb+bwpz4uGadLu/4mTZ
	 kex4aY2UuD7mdwpTxi+IHttxO21XIthFPHMLZSkJePQ/+S3wGAVWieeQUjzYM2HiZ0
	 MHTpCT9CPgF6NSjyct8vbXmzFoF7zw/1t4KFCT4jguGxjm+z6sxf/n8ICWxxqCkIqo
	 qxIso4ZIET8v+GA3H62zcxWXmngOPm1Vut7XSQo7zXIbxPk1jYhWHuJ0suBGjG3WIL
	 oq+PPELN3aj3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6CDCC433F2;
	Tue, 14 May 2024 00:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/4] virtio_net: rx enable premapped mode by
 default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564602881.15402.11255289410552772554.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 00:20:28 +0000
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 May 2024 11:14:00 +0800 you wrote:
> Actually, for the virtio drivers, we can enable premapped mode whatever
> the value of use_dma_api. Because we provide the virtio dma apis.
> So the driver can enable premapped mode unconditionally.
> 
> This patch set makes the big mode of virtio-net to support premapped mode.
> And enable premapped mode for rx by default.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/4] virtio_ring: enable premapped mode whatever use_dma_api
    https://git.kernel.org/netdev/net-next/c/f9dac92ba908
  - [net-next,v5,2/4] virtio_net: big mode skip the unmap check
    https://git.kernel.org/netdev/net-next/c/a377ae542d8d
  - [net-next,v5,3/4] virtio_net: rx remove premapped failover code
    https://git.kernel.org/netdev/net-next/c/defd28aa5acb
  - [net-next,v5,4/4] virtio_net: remove the misleading comment
    https://git.kernel.org/netdev/net-next/c/9719f039d328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



