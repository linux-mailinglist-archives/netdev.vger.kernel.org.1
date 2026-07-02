Return-Path: <netdev+bounces-304060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id saJVH38wRmqrLQsAu9opvQ
	(envelope-from <netdev+bounces-304060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:33:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B176D6F54DB
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:33:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JR4TEBmj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304060-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304060-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36AAF300822C
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686543CD8A9;
	Thu,  2 Jul 2026 09:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3F477998
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:20:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984030; cv=none; b=MpCmqWdVvc8ug0QOG/OnTQYm/lgR8Y5SJy4xj8u1/R6XfRHWS9izk1BwpchhxJWt74F6RZJFqD1DCmQo8ZDpPIRhrM8vjLL2nCbyZv64kAernKralRrPB36VskR0NylMgw0YplmJ8xA+UwYDcsohxAJxv7qeOO9CqiExmnJexgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984030; c=relaxed/simple;
	bh=VCOuhmbCsTeeWkcBoIo0xBV25FRe+FtVfMH5l5K92HE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dQyuKctNvM9K0nrUnofoUgunJ6bqMrfjW6cEKB8NzUdM76XY0G68rT1DH2mpnQzlusn2IhzAEEhqjVU/8dps2BzGG/aOwNK94uF9MX1QXSQefHSjRtpkZWfjQgenEuytYvq1jMiiTPpNIxbdnaXYG8EqZq9+dXM4H2NDctV0LaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR4TEBmj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E02D1F000E9;
	Thu,  2 Jul 2026 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782984029;
	bh=o54HdEcYFItmOC4goPLmkQUbY57bw/KM01KOjEHGAzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JR4TEBmj3t6W7L8rMGbNfNE5oOmrygPITzNscFfO9Q3onLfl5ydAkMWi0TLGqCKSu
	 rcWaFa63Fq44UIyKr7SBqOh+75IFz2nO0sixjd1/lFsUX6Q1m8bvSBn2JQVLFPD9hI
	 tPpO8IBkEuyhWbES4sR5scUF0uoC8tFNa8Szch9RwvVErAIVROZaKU6xr8raOIDbM/
	 TVhmKu3Ee2deTjJ1Uo+v9sa6ibMYn59EPZ8Dj+DmRvNx6kIiZQyG2dEQkMYY9v4utQ
	 /3Lw7iFTRSHeYA+TAXM/aUM3pIt3ydszn8iwcWMGNM+OXQ1rj5zSqKvTvExfzvXo51
	 xALjJeW++RpoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569E83926672;
	Thu,  2 Jul 2026 09:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ionic: Change list definition method
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298401214.1542207.8043096415877146966.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 09:20:12 +0000
References: <20260630065457.160081-1-zhulei_szu@163.com>
In-Reply-To: <20260630065457.160081-1-zhulei_szu@163.com>
To: zhulei <zhulei_szu@163.com>
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304060-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhulei_szu@163.com,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B176D6F54DB

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 14:54:57 +0800 you wrote:
> From: Lei Zhu <zhulei@kylinos.cn>
> 
> The LIST_HEAD macro can both define a linked list and initialize
> it in one step. To simplify code, we replace the separate operations
> of linked list definition and manual initialization with the LIST_HEAD
> macro.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ionic: Change list definition method
    https://git.kernel.org/netdev/net-next/c/09cfee6a8004

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



