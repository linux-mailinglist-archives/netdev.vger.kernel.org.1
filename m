Return-Path: <netdev+bounces-264653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL6IECxMqmmIOwEAu9opvQ
	(envelope-from <netdev+bounces-264653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:38:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BB721B321
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18407313517E
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF657369217;
	Fri,  6 Mar 2026 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZsSHc/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39334B662
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767984; cv=none; b=X0M1AxyE/Sm7H3sMNij+vAw1E7M5woDFATK7F9epXyhkmfLj0VkOKwYGVe52EEDGKgMtQZMguaVlGrdrerHrzCo/Sao0E0G6wMPGrD/xPE8Tt9ECRvowVEHb1yEDTgOUXPZbGB26IkHNUui9Xco7WFb7Vf6hCc9VUM+V5+ZrlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767984; c=relaxed/simple;
	bh=BljRyFR8MwRpGCuLM1muYqb20bgahZIXPjZtW1VrP+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nn9zPFBQuU5ja8fpAKMj21cI67C/ZklWkm60SvniIRhe9GxeJVg4nAw/5tZl0+1PMm92bLWGepIvY4JwC6ZHOPORxOIg3fwN34/Rt4BiEASuWGeru27egVB0uYuqH+2zxyUQ59TcR8RYEosET6N7EH+1hvQfQYefB9zKFlKGrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZsSHc/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B588C19423;
	Fri,  6 Mar 2026 03:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772767982;
	bh=BljRyFR8MwRpGCuLM1muYqb20bgahZIXPjZtW1VrP+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KZsSHc/1b8ACjm4cnDdIBPIhUPHP11nKtE6s/gwUf2pzMBcOd+Miq0KwBQJLROGOB
	 ziBb1hOeO3YbK+I5yTojs55C1c6eBbLQ/lzHnT/NB3IyJozy/OvAXXzfJ5skNCU4n6
	 BwcwRgHBVDlxLkFivPdbYXX4x8ul1L3k9U1SpokAytBMduxwN4k2E/YtzzJv7RBs8l
	 ZWYSKyvlQOHMkZrorfg/9FEKeOrOLfWnM1VoJvWlJsd4DStBlKKf6DQ9og+Kj3JZcu
	 JY6j20OlGNyMqY0a4144lrkt1QxGln1SalW+XVGkHTh3XM6SUWzE6aXdY7wi1pQu4x
	 A206KWeWghgCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C423808200;
	Fri,  6 Mar 2026 03:33:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move tcp_v6_early_demux() to
 net/ipv6/ip6_input.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177276798179.3348267.7931385291498596908.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 03:33:01 +0000
References: <20260304022706.1062459-1-edumazet@google.com>
In-Reply-To: <20260304022706.1062459-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: A6BB721B321
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264653-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 02:27:06 +0000 you wrote:
> tcp_v6_early_demux() has a single caller : ip6_rcv_finish_core().
> 
> Move it to net/ipv6/ip6_input.c and mark it static, for possible
> compiler/linker optimizations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move tcp_v6_early_demux() to net/ipv6/ip6_input.c
    https://git.kernel.org/netdev/net-next/c/46cb1fcdb75b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



