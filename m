Return-Path: <netdev+bounces-35208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A00C7A79E3
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A821C209ED
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA8115AF4;
	Wed, 20 Sep 2023 11:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD14426;
	Wed, 20 Sep 2023 11:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA607C433C8;
	Wed, 20 Sep 2023 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695207623;
	bh=e1LT1uWKTNbY/jHcSEbz9Us/LzaooCwhK99Cm+guV/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AXBZPDJpWq1JCw9uNB26VbpK/YqL39v0McD75clMC6LStz7ks8sAQWWmRgUn7cHd9
	 I6zEU2k5k1c5nLgBA5199JJLZEl+0yAcO83hqo/paZaj0Tg3/Tt6lItjAF4jrDfIbj
	 neeqRvuljkSTVQt7LeiM/Lf+mnXfE0hNW4HqElNyXQfuyfd+tvSy3kjfVDRI23AIS4
	 s+1tSPwygSOdRWoNPI6o49AtxLAgFnZjVt4nqoP9mJBDwcg0rtOjkqEM9JC2fj1GEh
	 OtRqTHl5PyUFebIAyeu6vEdW9VWIkzHymDzDWXZCQTT7WVtXzJHB0wf4xC4NLlca8e
	 DIYUaCEPrzXaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF94CC41671;
	Wed, 20 Sep 2023 11:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/handshake: Fix memory leak in __sock_create() and
 sock_alloc_file()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169520762284.31903.2503841633352666153.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 11:00:22 +0000
References: <20230919104406.847875-1-ruanjinjie@huawei.com>
In-Reply-To: <20230919104406.847875-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Sep 2023 18:44:06 +0800 you wrote:
> When making CONFIG_DEBUG_KMEMLEAK=y and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y,
> modprobe handshake-test and then rmmmod handshake-test, the below memory
> leak is detected.
> 
> The struct socket_alloc which is allocated by alloc_inode_sb() in
> __sock_create() is not freed. And the struct dentry which is allocated
> by __d_alloc() in sock_alloc_file() is not freed.
> 
> [...]

Here is the summary with links:
  - net/handshake: Fix memory leak in __sock_create() and sock_alloc_file()
    https://git.kernel.org/netdev/net/c/4a0f07d71b04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



