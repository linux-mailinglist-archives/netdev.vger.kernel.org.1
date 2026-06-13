Return-Path: <netdev+bounces-299061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PJIUNu3SLWrfkgQAu9opvQ
	(envelope-from <netdev+bounces-299061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CFE67FD7A
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:00:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="T12u3i/4";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299061-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299061-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A19DF3027B5C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD283A5E93;
	Sat, 13 Jun 2026 22:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296D2E8B6B;
	Sat, 13 Jun 2026 22:00:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388010; cv=none; b=Kg0xt6UixEp6OwpaGSZ98j8Cj50gpMrbnCFo+GY4uEL+lC1I4ywve/m0r2Ink426eMvDHK7lLncPN97Ez3+z+0tYmbxnId1PRM7Poq0m3HOhfwEyPFRxver2/lq8VImdwLzaxiUjaaTolrYgS9foXtt0MnRhZAppTUwQhvNEJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388010; c=relaxed/simple;
	bh=HeQJf1e09DUYIL+aw4gIXqbiPbXa4Dw65OO0fSuGEFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UCwz9Q/K0EcBZcR9gNIztaidGY/l7YgX3TsUEm7B/PUJhCOR01O0+hypWA3ys0vfa3X7mq/CO26EoLE3hTaveiJEBvhmseqRB0v3I1b+Iy8EBqEJKQrbSJkC4WDOUKNJunUB4PEE8ET1HC8GvQZYvrqk/FfJhCsfluuS/SzJ0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T12u3i/4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778AB1F000E9;
	Sat, 13 Jun 2026 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388009;
	bh=rA68kJZhnNjblo7d9Bf6fL30BN3xpW9wSzpe0KiOV/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T12u3i/4Og2nC6ggYzV7P9PtjYGcL4Gcnedicr5r9N03OPWB2Jxg4mEtBO+wnUGoY
	 MF7U4FWFindWxMyf09cTRORXd9Jpsm0jeq6pg4EaQU7/G5KMoijXqoDtzNBeU4goV2
	 SY7AeIdyidFGuDNDt2rR4JF9pZA7HHfkdiLZDXQRBc9eMXTa77XfnfBBsIRjq481D5
	 DcL0Sr/yQ/PGiMTG5cuHa1w0/pNDpsHhvv65Uq5dxC/xnrrJUqw3oYSgFdJcT+fZy1
	 58wrYHn4B+xKTW+qffbw1Q0NV2ArRgZkiVl6VQ/qI0eeLiyVY10fvubj5r72JmRNge
	 LVMEJ1qvvetRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CC2363A54A32;
	Sat, 13 Jun 2026 22:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmgenet: Use weighted round-robin TX DMA
 arbitration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138800539.1605072.16594394661463915072.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 22:00:05 +0000
References: <20260610085238.56300-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260610085238.56300-1-ovidiu.panait.rb@renesas.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299061-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ovidiu.panait.rb@renesas.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5CFE67FD7A

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 08:52:38 +0000 you wrote:
> Under heavy network traffic, we observed sporadic TX queue timeouts on the
> Raspberry Pi 4. The timeouts can be reproduced by stress testing the TX
> path with multiple concurrent iperf UDP streams:
> 
>     iperf3 -c <ip> -u -b0 -P16 -t60
>     NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 2044 ms
>     NETDEV WATCHDOG: CPU: 3: transmit queue 0 timed out 2004 ms
> 
> [...]

Here is the summary with links:
  - [net] net: bcmgenet: Use weighted round-robin TX DMA arbitration
    https://git.kernel.org/netdev/net/c/fd615abd5311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



