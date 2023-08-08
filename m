Return-Path: <netdev+bounces-25635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C15774F75
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78411C21080
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9278B1C9F7;
	Tue,  8 Aug 2023 23:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8081C9E3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6732EC433CC;
	Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691538024;
	bh=Bm8VsXZbW1QAfWAtjhOusHQ+LItZQVkoF4X2EUYjNlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D5IjaRPm9CcFkH+woPKV8HCbcGMrJbnNaFcGgvU9qlpkisXPhMjXZLiI9PooISZT7
	 VTn9ZDPsneiirrFyHiPYwCFwRcY1tCrtJVLXLPcMoS5ffv9QBaCcbO+ztUHAMcZSsq
	 1eL+ekHBPeAoUqLVMJnd9sRU6aM7O9XJaISRwDct2GhttUWKL3XUSk72psaswDqWeT
	 99EDm8tYUqgxa+iukC9oAE6sCpnGe9vFLnro8ryH5sRlO0MmTrbx2LDZUyufEHpTs7
	 v+dLRxZgPzmQ2y+I13WA0aw7JuHUvI1ro/+RnzQvXeoQ+zdby4oLH7W1kndS4FYDT7
	 dVak+DclMl16g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FB2FE33091;
	Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/unix: use consistent error code in SO_PEERPIDFD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153802432.28457.6086626478447395695.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:40:24 +0000
References: <20230807081225.816199-1-david@readahead.eu>
In-Reply-To: <20230807081225.816199-1-david@readahead.eu>
To: David Rheinsberg <david@readahead.eu>
Cc: netdev@vger.kernel.org, alexander@mihalicyn.com, brauner@kernel.org,
 davem@davemloft.net, sdf@google.com, bluca@debian.org, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 10:12:25 +0200 you wrote:
> Change the new (unreleased) SO_PEERPIDFD sockopt to return ENODATA
> rather than ESRCH if a socket type does not support remote peer-PID
> queries.
> 
> Currently, SO_PEERPIDFD returns ESRCH when the socket in question is
> not an AF_UNIX socket. This is quite unexpected, given that one would
> assume ESRCH means the peer process already exited and thus cannot be
> found. However, in that case the sockopt actually returns EINVAL (via
> pidfd_prepare()). This is rather inconsistent with other syscalls, which
> usually return ESRCH if a given PID refers to a non-existant process.
> 
> [...]

Here is the summary with links:
  - net/unix: use consistent error code in SO_PEERPIDFD
    https://git.kernel.org/netdev/net/c/b6f79e826fbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



