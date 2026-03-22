Return-Path: <netdev+bounces-270318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNm0DfsgwGkOEAQAu9opvQ
	(envelope-from <netdev+bounces-270318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 18:03:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9021E2EA1BA
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 18:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 113E1300A384
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F82F30B53F;
	Sun, 22 Mar 2026 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9SLQssR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61A1B78F3
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199032; cv=none; b=TgOPTo9AGaDbEn+KvWLnYqW8MnB4nMdPCY5zTG9lluLr5tNktB+J/rq2AmWrGETAKLOq3QpRN7/LZsdsmCDLeippSiTcsWnS3JlN/EYXJj6KlYtZO+9wUpdTvNhIWLTulIh5rkPom4GQqfmFyuZKTGmCjlTjWoON0kBo3XbvqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199032; c=relaxed/simple;
	bh=ZJtDWF5fTrJf70UH91Lb9W/VgidUdUCsqMJqFqEjLT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZCMLtDP86uJgZRo6p/zqdrunlH3lwf1Jd5b/QCixnGWAwXEPpjvXqDLqNHdFGsx4OVJvUAZF16FXYLaasJ7HULEMBs2WzKExif2O/bhnIjN+l8JAReMc1dOApgr0E1d1KykV9kUv/3kXarYI2ENGkaTepAhMcXYK6K+9mIUStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9SLQssR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859D2C19424;
	Sun, 22 Mar 2026 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774199031;
	bh=ZJtDWF5fTrJf70UH91Lb9W/VgidUdUCsqMJqFqEjLT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y9SLQssRO8LpIG7cgfTRssC8u7I71i3T5lFV65De0YhTBqA6mYhSZcTQx/FtrMhDQ
	 iv0XkqdvpGvYJdcN8UA09ADb+PX109/NFBwS5tJb/jEUNRgSIcFrtAlddXQiYEBKc0
	 yelcoNMf1NYszMly8vG961TOLA90XD7RMkNh2rW7qO9FGHXCKPnzxqxeBBSyGv5p2U
	 HHZTiFugE42Rl2V8bj89ZGSdA4WipE41UmgGomKvS4a3qoekGLE93W0teAovqsCnzp
	 8KhoocBT6jC5h5XbSpCHrlTclRwYYQ8hPQLHYD484ctnn7GuAOOzMAI0Tf4pGDVb8t
	 gOKSD7Pd/T4kw==
Message-ID: <cff10cf8-77dc-40b9-8030-25ee5ca24fc3@kernel.org>
Date: Sun, 22 Mar 2026 11:03:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net 3/3] selftest: net: Add GC test for temporary
 routes with exceptions.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260320072317.2561779-1-kuniyu@google.com>
 <20260320072317.2561779-4-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260320072317.2561779-4-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270318-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9021E2EA1BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 1:23 AM, Kuniyuki Iwashima wrote:
> Without the prior commit, IPv6 GC cannot track exceptions tied
> to permanent routes if they were originally added as temporary
> routes.
> 
> Let's add a test case for the issue.
> 
>   1. Add temporary routes
>   2. Create exceptions for the temporary routes
>   3. Promote the routes to permanent routes
>   4. Check if GC can find and purge the exceptions
> 
> A few notes:
> 
>   + At step 4, unlike other test cases, we cannot wait for
>     $GC_WAIT_TIME.  While the exceptions are always iterable via
>     netlink (since it traverses the entire fib tree instead of
>     tb6_gc_hlist), rt6_nh_dump_exceptions() skips expired entries.
> 
>     If we waited for the expiration time, we would be unable to
>     distinguish whether the exceptions were truly purged by GC or
>     just hidden due to being expired.
> 
>   + For the same reason, at step 2, we use ICMPv6 redirect message
>     instead of Packet Too Big message.  This is because MTU exceptions
>     always have RTF_EXPIRES, and rt6_age_examine_exception() does not
>     respect the period specified by net.ipv6.route.flush=1.
> 
>   + We add a neighbour entry for the redirect target with NTF_ROUTER.
>     Without this, the exceptions would be removed at step 3 when the
>     fib6_may_remove_gc_list() is called.
> 
> Without the fix, the exceptions remain even after GC is triggered
> by sysctl -wq net.ipv6.route.flush=1.
> 
>   FAIL: Expected 0 routes, got 5
>       TEST: ipv6 route garbage collection (promote to permanent routes)   [FAIL]
> 
> With the fix, GC purges the exceptions properly.
> 
>       TEST: ipv6 route garbage collection (promote to permanent routes)   [ OK ]
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 61 ++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



