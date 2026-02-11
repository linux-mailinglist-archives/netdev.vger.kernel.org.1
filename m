Return-Path: <netdev+bounces-258197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHXpIUIPjGn9fgAAu9opvQ
	(envelope-from <netdev+bounces-258197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 06:10:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C481214B9
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 06:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2A78300989B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60E340A72;
	Wed, 11 Feb 2026 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4VnTLt7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA061327BF3
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770786622; cv=none; b=MaeGPY1BkpFoMONLkbQf6+SgW8KL3leEKK64TLw+6SH7vuiXwzJbvVp9V23gOCwcfcZ/vG6LwN1aGfgPj/K1Z6J6fx9jZFV+B/pNk40jUBhvYyb+WK0Keo+LlzFk1RRfw75QYzrVt34Dk0h92UEwph00pB9acWASidin69BDTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770786622; c=relaxed/simple;
	bh=wMRjNs45joUMAZmeVUOvxARUE0I0y5BtdO0aK9FOKeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cqJtn3F4sv/36eOU22NJyTunjbxE8c+JzVdNbxCczHqmVNNp7MHo8J1nWNqo6yPmw9Ngr09vJcp4JVoEkWD0Y4NtGrBP7aDsasKuI4hXyi5bFdhJ91vpC2ZYwWmUCB783vwxqkcJZQIFw7c5aoeUvJpqlaUN43exXPMXx8z2EIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4VnTLt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F60C4CEF7;
	Wed, 11 Feb 2026 05:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770786622;
	bh=wMRjNs45joUMAZmeVUOvxARUE0I0y5BtdO0aK9FOKeY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D4VnTLt7tSG49bPiFqwA7KFWoCCvI/332Jg4ZiEn5gKi5uka+M5SGEYS1Yrs85ZJr
	 4Y7cT8LA60PG3Va5toT9qaiIY8xQuDprcyWwP0YznVY1CNCsDe28PXqM547QGO0gXb
	 jnjRW1JSHyKkkii6VG9xA4vKh6BWnoycp06+3evVaQN4A+v7LXGAt4GNeMgZzEpDJq
	 g/jEeMdNJ+Koth1+43FBQLF9x1FZpxX8rdL2E+0gORXORooI6nzJTUhsW1kIMWsoeu
	 eBjbdgJHRKMyMIRHn3d60R4gI/lGAzJtIJtqtnUI+i8ZNisQoO1v2rcVi+39NnH3D1
	 QBG/J4pteSKJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85025380AA50;
	Wed, 11 Feb 2026 05:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] ipv6: tcp: no longer rebuild fl6 at each
 transmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177078661731.7583.8652759832121393878.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 05:10:17 +0000
References: <20260206173426.1638518-1-edumazet@google.com>
In-Reply-To: <20260206173426.1638518-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-258197-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42C481214B9
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Feb 2026 17:34:19 +0000 you wrote:
> TCP v6 spends a good amount of time rebuilding a fresh fl6 at each
> transmit in inet6_csk_xmit()/inet6_csk_route_socket().
> 
> TCP v4 caches the information in inet->cork.fl.u.ip4 instead.
> 
> This series changes TCP v6 to behave the same, saving cpu cycles
> and reducing cache line misses and stack use.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] ipv6: add daddr/final storage in struct ipv6_pinfo
    https://git.kernel.org/netdev/net-next/c/03ff0cb1a926
  - [net-next,2/7] ipv6: use np->final in inet6_sk_rebuild_header()
    https://git.kernel.org/netdev/net-next/c/3d3f075e80f2
  - [net-next,3/7] ipv6: use inet->cork.fl.u.ip6 and np->final in ip6_datagram_dst_update()
    https://git.kernel.org/netdev/net-next/c/4e6c91cf60f2
  - [net-next,4/7] ipv6: inet6_csk_xmit() and inet6_csk_update_pmtu() use inet->cork.fl.u.ip6
    https://git.kernel.org/netdev/net-next/c/969a20198bd6
  - [net-next,5/7] tcp: populate inet->cork.fl.u.ip6 in tcp_v6_connect()
    https://git.kernel.org/netdev/net-next/c/19bdb267f733
  - [net-next,6/7] tcp: populate inet->cork.fl.u.ip6 in tcp_v6_syn_recv_sock()
    https://git.kernel.org/netdev/net-next/c/a6eee39cc2b9
  - [net-next,7/7] tcp: inet6_csk_xmit() optimization
    https://git.kernel.org/netdev/net-next/c/97d7ae6e14c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



