Return-Path: <netdev+bounces-301484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JifqAFnvOmpbMAgAu9opvQ
	(envelope-from <netdev+bounces-301484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4652D6BA119
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:40:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=InOAqbPE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301484-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301484-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 910A6300C027
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614D33A6F06;
	Tue, 23 Jun 2026 20:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66149396B76
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247221; cv=none; b=T/i+toj2t3e8xt3hieqGMj5+DcT941HtAJQK8+1+z6Jp02iu3RqcL0wwmmxbV1qejYQR0Kocn4o/mtcxyhQRJeitTzgTlXyHA02Lg8wu1SqzElXQ9sA/xkvh0FCr3D6itA0EAl1VeMpqK7ZjwgLUzBr3+lrJ0u2pn035EuOzu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247221; c=relaxed/simple;
	bh=epzjtXeO/6OP9nzvGrR4TfW+GaP5e/ERtezWocFhqec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EMKhEiLSeJm7Am5sbWJ0CLaKypJ892GVl6CLPHbxsjB+cgw5NRxwnHDwyBqaZbqP3U9uaNkSzuwqM3LWdTTlL3iP5JYilqyqUalKZwmosjUjKLFBtnshYyge5rNFelXnmeckJm0j0RQRFaOsJaeUDY2xKiDSM5Wl44x5kk0nlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InOAqbPE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE771F000E9;
	Tue, 23 Jun 2026 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782247219;
	bh=eFYgGUgZaxohMfSNmNcfA5UcWxQXriMHkIXv17OS1aI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=InOAqbPE0ueB+AwX/KW62Jv5p48S1h92tKFJMcMDTfv6PlexxgdI+FS32xVgc0ird
	 MV/VWe9N/a1i/842P7fbjZFqHWLO/Itqopn6OAHeAxn7+UkVBSSICg5mtXoThaTVgl
	 wCQDYvbK+0T7bf9nk5woq4BrHb6+jCbz4a8VkoFdudGI6SfwQyS5d8FsjdL5HCAgfe
	 qNuNo4JipMOfnxwQ+6J73jRztM8LMxnA0aE5LIN8HxXL0IqQOSJOwkBy/kzGXqQB4j
	 raGu/xUl9A0F8X2iWbpxrtYWZVi5TDLJtYYXU/e+XibPMe0BY3Sxh976Fm8e9rSh81
	 1kGCG9g3KXvaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AA33931005;
	Tue, 23 Jun 2026 20:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: drv-net: so_txtime: relax variance bounds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178224720930.2409533.11505050682346179213.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 20:40:09 +0000
References: <20260621200137.1564776-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260621200137.1564776-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, willemb@google.com
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301484-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4652D6BA119

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 21 Jun 2026 16:01:18 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The net-next-hw spinners on netdev.bots.linux.dev observe failing
> so-txtime-py tests. A review of stdout shows most failures to be
> due to exceeding the 4ms grace period. All I saw were within 8ms.
> So increase to that.
> 
> [...]

Here is the summary with links:
  - [net] selftests: drv-net: so_txtime: relax variance bounds
    https://git.kernel.org/netdev/net/c/e38fec239d92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



