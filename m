Return-Path: <netdev+bounces-45654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDD07DEC7D
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFAC1C20EB3
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F73A4C95;
	Thu,  2 Nov 2023 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="musrrxnq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1262114
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89DB6C433C9;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698904287;
	bh=otk3JHaNJ+D+HB8hAd06wvZT1Zwr/Vn4DRdmpJcovI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=musrrxnqeONh5ZBBqyt0WvqL78DnEfhrWm6jtAd80LNA8IcAdCHWMzX3+tgFhaisG
	 f17Dzz+SF03vW8haOhP8ONoexrv9yCHC7RrrLBfAQeW2AuopO6liwJ2j4B2uMhoy0q
	 me8F/XjwZEAQL2f1OdyO4lEiolv+CAvJSb7m61qCLbsUlP56PCTKrk6ik2/3VVtBX9
	 VWAp51GL8++UerjpWlOUms8w3x068ieNzKWYUzfzCkUahQOnM+QKH4jaMWR2h+PJgt
	 jRTWZ/OCl9+5d5ld1JtrQCesN/Z8xSGF8o0YkHLRgfsHqyDA9JoJyGA5hMHxAlHKzC
	 p/M+5qwyYEvhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D415EAB08B;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc: Fix two connection reaping bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890428744.30377.644414047950616687.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 05:51:27 +0000
References: <783911.1698364174@warthog.procyon.org.uk>
In-Reply-To: <783911.1698364174@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, marc.dionne@auristor.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 00:49:34 +0100 you wrote:
> Fix two connection reaping bugs:
> 
>  (1) rxrpc_connection_expiry is in units of seconds, so
>      rxrpc_disconnect_call() needs to multiply it by HZ when adding it to
>      jiffies.
> 
>  (2) rxrpc_client_conn_reap_timeout() should set RXRPC_CLIENT_REAP_TIMER if
>      local->kill_all_client_conns is clear, not if it is set (in which case
>      we don't need the timer).  Without this, old client connections don't
>      get cleaned up until the local endpoint is cleaned up.
> 
> [...]

Here is the summary with links:
  - [net] rxrpc: Fix two connection reaping bugs
    https://git.kernel.org/netdev/net/c/61e4a8660002

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



