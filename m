Return-Path: <netdev+bounces-274640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKgKLF2qzmkgpQYAu9opvQ
	(envelope-from <netdev+bounces-274640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:41:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BED2F38CA49
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59C0A3047C74
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1B23F8DF7;
	Thu,  2 Apr 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi4PE4by"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792B3F8DE9;
	Thu,  2 Apr 2026 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151534; cv=none; b=Neel+TaYQKeZBPSSse+PC/C66/IK1VE/vYIY9gX6yRSvQapG+ikcRPhO1uchY4dHS2yv3jFIBf9629lio7bVmHfGqgyr5/1yXWIPFCL+nXYXLn4an1OtP39Eea8xqynpofFYwZO8LKPDOrDO0EmIS9BNc93uKdwAlcPZr5Xz4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151534; c=relaxed/simple;
	bh=Lv4jjICV5OIN5clesTvp/4eXe6/e8324H84NVWHd/Cw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LAixTVr/OF5Q0LcZ3esKES7NAZZUAFGp47LWNfUcGaaaTBCbgfDZ1+Au9S19ifukWMAISzkEGzSmazEraTSrN4NQoo0Jjq/9oIcCW84C1hEEmQzx+TKMJrka5uK4BH8QtSXsrd6qSotL6sAJSZMjBiKVLp6/iESVdC8eRv0HEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi4PE4by; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1AAC116C6;
	Thu,  2 Apr 2026 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151533;
	bh=Lv4jjICV5OIN5clesTvp/4eXe6/e8324H84NVWHd/Cw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mi4PE4byQNf+NUFkIzoA4zteW2dqRUmcuOFURrcxLYJz6oFFw8OEnWD/mOTek2/39
	 7W4zyySJgPfJ0IBm4/ALiqdArny0mJWOpv5Gaiem/n35oha1z8zOjEcHuOWghH+y43
	 KRtqgsRDwtDrXtXUVGpZsT7AhWW6sPVeg4hhLzHUScoeRzXA95S9WU37UV7ZGgfZ/7
	 SItMxsLYwoeUG7zX2exv7lpW7dOxjCGFuFxWBadJu1ie8JeAUfK2Cwy4rW0zDto/gk
	 zMODlMeeJb+Q1MTz8C1JB9wIoVn9GSGzNzZhEHINjy2azK+WlXTN9Wyiu1dts3YsmI
	 x3fUsaZmcgCow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EF83809A08;
	Thu,  2 Apr 2026 17:38:37 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260402162522.666383-1-kuba@kernel.org>
References: <20260402162522.666383-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260402162522.666383-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc7
X-PR-Tracked-Commit-Id: ec7067e661193403a7a00980bda8612db5954142
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8f5627a8aeab15183eef8930bf75ba88a51622f
Message-Id: <177515151548.547608.7766954108602800491.pr-tracker-bot@kernel.org>
Date: Thu, 02 Apr 2026 17:38:35 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274640-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BED2F38CA49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Thu,  2 Apr 2026 09:25:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8f5627a8aeab15183eef8930bf75ba88a51622f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

