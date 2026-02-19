Return-Path: <netdev+bounces-259570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JzdKjNdl2mIxQIAu9opvQ
	(envelope-from <netdev+bounces-259570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:57:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB978161D26
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9882A301CFA1
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D382DB79E;
	Thu, 19 Feb 2026 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0jXjHlG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B12D0C79;
	Thu, 19 Feb 2026 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527449; cv=none; b=S9X4+5SmJTf2dC8kTtiJ6dY9XsbEQ85vnhRR9TgmF00ZjK9J0z7mjtxBqu0BfSepuxudgzfe7adO9ICKxltUuq1oWh6t0yoo9K1PH9xFfkke9wOwd7E3CFDtXAPGH85o/F1Ga+EiAD8ATx7PIZYSjwOe7BPTOL0C5LQLbf+145g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527449; c=relaxed/simple;
	bh=OhzmKhI8TY3uz34nQOO0vwRdL2B9PO1rN56n5yF5E08=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Vf/TPeqqmbF7+GDrQ92jZO8c2JcQ2KrY4fenGjeT99sG5wtRhRDsxc4/kZQXB1FVVecQ8i+QRPLhIWy6vwVoPvshfBcG+8G3pPzg5hFaKfE3Wcq9orRSd7XqdkuymdKqnO56SXytI8S9EjAsNOYYS/XDtT6JpNgOZz/iKiSEQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0jXjHlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03B9C4CEF7;
	Thu, 19 Feb 2026 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771527448;
	bh=OhzmKhI8TY3uz34nQOO0vwRdL2B9PO1rN56n5yF5E08=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B0jXjHlGEefEAEl6bgCuPFwKUwju6G8UHaT83OozLKnxoiZFlW0bQWXKK6ASaA+Cf
	 jfLKDKat7ELM0CFyLxvqMeJF/d/9fa+/Sjvs3B5ZeP/SjiO7qqT96Dv6NBbe7btMQ0
	 x7EqjUyVupMe+zuh3SQZUfJ4rF5cr1sF3vs17qSpzVHgKOeZqO/y6UWbFW+La79RSR
	 81dIwGxM64vcTPGV+UaOBPpJzuvB/YdXXeisMLRLDB6z6Z9GiJbmNvSkCUXyCUSaVe
	 8L2tsIWvZTp4I2dXVZRE7W0FN9GBjqw637HaRNXomQyFA4oHSjB+hBJt3c2uOqJJGl
	 lwm/cCNP3D1Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3983809A85;
	Thu, 19 Feb 2026 18:57:38 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260219182301.660280-1-kuba@kernel.org>
References: <20260219182301.660280-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260219182301.660280-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc1
X-PR-Tracked-Commit-Id: 571dcbeb8e635182bb825ae758399831805693c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
Message-Id: <177152745726.17614.8751117702981280588.pr-tracker-bot@kernel.org>
Date: Thu, 19 Feb 2026 18:57:37 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259570-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB978161D26
X-Rspamd-Action: no action

The pull request you sent on Thu, 19 Feb 2026 10:23:01 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bf22c33e7a172fbc72464f4cc484d23a6b412ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

