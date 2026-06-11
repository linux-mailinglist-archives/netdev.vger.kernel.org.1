Return-Path: <netdev+bounces-298353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NrlzDJEhK2pQ3AMAu9opvQ
	(envelope-from <netdev+bounces-298353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:58:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B756567557E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:58:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O7f4WWFw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298353-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298353-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CABE30345FA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1754D98F1;
	Thu, 11 Jun 2026 20:58:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16F3A3E9C;
	Thu, 11 Jun 2026 20:58:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211527; cv=none; b=qR0dLh2ZfNdcOMbYZVPNKbGyzrZE7Bk4ZwFtLTPB2GY4pTUa24m5f0C0EmsQrqR3m8StOKL84XlPKiiGMkmuHFWyOvML+bQ+xMo2oC2c31PQx41RfFLZOfJ3qidXlFqpkFnO9mPCNjXpFYlAu2vd+xUzVRdIIrcV4JOnDn0Ubaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211527; c=relaxed/simple;
	bh=fnhbFUzJ15Ee6bbkZ1nE0abkGJD1TNnkQwErHQMLL/U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kjPfLPfuMCOV4u/1pePzQn+1cHchHERAKH5f2TYmz1FTeolIGlnUYQqqInaxz5BxstgrSQqOQ2gxgbgxqM5SuP2ULsHMO9QGOP7hwHqB4TidRgzfN7V6SxHkJwg4F+xYrHun11tdKvGBxwlbXVxpy+gwSyRPnceV8MkGjBT8oIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7f4WWFw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C761F00A3A;
	Thu, 11 Jun 2026 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781211526;
	bh=VMkDy5SSTKPyifWZCnQOZ95JdFVTYKesLeLPOaI5Kdo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=O7f4WWFwN2smPxrBLA5jdJlZiXznasFQcS+nQT/eU83qGvL1IifzSy23Rr3lDVH/U
	 n2eNAKf11WZmtodURWOVd2XSmEs1gOaSSz8m2tLjhgNo5XOFzV1n2N1ebLSkaY/T+a
	 +IEXSk3HY+CShMf2yyfBdQBXhFGKsQ2BtnYrEzpuQAkoOPocJ54t/1niSMA2eKUIKa
	 6Ry29yxWW4SBNCk+SSvm83RnO/eD/jwexP2c20UfQnk0HeczxGXuUzE3/e0AmTy+t/
	 H1MfsveR3IZf5t+aMSwofCWQ93Z86l7MVoSRo/mBdSDVbFPj+8gVJwJ9W5kt8LuZYc
	 og2C0tPcjAEUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD93930FAA;
	Thu, 11 Jun 2026 20:58:44 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.1-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260611133405.310703-1-pabeni@redhat.com>
References: <20260611133405.310703-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260611133405.310703-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc8
X-PR-Tracked-Commit-Id: 7360b96099806396f4ce15233f6dddcb69248d34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22e2036479cb77df6281ebbd376ae6c330774790
Message-Id: <178121152344.362744.17108091307200549626.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jun 2026 20:58:43 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:torvalds@linux-foundation.org,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298353-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B756567557E

The pull request you sent on Thu, 11 Jun 2026 15:34:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22e2036479cb77df6281ebbd376ae6c330774790

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

