Return-Path: <netdev+bounces-305321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a4AvIuO4TGrRogEAu9opvQ
	(envelope-from <netdev+bounces-305321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:29:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 758467191BB
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:29:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mtmp+VVK;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305321-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305321-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BA0A301DB19
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF7530E828;
	Tue,  7 Jul 2026 08:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B32EC09B
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 08:20:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412427; cv=none; b=qLNGboRykji+KWYYEzYcMERhP4Dz/1asQZSHVfLoWVhG5snHYE21No+Wrk7n/SvbeMhgqd5Ko6xrcjZW1UXg56KQKkGKJs48BAGGMU4tDe8ogNId3goKAJhmCeILPZP/cnCIQN3AD6Fvkz2gmK4SyzQ6wUjNBxSybA2Px+97DIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412427; c=relaxed/simple;
	bh=Mv7hIGu0qh0YiqTgC7s7RNgpqHPK+a9PpbFXMHXX1qQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G3+T6pbSIuiGtoIghb0ffrMi+ToXlFLthUPJm4LmCByi8Zr3WuTaU2nK2Hy5ltoLQcCXkADpG2pPJTHU48wUtXev5cvk5aKdLEkwUaIo799yod6mRuxq6w2w+hK7ipGxQTXMLbepJ7a5ZNEM66meScFWIbjFavjqHL30Z2KYvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtmp+VVK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185BF1F000E9;
	Tue,  7 Jul 2026 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412426;
	bh=xXOAg0FpVCCICt02wq+bSUxL2DGd/Xe7kyDrvZ0/i2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mtmp+VVKGlG+tQCQ7GEhlx7heYpkwEdcwHY+76SRs1y1DhIwtxJgI1bgFiHqjL6vM
	 GqDUJGoaPKe6i+uvH5V7OZMv7gRTQ3j3f9uKA30nUvNpeZ0n02+WreoNeonKfsOdaI
	 yLC5bpqHIUzs76Hlrr4+jM/8wYNSdw5jwZAtY69caNXol+gPZYeaf4ftEg6EOA4av3
	 BMPWQ4mOpMdIY3rBZ4HspAB453vq6u4iDYKZi8NU9AFHrY211pkpFMYMebeRfwMqv8
	 ArNrdtCvTkk5zvNDbBaM5cAaldu1aTwt/UoKdLiw1PWwfCdrfWOmwWh9Eacg+QtA3q
	 8tARtq6PNiDOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A81392545F;
	Tue,  7 Jul 2026 08:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/tls: Consume empty data records in
 tls_sw_read_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341240614.1419868.13885768597307476374.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 08:20:06 +0000
References: <20260630191551.875664-1-cel@kernel.org>
In-Reply-To: <20260630191551.875664-1-cel@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305321-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 758467191BB

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 15:15:51 -0400 you wrote:
> A peer may send a zero-length TLS application_data record; TLS 1.3
> explicitly permits these as a traffic-analysis countermeasure (RFC
> 8446, Section 5.1). After decryption such a record has full_len ==
> 0. tls_sw_read_sock() hands it to the read_actor, which has no
> payload to consume and returns zero. The loop treats a zero return
> as backpressure (used <= 0), requeues the skb at the head of
> rx_list, and stops. rx_list is serviced head-first on the next
> call, so the empty record is dequeued, fails the same way, and is
> requeued again; every later record on the connection is blocked
> behind it.
> 
> [...]

Here is the summary with links:
  - [net] net/tls: Consume empty data records in tls_sw_read_sock()
    https://git.kernel.org/netdev/net/c/3be28e2c9cd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



