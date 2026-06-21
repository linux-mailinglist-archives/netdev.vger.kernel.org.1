Return-Path: <netdev+bounces-300927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ybb7OvRjOGpwbwcAu9opvQ
	(envelope-from <netdev+bounces-300927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:21:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 675716ABBDA
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IMWXc5VR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300927-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300927-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09AB73035D7A
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1637700D;
	Sun, 21 Jun 2026 22:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA9377031;
	Sun, 21 Jun 2026 22:20:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080430; cv=none; b=sFPD/xrWYXi1tHYxsc2V6joWE/SQ/HilzsxP1zme8H6WBh9kjjQajvBYwctshz1RuvtFpp31AuB2+rsDKpjlzh6807WqehhJC67xLkcGrUvmYqml1NZ/sbhsxagqDFwSdwTgo7Bl1lDOngOdFzQfTXoKQZQlmF32zjujDP983rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080430; c=relaxed/simple;
	bh=rq4FJ+WRfcMjS/NAh4Fd5n4igPd0BXzm4EIZQs69aHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LvDUme5wZxvUZ2ofDraYo2Nce02BcMpMpfem81Ot5Wzypm5xAn17bBOFDhWzzIsZJta7iNvPLhcr3Qwx41Tw1DiOTCdwqpVi8nPrESTVL1o2ge4z0AQ6K0jSGjwrUCLSjfTrKj+ML+6A5YLzthoyk8Kptny5QpdO8dez4g796gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMWXc5VR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5675F1F000E9;
	Sun, 21 Jun 2026 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782080427;
	bh=HIcUM+f+xRUZ9gubSCNr2wWaSLvTRKwlP4p9DNtv5JQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IMWXc5VRXQBSe8VIjYr2A8YcuTV1N2nE3PlC84exeZ8nA4WWCzKFoR7Pip/9FncIQ
	 OJDQwB7ts8QHlZsHeUiSxN3HsKNEThcHcqhNeJjIT2WzfvM9SDDlHuosDkTTLk59FO
	 wwZjFa3cPB5VVlQQIMiIB0pOqGjqgeMdBECWYKxk+1cZ8lfa0DizeANxfKuIgxkbLZ
	 YktvDjruwrgMAbAWcQruLUDSNsviV6FuKjE1Av+R63TDVqBPhFT2fvjigy4R5TJhMU
	 7ln+4+/4FEOKL/SZjciW6/8IxuuXJAgl+KkLvDWJwPE/SzCrsh+ZDrsTfrYdz2B0h8
	 WVHhfjqhzN0MQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C73AAA6EA;
	Sun, 21 Jun 2026 22:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: ndisc: fix NULL deref in accept_untracked_na()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178208041847.521994.10807235942565720646.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:20:18 +0000
References: <20260617065512.2529757-2-bestswngs@gmail.com>
In-Reply-To: <20260617065512.2529757-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xmei5@asu.edu
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
	TAGGED_FROM(0.00)[bounces-300927-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 675716ABBDA

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 14:55:13 +0800 you wrote:
> accept_untracked_na() re-fetches the inet6_dev with __in6_dev_get(dev)
> and dereferences idev->cnf.accept_untracked_na without a NULL check,
> even though its only caller ndisc_recv_na() already fetched and
> NULL-checked idev for the same device.
> 
> Both reads of dev->ip6_ptr run in the same RCU read-side critical
> section, but a concurrent addrconf_ifdown() can clear dev->ip6_ptr
> between them: lowering the MTU below IPV6_MIN_MTU calls addrconf_ifdown()
> without the synchronize_net() that orders the unregister path, so the
> re-fetch returns NULL and oopses:
> 
> [...]

Here is the summary with links:
  - [net] ipv6: ndisc: fix NULL deref in accept_untracked_na()
    https://git.kernel.org/netdev/net/c/d186e942365a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



