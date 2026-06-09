Return-Path: <netdev+bounces-296807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zNIFMhdiJ2phvgIAu9opvQ
	(envelope-from <netdev+bounces-296807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:45:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF0965B6A1
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:45:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bGOTp6JT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296807-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296807-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2226B3033D22
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAC9244661;
	Tue,  9 Jun 2026 00:40:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FD2561A2;
	Tue,  9 Jun 2026 00:40:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965608; cv=none; b=ii+hlSIEe7LrFEv7hZnOIscfIjSQ4I/h/SMoKL8Nw8xZnna6Hfx+yjdYt4Mo5jN6khb10NqZSUH2xLgcjsdIKCDG2xWkEJ89Nzf1/OQCdr9MpGZX7AxYqxki+yYwC5BkkRO9RlY6OTq1UICAutBf4MuxZEZQu6uOViUgiN/yhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965608; c=relaxed/simple;
	bh=QSRs5ey3scnhPEYDrBMhUdL6pX20fFZyrmoax2Zueaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BYpdoqhszQAPZOZqnfOPRGK4Wjgx7Rj+Qn6/nMG/kwv/sYS1Okig3Ud/JxDNRr+1qsLPwWcP+FudEEUOzQAmGhpUsSGwaclLG/s7oSJPI/KcfryzHkmQUWqy99Iq9oqXT0PUH2vTHit2RZLIBkAW+zshxpCwvSZfFEnYXWWPsb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGOTp6JT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9DC1F00893;
	Tue,  9 Jun 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965607;
	bh=L0E62KG2D/UnObTTSUX++yeF1ySfAiqIAWobLmG4PyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bGOTp6JTJ0uYkkBUy7te3lhAuFtElQaFLW3DgomiOTmgyZkrOdMrlxEHZ+v0vJO0i
	 7KX9fDmagErf/3BetEMdMz234k9uX2pwssbboBVfowLsjWmsjfKDk1X/AXFgNsQ7nD
	 J3QkoEZmUgFJmg8s/MRS/wrvUukcpm+WGobd0olaV5sLXREIDCD3Uh+sG4TAua3MWb
	 dI+OsqzpvduCDC69Lfkfur5s8lIGTKjKdv+CrDaug2/5NnrgH1wy21ZOrbeT5Cc7Ol
	 g4IkJXv/nIuLTtcGN31IkHrvnc8se+Q323b+ezpeWFBIVhBv+5QdDiln6ODHV2cP7R
	 VtBZ9H3xe1wWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A963812FDA;
	Tue,  9 Jun 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phonet: free phonet_device after RCU grace
 period
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096560558.1730160.3024997824207919729.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:40:05 +0000
References: <20260604000843.4028467-1-santosh.kalluri129@gmail.com>
In-Reply-To: <20260604000843.4028467-1-santosh.kalluri129@gmail.com>
To: Santosh Kalluri <santosh.kalluri129@gmail.com>
Cc: netdev@vger.kernel.org, courmisch@gmail.com, remi@remlab.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296807-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,remlab.net,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:santosh.kalluri129@gmail.com,m:netdev@vger.kernel.org,m:courmisch@gmail.com,m:remi@remlab.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:santoshkalluri129@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BF0965B6A1

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 17:08:43 -0700 you wrote:
> phonet_device_destroy() removes a phonet_device from the per-net device
> list with list_del_rcu(), but frees it immediately. RCU readers walking
> the same list can still hold a pointer to the object after it has been
> removed, leading to a slab-use-after-free.
> 
> Use kfree_rcu(), matching the lifetime rule already used by
> phonet_address_del() for the same object type.
> 
> [...]

Here is the summary with links:
  - [net] net: phonet: free phonet_device after RCU grace period
    https://git.kernel.org/netdev/net/c/71de0177b28d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



