Return-Path: <netdev+bounces-283342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIK0IYRY9WleKgIAu9opvQ
	(envelope-from <netdev+bounces-283342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 03:51:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD97A4B099E
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 03:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD2E43013D56
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E621255F57;
	Sat,  2 May 2026 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA/dsr8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B7175A6B;
	Sat,  2 May 2026 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777686656; cv=none; b=G84prbTM3El+yBA3TL9vEZP6uUE9hY0+RGLon2oQGeuux6PrY2dpA62704s1XOmpunuRcpJ1vBKbyUcTn4XVfB9lo7Qm24LZNDb9gsjQFMJdQdnzTWsLPc6kIOwTfzh/PhAKmKRcJ3MZUuKgNO6VwNv17tSdlYcfMEUv9rj3Ux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777686656; c=relaxed/simple;
	bh=xm2+9jsabpvycDbTrdE8sTP19ubMRurd4/NRQqS0ABw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fd7qxwi8pNDFiqbyWwrdss8f4Hp4MuKC10jQsP4fs4Rdw9PGnazJ6BLSh5qTWcfYVSRu7MqWR7Qnfibl3ofd+UM6Tl6TafuZyP+WkRBRRW9XguTFG+u1I6ywpODmQ8U/n9esOnyPJMLFH37unJI+poMn8voqt19uwQRibU8DsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA/dsr8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D58C2BCB4;
	Sat,  2 May 2026 01:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777686656;
	bh=xm2+9jsabpvycDbTrdE8sTP19ubMRurd4/NRQqS0ABw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OA/dsr8nwUCSnL2t9FNbtfb0FgIyKzAz9Jjs0tRAAo/49kxWuMKiYWZgDUsWPkZzN
	 bwf8PxeuC83NHE63GETX6uPv+n0gMdOgiIzY3iiW8S/Ob7ALhmaKfGKZjd8RVcbDLu
	 4EqFhL9qPVELVSiTCVWzbqq2wk1GmudUaa/tGTN8NP3BifLNDk/DT8H66OZBe3Tva/
	 cXNl608ten+VFdm3Fx50X0BjfZtGNra/P90D6ME+FzfC6gKDL9QOI/uHeNySp+y1df
	 WwnezShtEB2WV6hez2VtAxiqVY+PCJUvYhkG5+NwscClLi1DggizNov7HgQ0czg22N
	 glLvnkoNdv1zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC49380CEF5;
	Sat,  2 May 2026 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] ipv6: fix ECMP route failover on carrier loss
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768660905.3689119.5102123801449238514.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 01:50:09 +0000
References: <20260430200909.527827-1-sharmasagarika@google.com>
In-Reply-To: <20260430200909.527827-1-sharmasagarika@google.com>
To: Sagarika Sharma <sharmasagarika@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: DD97A4B099E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-283342-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 20:08:59 +0000 you wrote:
> This patchset resolves an issue where established IPv6 connections are
> unable to transition to alternative ECMP nexthops upon carrier loss.
> 
> Unlike IPv4, the IPv6 routing subsystem does not actively invalidate
> cached destinations during a NETDEV_CHANGE event. Sockets persist
> with dead routes, leading to stalled traffic or connection drops.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] ipv6: update route serial number on NETDEV_CHANGE
    https://git.kernel.org/netdev/net/c/4bc852006b62
  - [net,v2,2/2] selftest: net: Add test for TCP flow failover with ECMP routes.
    https://git.kernel.org/netdev/net/c/d1ae37dc6881

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



