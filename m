Return-Path: <netdev+bounces-221504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6327DB50A79
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3FE566088
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3A226D1E;
	Wed, 10 Sep 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERPEx6gW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E742264BD;
	Wed, 10 Sep 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469008; cv=none; b=no5zcPKloI4EtOQJf9kC5X+13Cmih+o2/MCWeUQfR/mONIZRowB/hxyGe7e784ULQNzacet/G57nwrtJVFgRefIQvlbdIQdhRlLZ4/r8wH2/ISUBoc/WAGjiQa5oyf7Xd/qHoYGQ/e3JWTDvjRYZVMEri2F89AAEuurK5DwVc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469008; c=relaxed/simple;
	bh=31ynHaSExIvuDjwFnZXBu1eJN+TxHwjKcZZvJ6vRyiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iVUffFC9UYpkr7hXsfCCEeSc4rmikwBrXdCgpMlxP1llJgIjMc0WRUxmbaW0aW7/kkGgCRq8Q+iaByOiiNCPaoKKDCnPU1q7Hqd6ztFp/I1BpI4VfvX1CdEFffBnjseDZk6xAhkan2j8/94y0BqQPjBFaFVbUFaow+z5S0t24QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERPEx6gW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B44BC4CEF4;
	Wed, 10 Sep 2025 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757469008;
	bh=31ynHaSExIvuDjwFnZXBu1eJN+TxHwjKcZZvJ6vRyiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ERPEx6gWeL3OsSIDwqsS85e9D0L2BOG2I8nnz8It68KBzFjRKlIx7+37//AxqCphC
	 5LJbO/3lmVaBYHEG7Bb5vV+aP82/3W6DJE7uYtQpPtk+IC4owCuSCVXUfY+QTB+S20
	 XZsgmB6kB0ak5RI+cX9vAEIHh7wYcIC/RKpZWqJWdLQxHdHcWIw2RrRQBAPsnDMQBf
	 hj7M2LMpAsdTmf96RV/jLIhIxC/CrhSsKYDDKOA6zz6xJDttvyBrSiYlw+YT+1d0qv
	 dyFHbJdGi47h3yRt+j8l/rV+2xf6XtE9F5p5EOMKD+G9WoQhDK5iDYcUzWqEHdKh3d
	 LM58qe8WA/gEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE05C383BF69;
	Wed, 10 Sep 2025 01:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mptcp: sockopt: make sync_socket_options propagate
 SOCK_KEEPOPEN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746901150.871782.13982454785645572183.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 01:50:11 +0000
References: <aL8dYfPZrwedCIh9@templeofstupid.com>
In-Reply-To: <aL8dYfPZrwedCIh9@templeofstupid.com>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, me@davidreaver.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 8 Sep 2025 11:16:01 -0700 you wrote:
> Users reported a scenario where MPTCP connections that were configured
> with SO_KEEPALIVE prior to connect would fail to enable their keepalives
> if MTPCP fell back to TCP mode.
> 
> After investigating, this affects keepalives for any connection where
> sync_socket_options is called on a socket that is in the closed or
> listening state.  Joins are handled properly. For connects,
> sync_socket_options is called when the socket is still in the closed
> state.  The tcp_set_keepalive() function does not act on sockets that
> are closed or listening, hence keepalive is not immediately enabled.
> Since the SO_KEEPOPEN flag is absent, it is not enabled later in the
> connect sequence via tcp_finish_connect.  Setting the keepalive via
> sockopt after connect does work, but would not address any subsequently
> created flows.
> 
> [...]

Here is the summary with links:
  - [net,v2] mptcp: sockopt: make sync_socket_options propagate SOCK_KEEPOPEN
    https://git.kernel.org/netdev/net/c/648de37416b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



