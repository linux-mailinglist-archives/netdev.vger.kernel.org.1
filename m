Return-Path: <netdev+bounces-298275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mpJCEL/9KmoI0wMAu9opvQ
	(envelope-from <netdev+bounces-298275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:26:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBF867469D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:26:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y7jLtHv5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298275-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298275-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D0030B4234
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF10B4C6F08;
	Thu, 11 Jun 2026 18:25:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E044B8DD1
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:25:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202319; cv=none; b=WhG8ZRPdLnc1P7DhcYwy/R4gh0p+FooTJO0cqaI0cH8aJY2bQA1Ww9FY07gPMI5XiaNqiUUVB9Zo/0GTS5tW3PWi7xli6JrtcgdKgZgx4vpoq8pTnd/Vm/9As47KnkGhZgXECDNBfF7OOqhd7VhOVL7fMja+5/x/Veqfc4rnvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202319; c=relaxed/simple;
	bh=/I5L56M+ThUGewDgybdP9lm94FGY1yTk4FB3FuNiVVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXShwrCeGk1Pl41d5b8s/s7NnpR1Rys1n/ch2Bxor/sgBvfKDgpoLIyXNpLwxF5FWloJfL3/yN6QmPP3BdjJXtCCgO6QDvmWLX/gZAp7bopXlObNpavM6YJ7yLavcEu/nG79f8iiqXi62Lw7XxxSMfRmuE5rZu/e/Vw8HgOv5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7jLtHv5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569D81F000E9;
	Thu, 11 Jun 2026 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781202316;
	bh=k3hy0DVLmoWJQwzzinCNA8uuI1NZAO968ZijxLsQ0ZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y7jLtHv5iLFw2zGmzsvdOtpTFltbTptw0BJuviawKIF66ILH7OdVQ3ril0K0CoT1d
	 MpkH2CW5Suy3fOVkghmlM1APDx9Hb+LKie1WhoVm03lUWfuN/qEGXH0aR8O8Sfup6U
	 4D4jhY6P8Itfz9foUxkTaqVvhDL4+dUx//4CHiHpD0Jkzg7QAZl0DJtQJeNVoxKAJg
	 ad+T/Rf7Fndcxz8XIGPS4/ltoXmmc8YPsl1VibJxBOtcPbmf/NhveyE7slDvzBDPwM
	 wzckozJLHaLSzNeHYFQDLq31GCtUBmZNIEnTpMaj9k90pBbYsatOZ42HBbq4GpwOPL
	 rQJ3a1ccvR3mg==
Message-ID: <ee1f0858-5976-48fa-9101-41f036b9166e@kernel.org>
Date: Thu, 11 Jun 2026 12:25:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] ipv6: Select best matching nexthop object
 in fib6_table_lookup()
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, willemb@google.com
References: <20260611154605.992528-1-idosch@nvidia.com>
 <20260611154605.992528-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260611154605.992528-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298275-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:willemb@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EBF867469D

On 6/11/26 9:46 AM, Ido Schimmel wrote:
> Currently, when using multipath routes without nexthop objects,
> fib6_table_lookup() selects the nexthop with the highest score. This
> means that when both a source address and an oif are specified, the
> nexthop that is chosen is the one that matches in terms of oif:
> 
>  # sysctl -wq net.ipv6.conf.all.forwarding=1
>  # ip address add 2001:db8:2::1/64 dev lo
>  # ip route add 2001:db8:10::/64 nexthop via fe80::1 dev dummy1 nexthop via fe80::2 dev dummy2
> 
>  # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy1; done > /dev/null"
>  # perf script | grep -o dummy[0-9] | sort | uniq -c
>      100 dummy1
>  # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done > /dev/null"
>  # perf script | grep -o dummy[0-9] | sort | uniq -c
>      100 dummy2
> 
> When using nexthop objects, fib6_table_lookup() selects the first
> matching nexthop and not necessarily the one with the highest score:
> 
>  # ip nexthop add id 1 via fe80::1 dev dummy1
>  # ip nexthop add id 2 via fe80::2 dev dummy2
>  # ip nexthop add id 3 group 1/2
>  # ip route add 2001:db8:20::/64 nhid 3
> 
>  # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:20::${i} from 2001:db8:2::1 oif dummy1; done > /dev/null"
>  # perf script | grep -o dummy[0-9] | sort | uniq -c
>      100 dummy1
>  # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:20::${i} from 2001:db8:2::1 oif dummy2; done > /dev/null"
>  # perf script | grep -o dummy[0-9] | sort | uniq -c
>      100 dummy1
> 
> This is not very significant right now because the nexthop is later
> overwritten during path selection in fib6_select_path(). However, the
> next patch is going to skip path selection when we have an oif match
> during output route lookup.
> 
> As a preparation for this change, align the nexthop object behavior with
> the legacy one and make sure that fib6_table_lookup() always selects the
> best matching nexthop. Do that by always returning 0 from
> rt6_nh_find_match() in order not to terminate the loop in
> nexthop_for_each_fib6_nh() and storing in arg->nh the best matching
> nexthop so far.
> 
> Behavior after the change:
> 
>  # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:20::${i} from 2001:db8:2::1 oif dummy1; done > /dev/null"
>  # perf script | grep -o dummy[0-9] | sort | uniq -c
>      100 dummy1
>  # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:20::${i} from 2001:db8:2::1 oif dummy2; done > /dev/null"
>  # perf script | grep -o dummy[0-9] | sort | uniq -c
>      100 dummy2
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/route.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



