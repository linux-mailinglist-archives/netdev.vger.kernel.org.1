Return-Path: <netdev+bounces-295541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tpVKIngkImoqTAEAu9opvQ
	(envelope-from <netdev+bounces-295541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD806445A9
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:20:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YKkAEYB1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295541-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295541-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 436263011F56
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F873B7742;
	Fri,  5 Jun 2026 01:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE82EEE71
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622420; cv=none; b=LQbbEOTq1YIPsqLLvJ+Q52hZo8DOxo1Kf1dnmGMTX+pa+qTyeVF7ry+pVnqXiivRuz+A7kthUNnGlBfh/KxCWnyz8nYRshevlmOO97Z1E3PgayMPbnUlq47M3ayGmfX9R55h8QKOMmE9H9VFfTLnlE2YBgD9IdPvwy/MGyUnQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622420; c=relaxed/simple;
	bh=s92NE7k/tYJ+gUcYEXEBuCmfGt3WJYhm5PQ7NA7S7Fk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XFCTzwl3z3UWgySkdy6u5arjl4l/AM8TCyRU9fQnS/Ulu0VG0q8TyNfOzCgUohHMEJxGPNLsrT+LXPNJKTXx3mcZpf42oUbyOlIj6S0g4PUYQbHgum8UI6ByUizI/edzRP9iINILtyqwDTcQcubtk5HE1TTi3J+SMgWkdwOP/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKkAEYB1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A041F00893;
	Fri,  5 Jun 2026 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622415;
	bh=E3JnGa1+MYCrgdCoNF24JoTJ46FCm5qzbegBjegyhL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YKkAEYB1r3/rUhUIM7JYXcpt/DAzPqiuSk6oH3UgO2jzLrGGlkKA8hwA12coafXww
	 Ij/DUmUXX6X9klAAU68SHqx5UMIaeowKR6uxf1Md3ytFPWSb/xRVKDQxYe3CNUBTue
	 PBLVcVx01Jh+3nEHvaDsevnTL80TDWgiSxd4PA1YpLDFXfr8QlRM1dKRP/c7WGppxm
	 M01IIoBltGmxfUBj+GPeKfnM/A/tQUp8YmotCpuaj2WJ7TlSNHSs1Laf7iaZ2mWZXe
	 lq40M2nzQr1addzQT558GDRY3EroWEotKOcqpMzmiug7+rbZTO4vVajZWvME4MrVv+
	 CxLz6VqCZRQOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A9C3930A8A;
	Fri,  5 Jun 2026 01:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: annotate data-races in sysfs and procfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062241589.3090676.12496831277617152146.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:20:15 +0000
References: <20260602152748.2564393-1-edumazet@google.com>
In-Reply-To: <20260602152748.2564393-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jv@jvosburgh.net,
 andrew+netdev@lunn.ch
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,jvosburgh.net,lunn.ch];
	TAGGED_FROM(0.00)[bounces-295541-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DD806445A9

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 15:27:48 +0000 you wrote:
> bonding sysfs and procfs read parameters locklessly,
> while drivers/net/bonding/bond_options.c can write over them.
> 
> Add missing READ_ONCE()/WRITE_ONCE() annotations.
> 
> This came as a prereq to avoid RTNL in bond_fill_info().
> 
> [...]

Here is the summary with links:
  - [net-next] bonding: annotate data-races in sysfs and procfs
    https://git.kernel.org/netdev/net-next/c/4dc5a40b3bc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



