Return-Path: <netdev+bounces-114430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389EA942932
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2C92836A3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465581A8C00;
	Wed, 31 Jul 2024 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0AZig4y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6D1A8BFE
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414640; cv=none; b=gQ0whUxqunhDPBd3tXm0rSfVRPQxRRhKzYbF/DcgCOh8PqhIqD23JgepJurimqqnPYqItx+efKNUfD3+fJu+KRi5IZpt3cCrifvnTFsnigawFcuG5RGr2KsFS7ZPj8YrORP3UE+2AWnpl2kb1r4F1ai4N+4mtO+RthY4ZNB+er4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414640; c=relaxed/simple;
	bh=qHydxGcYR2MiJe196F5q7cR5YEgzY6/L1S1fzNaA2+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dQcfij8ntwoMOFzEjnVG+L1b1xSNGwBb/WG/SAwh8xRjYu8XLdm6nh32cy3XRAluaUy7Kw+6VODtFXao2lXxRm+2iqb/OCeV3WrKzw2lc4P6eSZ2A/EEGxMKnLUIu2EOvvw31BnZeUxyeeSIWuyW4qhI8lnnQYY8p4MvqFR6sF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0AZig4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D0D3C4AF14;
	Wed, 31 Jul 2024 08:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722414639;
	bh=qHydxGcYR2MiJe196F5q7cR5YEgzY6/L1S1fzNaA2+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J0AZig4yW6kUm9wcrKwPy6Lwo+hIU6qwO+5PouAoOzi2vK5t5K4WdSG43MP0R1lGW
	 Uy0jYBudpHgN6XT5HLIEhvMyNJjt6H2h3xzbeS4WHYSmByOxmTPepgx0+HRg0XPc+s
	 doKp02ro/F15hATYJ5N97w5L4onKiL0Ie/mpXFUGV0xkd87btPgJ3FG643Qd9fBYwF
	 MKIjIPJivMunnxEGjiT2xRUjDf12ITlA1CtuatCqW3vASgbYQbJsuH6AoghjdZ3gfE
	 U9Qc+SOdZ+LBOrLpDjzuXhZwnxr4uBpgENgCMoBcUcBC1PXENa+9m3OsxgZ5x2b0Yu
	 JL/+qTHPEGiUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C694C6E396;
	Wed, 31 Jul 2024 08:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] l2tp: simplify tunnel and session cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172241463944.6677.8796621930261622899.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 08:30:39 +0000
References: <cover.1722265212.git.jchapman@katalix.com>
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 29 Jul 2024 16:37:59 +0100 you wrote:
> This series simplifies and improves l2tp tunnel and session cleanup.
> 
>  * refactor l2tp management code to not use the tunnel socket's
>    sk_user_data. This allows the tunnel and its socket to be closed
>    and freed without sequencing the two using the socket's sk_destruct
>    hook.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] l2tp: lookup tunnel from socket without using sk_user_data
    https://git.kernel.org/netdev/net-next/c/2e7a280692bf
  - [net-next,02/15] ipv4: export ip_flush_pending_frames
    https://git.kernel.org/netdev/net-next/c/4ff8863419cd
  - [net-next,03/15] l2tp: have l2tp_ip_destroy_sock use ip_flush_pending_frames
    https://git.kernel.org/netdev/net-next/c/ed8ebee6def7
  - [net-next,04/15] l2tp: don't use tunnel socket sk_user_data in ppp procfs output
    https://git.kernel.org/netdev/net-next/c/eeb11209e000
  - [net-next,05/15] l2tp: don't set sk_user_data in tunnel socket
    https://git.kernel.org/netdev/net-next/c/4a4cd70369f1
  - [net-next,06/15] l2tp: remove unused tunnel magic field
    https://git.kernel.org/netdev/net-next/c/0fa51a7c6f54
  - [net-next,07/15] l2tp: simplify tunnel and socket cleanup
    https://git.kernel.org/netdev/net-next/c/29717a4fb7fc
  - [net-next,08/15] l2tp: delete sessions using work queue
    https://git.kernel.org/netdev/net-next/c/fc7ec7f554d7
  - [net-next,09/15] l2tp: free sessions using rcu
    https://git.kernel.org/netdev/net-next/c/d17e89999574
  - [net-next,10/15] l2tp: refactor ppp socket/session relationship
    https://git.kernel.org/netdev/net-next/c/c5cbaef992d6
  - [net-next,11/15] l2tp: prevent possible tunnel refcount underflow
    https://git.kernel.org/netdev/net-next/c/24256415d186
  - [net-next,12/15] l2tp: use rcu list add/del when updating lists
    https://git.kernel.org/netdev/net-next/c/89b768ec2dfe
  - [net-next,13/15] l2tp: add idr consistency check in session_register
    https://git.kernel.org/netdev/net-next/c/0aa45570c324
  - [net-next,14/15] l2tp: cleanup eth/ppp pseudowire setup code
    https://git.kernel.org/netdev/net-next/c/d93b8a63f011
  - [net-next,15/15] l2tp: use pre_exit pernet hook to avoid rcu_barrier
    https://git.kernel.org/netdev/net-next/c/5dfa598b249c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



