Return-Path: <netdev+bounces-194184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C448DAC7B9C
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC571BC76D9
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ACB28D8EE;
	Thu, 29 May 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3FFw7hY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA627A55;
	Thu, 29 May 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748513395; cv=none; b=Kw3QJ/G0ywYqv8v0O6ODXH0JIg8/mEOcphWJU536NOu2y7/KvbVFgV++VzZvvjLE8rYdmFwvnleiX6QwqXtZGgIjovyUqqNNPZR2p0bV9p3eAbafLKjjy1TSycj2eogovrn+B3DkAA1B4NH+kqjqMR92q8YqhP0D1P1Wucc1qaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748513395; c=relaxed/simple;
	bh=14tNTQ+1DdwMsl414suTznTyHQV3ArWxsFoXYID5Af0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=svRRZM1wfqXidAGGxdOLmnk6VnvJ8LU/AneNsQErYBpBQmyb1np2rj05c3amWXlJM9bZKNnOANjpOnLgMNrV2/93Ic/NRhwyFg1WedbZbpSNcf98lyzarlas8VcZpEQizDwncuINCfQSw+ERBMr3EW9wct1ZukTXdmUxW6qe1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3FFw7hY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA9FC4CEEB;
	Thu, 29 May 2025 10:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748513395;
	bh=14tNTQ+1DdwMsl414suTznTyHQV3ArWxsFoXYID5Af0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c3FFw7hYUKR3LSvcOXjBTbLsrHPnvpqhXU2kykUI8PufdBDCJayX4tMyv92xMlEA2
	 bPUsPaE0fY96FvAphThJyzQ6sDbnoQSMn5mpxwMxFJ4FEQZUbxQKuj1aC86BWrYSqe
	 Hu86QkQrYhJTnwUzbnas4iuetugyHwgSZt4n5qcvXIFYTeuJzpolleUnHtHlsOQq+f
	 HGUVrN1kgy4O28SJWXriLHn33s1g07/oKSRq6Ax7HvvXWtaEhI3jddmtzne8d02e8l
	 PTVGvlkRJsDIV9NmNd/iet9CApzIeU4cqlkaaf3Ccm5btI8weT7MXseQa4X4kXnDsw
	 dto69b3s4jW1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C3239F1DEE;
	Thu, 29 May 2025 10:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: tipc: fix refcount warning in
 tipc_aead_encrypt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174851342900.3214659.3602583798283655289.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 10:10:29 +0000
References: <20250527-net-tipc-warning-v2-1-df3dc398a047@posteo.net>
In-Reply-To: <20250527-net-tipc-warning-v2-1-df3dc398a047@posteo.net>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, wangliang74@huawei.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 May 2025 16:35:44 +0000 you wrote:
> syzbot reported a refcount warning [1] caused by calling get_net() on
> a network namespace that is being destroyed (refcount=0). This happens
> when a TIPC discovery timer fires during network namespace cleanup.
> 
> The recently added get_net() call in commit e279024617134 ("net/tipc:
> fix slab-use-after-free Read in tipc_aead_encrypt_done") attempts to
> hold a reference to the network namespace. However, if the namespace
> is already being destroyed, its refcount might be zero, leading to the
> use-after-free warning.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: tipc: fix refcount warning in tipc_aead_encrypt
    https://git.kernel.org/netdev/net/c/f29ccaa07cf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



