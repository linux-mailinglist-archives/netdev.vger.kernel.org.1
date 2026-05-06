Return-Path: <netdev+bounces-284629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MnA2GiSO+mkaPwMAu9opvQ
	(envelope-from <netdev+bounces-284629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:41:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BD24D4FB7
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1198301BF54
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC291F4180;
	Wed,  6 May 2026 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeGUQFXg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8351C5F27;
	Wed,  6 May 2026 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028064; cv=none; b=bWvQdcqhfpKNw+kOJ4fbUY4saHj6byQU2otgwgglCZiNxJk3qKuq/swPnElAtJgW9hjL7aRat2cG4QpOh9ACgpv0+AFib/jJrwS2cpXLh9LFMaaCNJhJy1jpw1BXx8vn9Gr6t96/KOTt2E1kYza+ljWewI9J7+XmDLDZMfq9w+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028064; c=relaxed/simple;
	bh=ADQUPChSquq4ZEatB10qmnFWwwZD0BplaIlJ0ZktwGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F2ZVXim5GyceLJsEVZQoqpVVqHXdJMKgAdjYEON1lvPqvDIIvokUivxd/2/JKpu2li7Cf5LUYkt0kKKK/7+WjFi3z2KMJQwOClcAVupcMISMiXdKGW6GtR/4bhitPIkL02oOjpQPR3+V+qz+bVLoFsmX7tWI9NgECreodb3oONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeGUQFXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983ECC2BCB4;
	Wed,  6 May 2026 00:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778028063;
	bh=ADQUPChSquq4ZEatB10qmnFWwwZD0BplaIlJ0ZktwGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JeGUQFXgZdrgsYbykSFI1Fk/BU8vLNhHNn/uQ1yt7Ijfk+Vk6HGErCtoRYUbW42Bo
	 5iYXL/lD0RSX9LiH+mypt6zHGzwTwTWRvuLuuokpCcRjnJ4Mjbkhbzt0js5p6xj0Rt
	 8GyxC7WM+RbOnrbhUp3HjwBwp5JPWWyFv4desbTHIb2he/mazwHS8a23Pm7JWvRcpY
	 V1ttRtfztKE6HPQBFifNhhjDsnvjslDkyGWGVXyLinVQqocZ8F4JP0/AKTT5Aj3BqI
	 TGWF+sS53OndBVtEtY6qiB4oD9DoIWkN7s0EFRWqnTODg1YU88xiCqiWCFHguhDnDG
	 srksRqtrHFzLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE13930780;
	Wed,  6 May 2026 00:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ipv6: default IPV6_SIT to m
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177802801380.2324972.11209982605677016387.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 00:40:13 +0000
References: <20260503192515.290900-2-hi@alyssa.is>
In-Reply-To: <20260503192515.290900-2-hi@alyssa.is>
To: Alyssa Ross <hi@alyssa.is>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, fmancera@suse.de, rbm@suse.com, krzk@kernel.org
X-Rspamd-Queue-Id: B7BD24D4FB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284629-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  3 May 2026 21:25:16 +0200 you wrote:
> This basically defaulted to m until recently, since IPV6 defaulted to
> m.  Since IPV6 was changed to a boolean with a default of y, IPV6_SIT
> started defaulting to built-in as well.  This results in a surprise
> sit0 device by default for defconfig (and defconfig-derived config)
> users at boot.  For me, this broke an (admittedly non-robust) script.
> Preserve the behaviour of most configs by avoiding building this
> module, that's probably overall seldom used compared to IPv6 as a
> whole, into the kernel.
> 
> [...]

Here is the summary with links:
  - [v2] ipv6: default IPV6_SIT to m
    https://git.kernel.org/netdev/net/c/901a7d9e2f28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



