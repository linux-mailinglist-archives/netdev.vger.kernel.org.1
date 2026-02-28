Return-Path: <netdev+bounces-262159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C1iF2ETo2lk9gQAu9opvQ
	(envelope-from <netdev+bounces-262159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:10:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5601C436A
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988FE30378B7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5E42D8DD9;
	Sat, 28 Feb 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWkl9Owz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75972D46A9
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295004; cv=none; b=FARo1fu5xCoRugK5Db+MfuRT0m6z8aSV/VJ25kanrzG5k7POlgBN0g6PTZ9zYuEFIdEFadugBv1bIBm3JyRV92rrh7jaagqeRF7nu10HwKM8VqcqYMFW8Eio+/hY2kQVV+ko7Poxl19wckYYYdoZbAc828gZXPoViWGwpcIpgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295004; c=relaxed/simple;
	bh=hHvZvdWkWX880UV7kEv5hR5XB7jB9JzD+gc5Df+8geQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NCcKaY9IlGf9lGbmrb6k/MsTKWZS+N2O7hzgVG6wIh2m34qNgRT4pxyAm6uKZH2pp8hVRS0Lb8xhv6tibct+6QrgVHZPwjtOJBvS03CpvGlxVec1fxNE5qCVf3bnTUF+DgdnSFP9tUMaW8CPtB4yfpNHNvz16RL25zIq7ZmxZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWkl9Owz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C66BC116D0;
	Sat, 28 Feb 2026 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772295004;
	bh=hHvZvdWkWX880UV7kEv5hR5XB7jB9JzD+gc5Df+8geQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AWkl9OwzUfqSQPfHikJ3fOR1ZVHINRLgaJFIOV5kvpWPnWRb+p2SQh4WcPm+MRNam
	 XFrFI8/1KSWz0ovlB6CQa+QVMqgexK5ytxXjfckfNEy4EGnhF6WGsKcEOnmZA3OHpQ
	 ZD5QC2NMNYqxfPD59JYgPnW1ijDsQEAbet36auNao2K3BU4evVf/Lj4MMaYysGlKCx
	 0lqADm2lFeKX280XRFKNc70SM/b18or+pNHu1bh9cRZJJyLZXc27fHx0e49WnEHX4c
	 cvycjk9SLt87VsjOyQxdd/nBLc7nbRqs6yAbPPcURN9ODK58E0vQO6Q5b148Spu5i/
	 k26Ized0gl6sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D1939F2021;
	Sat, 28 Feb 2026 16:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] udp: Unhash auto-bound connected sk from 4-tuple
 hash
 table when disconnected.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177229500780.3006106.13968115915300513036.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 16:10:07 +0000
References: <20260227035547.3321327-1-kuniyu@google.com>
In-Reply-To: <20260227035547.3321327-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 lulie@linux.alibaba.com, kuni1840@gmail.com, netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-262159-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D5601C436A
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Feb 2026 03:55:35 +0000 you wrote:
> Let's say we bind() an UDP socket to the wildcard address with a
> non-zero port, connect() it to an address, and disconnect it from
> the address.
> 
> bind() sets SOCK_BINDPORT_LOCK on sk->sk_userlocks (but not
> SOCK_BINDADDR_LOCK), and connect() calls udp_lib_hash4() to put
> the socket into the 4-tuple hash table.
> 
> [...]

Here is the summary with links:
  - [v2,net] udp: Unhash auto-bound connected sk from 4-tuple hash table when disconnected.
    https://git.kernel.org/netdev/net/c/6996a2d2d0a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



