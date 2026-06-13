Return-Path: <netdev+bounces-298851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JGILOxSsLGqMVAQAu9opvQ
	(envelope-from <netdev+bounces-298851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:02:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C30C67D61E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:02:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GW+e6JFD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298851-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298851-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07DC2318FB1F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56528263C8F;
	Sat, 13 Jun 2026 01:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0D235358
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312431; cv=none; b=lLAwmgn1xwMHc2fvU7HUW1glkbHIbhArwUShR39AERoXv+Xl95XyifkcCiIinxJpROTZh7ySLDeu2yijifosGZPhwUvGoeZcxiy5GyrjYnlFUr6rPhgJLPhQC8uli/JWMSD72pNy5/+Xzt0jRxugKhe/CIYRsc5xEdVqSuIK49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312431; c=relaxed/simple;
	bh=VS9gNT48kkCZn83FIUmr6ptx+dAIDUC/fBgMULP5P4c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ckHwscD8hNAJN8/2XLC/x6TY2/ueIGJKUwNd2YcyODdZ6MZv/UyHw017j7ahy8zVlgMoF1usAk3bjnXAinEKu3Bb53V8F/W3a4BTmOcMOWWnW5ChfIhd15XlBqziZOSzvDDqnLzJ8DuKj1xrEDzBt9HjR+hxpZQyr3RR4lR6vdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW+e6JFD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9C71F000E9;
	Sat, 13 Jun 2026 01:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781312429;
	bh=XX0ymFozsWtkXJ6F0GcscFBPe5VJmQoAGErXK/cl6Ow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GW+e6JFD3njoxkxL1dY/ZT49krH9limp2s4eeJeOBEazgY6CqgDq9PCpdWJC6fEe6
	 fGMvyq0rkGgVlOhMyBZw6FWJI0kzF54oMzxPqXFPY+lRRFwKnHmX5hgD00eiCID22m
	 zzofDfqVZ8fxUTtQ6S8iDYL9nSF9Trr+5pdKQBdpAgQcMt7SY+lRjiivfgyriuwt8z
	 99TIYTLg5uJAFJnyOIOtv9JGJlXuCUVeCpoLxuUEWCbRTYyaNUs4EflcE1wMrt6C/D
	 SqUgIZGzilodkZ/sB8Az1NyV1E7R1T34NWV39p3L2zbAhiSwAdIV9zse7pwJDzRSkj
	 bCp8fLCwJm+Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398339E9607;
	Sat, 13 Jun 2026 01:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] ipv6: Honor oif when choosing nexthop for
 locally generated traffic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131242613.1315131.18235073740348361443.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:00:26 +0000
References: <20260611154605.992528-1-idosch@nvidia.com>
In-Reply-To: <20260611154605.992528-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 willemb@google.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298851-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dsahern@kernel.org,m:horms@kernel.org,m:willemb@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C30C67D61E

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 18:46:02 +0300 you wrote:
> Patch #1 is a preparation patch following the comment from Sashiko on
> v2. See details in the commit message.
> 
> Patch #2 aligns IPv6 with IPv4 and changes IPv6 route lookup to prefer a
> nexthop whose nexthop device matches the specified oif.
> 
> Patch #3 adds a selftest.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] ipv6: Select best matching nexthop object in fib6_table_lookup()
    https://git.kernel.org/netdev/net-next/c/484bb9d164df
  - [net-next,v3,2/3] ipv6: Honor oif when choosing nexthop for locally generated traffic
    https://git.kernel.org/netdev/net-next/c/d25e7e9d8a6c
  - [net-next,v3,3/3] selftests: fib_tests: Add test cases for route lookup with oif
    https://git.kernel.org/netdev/net-next/c/707c1f866c68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



