Return-Path: <netdev+bounces-295320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nHaSIjGjIWq4KQEAu9opvQ
	(envelope-from <netdev+bounces-295320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:09:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14356641B52
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:09:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CDhvtm92;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295320-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295320-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2979C30D37ED
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F98C43D50D;
	Thu,  4 Jun 2026 16:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F5421F10;
	Thu,  4 Jun 2026 16:00:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588829; cv=none; b=NbDFGm+E9bqDAZDI4MxsnyvCELdN3petbPWLSZgmpkRvUeATNjLDRJfUu9LmB2WYuFe3olUXJseCNy+W3nSeW7ViXCXXLIsrdiU7yWKFKnTKZ6wHoxakzAfmQW5ZuQnACVX4UyJF9CSGeNFcjkiW5MRzJnwLqQyKzo/FBkmELUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588829; c=relaxed/simple;
	bh=9fu5TCX1JMHyQbNhPkxmp6mA7guwydc4zcI/EDAY4YI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LL5cmJPmtkn+wCKn7gGEgo084YfjZLGC2pfqFU0N30xu+M/M4DfBcD+3zRDs4uzFUsmgWDICqVs+cJ6MEoMndiD16r0q2B+DKHuXhgVcmr/X1Y5/O3bnqv5DSQBwLpFF7IJMmMoQFcD1YFQZSWA77OTRCFTUuDXjk4LaYqsl0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDhvtm92; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390B91F00893;
	Thu,  4 Jun 2026 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588828;
	bh=4h7AD9uWV6717BlUSSiXM3fiDJit+ieznbxH6ru2vFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CDhvtm92gc2NaudALeR4z7+RWxY+M0bBcXpYzvlGhG0R8nQh1BvYVAEeapQWphXad
	 ldiNySsDkcYgLZqLuQDqpLQll6vWa1zNfCTKBVVjuNJCBGeZkZxELAFkUTT/NxUKyK
	 NqxoHIVQUTpSlY9pv6fZG3368zSdLAq8rVS7lDNt4DjbE0gY/kuFbT/frwYc18ToIR
	 iAuVrsFoDKaJ83Dp1JjsUI2wM0l71rvqvlqwuEZwDaUeGpBlJXxh90gOeMbGavMUAd
	 lAvFr45laQqM8fND2E7eFlMbAe4W/a2IXB9kaJPTTs6bASM7Q5koYa0oigYfD+Kiox
	 crZMByFTTgYFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD039309B7;
	Thu,  4 Jun 2026 16:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rtase: Reset TX subqueue when clearing TX ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058882889.2493857.5736779387535763141.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:00:28 +0000
References: <20260602114659.12335-1-justinlai0215@realtek.com>
In-Reply-To: <20260602114659.12335-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, horms@kernel.org,
 pkshih@realtek.com, larry.chiu@realtek.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295320-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:justinlai0215@realtek.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:horms@kernel.org,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14356641B52

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Jun 2026 19:46:59 +0800 you wrote:
> rtase_tx_clear() clears the TX ring and resets the ring indexes.
> However, the TX queue state and BQL accounting are not reset at
> the same time.
> 
> This may leave __QUEUE_STATE_STACK_XOFF asserted after
> rtase_sw_reset(), preventing new TX packets from being scheduled.
> 
> [...]

Here is the summary with links:
  - [net,v2] rtase: Reset TX subqueue when clearing TX ring
    https://git.kernel.org/netdev/net/c/ab1ecaabe74b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



