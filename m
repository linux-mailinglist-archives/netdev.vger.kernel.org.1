Return-Path: <netdev+bounces-295437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7/CDMY/5IWrIRAEAu9opvQ
	(envelope-from <netdev+bounces-295437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:17:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7B643C3B
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:17:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eTZHiFHk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295437-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295437-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 137653048DCA
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4F30D41A;
	Thu,  4 Jun 2026 22:11:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351B31D366;
	Thu,  4 Jun 2026 22:11:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611111; cv=none; b=kgNHa2J9icZE53WD+OHt2kealAoiUptv9mXgFfF2ccWo5i5t7C9kmMN8IwvWNZHOwh3T76UPXJIS2eaDTx8hQaKqVyBvN+/vykKfMyRDyI9+JKEUBYUs/RKciZAJENJJD6LozPu+gAoZJooFXv96nYGI0gsjqxfB+9qb+E9KGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611111; c=relaxed/simple;
	bh=tqnlzggUeP+DeqCuU6PMcOwk1UKbT+3RhEFmlE+FSPk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r2nXLsuBmrJhjKNReL3vSDjMZy4izwqYLwN6iBbdpBFb3J4jAKWa6lSU2c3cdiFIbp+yd5Ko/RcI+6UhHzhB6YTiRzNbtPod/EglpFyLMfGv6jaJrey8qVH+qfT9//1rFgs3q2GQ2QbXRlPLhX4XXNlw/Dr8tq52DIdXmP7md9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTZHiFHk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BDD1F00893;
	Thu,  4 Jun 2026 22:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780611110;
	bh=S0LrZZRScugOJWF+OWiPG6bj2BfIJIAsTtEDJXX7ryg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=eTZHiFHkyTXgoDUSOtNEVGa0o/bz/G5FGL0Xjhe6TzeL6voWeDya2V2Xk+MUTDp4E
	 2lVn2XxaxROancEWPNDVYfvbubRx8IcbMNXDKXJw60sNlTcOxqy1WMvUAK6kDo9aHz
	 sib5qKnTaK4bgVZXwQatSSxvdwXarftFUwcKCVO/COD48zkXtUH9UtLt0l5hxl6a8e
	 NJyYYfUS064Ff5Tc7p5LvDlciVrDH45zp2Vey5khR2pQBEB+iV+6Wf+Gk9/99nkDCh
	 1lhbPwCfMVEbzOogMgh/ok2vIID91pyP/SAu+O8kn6+OGuioMYOwYiS2mrQ1RT60cb
	 cq78HlIwCi+JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C133930A31;
	Thu,  4 Jun 2026 22:11:52 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.1-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260604173137.3434910-1-kuba@kernel.org>
References: <20260604173137.3434910-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260604173137.3434910-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc7
X-PR-Tracked-Commit-Id: b6197b386677ae5268d4702e23849d9ad53051ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
Message-Id: <178061111129.3043969.9400012738673082977.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jun 2026 22:11:51 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295437-lists,netdev=lfdr.de];
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
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EA7B643C3B

The pull request you sent on Thu,  4 Jun 2026 10:31:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddd664bbff63e09e7a7f9acae9c43605d4cf185f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

