Return-Path: <netdev+bounces-281035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBXmK2y362kJQgAAu9opvQ
	(envelope-from <netdev+bounces-281035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 20:33:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A0A46276C
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 20:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F4543004061
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D33F0AA7;
	Fri, 24 Apr 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbzdVqjZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392423E8C70;
	Fri, 24 Apr 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055584; cv=none; b=HF/5Hn1sfbMoB34tujcB6uwQ6G9zB+2k4wKSfGIKy9t7jmS7B/bMSatECU0EyH6PXU+wBB3ug626y1vgUVbnIAkPZ/2XGacmZ26Kf1/+/pnx68kCoK4slQawAE/Tejked4oXcsDbnUgwxqsroPVfJaHP8jOG9xLU7BlLsDSLLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055584; c=relaxed/simple;
	bh=1RY6xTLCQIlYQWFEWI0JsJnlcICY/pbYu4T3FNl+wBc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b/pr2CZqbrleO4UnQhM8EDkFXW1TRqXaZ+NuC05q95VnVZL+3pJ5LzLeQQFqEPmajRouqpu/2elEOB2n3ABnab+GDMPMhBKtlip3HcRWpqhEWwLWrDpDEh8Do//g3tLlla+Dh+up7Qcc7QLEKQGS/Jex7Hp8Jrb3qr8nGkZupnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbzdVqjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18891C19425;
	Fri, 24 Apr 2026 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777055584;
	bh=1RY6xTLCQIlYQWFEWI0JsJnlcICY/pbYu4T3FNl+wBc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bbzdVqjZFvbFqYKX52U2ig+SfSYf7THYiGwC4GqWXiIlhKfL++y9ZU1QyEAmsNpy0
	 ffK/XXE00xO2Atc3mozEs+5MHcHmKrtH8wQilM6rg2U28Hz9N9jZW3fvlI4fps9PMy
	 PzHTEuTpC9hnb7kFIOEa3j075otpIWIfcBReh3a3LQudvtmq8SRzWILxx8U2M4vQum
	 Gb5KIw0EDfZiFQ9SN5dedmy1x3tFrUWU9rf/5idmxkky8b+t02YGc5UYGrIXBJlNrA
	 tDez7Czq0ApPCPNWRaEOAMrR8VoahvWXUBQsoIkuB+xcOG7zQ+cZqxC6t994UTf4W8
	 gCG5ssOCmr7oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA17538119C3;
	Fri, 24 Apr 2026 18:32:25 +0000 (UTC)
Subject: Re: [GIT PULL] Networking deletions for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260423235422.1541768-1-kuba@kernel.org>
References: <20260423235422.1541768-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260423235422.1541768-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-deletions
X-PR-Tracked-Commit-Id: 0c22ed0fadcad620277a56c0ba2867d4850d053a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64edfa65062dc4509ba75978116b2f6d392346f5
Message-Id: <177705554440.1656274.3849780963665058916.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 18:32:24 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B3A0A46276C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-281035-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org]

The pull request you sent on Thu, 23 Apr 2026 16:54:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-deletions

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64edfa65062dc4509ba75978116b2f6d392346f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

