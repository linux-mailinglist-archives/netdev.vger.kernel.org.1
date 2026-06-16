Return-Path: <netdev+bounces-299910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QMbII6V4MWrPkAUAu9opvQ
	(envelope-from <netdev+bounces-299910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:24:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CC86920AA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W8cNWj6Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299910-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299910-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A92325B87E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6654657E7;
	Tue, 16 Jun 2026 16:10:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4D44E045;
	Tue, 16 Jun 2026 16:10:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626219; cv=none; b=QbmIkXtLW8toOnJvoVsaO/3T7ZeWyb4/WwjWXeL8bqY6urT+w8oGnv5V91oRdg3pjxFuB0xzVyW6aVJ88T0q6Nu6Yz6gk8gDqkDRw6MJQkmUIZR0DBW9yPOghrlSzrdkqMaw4975smVwcW+JoRSKI3fmhqizCCbFj8ncMnreAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626219; c=relaxed/simple;
	bh=ogTgS1jVkWDMupmCeIfpN/zACidCFcsMLCYNh0k14Mk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u4krbXjaVrZwvc/WwBa55OgkWw264pNo92pFjyn3y19j0ierdR2Oz+6MlHMOMtIHDn3Y+skrgjtOGbEMvxuckU4g8rH3erehCTH/fxfPjEQLb2jJ2nKGQUrw9rRC3aMvuVs0pMQUkB3wD6Va7vDDE+3clGXSO7JdgxYE3+vPArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8cNWj6Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4C71F000E9;
	Tue, 16 Jun 2026 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781626217;
	bh=iOEMBj+SMmhTxgAMAdDbP7Hgv7+uyAEdMJ2s+ta4Zmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W8cNWj6ZJ76nq1ZaMGWDK2BPGXPMMqaFkkJkaZMD69BX/dP2pcJlPKYlxftlzeVUM
	 Klt5erPAuRdRaNLWEETqEz5ohL9DptSUFxFO5OaJgkG+hnX2gcBDdF0NJxxTc7nY2l
	 avtQhogcxxA9+wcEDUQpo0aEqcKLn0aaKNP3d+PfyKEprUKGNxBrK2WExhs/Zwwdsw
	 yJRPBJ3UhcCc8AXvsEsNZ1YISAkV5tat1w5T2SUBI/04GHZ1TI8e6HzeIwHo5EwknE
	 Oi5G3pwy5Vfc/ihfETEiQi1Bwg4L9jCu06NIVtbJ1z6u7/ZOi+viakUsL+zZf+9bA+
	 ri1a8qf4tjfCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391E3930ABA;
	Tue, 16 Jun 2026 16:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] tls: reject the combination of TLS and
 sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178162621239.1143794.13386729126363922107.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 16:10:12 +0000
References: <20260614014102.461064-1-kuba@kernel.org>
In-Reply-To: <20260614014102.461064-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bpf@vger.kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com,
 sd@queasysnail.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,cloudflare.com,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-299910-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2CC86920AA

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 18:40:55 -0700 you wrote:
> There are no known TLS+sockmap users and it has some known
> hard to solve bugs. Let's reject this configuration as we
> discussed a number of times.
> 
> Jakub Kicinski (5):
>   tls: reject the combination of TLS and sockmap
>   tls: remove dead sockmap (psock) handling from the SW path
>   selftests/bpf: remove sockmap + ktls tests
>   selftests/bpf: drop the unused kTLS program from test_sockmap
>   selftests/bpf: test that TLS crypto is rejected on a sockmap socket
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] tls: reject the combination of TLS and sockmap
    https://git.kernel.org/netdev/net-next/c/460e6486617c
  - [net-next,2/5] tls: remove dead sockmap (psock) handling from the SW path
    https://git.kernel.org/netdev/net-next/c/79511603a65b
  - [net-next,3/5] selftests/bpf: remove sockmap + ktls tests
    https://git.kernel.org/netdev/net-next/c/faf89584e436
  - [net-next,4/5] selftests/bpf: drop the unused kTLS program from test_sockmap
    https://git.kernel.org/netdev/net-next/c/6af8971d910e
  - [net-next,5/5] selftests/bpf: test that TLS crypto is rejected on a sockmap socket
    https://git.kernel.org/netdev/net-next/c/5949a7cf11e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



