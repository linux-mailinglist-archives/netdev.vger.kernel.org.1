Return-Path: <netdev+bounces-288040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAaVAqj7BWrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD9544DFD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9563097790
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFC034404E;
	Thu, 14 May 2026 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1/6awxy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B3342526;
	Thu, 14 May 2026 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776865; cv=none; b=hCpu+Z5ES0m5RCCaf4kW0Dfl9g4tooVu0/xAGdcpU3QzH4cHhfe9IcS1/uw58irOnclWqLpp+ABQtBGYhZwJxJJxVx+/4iLwCqS4MhyTmEPqlOl1dzZvC/glfR+TNb+qOqnRSWQoPqRhF4sQYdcHd45c41JqSvbwYftL2akz4Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776865; c=relaxed/simple;
	bh=s7EK2qH9tQujFv8ab+D4IlhAXvQIX4vF0Ty7WnVJ2vw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BKyMKXNHeyY3Au65agDtuh//ZJsh/pGlYGRgmO05LZW0/4nLOWn4B6nSTXNuAw1I92VUQ1cautSTJlTnuUuD7gkPet5T8sgp/3jqiyMyE7stoV4reltvHQnZHVEGmEn/pYMgQwmss8GebwzLrURFzVle8PBAUUfXFS8xx9pmbv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1/6awxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7984FC2BCB7;
	Thu, 14 May 2026 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778776865;
	bh=s7EK2qH9tQujFv8ab+D4IlhAXvQIX4vF0Ty7WnVJ2vw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S1/6awxy8B680bAcGlLokpczu1N6w7kIhNXWZQC1MuEMa/dw64ZEYPqAyJ4UVGdQT
	 Ms4ZJiKa4urrPSvsXnQz5Hc+JbAV7fFXZO4FQ9GaKa94SVCk1mZkBl1MaGsOHgjHuF
	 g3MjdqClxrEe/Rd+KMQY+1XQHh7JQOLyN9OH3ZnDUWhAvdvizAsS+YgkRDSRRCvVDe
	 RwISNCQvSmZlexwYhC8No/rysHkYj3t2lfAK2ALYLm2MuJkYsYuCwDjKjInmJqh71C
	 m+nIvFpDRsPtfA0r5r+UcYn5g80+zlDgb0Lfq8A2wIoQztBt7vA/z0VgH/D4qzLb77
	 6QqHDB8DGbLog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE1139D6578;
	Thu, 14 May 2026 16:40:11 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.1-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260514142703.267609-1-pabeni@redhat.com>
References: <20260514142703.267609-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260514142703.267609-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc4
X-PR-Tracked-Commit-Id: c78bdba7b9666020c0832150a4fc4c0aebc7c6ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66182ca873a4e87b3496eca79d57f86b76d7f52d
Message-Id: <177877681011.7753.4185449644545215098.pr-tracker-bot@kernel.org>
Date: Thu, 14 May 2026 16:40:10 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 57FD9544DFD
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
	TAGGED_FROM(0.00)[bounces-288040-lists,netdev=lfdr.de];
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
X-Rspamd-Action: no action

The pull request you sent on Thu, 14 May 2026 16:27:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66182ca873a4e87b3496eca79d57f86b76d7f52d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

