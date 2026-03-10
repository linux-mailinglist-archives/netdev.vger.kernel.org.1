Return-Path: <netdev+bounces-265852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SARVIkN9r2kXZwIAu9opvQ
	(envelope-from <netdev+bounces-265852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:09:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1ED2440C5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C49C631FC673
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D452E973A;
	Tue, 10 Mar 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY6RGnqv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630330F541;
	Tue, 10 Mar 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108027; cv=none; b=GUBtZqmj4BBxrn7AT4cEkwCgKn/qqFCOYIW3jOhOgN9zT/xf2QQRGhtlLjpWWLaFIMWqxOniVpt7GuqNl3u+niBYRX5A0xRuzdHgtQs+p0C06nWh0fj1ge3eVsmfmA6/7AHfo8zB3tx1Kswj+kpapOiuPk1u1vshpWHMopMY/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108027; c=relaxed/simple;
	bh=gMEydkz6GWXMSQkpSdb6XQu4xJKeUsGAF2+pD8v/S5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pyc/Et5yixTMhNWu66NAgI1SmtWZPQFKjCMOaBwdKGMJ7uMmIYwZTfhZ0kIrGH7iFeRJTqsm+EEHUr6Mnv8FuZeZQUxB/zv0IElUcgmK5znLWUeoffQb1necuosGVfiCdA24YOrT70kc9L6UfZqZYgZU/21tZb1uMuUC+XPrul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY6RGnqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DA5C4CEF7;
	Tue, 10 Mar 2026 02:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108026;
	bh=gMEydkz6GWXMSQkpSdb6XQu4xJKeUsGAF2+pD8v/S5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iY6RGnqvKgo6TBzA/yKBJ15ppkjgSrGkc5aNVnqrTOyimqdFNyzqHo6YVWwdDy+cb
	 4zLMKlDgGiGxWfiqrALLOlNctIjuG5q2hbsvrsL+QNGmkQFSCaCJWBPJXVtdGS1SIC
	 oHZR3FamzArJKkQ3tgrRBotdol+z5iWZmuPDCxRJqZ3g4EINbWUR6r9SKJMiptpRbi
	 zxrNvyzN802jJq+CSMJ4PJ8zpDAS3jzLDU63R6nbozR7g5jtEaz2AFq1i5af6zYGwe
	 xc+dBvSPadta5XbX+i7jiNurjTPaGnfpJDm0xbXiaTWPjivluZNGiobGNXzNLjRW7s
	 KMfk2qQxRa9qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EBC3808200;
	Tue, 10 Mar 2026 02:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tcp: remove unused hash_size from struct
 tcp_out_options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310802356.2022132.6757741027991686076.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:00:23 +0000
References: <20260307051619.51685-1-kmta1236@gmail.com>
In-Reply-To: <20260307051619.51685-1-kmta1236@gmail.com>
To: Keita Morisaki <kmta1236@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jakub@cloudflare.com
X-Rspamd-Queue-Id: CE1ED2440C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265852-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 14:16:19 +0900 you wrote:
> hash_size is declared but never read. The MD5 path always uses a
> fixed size of 16, and the TCP-AO path uses tcp_ao_maclen().
> 
> This closes a 7-byte hole and reduces the struct size from 96 to
> 88 bytes.
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tcp: remove unused hash_size from struct tcp_out_options
    https://git.kernel.org/netdev/net-next/c/8ca8eb057673

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



