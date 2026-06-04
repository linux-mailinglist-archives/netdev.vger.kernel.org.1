Return-Path: <netdev+bounces-295020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id svlfDYbfIGry8gAAu9opvQ
	(envelope-from <netdev+bounces-295020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:14:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D763C6C0
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:14:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="EB+7Ywf/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295020-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295020-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46FCB308552C
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42622DB7B8;
	Thu,  4 Jun 2026 02:10:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49FA2BE03C
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 02:10:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539035; cv=none; b=P/LnHqLsvDcu9qgnj2xzFt8GgxsKsA1NNkZ8NXffgHB5n0q/m9Uq1BA3ZTPzzTzj4ZsGfbkMOY+JBcZJE3nByOaWkqmCeWBJWkjE8ovJGC+JFWoNKMgcbQpvMbMepzTtqH//WxgMvW8cNQEKLIkMmdZhArHuDH+5f/AoD/UkK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539035; c=relaxed/simple;
	bh=VgZMtvvKYdijYdygSYFnAKLSJXQMoPIygg/UhoTi5Aw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sPjsWpPFQoMhWR92Fz4wjWVsxnH1EjY9Qx95HdJLs6gmQsAOfcE1hellfL0f25XCxsle7hmi47iRxL33T1tqiM4JQM9i6Dun+B2ng2pSrkYDpdO3xX4StoXcYx/qLi40/+yOEpWLZBdzMmFXQyzaYM8csVjZZQiZg5/SDn9WuHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB+7Ywf/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E4E1F00893;
	Thu,  4 Jun 2026 02:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539034;
	bh=2FPN27sUVTAqTYUzXGYyqqcyAD5UhkDv4v+FdoWAwHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EB+7Ywf/Lb3ajKqjH7csT0PsOzgH4h+5zmTbEpCKp13kxFn1Vm8TBmBwNjPx9eFnF
	 wSQ7+i9N3Cenq/0G/Muz3TjPGK1PSlOhFNS0pTFC3qlutPE5GVdYlqOAETFyIgyOIS
	 s1TMxTfSwxJHxfNXX1ZNSkojOWsO6NUvOZJ43jJmjOnbptop9OW72apgrCp5Hfdl/j
	 unJ89HomJ953QYG8tWB9GdsSlDlBQCVlVMno6+K+zpLLa5RB1H3rgNZNh9Pd120ltY
	 8sEfjX4cKmWTonTmRk0HTTbgT30wlal742ESD1/gsMnRfqayN4UYqaDS6IN24pLNuR
	 QnZOrz53J0Mtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D092B39308E0;
	Thu,  4 Jun 2026 02:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: raw: remove six obsolete
 EXPORT_SYMBOL_GPL()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053903539.2204548.11328695461139418091.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:10:35 +0000
References: <20260602165036.2712408-1-edumazet@google.com>
In-Reply-To: <20260602165036.2712408-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
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
	TAGGED_FROM(0.00)[bounces-295020-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E6D763C6C0

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 16:50:36 +0000 you wrote:
> IPv6 can not be a module anymore, we no longer need to export:
> 
> - raw_hash_sk()
> - raw_unhash_sk()
> - raw_abort()
> - raw_seq_start()
> - raw_seq_next()
> - raw_seq_stop()
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: raw: remove six obsolete EXPORT_SYMBOL_GPL()
    https://git.kernel.org/netdev/net-next/c/3070d0294e12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



