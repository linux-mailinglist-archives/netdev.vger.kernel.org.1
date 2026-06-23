Return-Path: <netdev+bounces-301494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vIrDOcj/OmpgOAgAu9opvQ
	(envelope-from <netdev+bounces-301494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4AB6BA4ED
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:51:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=catHd3nG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301494-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301494-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E08030512B0
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832243B6C0A;
	Tue, 23 Jun 2026 21:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA83B1EF2
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 21:50:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251427; cv=none; b=A8up/MHytPOHRSWpASMto0VfjdH90zs29ryYzvGtUHADuwoEnfE9gTmg6JIounDDdZ9u2hsUddJbHGlTb6Gl/f82XwDaUrNjh+nDiqI/51+0phtULj9Dtb2TamPNcA0tKGo+VXTCFBTuu50kzo9V5ZH9R4qRESVAWpfzvprCVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251427; c=relaxed/simple;
	bh=npSfEjlpqzjgo38wldhgXCTvwEfDvuUydJIQYo7rab0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OzCI0Xc0bTXUzaJiW9RwpeMEQnP/SzTIBGo+I3LoHM9weGavkyKLJueWKZC6QZfOGaFfG8VCNxwuX9LePIedreMo9XDdQBF0f3C+PHofqi+1jgRVorhVvTzQXqcx843OEKORRld07hQ359FL2Og2qvts8+JQGFhDk1pLWBIMF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=catHd3nG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E891F000E9;
	Tue, 23 Jun 2026 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782251426;
	bh=ggRTL6oZ5lbaOF9NGGG0bE9/K8OX87/xneGSMvldiWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=catHd3nGN2CbXSZXI+ABwTpHkSRawhucIplCLDKwGtoSETnAGa64QDT+IBXbUbTqL
	 GkTcQV1yvDV5Ot/3rdmCkNEQFkZME4L0r2+B6Kt+3tWXedd7oOGOMtk8KMV8DuQhYJ
	 8vDUNVYleL6p15AvwePm0/eosARHz19WrLOuvMSUWQbbuiV1Q0YCeh+MXULvrAdXml
	 9InbIsqhlo837QAIPVZuABuF4po8yIgDCHt5p744tr9dGVUbTpB2MpVseUrJq4+0Gk
	 7gPIhOfMgFG9VO9T7VCiRJCcEMp/3GFYRTfQai+rsVk6c3ovf3dy6Cof/eOFzmxFWG
	 d71u9Vb17MDMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08AA393101D;
	Tue, 23 Jun 2026 21:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: do not acquire dev->tx_global_lock in
 netdev_watchdog_up()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178225141531.2433118.17068127211611515028.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 21:50:15 +0000
References: <20260622110108.69541-1-edumazet@google.com>
In-Reply-To: <20260622110108.69541-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, m.szyprowski@samsung.com
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,samsung.com];
	TAGGED_FROM(0.00)[bounces-301494-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:m.szyprowski@samsung.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C4AB6BA4ED

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 11:01:08 +0000 you wrote:
> Marek Szyprowski reported a deadlock during system resume when virtio_net
> driver is used.
> 
> The deadlock occurs because netif_device_attach() is called while holding
> dev->tx_global_lock (via netif_tx_lock_bh() in virtnet_restore_up()).
> netif_device_attach() calls __netdev_watchdog_up(), which now also tries
> to acquire dev->tx_global_lock to synchronize with dev_watchdog().
> 
> [...]

Here is the summary with links:
  - [net] net: do not acquire dev->tx_global_lock in netdev_watchdog_up()
    https://git.kernel.org/netdev/net/c/d09a78a2a469

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



