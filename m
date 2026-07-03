Return-Path: <netdev+bounces-304452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mcRuNKV4R2owYwAAu9opvQ
	(envelope-from <netdev+bounces-304452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:53:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C5A7004EB
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:53:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WFh57eHd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304452-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304452-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9053308C302
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12421339719;
	Fri,  3 Jul 2026 08:35:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D483019AA
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:35:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067752; cv=none; b=RKXZN+LxZLxPDdu96Pdzn+gTvXG3HcHcLck4pm9fHsnAyJYyCbOLkO7MiqSyI+s2oovCXpfNerXpTAN467JS3oXLMGzpXrP67iSWQzanjYGzY7+jKAs3f/iEVfAKP4aI9oEhNRHwZGlo1tyNQKdGWM+lZ5viisxsFts9UjcYw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067752; c=relaxed/simple;
	bh=ZedgvzdroAmWQAwpAKO4f979IxRCT0NG79Cg9IVYYcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LldqkDmNUOeRZ4M0hg/brUXz2Wi1rhSaZzHUYfbY4sl7c8QowIy0wNszXkziJD8HtVz8G8QCZTiRRzJPL4r+1FNrRta8NjZ/5cu1CE9iAhQKG7/+C8PVIZ23ayU7z54Y7cygUHJUQGqCgz77WqwaghpbUfdr6yc3pQUWIFQuhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFh57eHd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00D71F000E9;
	Fri,  3 Jul 2026 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783067750;
	bh=CxxMVJB72QyFg1TyIOBoEzRg14WUyK0zXhkZQEr6HLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WFh57eHdP7yWWbPme4JBazmDrmR5yIOXktbZ1JNPU24skMzPP7ytgG0APBwvTRbZF
	 AfTLPs0X9iFasExx5EWWztjr+YsAlOZ+OgxHMjdqejcAoi00OLOWncPASEQUWP6upu
	 /nMPmNjn+olALWIfGkL4XyYTLh3tlZvpHiaU6bTC/ZtKMFMYu95AIUM744XCqaa91d
	 5HHzS192r5QBacImc/66jkvUwbearukISuOpsTP8kBqando2P4Hu+T5AKGjJRhG7ox
	 2OJPNoj0A+OzOxKHe9PAmYxGDLleUrEDnH0mVDx/0WUj11vbALJzz45MPNK9Tmssu9
	 gp8ckl+sacZCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AF039389FB;
	Fri,  3 Jul 2026 08:35:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gue: validate REMCSUM private option length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178306773313.2512156.14413228998878751784.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 08:35:33 +0000
References: <20260701022617.53171-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260701022617.53171-1-q.h.hack.winter@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304452-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:q.h.hack.winter@gmail.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:qhhackwinter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49C5A7004EB

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  1 Jul 2026 10:26:17 +0800 you wrote:
> GUE private flags can indicate that remote checksum offload metadata is
> present. The private flags field itself is accounted for by
> guehdr_flags_len(), but guehdr_priv_flags_len() currently returns 0 even
> when GUE_PFLAG_REMCSUM is set.
> 
> This lets a packet with only the private flags field pass
> validate_gue_flags(), after which gue_remcsum() and gue_gro_remcsum()
> read the missing REMCSUM start/offset fields from the following bytes.
> 
> [...]

Here is the summary with links:
  - [net] gue: validate REMCSUM private option length
    https://git.kernel.org/netdev/net/c/d335dcc6f521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



