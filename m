Return-Path: <netdev+bounces-120768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD595A8FB
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA8D1F24375
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A0C749C;
	Thu, 22 Aug 2024 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghRlq5NQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93C7494
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287234; cv=none; b=RZQUwl9gPqr2B6mE7AyBg0rBBgFFGt0Xu4anp3oobSSrkU2JBt6/RAAtto17z1A9cSjsTx6w/oys/nFs9H/Qy9oId9rGXegHK0OIYei+Ex8latq5Vou3PYhFuUScrQCg1PKI8u1lxucjUGG0dZfROAbqDDYZD8o7JLJWnM3QVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287234; c=relaxed/simple;
	bh=H9MmUw+/3ZcT/hwaZh2pjOgcM9Tr3GZyl00babLjzCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qHxJA1a+bZOcyA/0nfWlvc9GWfw9U/vHHZzh/Swe2v/QrR4Wdm8pzMvKn0biatE1fcqxO9KC3xmfTY5gU1FpuRDCBrDfNldtbcPkFopcSQM4CjuVNdRQGRZq1rANHccfIFsVx715Lh/X7i8h24nsLCtV1uxNg+89deWkKCBsehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghRlq5NQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98169C4AF0E;
	Thu, 22 Aug 2024 00:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724287233;
	bh=H9MmUw+/3ZcT/hwaZh2pjOgcM9Tr3GZyl00babLjzCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ghRlq5NQl9it4100tswx1I/bTPw2fFHvfD+NWusR2bh81MQ26wAd0//WoxTqAM9zB
	 s2hdAQS1JShpoxXJHqCWP+yE1uwD1wQ9Xjdg2hq+nV7S1ta4cf1J7hUNdBPMgbWlWn
	 jdQEyYXhlxCGb663FFvx1oG5yEu2hS4tkw04TWoM8+TfMRKjKw7OgHB4YV2xVCWunv
	 iQRmEng1pedadX/oZQ6iiwX77XcsVZBftkhRA1ByTHL4uKgOJymbtiQ3RmufyAC3MB
	 T9ux1hP0dgwIrxDBtmFcU7Fnb0b2XEZEDNWPAT9m09TIcqc80wrCbOAatuAlm718rn
	 a4WbqCT8uq8rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B2E3804CAB;
	Thu, 22 Aug 2024 00:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netpoll: do not export netpoll_poll_[disable|enable]()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428723299.1872412.6094396217061754689.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:40:32 +0000
References: <20240820162053.3870927-1-edumazet@google.com>
In-Reply-To: <20240820162053.3870927-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 16:20:53 +0000 you wrote:
> netpoll_poll_disable() and netpoll_poll_enable() are only used
> from core networking code, there is no need to export them.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/netpoll.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net] netpoll: do not export netpoll_poll_[disable|enable]()
    https://git.kernel.org/netdev/net/c/007d4271a5f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



