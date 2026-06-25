Return-Path: <netdev+bounces-302035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UV+ZKmVWPWpF1ggAu9opvQ
	(envelope-from <netdev+bounces-302035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:25:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFCC6C774E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:25:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FA7E3QkV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302035-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302035-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88FCE30D5406
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F43EBF35;
	Thu, 25 Jun 2026 16:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B503EB81A
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:21:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404466; cv=none; b=hZV4Pf6MtZa/bBt0gHsHn+DOlLs4fO2v/lcyvLIFy+Su7vCnUx3DDVC3StLZF4Os2MY5OZLk170Vp/6BB2PHSGpTA3Qd95svpITtZVvWZAttL6xQjhbiDCzYBVKzoTHyCcvRY+gdQS0Jz+NzETqTLiGcdwMkH0c5rmm+xYQg4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404466; c=relaxed/simple;
	bh=KSbqgoHGNzYBrCqqe1NILAOfZlR0Bog8V5qxiem35mA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NcwdygfLgIRtxkoXZHzTCh+D0KkF/8W5ZbENg/5lghAbExK/m6Z4CCf3k1rEPN+NhXQf3VjAK7NxoOyzXzEW8dT/ysDv/VOz1xtfOFpa1QUukoq8TgMpJUn3mv+galp4lYz7FVte+ZmU09ijUM4wqjIDBjEGD1xrVkYY2lvLo3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA7E3QkV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F8A1F000E9;
	Thu, 25 Jun 2026 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404464;
	bh=R9YbzsmjCZpBRNgWP4J4vs+VqRH+hvRpRw4HededISQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FA7E3QkVYXbqeDgnetlcYUDiB1QO1vkZXA1R2KCbiuJYxltqYwkZGOGmCnoD5HstU
	 TXnhn1b4Wb1hKBWMY3M6skuxeXOuyJk6ZtImFfZd3MhjYpAGupb7a6rAzdjd9AzYHp
	 58JUEZaTwEWmTh1co37VXfc1OmUzIOFh16iEKKQIzuPEgVexaRs4gZUoXnXSd4ymMW
	 ElS+zjQvSJ0U/B8RR3rRc4pPGyCOnFmwjux9ALceOGGEmA7f1vkCtdF2QGZBAcO0Ty
	 FsFU8LQwEtb8GIshnN81uZuuo6cfzP8kplwo8dB6LjWHSXd2EoS1GfHhs/4SotTGio
	 Ym/r6e9zoQ0JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08A53AD449A;
	Thu, 25 Jun 2026 16:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] tipc: syzbot related fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240445253.3803792.1258406668336193421.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:52 +0000
References: <20260623173030.2925059-1-edumazet@google.com>
In-Reply-To: <20260623173030.2925059-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, lucien.xin@gmail.com, jmaloy@redhat.com,
 tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,lists.sourceforge.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302035-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:lucien.xin@gmail.com,m:jmaloy@redhat.com,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:lucienxin@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CFCC6C774E

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 17:30:28 +0000 you wrote:
> First patch fixes a recent syzbot report.
> 
> Second patch is inspired by numerous syzbot soft lockup
> reports with RTNL pressure.
> 
> Eric Dumazet (2):
>   tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
>   tipc: avoid busy looping in tipc_exit_net()
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
    https://git.kernel.org/netdev/net/c/7116764ca53f
  - [v2,net,2/2] tipc: avoid busy looping in tipc_exit_net()
    https://git.kernel.org/netdev/net/c/c1481c94e74c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



