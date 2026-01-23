Return-Path: <netdev+bounces-252629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAptEovucmkxrQAAu9opvQ
	(envelope-from <netdev+bounces-252629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:44:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A2D702BA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 388903021D1C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B77737F0EB;
	Fri, 23 Jan 2026 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvlpxBBq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287133F38C;
	Fri, 23 Jan 2026 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769139832; cv=none; b=AN2m2WQmxFs81jTghAP67veNieRHvVWS0CPSZBX8usl6B8MlYqrwhSoySj/r87nmC6I3cU2GTJaKIe0ytpNCuCV2zTb1y98os+qx9sDtg+sAx9AP25vC1O5Fx3P7FzMq8ktK4UVI1H64gFq5/rGOY/LRxTj9G1aNGMmDOUs2gDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769139832; c=relaxed/simple;
	bh=eeX1BPETurOKxiea+lm84+RmzW9ljWpsKxxh9YWwq28=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MbGw+x2nDgiXBkd3Fjd1pdF28wFaVKNQExNqhJApUNyjxaUVDgILN2fbuowAZ1HntNKKvtiZqIw+sJDYaGn4C9FIm8MSsp667OOR9ik+wxEmAxoDu2KlhfLC8+xEaF3HBLsWvuvZx3s86i6+dPWddTtEARaoDpmcF3eyueuhpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvlpxBBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D1FC19421;
	Fri, 23 Jan 2026 03:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769139831;
	bh=eeX1BPETurOKxiea+lm84+RmzW9ljWpsKxxh9YWwq28=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uvlpxBBq1OagRFq+Pff5xOQfxQzl4VfbUE78hjs1jw/INWOQijrlJjtWnkcgJefoh
	 bpW0wPtOL4n7dyjhmk5znyJ5Xmh2k01Tz4haIkC4C3fgeyownfG/Ef8fHlSxs+5lK0
	 BuG2inU6CnjE5ZDKfKHviu0cAlNhuFeA6/4kvu2n/C+yUOYJI5oHknD2IiC7t+292j
	 oySy0e0ydTiobG7oi6gi0LFoKxYq2SztMRML6KgvRMNYzzeXB35dbbPMiZ+FwHWki7
	 pcdk4nsHvOz5v0Kg5m62GkwqTrSyraY5Bam/ymdgms/fY7OJnLhxbDGp4nzaHXDSxY
	 x3Xc6SOyPmGBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CA1263808200;
	Fri, 23 Jan 2026 03:43:48 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260122170016.3148026-1-kuba@kernel.org>
References: <20260122170016.3148026-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260122170016.3148026-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc7
X-PR-Tracked-Commit-Id: 4a3dba48188208e4f66822800e042686784d29d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a80e38d0fe1fe7b59c1e93ad908c4148a15926a
Message-Id: <176913982749.2385556.5703159874103942237.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 03:43:47 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252629-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72A2D702BA
X-Rspamd-Action: no action

The pull request you sent on Thu, 22 Jan 2026 09:00:16 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a80e38d0fe1fe7b59c1e93ad908c4148a15926a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

