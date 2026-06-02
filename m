Return-Path: <netdev+bounces-294386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mX4XL+82H2osiwAAu9opvQ
	(envelope-from <netdev+bounces-294386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:02:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB9631997
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:02:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Oj+61BOk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294386-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294386-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 463D7303F2B9
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67924A078;
	Tue,  2 Jun 2026 20:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51E256C61;
	Tue,  2 Jun 2026 20:00:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430412; cv=none; b=a3rXicp1+B9FSe0vwD4cJRBJr5O5eQh5MXy5r/QHmIU6IC+ofQhmOTANj1E2solYTjYgi6V6yjLrJ0GEtChVWUyCzBCZf2xud7gIRxRQ/WoUPP3nfIEEHbSUk0WlbOx3y/TaGQW9hXY60l6SmMvqbxlrsd4biTCL02TpMrXqlNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430412; c=relaxed/simple;
	bh=Pbym3ateJqpycCCBrIFVaehkRAs3cpsr0FZ4JnFM4LM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fbB9JqtEEdTW3XwH4ZfZ9K4flkr0M6fJeePzz2tT+bO6NhkJBukU9G66vFAAASLCWnRa20glHZs5jfVMpfBsWtstO0jK5phgJaWemlzN2pww3fXTZedpnu+8iG6FNW9iFA7zN1bjiHlofEk7gVkuH5Lp+A3aXv4bqg7+t62mxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj+61BOk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432631F00898;
	Tue,  2 Jun 2026 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780430411;
	bh=194P7vb5HseoyOFDlJNE+Is9+6yMdUnIR94zJqh2Ws4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Oj+61BOkW73ykU/7BSdfIfCZfutQUwxT7KrjFmhEG3ohdl6+9qyTHhFtB6eU59Fy8
	 3iE2ta9HJHmRHNNDure9Dmg0XWyqM0e/mzIrxQ8cUDwzP64T79LmZvz9VY995c/hGp
	 jHF4rIpQCCGiLL42AET5U7lDiQgHSHGuFeuDmk44YskA+rJ+NLBoxF2aO9P050w74A
	 QGP6XYR9aPcsv0rIXJ4V0czEXozMlaaDctvWmWZunUFry/s2H/lUin6cdSBuqIqcW3
	 ddYOILsWijXr9lpTE/bJgh3CR5CcggSNPL9Qccm79K4Nen4EdUT85KZhzU4htbmabj
	 SF9hGMWZ94AHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BC53811A6E;
	Tue,  2 Jun 2026 20:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] netdevsim: psp: fix issues with stats
 collection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043041314.1026900.16247038628366126576.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 20:00:13 +0000
References: <20260529-fix-psp-stats-v2-0-3a194eacf18e@gmail.com>
In-Reply-To: <20260529-fix-psp-stats-v2-0-3a194eacf18e@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294386-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel.zahka@gmail.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danielzahka@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ECB9631997

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 06:15:26 -0700 you wrote:
> It has come to my attention via a sashiko review of my net-next series
> for aes-gcm in netdevsim [1] that there were preexisting issues with
> netdevsim's implementation of psp statistics.
> 
> API usage issues:
> 1. not calling u64_stats_init() on the u64_stats_sync object during
>    init
> 2. not serializing usage of the writer side API during stats update
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] netdevsim: psp: update rx stats on the peer netdevsim
    https://git.kernel.org/netdev/net-next/c/abaef7e966fd
  - [net,v2,2/2] netdevsim: psp: use atomic64 for psp stats counters
    https://git.kernel.org/netdev/net-next/c/163bea8010bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



