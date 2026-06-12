Return-Path: <netdev+bounces-298825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l9JpKqqbLGrwTgQAu9opvQ
	(envelope-from <netdev+bounces-298825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:52:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0406667D19B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:52:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IDoMl7yy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298825-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298825-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA5933849A3
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62EC345CAE;
	Fri, 12 Jun 2026 23:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD7F34DCF3
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 23:50:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308221; cv=none; b=QpuZhWUi3188Vy0zwf1TAGWq12Z61oWCP3WegXHBmfjxCfy405juQH+UpcuK591IVBvv6cMIxI5nUgX1GFxTVWBK70XOoPjWDO9pgLjJyr47PWMPB2ysou+nc0Xhkt2yBQblehzxr/Fw9j1v1vIuH4uA0bI6PgtrpCKEYcMfZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308221; c=relaxed/simple;
	bh=v8s4n1m08a8NKSVDiJMnvRSH0fFqRml5wzuBDNn3VP8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mgatg+lX9u3YiNayDJG6xsVCDd6MFbncGgE9iddXvEs+2oNP5hDZ7sDwP+s8ZMGKV45cVfDTVDRIN4oBVkQuFNAkNGBxFRfwmJLY7wdUM4ZlmfniDw8Mgp4+WqvKbufgx10dHIOXAZX+ooNd9BrqIDE9lNNrHpE8zybo0TWaRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDoMl7yy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E1E1F000E9;
	Fri, 12 Jun 2026 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308220;
	bh=uB3HsOfnb2kZ0EzOZZuYoSXKniGicSMigJfrAagnAkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IDoMl7yypf788yfooFiA9oHzj1eV2Yg3AtF16uXPLYiGBaoBYrjuHBJRQ2XG0UWd1
	 UZvuPmDgzH10+2w7QXzv5Tb7D8r1zqpjFgtRSL51e6NT5TL5wd1uJiMJyHEkKxfXvn
	 FUfEjxq0M36GlQXNQpmvyEy4I+TWcQZPaJFfvfbbO5AZ9WkTH/03o+i+yYH6JLLl0v
	 9n6VtSgAB0Yrr3vftBuBd05yrYapNYd8zZeK9iQrlWKjM9LpbK8L/Jun6rfFRSPyKD
	 B6mcQ4q1f7MV5VXnmqdT9uCBeyGh0oqUHR0qkr/cVsw1Ufl2UU72UfzXOC0i1/zkPR
	 OmX6n++Lpg9HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397A39E9602;
	Fri, 12 Jun 2026 23:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip_tunnel: annotate data-races around t->err_count
 and
 t->err_time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130821713.1294761.16402242883960521117.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:50:17 +0000
References: <20260611165247.2710257-1-edumazet@google.com>
In-Reply-To: <20260611165247.2710257-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-298825-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0406667D19B

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 16:52:47 +0000 you wrote:
> ip_tunnel_xmit() runs locklessly (dev->lltx == true).
> 
> ipgre_err() and ipip_err() also run locklessly.
> 
> We need to add READ_ONCE() and WRITE_ONCE() annotations
> around t->err_count and t->err_time.
> 
> [...]

Here is the summary with links:
  - [net] ip_tunnel: annotate data-races around t->err_count and t->err_time
    https://git.kernel.org/netdev/net-next/c/80a7e3507d86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



