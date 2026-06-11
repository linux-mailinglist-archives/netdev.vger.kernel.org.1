Return-Path: <netdev+bounces-298400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ubzIKVlAK2qd5AMAu9opvQ
	(envelope-from <netdev+bounces-298400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:10:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AC1675C59
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:10:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X0U1RSyP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298400-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298400-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A233D3032391
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B3A382F26;
	Thu, 11 Jun 2026 23:10:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C3388E6B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:10:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219415; cv=none; b=a2gxT0SABED0vwrtAhZnYjn9G8z7YGd4QPqUcRGNAZIJZ94vvdsmgpNfw8w9b9urZRraJ+S4XURrMbWvBdKVh0WSww4dl97qhOumGSc3KJTIXrI3TgrX3n/p+PqbWb47KuERuXPWnrCEhqqAqL43g7ZSFZD7kF5JgYX2CUk3STg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219415; c=relaxed/simple;
	bh=h9JmDogsSn3UFTddTluSRqDbonS0aqFqEUzFH6UoXLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EC12juKtDHtE3jRBrb5nKgO5yR55YTa/nyder3NSyuapbQB4yIdV/Zek1EgzQBbMPhsT7rOZHI7TcwurGPorq171y0uwn7sNI4w90efVbB8abwsmZ/JLBP6oTd+q3KW+Ng3c3ThTh7KabeSqqcE054bB+ioS1b+lbhRQQVFCKKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0U1RSyP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92C21F000E9;
	Thu, 11 Jun 2026 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781219414;
	bh=zbqn6xqCjRKdAH1tAbnTzaXYwF5sfXjGk6OP/nL3raA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X0U1RSyPdAWQIFI6NR7MnYLjdYAoesErboKwXB9rBM5h9J2atU4Uqwx9wmXsN2uy1
	 aA29aVME968FoZN2flHl/9PxnSoUEs7Ujm2Gr1BEDjpPfXKLJJ2SW69Bo+4ZkLzkBH
	 446xTHHpR3XawZ1iecylMZ7X3I2QVnyhqKSJGtPE+SZ6e6zrVBhBQwx00AOD8tTjTv
	 SSZqKEZdiT1wJVKLKAuzgXEWURO36Eza+egQyHU9NkhlgWTpR4AXZ9V59PI5UTGiaN
	 igAeridZ/6eGyv2W0jWFf0TniBWcLTHo843POCpBq3kRREck0Ft4mpUon0FUBShWk2
	 oXA1S152hVIVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567DB3930FB3;
	Thu, 11 Jun 2026 23:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_hfsc: Don't make class passive twice
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121941114.401113.716094225489847142.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 23:10:11 +0000
References: <20260610132824.3027549-1-victor@mojatatu.com>
In-Reply-To: <20260610132824.3027549-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, anirudhrudr@gmail.com, pctammela@mojatatu.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298400-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:victor@mojatatu.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:anirudhrudr@gmail.com,m:pctammela@mojatatu.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38AC1675C59

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 10:28:24 -0300 you wrote:
> update_vf() is called from two places for the same class during a single
> dequeue when the class's child qdisc (e.g. codel/fq_codel) drops its last
> packets while dequeuing:
> 
> 1. The child calls qdisc_tree_reduce_backlog(), which, now that the child
>    is empty, invokes hfsc_qlen_notify() -> update_vf(cl, 0, 0) and turns
>    the class passive (cl_nactive is decremented up the hierarchy).
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_hfsc: Don't make class passive twice
    https://git.kernel.org/netdev/net/c/90b662ea25f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



