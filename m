Return-Path: <netdev+bounces-292027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKlkLkBCFmrnjwcAu9opvQ
	(envelope-from <netdev+bounces-292027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:00:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 290D65DE1BC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7DCF300DDDA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AD72EB874;
	Wed, 27 May 2026 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BynPil59"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB182236EE;
	Wed, 27 May 2026 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843607; cv=none; b=LNN52i+QiD0iQueOD4Rab/2PS8xnd94ZDmq6FLGWtK7xNSeOK3Tf0yD0r7FR6sXyiMgi9M6S9AUpV9cmoibHDDKmgtx9R8L9KC8YQtFNe0hpMw5GQ3ip+6HkH+bLno3+UeVwSWvveKgdMK9mtZjd2JkMzJHjZ4fA/IrcENVxFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843607; c=relaxed/simple;
	bh=IajCAsdWcUTnBYLAXYluK77tsdVlBnpWioIaHyv97Eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OOU/gGHQMWhSuf1P80WZTZWgoEPGEg0wsWF+fS8ULNLIMNa+572YFIYD9Zinb220O6P5BXAwzN/QW/WDMEfd/AavqAYZJWhyYiS8JWWsur36qB2ouk3uSncKdiuPeACJkpqa9/3zecFESc2IpwRnf729+pBZUJ/T8wq+C9piWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BynPil59; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6351F000E9;
	Wed, 27 May 2026 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779843605;
	bh=h8vYUU9HFAKEwBE4J/VFBVxNhPKej+gx8waEeLNwq/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BynPil59Q0WcSgGF9+uEotIynfgLB4/MJsRtF2iiunG6iZnLFs40UA5NV5AOWLvEN
	 3Joy5bsWRQZF+cUqI9HjmfR7A4UYgDjV7DakneTvjG8Oh1lKSkuMIIKZ9KyHkjPqVb
	 ZqlEslIhPVwi1FUXghbzlENAOR0AQo8LXMkmTK3+9ZJ+WprA1aCHlRB0GFCnTw4R/P
	 N8ZQJ0pLA5Qf8Nt+h412lUNgbJ/5oTgo1XOXVHbZZ8UdQorHHNDz0J81zdTXjv28xE
	 eTnW45NALhONHsUBuvivTc67JrmP+e6hsKfhuXzSJs38iBczSO3dMxdZIGx7QRnkeX
	 qUyjJpYQIv89g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C74380CEED;
	Wed, 27 May 2026 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2 net-next v5] ipv6: addrconf: fix temp address
 generation
 after prefix deprecation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984361139.4034294.5875665579147124672.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:00:11 +0000
References: <20260523103811.3790-1-fmancera@suse.de>
In-Reply-To: <20260523103811.3790-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 idosch@nvidia.com, dsahern@kernel.org, steelman@post.pl
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-292027-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 290D65DE1BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 May 2026 12:38:10 +0200 you wrote:
> When a router temporarily deprecates an IPv6 prefix (either by sending a
> Router Advertisement with Preferred Lifetime = 0 or by letting the
> lifetime expire) and later restores it, the kernel permanently loses its
> ability to generate temporary privacy addresses (RFC 8981) for that
> prefix.
> 
> This happens because the address worker attempts to generate a
> replacement temporary address when the current one nears expiration. As
> the base prefix is deprecated already, the generation fails after
> marking the temporary address as already having spawned a replacement
> (ifp->regen_count++).
> 
> [...]

Here is the summary with links:
  - [1/2,net-next,v5] ipv6: addrconf: fix temp address generation after prefix deprecation
    https://git.kernel.org/netdev/net-next/c/e20d8922aa8f
  - [2/2,net-next,v5] selftests: fib_tests: add temporary IPv6 address renewal test
    https://git.kernel.org/netdev/net-next/c/2b9cceb061d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



