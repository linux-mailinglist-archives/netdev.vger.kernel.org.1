Return-Path: <netdev+bounces-281613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCWqAQMj8GlhOwEAu9opvQ
	(envelope-from <netdev+bounces-281613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:01:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A847CF97
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E85F30465FC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992582EA498;
	Tue, 28 Apr 2026 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvX5UeKy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A202DC791;
	Tue, 28 Apr 2026 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345251; cv=none; b=onZRWaG7UBUSELmmyCZog7UTIjjaJb05taxNy0mce258+GLXpjvKxKJaMd1j4gEkAsXFmsFvMrRvKJagl4lSoKwpOlSIIHt2B6LtZ6MK/jtqZK6g63ry4ZC2cxVozYS17aZIQItnOPask2B2yuqa2YOPeIYY+gqNlEg28WBF4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345251; c=relaxed/simple;
	bh=LjnhZsugMmN25Iy/w6hgc06WQdN47df7qkY2yDxWt7k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AHSiMb/k9HEoSKnA5KD/DB3M2MuhMfnUZb6zKW27CjPiUeTwBmH2MFxUIvx18v9pDbguHD1GIINNSAy3RSZYd8HZxRaMp4HJM52T/lutAPjZuD5TeKmbZtB9s4Rnwbm1qi11Ej7a2qG0op+cuJ/TQoVDEYiWzZ2GmmD8TtOX4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvX5UeKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15707C19425;
	Tue, 28 Apr 2026 03:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777345251;
	bh=LjnhZsugMmN25Iy/w6hgc06WQdN47df7qkY2yDxWt7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jvX5UeKy0xg2C++4T5sZ/jjsClcIah//74nXi3su8sYmQizIY2U9T408zd73ZVvLj
	 3tZc/X/yO8MIUTuIc/GA3lWkxMNI3fi5YtDVWH6YkD+doHoQebK37w3FPyO12sMTOc
	 Oe2dnA22/aKu9FBpAQ0zHcqsyY3FECm5BRAj0h0lwRGnVMYQvVb2vSFv9YU7xLF3TW
	 cCF5KeFp/ZIASbfTP238CoPGzrWxUF19r4M1bnGWLvTnKArmYDBeZ77GOpdr5vDQ8Y
	 IqeSAkPyzu+mRjhQuuSV+izDRm/ALA1zqSk/cy09gtONQBcYq3f6Ftgn61IEDMt+65
	 sF5quOWoebGxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE20392FFDD;
	Tue, 28 Apr 2026 03:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tcp: make probe0 timer handle expired user timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177734520829.218500.17064507281464227634.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 03:00:08 +0000
References: <20260424014639.54110-1-ahacigu.linux@gmail.com>
In-Reply-To: <20260424014639.54110-1-ahacigu.linux@gmail.com>
To: Altan Hacigumus <ahacigu.linux@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 enchen@paloaltonetworks.com
X-Rspamd-Queue-Id: 6F1A847CF97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281613-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 18:46:38 -0700 you wrote:
> tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffies
> using subtraction with an unsigned lvalue.  If elapsed probing time
> exceeds the configured TCP_USER_TIMEOUT, the underflow yields a large
> value.
> 
> This ends up re-arming the probe timer for a full backoff interval
> instead of expiring immediately, delaying connection teardown beyond
> the configured timeout.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: make probe0 timer handle expired user timeout
    https://git.kernel.org/netdev/net/c/2b9f6f7065d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



