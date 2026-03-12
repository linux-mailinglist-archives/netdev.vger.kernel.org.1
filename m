Return-Path: <netdev+bounces-267193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DzINMcXs2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:45:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BFA278434
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A163016EE0
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A023ED13E;
	Thu, 12 Mar 2026 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOvwOXgA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455753C660A;
	Thu, 12 Mar 2026 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344689; cv=none; b=DBhuE7+dEwhzj6QgPDpAiCNFM043tqz/QCxRrhMNOC3QDa8ea4Z0lwydxFwREtDLpkbt3BzTYtqHknf8U7VCaO1XjoSO7zYSJv7tQFRBLgsKbZ7mPZqgFmaUHhwr4fgp+ajI7oOTF2vQX2aIvq6X0qv4oz39A7brK954IiTyAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344689; c=relaxed/simple;
	bh=HbgJLOEQ0oV93hkQkjDhJIesRiYk6RqPcmdVKW1FEUw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lN6wi95L5iVmfYbMgEq1mPAio0AIngbQVToNH0YAGS3YIdx1KLH/c/Fv2QcESg1m3xEAjYaAN49JLbD7PRM6Z+LFUfU3GxNc0G5RjgNIORppxMbw+CudXwEmVzAqVbVTIDp8pRw+JjjGwIj3EtwHcdkcdHY9MOQrGeD3WED1DUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOvwOXgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B97C19425;
	Thu, 12 Mar 2026 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773344689;
	bh=HbgJLOEQ0oV93hkQkjDhJIesRiYk6RqPcmdVKW1FEUw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lOvwOXgA00A8/9TDa41Qv/xbYmgHOcwSW3NeH/flXmjo49Lfl4LwTffNCTnC6vZJH
	 6SFRyZpBJ1H7aUqhUO83VSKV6BCdM73Xwnc5wzW9f0sCph64BOmra/zzxdfeQhr6Fd
	 BfaeTOIKAJ5fGZW1qPWyq1PDu44seN9kMepZbCJiW1UkXet11PzZdxrPyqNErUrtbE
	 LnNz+vKEuxrTP1cNVbj4tgjwVAJPNOrZlEAYNHhAxlDCtsOdhS3OgfnRo/L8V3LjF6
	 MYNyUql1yS/HTcjsTWgHdUDEYI/240o8gF3FawEmPQdy+PvtOgtfFtOZOMrwM925KN
	 krY0N2L8fYypg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F793808200;
	Thu, 12 Mar 2026 19:44:45 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260312151934.271993-1-pabeni@redhat.com>
References: <20260312151934.271993-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260312151934.271993-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc4
X-PR-Tracked-Commit-Id: c38b8f5f791ecce13ab77e2257f8fd2444ba80f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c7e63d702f6c4209c5af833308e7fcbc7d4ab17
Message-Id: <177334468421.523191.9794640527948284929.pr-tracker-bot@kernel.org>
Date: Thu, 12 Mar 2026 19:44:44 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267193-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38BFA278434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Thu, 12 Mar 2026 16:19:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c7e63d702f6c4209c5af833308e7fcbc7d4ab17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

