Return-Path: <netdev+bounces-298827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gfE4MamdLGpiTwQAu9opvQ
	(envelope-from <netdev+bounces-298827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:00:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 186AE67D1E2
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:00:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lzrDMYwO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298827-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298827-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC67324051C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693243806AF;
	Sat, 13 Jun 2026 00:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857B37A4BA;
	Sat, 13 Jun 2026 00:00:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308817; cv=none; b=mEuSZyrV23lPS84iZ8uAn0eON95hp3Pn+Pb3Y8vWgzHLaIHqXuWKPLEmoUJf2Y7XxYxbJ+JMwR/MArTxCwzXaS8YYevtbNffSk3nr3pKeupOBMDABCbeajMnL1tCEjU5QctQPImx/5F+0yyPMTWWQf5BI4LhqNR/XpRMJgZM8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308817; c=relaxed/simple;
	bh=uyKZNfV+FrzC5S34lvsTujIR2Q8wqllWcjddceNEE+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mELRCACfuzE3rOdvNGiU+KYHtOPoYGTDM0Nf0Z5tm2lzEoDyg34tX3pWgBCQnxWwpZ4wAyasUIC5QXV2zIJ5CEii5Cp38dVs9pzGSaR0IjC/cUnUg4cygKcvXSLnxJvMccrEQbCTGrfHTcSX4z3fes3rGVWniGscPyR0xiRBXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzrDMYwO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BDD1F00A3D;
	Sat, 13 Jun 2026 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308816;
	bh=Nt1+ajjDEnNN42gTfFZL55aPCz/54VtL02JEDvkr8cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lzrDMYwOeYEI9Nyex34CKB1qA0oaFH8CzITvm4zVF1w2bYbSucUVGCKzoIB8TosXB
	 7NgOFv+vbPtpMWhVng3GKM+IjostIbZG94AG15cLi4Kygmo9PeNiKesPhbk0wcAZgH
	 OtgL46D5g/FCou1ZTY+fjl75pDe/cCkzpciCWpuMdGOZQ296NPYOqA7lFWY20tR+f4
	 ZGErBWNqCC6JUSYrVHgz22//mGwPpv7RYczWHjUaph6ING8zl6xMYZ561qRkadzG6G
	 /TBIJbnS9tM+rHM+IGzEtoOhSvjqFJyKMWBrshD7jXqtxLaXrLmODj8YOxx79kaD7G
	 PgbXbpUPMKkng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AE439E9605;
	Sat, 13 Jun 2026 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130881264.1297459.951918209446333634.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 00:00:12 +0000
References: <20260609140911.838677-1-dhowells@redhat.com>
In-Reply-To: <20260609140911.838677-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298827-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:netdev@vger.kernel.org,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 186AE67D1E2

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 15:09:04 +0100 you wrote:
> Here are some miscellaneous AF_RXRPC fixes:
> 
>  (1) Make sure rxrpc_verify_data() allocates a buffer, even if the DATA packet
>      being looked at is zero length to avoid potential NULL-pointer
>      exceptions.
> 
>  (2) Don't move an OOB message (e.g. an RxGK CHALLENGE) off the receive queue
>      onto the pending queue in recvmsg() if MSG_PEEK is specified.
> 
> [...]

Here is the summary with links:
  - [net,1/5] rxrpc: rxrpc_verify_data ensure rx_dec_buffer alloc
    https://git.kernel.org/netdev/net/c/16c8ae9735c5
  - [net,2/5] rxrpc: Don't move a peeked OOB message onto the pending queue
    https://git.kernel.org/netdev/net/c/5801cff7d5d7
  - [net,3/5] rxrpc: Fix UAF in rxgk_issue_challenge()
    https://git.kernel.org/netdev/net/c/107a4cb0d47e
  - [net,4/5] afs: Fix netns teardown to cancel the preallocation charger
    https://git.kernel.org/netdev/net/c/47694fbc9d24
  - [net,5/5] rxrpc: serialize kernel accept preallocation with socket teardown
    https://git.kernel.org/netdev/net/c/dc175389b18c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



