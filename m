Return-Path: <netdev+bounces-304228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h9wGBEWQRmqWYgsAu9opvQ
	(envelope-from <netdev+bounces-304228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 18:22:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E04DD6FA1D5
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 18:22:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ecE+V5xA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304228-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304228-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8268A30954A9
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67E0340412;
	Thu,  2 Jul 2026 16:07:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C663403E0;
	Thu,  2 Jul 2026 16:07:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008466; cv=none; b=IPkfHB+LINW84eCoPGT1a3x/czE9AjwI2wf+idCKPw58UzYNw9axsTyOe+8wjQIcnEvFAb46ZS/PVu4CEnPSODzuqffPjKHsYkJ48GuigWu1iO1gdjOhrSjSqnVuzku9fNzy6aigXoqh+Clq0MPSBUF6e4kE5WrOSHfA6Kan75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008466; c=relaxed/simple;
	bh=aCMZrfedDCy2ZiBPvr7bFgfFPfLN66OpswmbceIhilA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RDc1QYYtFHSzuVAr7MHBFEgJCNJh+lmY0w3m9Bu76If99sY+gPgg9969AHrhKnOMPHeRVr7aitp/wxvc1jCB1UIQW5qVH82WYbIi4QSJBxECc00KxcxwRmHAWgK6+Nfz+D79J1P65tz4MLYdx1ood7RSJ6+JbLhvjR/wn+a8728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecE+V5xA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E811F000E9;
	Thu,  2 Jul 2026 16:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008465;
	bh=bxRbsHh7DGrBnH/elhn8IT7S7zGFOJNmergori34DvA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ecE+V5xAD3ya91rHi7O6jiAUZ2g5sp2hgTp7F2GGs8h6lfgnSh9+QlaSko4dnIQFR
	 BkPrFv6crSEcpjNn+ESJkChbFCziZTUpBke24yV01WUTVn1cfk98csABkDoUtGbtYY
	 +7+Isx2Ow94PfuS27uxMdIS2chhwuH5+JjHWXuEXkMtxEUDLYbTqXJi9cV2+m57FrT
	 PPnFGnd4A9uV0sNqi9cKFBCsJh7tVc0TtSj5YseiJgDwhaqlpclkgv7HsD6WbKaOOe
	 PabmldopXMMkJQx4FzrTXWP1LQJy2cGvD0P1F65uwwDcDumys5cbhi64CjTwBcsRmn
	 GWrH2YTvF8XKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C123930934;
	Thu,  2 Jul 2026 16:07:29 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.2-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260702125444.230438-1-pabeni@redhat.com>
References: <20260702125444.230438-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260702125444.230438-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc2
X-PR-Tracked-Commit-Id: d8e8b85a85fe21954d303db68034aac4639df88d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87320be9f0d24fce67631b7eef919f0b79c3e45c
Message-Id: <178300844841.1754005.17953259672059371615.pr-tracker-bot@kernel.org>
Date: Thu, 02 Jul 2026 16:07:28 +0000
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:torvalds@linux-foundation.org,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304228-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E04DD6FA1D5

The pull request you sent on Thu,  2 Jul 2026 14:54:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87320be9f0d24fce67631b7eef919f0b79c3e45c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

