Return-Path: <netdev+bounces-298383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qFcNEVY3K2qx4QMAu9opvQ
	(envelope-from <netdev+bounces-298383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:31:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF9675A47
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:31:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="aqH0s6/b";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298383-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298383-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC6FC33C8171
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE5A3FCB29;
	Thu, 11 Jun 2026 22:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7253D0923
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 22:30:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217021; cv=none; b=ktIyZsZIL9Oia8b0/ZMS+g7N5r+dh9I5f6RJ7+cDyIAMMGpthm7hQcDeDgXeNegRnmkOGPJjvJKD0yq1fcOgUmqaTZJk3dvlgeL3dLH6VULUDoonwbKVlWrkp42DhF2y8qWUy5C/iIczlqNhq6MGYfKNHsMbw0dgKl9xUdcMSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217021; c=relaxed/simple;
	bh=XMEg4+lZXxcFxnzojGgmBnM3VpNyILxZwzg5fj/joe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=niI/b8pGgfb4YZoS3+8wtzIRZn5mOhDWknk0ojncGBWios7NIfOOXKWY3VEnjllPufYSDmu/0lRLNXkwV9o47tjKEEmc5BIEZTd3QofMgr3dSs1Kf2nYBfGjNYw6iybvfXDqpgLUwerioHbaFNyVDHu/lJWVT3IsVkhuRi331YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqH0s6/b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA321F000E9;
	Thu, 11 Jun 2026 22:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781217020;
	bh=pmqnXvm8j0YctDYPkvzzb82KQ0eCgHXq/TbwLAAVzKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aqH0s6/bcyXhvkeSgjgRhGqsmktA9L0W3HhcJtOYKpyypGlno6UoFikgoKe+D7TsL
	 srBHlzK88+mYymWy4/ICthL6k2irkGaumNHM9D8dB2IYpjo60kkPghZl+gq6Ep40hp
	 CirbYjkOCfuwxDPazVRGf9IP8mIVEg0FMHjnkb8GREA9nx7JCO0rjrboBhCvJmjKDY
	 IN55/yjVZTKhqu02T5i4GepGt6vIVJ+9ua/VxsXh1skovk1HdXxdtKxkMaub+yaEmF
	 pGXLPE45Iy0v0qJIalwsPo440JA2jjaswiW4+SzAPtIPGyTBC5PqcoaJtNrLW2U6Pe
	 SQ4exRQ6ILnVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939023930FAD;
	Thu, 11 Jun 2026 22:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/2] net: fib: Fix two use-after-free in drivers
 during
 RCU dump.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121701713.389578.16845185284597284885.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:30:17 +0000
References: <20260610061744.2030996-1-kuniyu@google.com>
In-Reply-To: <20260610061744.2030996-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 amcohen@nvidia.com, jiri@resnulli.us, kuni1840@gmail.com,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298383-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:amcohen@nvidia.com,m:jiri@resnulli.us,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89AF9675A47

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 06:17:17 +0000 you wrote:
> syzbot reported fib_info UAF in netdevsim, and the same bug
> exists in rocker and mlxsw.
> 
> Patch 1 fixes it, and Patch 2 fixes the same type of bug of
> fib_rule.
> 
> 
> [...]

Here is the summary with links:
  - [v1,net,1/2] ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().
    https://git.kernel.org/netdev/net/c/06b693d2eb66
  - [v1,net,2/2] net: fib_rules: Don't dump dying fib_rule in fib_rules_dump().
    https://git.kernel.org/netdev/net/c/2821e85c058f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



