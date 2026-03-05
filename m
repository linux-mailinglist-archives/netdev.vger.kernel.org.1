Return-Path: <netdev+bounces-264521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLLhCNDcqWm4GgEAu9opvQ
	(envelope-from <netdev+bounces-264521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 20:43:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B63B0217ADA
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 20:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49ADB301E98A
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9D22571DA;
	Thu,  5 Mar 2026 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHbNt0A0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6083BA24F;
	Thu,  5 Mar 2026 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739788; cv=none; b=suvp7p9gg+v0pMU5SNKz8OTR+wvrxBjj7yNoDt3q+vUz8aTBUZU7nbt5U1D1IdLVVDyMTMvckZiiCcKHE4t94eQ855NomGTC++pZeCYo4NO1EhRIYkA0oYibxQRGXtVXRlDhT1UMRWSwFnrvfj+SbPtkFuFv4t2mwLWpbG473Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739788; c=relaxed/simple;
	bh=xaxI9wXyhK2uB0sI28ov4lSZimgICF4vdaoKi1ZfTjw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JRPVVnEr89ASoqJQXUL5PnMYUwnugXgc18awR9mJJxuVMcr8hErBQ2xzy039xVm8Zrx4z1z4opZ7x6Mfma6HE9ZcWHKDq7aE8yzYO+27gEvnE/akDlxVxx5OTFLKl2sDb70mC2FWhQAVn2RoTgQFLKy7fNBoMrU1f7+4H4Sgkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHbNt0A0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE2C116C6;
	Thu,  5 Mar 2026 19:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772739788;
	bh=xaxI9wXyhK2uB0sI28ov4lSZimgICF4vdaoKi1ZfTjw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gHbNt0A0ZvH3jMfkQHNFvR8SE8IlJn1XbDZP6UgfRbTXzoFsdC8vIqfHtV/e0nY7C
	 AGETwjy7QMNHjaCiKllHaxeH0x17XdV1fZi9v/5FTN2L15VUe8aI60cf2aEP8wjPKW
	 Ryu335Bt8mDlbYu+DwmhD+AT4upqKg7KGgOPplcqvJ2vdwAnzuOlTFA+yJL6ELvHiq
	 j+Pi93vW7n35xaJIOqqGcjk7Zakcs0IJzSCyd+GKo6hCtBtKfqRUwDxL40zcGhu4gf
	 /I25l5ext8/uQrf0KVssFa0VtgwNuZiBRX368P0z1jyrLKlr2CHy1A0DjqGq1SlmJW
	 W8bVprDwvQLwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4003B3808200;
	Thu,  5 Mar 2026 19:43:09 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260305171004.322683-1-kuba@kernel.org>
References: <20260305171004.322683-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260305171004.322683-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc3
X-PR-Tracked-Commit-Id: cf440e5b40649d1ffbc6c4e33fef3223c7482897
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abacaf559950eec0d99d37ff6b92049409af5943
Message-Id: <177273978772.3262774.812824881655316861.pr-tracker-bot@kernel.org>
Date: Thu, 05 Mar 2026 19:43:07 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B63B0217ADA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264521-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The pull request you sent on Thu,  5 Mar 2026 09:10:04 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abacaf559950eec0d99d37ff6b92049409af5943

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

