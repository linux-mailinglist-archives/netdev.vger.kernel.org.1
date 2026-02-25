Return-Path: <netdev+bounces-260692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AiPBSZKnmnXUQQAu9opvQ
	(envelope-from <netdev+bounces-260692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:02:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9909318E7D4
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E13530FB5C8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE73283CB5;
	Wed, 25 Feb 2026 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCZBQzeK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57589280331
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981203; cv=none; b=OIf/OyN7mAIXkIeogUX3qM4PLF70LqqpfIWdDHnW03T3ZBdjaA6aKYjaF8yAjjfDzSbiIp0UlbP+hmGVooHK0RGSHNeJM2BtO7tVbbH03eJo2v7TLVUTM9kgUuXayS1S5lhV9Pd8AD0Utkfpk3xFFuXNy5fZWQDQ9lIBeXHPftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981203; c=relaxed/simple;
	bh=yLZUgx5mqbzs4oaffYbIqA3f5wMo6zF71cfIZ2rkCSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZppvqlfYraKNIWP2FvR25blasl5aoJPIUvyRyD7H0+j37m0Y75Ciq0hkCI9IfOfg+3vLRC9QI7CiczyXXqs4BNtG2TESoKL2veYSM7pt5E5LVeLRewLowG590o2aOiSdciFUOR2mxNxVzWErHIDnq27INBkh5AUtzx3R4bzF218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCZBQzeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17834C2BC87;
	Wed, 25 Feb 2026 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771981203;
	bh=yLZUgx5mqbzs4oaffYbIqA3f5wMo6zF71cfIZ2rkCSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZCZBQzeKMnOb3B87aUO1hmiuEwwvP2A7l3zIxtgI9T5JgnQwIloXHrh7nC5/5NDz7
	 OZ+YR+zmL3V0WkXgsaKOqF68kVZThKhJw+lghNOIFn8zwA7GEqUK7mir7iNOdO1ttZ
	 pE9idCcsSJ1c71uaIGrR/cn91oHCYxE85/ekS+1lSx4+CzaNaaBdBVLdPcWgxWrOJl
	 JeaoIN/9BJtrIhQXrzKhAx5AvUoZuk5xvVnavLeGlU2tJVS/ZVyBa3J6FKNeQqdw56
	 NPApaKSWMolTt4RXRdqEnEvJpS/Uq06p0zY5pD151X9r0fyUB5K4jaPgRSe0k7hm/0
	 +w07rDHbBe9yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DDB3808203;
	Wed, 25 Feb 2026 01:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: __lock_sock() can be static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177198120778.17446.9183992293157130973.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 01:00:07 +0000
References: <20260223092716.3673939-1-edumazet@google.com>
In-Reply-To: <20260223092716.3673939-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-260692-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9909318E7D4
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 09:27:15 +0000 you wrote:
> After commit 6511882cdd82 ("mptcp: allocate fwd memory separately
> on the rx and tx path") __lock_sock() can be static again.
> 
> Make sure __lock_sock() is not inlined, so that lock_sock_nested()
> no longer needs a stack canary.
> 
> Add a noinline attribute on lock_sock_nested() so that calls
> to lock_sock() from net/core/sock.c are not inlined,
> none of them are fast path to deserve that:
> 
> [...]

Here is the summary with links:
  - [net-next] net: __lock_sock() can be static
    https://git.kernel.org/netdev/net-next/c/2550def53bbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



