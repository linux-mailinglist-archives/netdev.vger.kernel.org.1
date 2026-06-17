Return-Path: <netdev+bounces-300076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aUXEJuFdMmp/zAUAu9opvQ
	(envelope-from <netdev+bounces-300076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:42:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0464A697A19
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:42:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Hbce7lz/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300076-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300076-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F22C73072749
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C283B83FC;
	Wed, 17 Jun 2026 08:41:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734123932F1;
	Wed, 17 Jun 2026 08:41:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685675; cv=none; b=QYeLsx2rAteSBiGn95uUx30qMfYkJDr1mLCp5ZGq7TdgAfm4pyL9VonlUx0GFEalQCGdItdWQo6VXZHj4k+40EIl7O4NZN8OPbyUViqPXBRbE5FoYI4NgK9xnPM7wux1jawHde4fWN65eguFt+CEpzac/lSycC56RPTGBGC8OVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685675; c=relaxed/simple;
	bh=LL/XLpMG+01tduNwhUY7wmu9os4kKuO/zowbSfjldmU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LDA70Wb62MEVsh9wkM9Lnfvs2pgq9LGLBwFhGIfvR7QFur/jWC92wLFjZYXyJk8wBku7TiRZYwJ2xtEVYREFwlu+uuauW3xSsHFKbXn4wtrKi6am4POWNFCTQiQ1McqdSIMUqOABSq2pIdi4TRa2gfb+0ZitOTZkuWHGRwpQnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbce7lz/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565A51F00ADE;
	Wed, 17 Jun 2026 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781685672;
	bh=Ae7w3pTdt6QnuNDYgrbPQEQVF1x8C6o8Z2i7PaslWVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Hbce7lz/4MCNfHfyqMPcXVvirWaO0LXDvMNxz1Iq1V57Uf3ZOSiMV3bMCX+Xz3UtY
	 yQV7kMYvSarUhFRVzlDSZb7KysTwA21z9XywvOMTQhYpLncp9cWnL1fUxIggSK+UXS
	 UOVQKpW4JWNtxBSz1gDgWPE9yZR+n88CazMgldcJgt1ZV22GqUix6yRTdKXiecgyz9
	 fZ3J0dmLQ3g7MTEhHSaUXFaeSX0WT6UY+v9w5uIkXXCvhRstuqzHLy19mTJZJuiL0p
	 74v4OPR1ZjikYRWFkh6/3N7Z++kJ2+/LdZVOjteVzjI6lLOv4qlKBt9ws+0qvHU/gI
	 Lj7M4J1Xhj2JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BED123930DCB;
	Wed, 17 Jun 2026 08:41:07 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260617000705.931602-1-kuba@kernel.org>
References: <20260617000705.931602-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260617000705.931602-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.2
X-PR-Tracked-Commit-Id: d954a67a7dfa58b7a9b3194322d321b940eb60c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b85966adbf5de0668a815c6e3527f87e0c387fb4
Message-Id: <178168566654.1433416.18155324279935635597.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 08:41:06 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300076-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:torvalds@linux-foundation.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0464A697A19

The pull request you sent on Tue, 16 Jun 2026 17:07:05 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b85966adbf5de0668a815c6e3527f87e0c387fb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

