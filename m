Return-Path: <netdev+bounces-306622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vyO4OgcUUWpq/AIAu9opvQ
	(envelope-from <netdev+bounces-306622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:47:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF073C5F6
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:47:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WOaR2DDW;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306622-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306622-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10871300332F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D995E435EC3;
	Fri, 10 Jul 2026 15:40:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DB3C553B
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:40:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698037; cv=none; b=CqCTGBxQr1NPbSBgSdD8NVXyra7ZPYRmEeEAOan8Cqv3DqY7LldWIVJQYrUITsmUWI7glBnCP6Rcftyub1mRuZ7cH1kqtET89o7FcA11PDL1BwtzrZm15O5M4LCugYepTTo+8Id8zzmv2IoIAZRX5X3LgKIKP0zCIBFZP4VvzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698037; c=relaxed/simple;
	bh=BruHszgQKXC5nMgfHOL7Zceo55mvSdLe3ZsaDNvyDLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ccIhFGgPv5wx2MlZQZurEkYwcLXWi88WbKn711JuKvQE7NDR3RFJzzzEzGYrWSHMaiEYn9ByP4VFHFAe3ax9sc2yoWnGsW+wpS6KgJezW5Vn0NrCdJoRZs5Ws3V3vA3MvRkLrcRjWPRKQUACwbUB7mVQ2G+/4CVIkZOiFbtqeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOaR2DDW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB741F00A3A;
	Fri, 10 Jul 2026 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783698028;
	bh=MQEW4HHqbSnKqGo3a+ya3bSiB4jx6NB3sjKoJPprHb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WOaR2DDWAH0i209fSjkRkx+RbyDc/BUToDqg4MEaU2qrQdlcmjJFDwTkxYlT32h0w
	 rj8AeQTBTET19GMKR+ZtHog/OtPYgqTmCtLsPdb1KXA4sAiZrY1jLSHVvmwpiAIhqy
	 zH3bndXReY7trozWCx+oNRB+KRtE0HtnEjJ6Kx/L5s2EcVXMyiH5i5wO0VEzktV2uF
	 FAjmgF+bDpASKCTkThID585YRYAnqDZAWxcfZrhN+p4VqanhTFkqYoP8XJODnMaVrz
	 HWTtNzy3CyFEG4wlcCCgOn9YJcd/N6FAFUF/60DMX2JO1qy36mjZmbT2O9m5nz+1sN
	 AU+kfkihl7UAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D090E3924F9F;
	Fri, 10 Jul 2026 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] tun: no longer rely on RTNL in
 tun_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178369800638.742691.4280078697381191859.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 15:40:06 +0000
References: <20260706163517.2415530-1-edumazet@google.com>
In-Reply-To: <20260706163517.2415530-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, willemb@google.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-306622-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:willemb@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3ADF073C5F6

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  6 Jul 2026 16:35:17 +0000 you wrote:
> Update tun_fill_info() to read device configuration fields (flags, owner,
> group, numqueues, numdisabled) locklessly using READ_ONCE().
> 
> Annotate all writes to these fields in the control paths with WRITE_ONCE()
> to prevent data races, as these fields can be modified concurrently via
> ioctls (TUNSETPERSIST, TUNSETOWNER, TUNSETGROUP, TUNSETIFF) or queue
> attaching/detaching.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] tun: no longer rely on RTNL in tun_fill_info()
    https://git.kernel.org/netdev/net-next/c/23dad2d088df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



