Return-Path: <netdev+bounces-298840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vY1nD3elLGoiUQQAu9opvQ
	(envelope-from <netdev+bounces-298840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:33:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA5667D518
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:33:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RGvaQ1DT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298840-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298840-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D04A0309899C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4A8221FB1;
	Sat, 13 Jun 2026 00:30:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762521638D;
	Sat, 13 Jun 2026 00:30:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310632; cv=none; b=joFa1hpTgRZIwNAUuX0SbSIGHAueZRUtZb9yXj5NOh+CIwnazCC1K4KErSYWBoKxw5KkL1FEqvACWy6he0DALwsYqxtGIR6jaD7WOi6pgbDnmeMq4lk7VnfqdoqWI7AkJAv+7Gok0fnLBR5fgDbwJfBe1RPIk+OGRZWWGl542BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310632; c=relaxed/simple;
	bh=3JkWfIxR7KSgm+S+QDEOfKI2b4F0bUFZNrhL4sJTNEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JSbVAqVzB/eRm+1WWYmirkKa7wZpr3SFtuc34KEANMvLPb6peX+Wsm4U2KxGN8YseiieqQW21qVripHGZ2vWQNxkZ1NCfRo83V/nBu+qUX2iD/9QSEbnfjjuJIq69TnsP7o7gVwZp0nWanXwRBdDXV4mer9Encd/QQGWEVfdZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGvaQ1DT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803C71F000E9;
	Sat, 13 Jun 2026 00:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310631;
	bh=WMGDE+I1ANpYvbTXCg8Hr3B2oWJc9M49fb5XBbAPXJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RGvaQ1DTBZ3qkQV/1IGM3aWJS2mYSoL0aXS69+4b4x+CIDZBWqovigHcuCg+t5of1
	 W4dYyChbZcSIeAQEksIL5s+BVn4U54EdeqXZ1/meHqMH24HJyJ+fqRylm4PeUaPD5C
	 hEqUwUX58TGIMyv9xWULbFP1FBQXLfwQbS73PwmeLcj0QgmmwGcg+g9MSIAVbgMsrP
	 wm/QMIAqmF0xLW7innrWqjpfG8Z3cf+xv3Lr9W/5n4rMaJVY+dpDb7aTvRVg4i6riy
	 Y2Gsz/zPFeA4dCLD9bOtOItP26JQcnWcm+bkKW55Yle2zb8+ejdC6Iumnbtj/RjzmZ
	 7LDCJ2oPXXuZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698139E9607;
	Sat, 13 Jun 2026 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] ipv6: mcast: annotate data races in
 /proc/net/igmp6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131062788.1306549.10543327145544730405.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 00:30:27 +0000
References: <20260609081113.7613-1-sigefriedhyy@gmail.com>
In-Reply-To: <20260609081113.7613-1-sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298840-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AA5667D518

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 17:11:11 +0900 you wrote:
> /proc/net/igmp6 walks IPv6 multicast memberships under RCU without
> holding idev->mc_lock, taking a lockless snapshot of two fields that
> writers update under the lock: mca_flags and mca_work.timer.expires.
> 
> Patch 1 adds WRITE_ONCE() to all mca_flags update sites and READ_ONCE()
> to the procfs reader.  Patch 2 does the same for the timer.expires read
> in the procfs path.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] ipv6: mcast: annotate data-races around mca_flags
    https://git.kernel.org/netdev/net-next/c/d0dc208808a2
  - [net-next,v2,2/2] ipv6: mcast: annotate igmp6 timer expiry race
    https://git.kernel.org/netdev/net-next/c/1ea2f885a76b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



