Return-Path: <netdev+bounces-261521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOPpBCmMoGkCkwQAu9opvQ
	(envelope-from <netdev+bounces-261521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:08:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331B1AD49B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACCE1315D819
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688E355F4B;
	Thu, 26 Feb 2026 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFfTsZTR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D1355F43;
	Thu, 26 Feb 2026 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128420; cv=none; b=j5ioHDgVfmXtMDZlc0mVqnSe0p0/0nejVsJN6DRoZaXavKqhdAsIhb0a2Pin+24NPPfvjGPjGDrDpBnsygJLpZ6y4/+/c54SPMJFJhlScVmwwFtfY53KbxIQOgQyUGaJ9oBjrUYSJ/Xhu7rdKUlV/g6w1HiK9It+vRoxJH9lAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128420; c=relaxed/simple;
	bh=Xd+5YKu839LfJvfx00zvQchEU5HBqB1+xnhUcdfU01Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LTLsm4ZWDrEVJ6FvshVoy7qmwpwKmsCkzh+qkC7DLLQwuTOSbb4GYVwKk2HpqG45DrmnYYLAbqMr5iyiL8F/ja0LoXFKkeh6hlozKIcwhCXg1+icePgIn7/GkUqTvU/UNVcRXBrmVF50gy9EQHyfpBEWdkWvqAhTbECZlahKxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFfTsZTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EABDC2BC86;
	Thu, 26 Feb 2026 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772128420;
	bh=Xd+5YKu839LfJvfx00zvQchEU5HBqB1+xnhUcdfU01Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AFfTsZTRyDrBxsYMIWepYEynjuCJgv1FW/4HqAmzVVjOxDhtXHw2iALMMqhBnXyO0
	 rVJ36y0gadGqqhmD1jOEs7jWm9sRKdoC/u9f8F2Ocs/DA0AnZqvE2+BMbJgyDtu2UV
	 tFyDNm7v+JfsAmPibtOYhBq10oWwXHH91qCZCITb4ccPPlQHgrKN+FSfMN3OwEyPi2
	 ytq08rYUmU78ec+QWJexOEMI2Zim8yXZgK0Bjw/9QHx1oZyQV9vyg+pXPo+2slYC6s
	 YNk8oEhqV6KH+3fVJnzvHvUbXV92n1ENTKjGzDhG2Y7mtcrpM93E8nuscZ/TrhUFna
	 flf7j0MnT9iPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030EF393093E;
	Thu, 26 Feb 2026 17:53:46 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260226151529.259438-1-pabeni@redhat.com>
References: <20260226151529.259438-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260226151529.259438-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc2
X-PR-Tracked-Commit-Id: baed0d9ba91d4f390da12d5039128ee897253d60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9c8fc2caea6ff7e45c6942de8fee53515c66b34
Message-Id: <177212842450.1769138.14012357854011263431.pr-tracker-bot@kernel.org>
Date: Thu, 26 Feb 2026 17:53:44 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261521-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7331B1AD49B
X-Rspamd-Action: no action

The pull request you sent on Thu, 26 Feb 2026 16:15:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9c8fc2caea6ff7e45c6942de8fee53515c66b34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

