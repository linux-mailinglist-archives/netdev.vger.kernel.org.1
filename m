Return-Path: <netdev+bounces-282945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O1AJPyF82kY4wEAu9opvQ
	(envelope-from <netdev+bounces-282945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 142DF4A5DE9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D093A30B0A37
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFEC472790;
	Thu, 30 Apr 2026 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFYeKtsS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF846AF21;
	Thu, 30 Apr 2026 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566861; cv=none; b=UH0DJhxoWbllLlLqbsAUf1wjM2NWrE2vfJ1aVtWBD6C2diqL/HfREPSFw39Y3RVkbHA51+iaKEt0dR7rILAENu8rbNFCdAcHvVsLPXo7xtKCC0N1KqQws5roTDxC3QoKY3vozJEaa4snDzCu2anqZLv7dMx00dC6Hy1z4mIgl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566861; c=relaxed/simple;
	bh=nNqgTaUlWlPegEyRdd94ifG+Z0XCSCC5Tit/V6GBwjY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dfb/YaRpvbXCtdWdJJxBGltg/GFEhjdXa+0Qp+GedCUVBobncZ1smHReJpUmGxfle0WwqQCPiiHJURh5p719icrpjrGyaSikEGZIcWVRMLB1q4Z6QI+9XJ4taCIJPca+BcCZlOSpwkE7CpE9p3j1OKxLw8yVUwEURFAy9VE9prA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFYeKtsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCDCC2BCB3;
	Thu, 30 Apr 2026 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566861;
	bh=nNqgTaUlWlPegEyRdd94ifG+Z0XCSCC5Tit/V6GBwjY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cFYeKtsSLfGuu+bH5B3mVs5LUWcIrnBc8q4dx1AKmUhwU9/p1KxmArOPfv9dF0u1V
	 5cpLfra5tBPrh8GenSxBTy4vIZvXxfA1A1jU2YYO1z4QwGYodpldknZ6i7XPim0ukx
	 /WhyacxE239aEDa3R681Nspa9JNmrXntmGuC55oSXINskt0d10AFc8f+xp4OQEowG/
	 TahpdPcOqkb/yFErmHMGnipqRxJS0ouSMqV5CdQJclCCgYA1mbymKIHbXgbAJBdjyO
	 WuUmyB9kB1St1haZyc4gYKPFrs6Fz4rLARuApNZIlvJCQZJ5FBVVW21hLHZLhlwbnV
	 xde1nSJ+WpHTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02ED3380AA61;
	Thu, 30 Apr 2026 16:33:37 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260430135922.238723-1-pabeni@redhat.com>
References: <20260430135922.238723-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260430135922.238723-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc2
X-PR-Tracked-Commit-Id: 1e01abec856593e02cd69fd95b784c10dd46880c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08d0d3466664000ba0670e0ef0d447f23459e0d4
Message-Id: <177756681570.3088538.1905720201998839141.pr-tracker-bot@kernel.org>
Date: Thu, 30 Apr 2026 16:33:35 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 142DF4A5DE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282945-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The pull request you sent on Thu, 30 Apr 2026 15:59:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08d0d3466664000ba0670e0ef0d447f23459e0d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

