Return-Path: <netdev+bounces-296009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u9poLT1xI2oEuAEAu9opvQ
	(envelope-from <netdev+bounces-296009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:00:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C8C64C0F1
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:00:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QACf3VfO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296009-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296009-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97BCC3022967
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF45E18A6A8;
	Sat,  6 Jun 2026 01:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EC1A704B
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 01:00:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707626; cv=none; b=nbs6dUUipfCoz4cGAojBOu5Gdd7B4AISEUqlmVR0ZDXSBy6UO0JbtegMZ2gTzoujzXcWo1A9d84TcJjCRrX5MkloZOwXViZ3m7AMmY7fTrmQbB/oDMr9FfId7KKMN+3gTENR586niTuLpU1FXZ2Jd+iRQDpVzEIDgME6nHrW1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707626; c=relaxed/simple;
	bh=2dt3j7xK0yTYyQmx1h8DuZ6BVD4GTFhqplrD6TvgORg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JydF5qqkRSjOhbQ5kqoRVIn7daevKZSBlf37hePew/9VxdVo0xFD6XR9PbYshbnr9XRhApgPiJFhKIfwiGukAOIZe+5JgurT+Mvj9BnIapxjZms7GiCt8+x2xJ9l89/Iv2Vmway+v6LfkRcsd+pIMOGXSjw/5Cq4qZYPQ1LO3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QACf3VfO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5E31F00893;
	Sat,  6 Jun 2026 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707625;
	bh=a4LMEFoS+tUuds4DJWXU9nFxPwxAUDbm1tSBiNrNZeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QACf3VfO78+LprqJVfNYWCH1KS3GdaOMRoaXTdqUeEUynjrSRcWvmYZ8ygLiAwfJS
	 QcX+E/FRAf5+Vv3J4aUC+VviC2lLMbAPdtJ6zW75AK1PSmDabvZD9AdqXanq9FPW08
	 uijS9IBXL3vPoI6NKOshgTRP1ypjpYpbjETYHJublYxLTOd+FuXqMY7hiVMmKpm5ZD
	 RrkOsvxARf9Kqh44j2mjvaw9IQeo0vPrOSmPZLgL6rwvoT/P/iZCxiemanfRfD5tUe
	 6n2LzH6UWMD2nZqrXAcNR+wCE7vPFp8FPvxeyBkbbC+Bcwa/l3hD0jL1+StKPjTcEJ
	 YJdPTSsZFKQGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F03930C06;
	Sat,  6 Jun 2026 01:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: remove obsolete EXPORT_SYMBOL() and
 EXPORT_SYMBOL_GPL()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070762564.3975748.11843425072454917140.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:00:25 +0000
References: <20260604174555.2801532-1-edumazet@google.com>
In-Reply-To: <20260604174555.2801532-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-296009-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08C8C64C0F1

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 17:45:55 +0000 you wrote:
> These symbols don't need to be exported, they are only used from vmlinux:
> 
> - inet6addr_notifier_call_chain
> - inet6addr_validator_notifier_call_chain
> - in6addr_linklocal_allnodes
> - in6addr_linklocal_allrouters
> - in6addr_interfacelocal_allnodes
> - in6addr_interfacelocal_allrouters
> - in6addr_sitelocal_allrouters
> - inet6_cleanup_sock
> - ip6_sk_dst_lookup_flow
> - ipv6_proxy_select_ident
> - ip6_sk_update_pmtu
> - ip6_sk_redirect
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: remove obsolete EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL()
    https://git.kernel.org/netdev/net-next/c/9410fb4da2d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



